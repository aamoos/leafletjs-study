<%@ page language="java" session="true" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/template/constants.jsp"%>
<script>

   //로그인 submit
    function loginSubmit(){

        var params = {
             'un' : $.trim($("#loginId").val())
            ,'up' : $("#loginPw").val()
        }

        console.log(params);

        $.ajax({
             type : 'POST'
            ,url : '/auth/login-proc'
            ,dataType : 'json'
            ,data : params
            ,success : function(result) {
                console.log(result);
                if(result.resultCode != "00"){
                    alert(result.resultMessage);
                }

                else{
                    location.href=result.targetUrl;
                }

            },
            error: function(request, status, error) {

            }
        })
    }

    function enterkey() {
        if (window.event.keyCode == 13) {
            // 엔터키가 눌렸을 때
            loginSubmit()
        }
    }
</script>