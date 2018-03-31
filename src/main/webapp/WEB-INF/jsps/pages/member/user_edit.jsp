
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form" id="editToForm">
        <input type="text" hidden id="uid" name="uid">
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="we-red">*</span>用户名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="username" required="" lay-verify="required"
                       autocomplete="off" placeholder="商品名称..." class="layui-input">
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
            <label  class="layui-form-label">性别</label>
            <div class="layui-input-block"  >
              <select id="sexname" name="sex">
                  <option value="">请选择<option>
                  <option value="男">男<option>
                  <option value="女">女<option>
              </select>
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
            <label for="udate" class="layui-form-label">
                <span class="we-red">*</span>发布日期
            </label>
            <div class="layui-input-inline">
                <input type="Date" id="udate" name="udate" required="" lay-verify="required"
                       autocomplete="off" placeholder="发布日期..." class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <button class="layui-btn" lay-filter="update" lay-submit="">
                修改
            </button>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    var form;
    var $;
    layui.use(['form', 'layer', 'jquery', 'admin'], function () {
        var admin = layui.admin,
            layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;
        //loadBrand();
        form.render('select');

        form.verify({
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if($('#password').val() != $('#repass').val()) {
                    return '两次密码不一致';
                }
            }
        });
        //监听提交
        form.on('submit(update)', function (data) {
            $.ajax({
                data: $("#editToForm").serialize(),
                dataType: "text",
                type: "post",
                url: "${pageContext.request.contextPath}/useredit",
                success: function (res) {
                    if (res !=null) {
                        layer.alert("修改成功", {icon: 6}, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.layui.table.reload('articleList',{page:{curr:1}});
                        });
                    } else {
                        layer.alert("修改失败", {icon: 5}, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
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