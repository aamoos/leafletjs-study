<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<body>
	<main role="main" class="inner cover">
        <h1 class="cover-heading">LeafletJs Tutorial</h1>
<!-- 		<p class="lead">- openstreetmap</p> -->
<!-- 		<div id="map"></div> -->
<!-- 		<br> -->
		<p class="lead">polyline 거리 측정</p>
		<div id="map"></div>
      </main>
</body>

<script>
	let lon = "";
	let lat = "";
	let leafletMap = "";
	let startMarker = "";
	let finishMarker = "";
	let contextMenuFlag = true;
	let lineArray = [];
	let drawControl = "";
	let layerType = "";
	let polygon = new L.featureGroup();
	let drawlon = "";
	let drawlat = "";
	let drawnItems = "";
	let layer = "";
	
	//apikey
	const apiKey = $("#apiKey").val();
	
	$(function(){
		init();
	});
	
	function init(){
		navigator.geolocation.getCurrentPosition(onGeoOk,onGeoError);
	}
	
	//현재 좌표값 가져오기
	function onGeoOk(position){
	    lon = position.coords.latitude;
	    lat = position.coords.longitude;
	    console.log("You live in", lon, lat);
	    
	    //wmts 가져오기
	    vworldWmts();
	}
	
	function onGeoError(){
	    alert("Can't find you. No weather for you.");
	}

	function vworldWmts(){
		//leaflet 지도 띄우기 (EPSG : 4326)
		leafletMap = L.map('map').setView([lon, lat], 15)
		
		L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+apiKey+"/Base/{z}/{y}/{x}.png").addTo(leafletMap);
		
		//해당 플래그가 true일때만 동작
		//맵에 오른쪽마우스 클릭이벤트
		leafletMap.on('click', leftMouseClick);
		leafletMap.on('contextmenu', rightMouseClick);
		
		//layer 변경
		changeLayer(leafletMap)
		
		//leaflet 그리기
		initLeafletDraw(leafletMap)
		
	}
	
	//layer 변경
	function changeLayer(leafletMap){
		drawnItems = L.featureGroup().addTo(leafletMap);
		const vworld = L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+apiKey+"/Base/{z}/{y}/{x}.png", { maxZoom: 18});
		//레이어 변경
		L.control.layers({
			'vworld' : vworld.addTo(leafletMap),
			'osm': L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
				attribution: 'osm'
			}),
			'google': L.tileLayer('http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}', {
				attribution: 'google'
			})
		}, { 'drawlayer': drawnItems }, { position: 'topleft', collapsed: false }).addTo(leafletMap);		
	}
	
	//leaflet 그리기
	function initLeafletDraw(leafletMap){
		
		drawControl = new L.Control.Draw({
			edit : false,
// 			edit: {
// 				featureGroup: drawnItems,
// 				poly: {
// 					allowIntersection: false,
// 					remove: false
// 				}
// 			},
			
			draw: {
				polygon: {
					allowIntersection: false,
					showArea: true
				}
			}
		});
		
        leafletMap.addControl(drawControl);

		//created
		leafletMap.on(L.Draw.Event.CREATED, function (event) {
			layer = event.layer;
			layerType = event.layerType;
			drawnItems.addLayer(layer);
			//polyline 일경우
			if(layerType == 'polyline') {
				createAreaTooltip(layer);
		    }
		});
		
		//그리기 도구 열때
		leafletMap.on('draw:toolbaropened', function (e) {
			
			contextMenuFlag = false;
		});
		
		//그리기 도구 닫힐때
		leafletMap.on('draw:toolbarclosed', function (e) {
			contextMenuFlag = true;
		});
		
		//도구모음 클릭시 layerType
		leafletMap.on('draw:drawstart', function (e) {
			layerType = e.layerType;
		});
	}
	
	//tooltip 생성
	function createAreaTooltip(layer) {
		console.log(layer.areaTooltip);
        if(layer.areaTooltip) {
            return;
        }

        layer.areaTooltip = L.tooltip({
            permanent: true,
            direction: 'center',
            className: 'area-tooltip'
        });

        layer.on('remove', function(event) {
            layer.areaTooltip.remove();
        });

        layer.on('add', function(event) {
            updateAreaTooltip(layer);
            layer.areaTooltip.addTo(leafletMap);
        });

        if(leafletMap.hasLayer(layer)) {
            updateAreaTooltip(layer);
            console.log(layer.areaTooltip);
            //얘가문제
            layer.areaTooltip.addTo(leafletMap);
        }
    }
	
	//툴팁 content 업데이트
	function updateAreaTooltip(layer) {
        let latlng = "";
        let content = "";
        
        if(layerType == "polyline"){
        	latlng = layer.getCenter();
        	let coords = layer.getLatLngs();
			let length = 0;
			for (let i = 0; i < coords.length - 1; i++) {
				length += coords[i].distanceTo(coords[i + 1]);
			}
			console.log(coords[coords.length - 1]);
		    
			//반올림
			let totalMeter = meterCalcurate(length);
			content = "<div class='list-group'><a style='text-align: center;' href='javascript:void(0);' class='list-group-item list-group-item-action'>총거리 : "+totalMeter+"</a></div>"
			latlng = [coords[coords.length - 1].lat, coords[coords.length - 1].lng];
			
        }
        
        //ha -> 제곱미터로 변환후 소수 첫째자리까지 반올림후 3째자리까지 나누기
        layer.areaTooltip
            .setContent(content)
            .setLatLng(latlng);
        
        //polyline인경우 offset 처리
        if(layerType == "polyline"){
        	layer.areaTooltip.options.offset = [0,80];	
        }
    }
	
	//왼쪽마우스 클릭
	function leftMouseClick(e){
		
		if(!contextMenuFlag){
			//선
			if(layerType == "polyline"){
				lineArray.push(e.latlng);
				console.log(lineArray);
				
				let length = lineArray.length;
				
				const polyLineIcon = L.icon({
				    iconUrl: '/images/start-marker.png',

				    iconSize:     [30, 30], // size of the icon
				});

				drawlon = lineArray[length-1].lat;
				drawlat = lineArray[length-1].lng;
				
				polyLineMarker = new L.marker([drawlon, drawlat], {
					draggable: false,
					autoPan: false,
					icon: polyLineIcon
				});
				
				polyLineMarker.addTo(leafletMap);
				
				if(length > 1){
					let distance = lineArray[length-2].distanceTo(lineArray[length-1]);
					
					//미터 -> 키로미터로 변환
					distance = meterCalcurate(distance);
					
					polyLineMarker.bindTooltip(distance, {direction: 'top',noWrap: true, opacity: 0.9, permanent: true}).openTooltip();
				}	
			}
		}
	}
	
	// m -> km로 계산
	function meterCalcurate(distance){
		distance = Math.round(distance);
		
		if(distance >= 1000){
			distance = (distance / 1000).toFixed(2) + "km";
		}else{
			distance = distance + "m";
		}
		
		return distance;
	}
	
	//오른쪽 마우스 클릭
	function rightMouseClick(e) {
		
	    const lon = e.latlng.lat;
	    const lat = e.latlng.lng;
	    
	    const popDiv = "<div class='list-group'><a style='text-align: center;' href='javascript:void(0);' onclick='startBtnClicked("+lon+", "+lat+")' class='list-group-item list-group-item-action'>출발</a><a style='text-align: center;' href='javascript:void(0);' onclick='finishBtnClicked("+lon+", "+lat+")' class='list-group-item list-group-item-action'>도착</a><a href='javascript:void(0);' onclick='distanceMeasure()' class='list-group-item list-group-item-action'>거리측정</a></div>";
  
	    console.log("팝업 lon : " + lon, "lat : " + lat)
	    
	    //contextMenuFlag가 true일때만 팝업 show
	    if(contextMenuFlag){
	    	//오른쪽마우스 클릭이벤트
			const popup = L.popup()
		    .setLatLng([lon, lat])
		    .setContent(popDiv)
		    .openOn(leafletMap);
	    }
	}
	
	//출발버튼 클릭
	function startBtnClicked(lon, lat){
		if(startMarker != ""){
			startMarker.remove();	
		}
		
		leafletMap.closePopup();
		
		const startIcon = L.icon({
		    iconUrl: '/images/start-marker.png',

		    iconSize:     [30, 30], // size of the icon
		});

		startMarker = new L.marker([lon, lat], {
			draggable: true,
			autoPan: false,
			icon: startIcon
		});
		
		startMarker.addTo(leafletMap);
		
		//마커 마우스 이벤트
		markerMouseEvent(startMarker);
	}
	
	//도착버튼 클릭
	function finishBtnClicked(lon, lat){
		
		if(finishMarker != ""){
			finishMarker.remove();	
		}
		
		leafletMap.closePopup();
		
		const finishIcon = L.icon({
		    iconUrl: '/images/finish-marker.png',

		    iconSize:     [30, 30], // size of the icon
		});
		
		finishMarker = new L.marker([lon, lat], {
			draggable: true,
			autoPan: false,
			icon: finishIcon
		});
		finishMarker.addTo(leafletMap);
		
		//마커 마우스 이벤트
		markerMouseEvent(finishMarker);
	}
	
	//마커 마우스 이벤트
	function markerMouseEvent(marker){
		marker.on('mouseover', function (e) {
			marker.bindTooltip("끌어서 이동", {direction: 'top',noWrap: true, opacity: 0.9}).openTooltip();
			//class명 추가
// 			marker._icon.classList.add("btn__close");
        });
        marker.on('mouseout', function (e) {
//         	marker._icon.classList.remove("btn__close");
        });
        
        marker.on('click', function (e) {
        	marker.remove();
        });
	}
	
</script>