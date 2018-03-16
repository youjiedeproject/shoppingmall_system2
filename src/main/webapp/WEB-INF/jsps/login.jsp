<%@ page language="java" contentType="text/html; charset=UTF-8"
                pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style type="text/css">
        body{
            background:url(${pageContext.request.contextPath}/images/mybackgroup.jpg)
            fixed repeat top center;
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户登录</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js"></script>
</head>
<body style="background-color: antiquewhite">
<div align="center" style="background-color: aqua;width:600px;margin:auto;margin-top: 200px">
    <h1>小杰商城登录界面</h1>
    <hr>
    <form action="" method="post" id="userForm">
        <table style="text-align: left;">
            <tr>
                <td style="width: 600px">
        用户名<input type="text" size="50" name="username">
                 </td>

            </tr>
            <tr>
                <td style="width: 600px">
        密  码 <input type="password" size="50" name="password">
                </td>
            </tr>
            <tr>
                <td style="width: 600px;text-align: center">
                     <input type="submit"  value="登录" style="margin-right:20px"/>
                    <input type="reset" value="重置" style="margin-right:20px">
                    <input type="button"  value="注册" onclick="fn()" style="margin-right:20px"/>
                    <span color="red" id="mess"></span>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
<script type="text/javascript">
    $(function() {
        $("#userForm").validate({
            rules : {
                username : "required",
                password : "required"
            },
            messages : {
                username : "用户名不能为空",
                password : "密码不能为空"
            },
            submitHandler : function() {
                //提交Ajax
                $.ajax({
                    data : $("#userForm").serialize(),
                    dataType : "text",
                    type : "post",
                    url : "${pageContext.request.contextPath}/user/tologin",
                    success : function(rec) {
                        if(rec=="0"){
                            $("#mess").html("用户名或密码错误");
                        }else{
                            location.href = "${pageContext.request.contextPath}/product/"
                        }
                    }
                });
            }
        });
    })
function fn() {
    location.href="${pageContext.request.contextPath}/user/register";
}
</script>
</html>