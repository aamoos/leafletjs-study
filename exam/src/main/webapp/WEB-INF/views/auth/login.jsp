<%@ page language="java" session="true" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/template/constants.jsp"%>

<!------ Include the above in your HEAD tag ---------->
<form>
	<h1>로그인</h1>
	<div class="form-group">
		<label for="exampleInputEmail1">이메일</label>
		<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
		<small id="emailHelp" class="form-text text-muted">아이디 또는 패스워드가 일치하지 않습니다.</small>
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">비밀번호</label>
		<input type="password" class="form-control" id="exampleInputPassword1">
	</div>
	<div class="form-group form-check">
		<input type="checkbox" class="form-check-input" id="exampleCheck1">
   		<label class="form-check-label" for="exampleCheck1">이메일 저장</label>
 		</div>
	<button type="button" onclick="location.href='/auth/join'" class="btn btn-danger">회원가입</button>
	<button type="button" onclick="loginSubmit()" class="btn btn-primary">로그인</button>
</form>