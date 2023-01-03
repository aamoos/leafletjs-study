<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<tiles:insertAttribute name="meta"/>
		<tiles:insertAttribute name="styles"/>
		<tiles:insertAttribute name="scripts"/>
<%-- 		<tiles:insertAttribute name="contents-js" flush="true"/> --%>
	</head>
	<body>
<!-- 		<div class="cover-container d-flex h-100 p-3 mx-auto flex-column"> -->
			<tiles:insertAttribute name="header"/>
			<div id="contentsDiv" class="container"><tiles:insertAttribute name="contents"/></div>
			<tiles:insertAttribute name="footer"/>
<!-- 		</div> -->
	
		<!-- wrap -->
<!-- 		<div id="wrap"> -->
			
<!-- 			<div id="c-mask" class="c-mask"></div>/c-mask -->
<!-- 		</div> -->	
			
	</body>
	
</html>