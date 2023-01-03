<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<body>
	<main role="main" class="inner cover">
        <h1 class="cover-heading">LeafletJs Tutorial</h1>
<!-- 		<p class="lead">- openstreetmap</p> -->
<!-- 		<div id="map"></div> -->
<!-- 		<br> -->
		<p class="lead">- 마우스 오른쪽 클릭시 팝업</p>
		<div id="map"></div>
      </main>
</body>

<script>
	var lon = "";
	var lat = "";
	var leafletMap = "";
	var startMarker = "";
	var finishMarker = "";
	
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
		
		//apikey
		const apiKey = $("#apiKey").val();
		
		//leaflet 지도 띄우기 (EPSG : 4326)
		leafletMap = L.map('map').setView([lon, lat], 15)
		
		L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+apiKey+"/Base/{z}/{y}/{x}.png").addTo(leafletMap);
		
		//맵에 오른쪽마우스 클릭이벤트
		leafletMap.on('contextmenu', onMapClick);
	}
	
	function onMapClick(e) {
	    const lon = e.latlng.lat;
	    const lat = e.latlng.lng;
	    
	    var startButton = "<button type='button' onclick='startBtnClicked("+lon+", "+lat+")' class='btn btn-outline-success btn-sm'>출발</button>";
	    var finishButton = "  <button type='button' onclick='finishBtnClicked("+lon+", "+lat+")' class='btn btn-outline-danger btn-sm'>도착</button>";
	    
	    console.log("팝업 lon : " + lon, "lat : " + lat)
	    
	  	//오른쪽마우스 클릭이벤트
		var popup = L.popup()
	    .setLatLng([lon, lat])
	    .setContent(startButton+finishButton)
	    .openOn(leafletMap);
	}
	
	//출발버튼 클릭
	function startBtnClicked(lon, lat){
		if(startMarker != ""){
			startMarker.remove();	
		}
		
		leafletMap.closePopup();
		
		var startIcon = L.icon({
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
		
		var finishIcon = L.icon({
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