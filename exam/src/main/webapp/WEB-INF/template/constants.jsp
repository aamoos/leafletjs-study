<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%@ taglib prefix="ct" uri="/WEB-INF/tlds/common-taglibs.tld" %> --%>
<%-- <%@ taglib prefix="paginator" uri="/WEB-INF/tlds/paginator.tld" %> --%>

<c:set var="version" value="<%=new java.util.Date()%>" />
<c:set var="ctxPath" value="${pageContext.request.contextPath eq '/' ? '' : pageContext.request.contextPath}" />
<c:set var="remoteURI" value="${ctxPath}${requestScope['javax.servlet.forward.servlet_path']}" />
<c:set var="orgRemoteURI" value="${requestScope['javax.servlet.forward.servlet_path']}" />