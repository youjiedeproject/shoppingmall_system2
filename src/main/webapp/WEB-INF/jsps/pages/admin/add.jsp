
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加管理员-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../static/css/font.css">
    <link rel="stylesheet" href="../../static/css/weadmin.css">
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form" id="addToForm">
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="we-red">*</span>用户名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="username" lay-verify="required|username" autocomplete="off" class="layui-input">
            </div>
            <span id="span1"></span>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">性别</label>
            <div class="layui-input-block" id="sex" name="sex">
                <input type="radio" name="sex" value="1" title="男" name="sex">
                <input type="radio" name="sex" value="2" title="女" name="sex">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="telephone" class="layui-form-label">
                <span class="we-red">*</span>手机号码
            </label>
            <div class="layui-input-inline">
                <input type="text" id="telephone" name="telephone" lay-verify="required|telephone" autocomplete="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="email" class="layui-form-label">
                <span class="we-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="text" id="email" name="email" autocomplete="off" class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label for="address" class="layui-form-label">
                <span class="we-red">*</span>地址
            </label>
            <div class="layui-input-inline">
                <input type="text" id="address" name="address" autocomplete="off" class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label for="password" class="layui-form-label">
                <span class="we-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="password" name="password" lay-verify="required|password" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                6到16个字符
            </div>
        </div>
        <div class="layui-form-item">
            <label for="repass" class="layui-form-label">
                <span class="we-red">*</span>确认密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="repass" name="repass" lay-verify="required|repass" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="add" lay-submit="">添加</button>
        </div>
    </form>
</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['form', 'jquery','util','admin', 'layer'], function() {
        var form = layui.form,
            $ = layui.jquery,
            util = layui.util,
            admin = layui.admin,
            layer = layui.layer;
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
        //自定义验证规则
        form.verify({
            /* username: function(value) {
                  if(value.length < 5) {
                      return '昵称至少得5个字符啊';
                  }
              },*/
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if($('#password').val() != $('#repass').val()) {
                    return '两次密码不一致';
                }
            }
        });
        //失去焦点时判断值为空不验证，一旦填写必须验证
        $('input[name="email"]').blur(function(){
            //这里是失去焦点时的事件
            if($('input[name="email"]').val()){
                $('input[name="email"]').attr('lay-verify','email');
            }else{
                $('input[name="email"]').removeAttr('lay-verify');
            }
        });

        //监听提交
        form.on('submit(add)', function (data) {
            $.ajax({
                data: $("#addToForm").serialize(),
                dataType: "text",
                type: "post",
                url: "${pageContext.request.contextPath}/user/adminadd",
                success: function (res) {
                    if (res !=null) {
                        layer.alert("添加成功", {icon: 6}, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.layui.table.reload('articleList',{page:{curr:1}});
                        });
                    } else {
                        layer.alert("添加失败", {icon: 5}, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            parent.layui.table.reload('articleList',{page:{curr:1}});
                        });
                    }

                }
            });
            return false;
        });

    });
</script>
</body>

</html>