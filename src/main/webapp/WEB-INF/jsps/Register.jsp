<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body{
            background:url("${pageContext.request.contextPath}/img/1.jpg")
            fixed repeat top center;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
    <script type="text/javascript">
        $(function(){
            $("#username").blur(
                function(){
                    $.get(
                        "${pageContext.request.contextPath}/user/verifierRegister",
                        {"username":this.value},
                        function(data){
                            if(data!=0){
                                //var val=data.username;
                                $("#span1").html("用户名已被注册");
                            }else{
                                $("#span1").html("用户名可以使用");
                            }
                        },
                        "text"
                    );
                }
            );
        });
        $(function(){
            $("#myform").validate({
                rules:{
                    username:{
                        required:true,

                    },
                    password:{
                        required:true,
                        minlength:6
                    },
                    replacepassword:{
                        required:true,
                        equalTo:$("input[name='password']")
                    },
                    email:{
                        required:true,
                        email:true
                    },
                    telephone:{
                        required:true
                    }
                },
                messages:{
                    username:{
                        required:"请输入用户名"
                    },
                    userpassword:{
                        required:"请输入密码"
                    },
                    replacepassword:{
                        required:"请输入重复密码"
                    },
                    email:{
                        required:"请输入邮箱"
                    },
                    telephone:{
                        required:"请输入电话"
                    }
                }



            });
        });
    </script>
    <title>注册界面</title>
</head>
<body>
<div style="margin-top: 150px">
<form id="myform" action="${pageContext.request.contextPath}/user/toRegister" method="post">
    <div align="center" style="background-color: beige;width:900px;margin:auto;">
        <h1>注册界面</h1>
    </div>
    <div  style="background-color:#999;width:900px;margin:auto">
        <table align="center" cellpadding="0px" cellspacing="0px" border="1px" width="100%">
            <tr>
                <td align="center" width="30%">用户名</td>
                <td align="left" width="*"><input type="text" id="username" name="username" size="50"><span id="span1"></span></td>
            </tr>
            <tr style="text-align: center">
                <td colspan="2">
                 男 <input type="radio" name="sex" value="1" title="男" name="sex">
                 女 <input type="radio" name="sex" value="2" title="女" name="sex">
                </td>
            </tr>
            <tr>
                <td align="center" width="30%">密码</td>
                <td align="left" width="*"><input type="password" name="password" size="50"></td>
            </tr>
            <tr>
                <td align="center" width="30%">确认密码</td>
                <td align="left" width="*"><input type="password" name="replacepassword" size="50"></td>
            </tr>
            <tr>
                <td align="center" width="30%">邮箱</td>
                <td align="left" width="*"><input type="email" name="email" size="50"></td>
            </tr>
            <tr>
                <td align="center" width="30%">电话</td>
                <td align="left" width="*"><input type="text" name="telephone" size="50"></td>
            </tr>
            <tr>
                <td align="center" width="30%">地址</td>
                <td align="left" width="*"><input type="text" name="address" size="50"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center">
                    <input type="submit" value="注册" style="margin-right:20px">
                    <input type="reset" value="重置" style="margin-right:20px">
                    <input type="button" value="返回" onclick="re()" style="margin-right:20px">
                </td>
            </tr>
        </table>
    </div>
</form>
</div>
</body>
<
<script test="css/text">
    function  re() {
        location.href="${pageContext.request.contextPath}/product/";
    }
</script>
</html>