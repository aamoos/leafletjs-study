<%@ page language="java" session="true" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/template/constants.jsp"%>

<!------ Include the above in your HEAD tag ---------->
<form action="/auth/join" method="post">
	<h1>회원가입</h1>
	<div class="form-row">
		<div class="form-group col-md-6">
			<label for="email">이메일</label>
			<input type="email" class="form-control" id="email" name="email">
			<button type="button" class="btn btn-outline-primary">중복확인</button>
		</div>
		<br>
		<div class="form-group col-md-6">
			<label for="password">패스워드</label>
			<input type="password" class="form-control" id="password" name="password">
		</div>
		<br>
		<div class="form-group col-md-6">
			<label class="text-danger" for="password2">패스워드 확인</label>
			<input type="password" class="form-control" id="password2" name="password2">
		</div>
		<br>
		<div class="form-group col-md-6">
			<label for="name">이름</label>
			<input type="text" class="form-control" id="name" name="name">
		</div>
		<br>
		<div class="form-group col-md-6">
			<label for="nickname">닉네임</label>
			<input type="text" class="form-control" id="nickname" name="nickname">
		</div>
	</div>
	<br>
	<button type="button" onclick="join()" class="btn btn-danger">회원가입</button>
</form>
