<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<body>
	<main role="main" class="inner cover">
        <h1 class="cover-heading">LeafletJs Tutorial</h1>
<!-- 		<p class="lead">- openstreetmap</p> -->
<!-- 		<div id="map"></div> -->
<!-- 		<br> -->
		<p class="lead">- wmts 배경지도 (내위치)</p>
		<div id="map"></div>
      </main>
</body>

<script>

	$(function(){
		init();
	});
	
	function init(){
		navigator.geolocation.getCurrentPosition(onGeoOk,onGeoError);
	}
	
	//현재 좌표값 가져오기
	function onGeoOk(position){
	    const lon = position.coords.latitude;
	    const lat = position.coords.longitude;
	    vworldWmts(lon, lat);
	}
	
	//내좌표값 가져올때 error
	function onGeoError(){
	    alert("Can't find you. No weather for you.");
	}

	//vowld wmts 배경지도
	function vworldWmts(lon, lat){
		//apikey
		const apiKey = $("#apiKey").val();
		
		//leaflet 지도 띄우기 (EPSG : 4326)
		const leafletMap = L.map('map').setView([lon, lat], 15)
		
		L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+apiKey+"/Base/{z}/{y}/{x}.png").addTo(leafletMap);
	}
	
</script>