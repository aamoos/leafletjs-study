<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<body>
	<main role="main" class="inner cover">
        <h1 class="cover-heading">LeafletJs Tutorial</h1>
<!-- 		<p class="lead">- openstreetmap</p> -->
<!-- 		<div id="map"></div> -->
<!-- 		<br> -->
		<p class="lead">- 출발 도착 버튼 클릭시 마커찍기</p>
		<div id="map"></div>
      </main>
</body>

<script>
	let lon = "";
	let lat = "";
	let leafletMap = "";
	let startMarker = "";
	let finishMarker = "";
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
	
	//내좌표값 가져올때 error
	function onGeoError(){
	    alert("Can't find you. No weather for you.");
	}

	//vowld wmts 배경지도
	function vworldWmts(){
		
		//leaflet 지도 띄우기 (EPSG : 4326)
		leafletMap = L.map('map').setView([lon, lat], 15)
		
		L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+apiKey+"/Base/{z}/{y}/{x}.png").addTo(leafletMap);
		
		//맵에 오른쪽마우스 클릭이벤트
		leafletMap.on('contextmenu', onMapClick);
	}
	
	//마우스 오른쪽 클릭시
	function onMapClick(e) {
	    lon = e.latlng.lat;
	    lat = e.latlng.lng;
	    
	    const popDiv = "<div class='list-group'><a style='text-align: center;' href='javascript:void(0);' onclick='startBtnClicked("+lon+", "+lat+")' class='list-group-item list-group-item-action'>출발</a><a style='text-align: center;' href='javascript:void(0);' onclick='finishBtnClicked("+lon+", "+lat+")' class='list-group-item list-group-item-action'>도착</a></div>";
	    
	    console.log("팝업 lon : " + lon, "lat : " + lat)
	    
	  	//오른쪽마우스 클릭이벤트
		const popup = L.popup()
	    .setLatLng([lon, lat])
	    .setContent(popDiv)
	    .openOn(leafletMap);
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
		//마우스 오버
		marker.on('mouseover', function (e) {
			marker.bindTooltip("끌어서 이동", {direction: 'top',noWrap: true, opacity: 0.9}).openTooltip();
			//class명 추가
// 			marker._icon.classList.add("btn__close");
        });
		
		//마우스 아웃
        marker.on('mouseout', function (e) {
//         	marker._icon.classList.remove("btn__close");
        });
        
		//마우스 클릭
        marker.on('click', function (e) {
        	marker.remove();
        });
	}
	
</script>