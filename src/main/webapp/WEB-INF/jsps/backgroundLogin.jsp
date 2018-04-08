
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>管理员登录-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js"></script>
</head>
<body class="login-bg">

<div class="login">
    <div class="message">小杰商城后台管理登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" id="Form1">
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <div style="text-align: center">
        <a title="登录" onclick="sub()">
            <i class="layui-btn layui-btn-normal" style="font-size:15px" >登录</i>
        </a>
        </div>
        <hr class="hr20" >
    </form>
</div>

<script type="text/javascript">
    function sub() {
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath }/backRegister" ,//url
                data: $('#Form1').serialize(),
                success: function (result) {
                    if(result==1){
                        location.href="${pageContext.request.contextPath }/index";
                    } else if(result==2){
                        alert("您没有权限登录后台");
                    }else{
                        alert("用户名或密码错误");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
    }
</script>
<!-- 底部结束 -->
</body>
</html>