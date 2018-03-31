
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        <input type="text" hidden id="oid" name="oid">
        <div class="layui-form-item">
            <label for="oname" class="layui-form-label">
                <span class="we-red">*</span>收件人
            </label>
            <div class="layui-input-inline">
                <input type="text" id="oname" name="oname" required="" lay-verify="required"
                       autocomplete="off" placeholder="商品名称..." class="layui-input">
            </div>

        </div>

        <div class="layui-form-item">
            <label for="money" class="layui-form-label">
                <span class="we-red">*</span>金额
            </label>
            <div class="layui-input-inline">
                <input type="text" id="money" name="money" required="" lay-verify="required"
                       autocomplete="off"  class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>创建人</label>
            <div class="layui-input-block">
                <select name="uid" id="uid" required="" lay-verify="required" lay-filter="cid">
                    <option value="">请选择</option>
                </select>
                <input type="text" hidden id="username" >
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>支付状态</label>
            <div class="layui-input-block">
                <select name="paystatus" id="paystatus" required="" lay-verify="required" lay-filter="paystatus">
                    <option value="">请选择</option>
                    <option value="已支付">已支付</option>
                    <option value="未支付">未支付</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>配送方式</label>
            <div class="layui-input-block">
                <select name="delivery" id="delivery" required="" lay-verify="required" lay-filter="delivery">
                    <option value="">请选择</option>
                    <option value="顺丰快递">顺丰快递</option>
                    <option value="圆通快递">圆通快递</option>
                    <option value="中通快递">中通快递</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="ordertime" class="layui-form-label">
                <span class="we-red">*</span>创建时间
            </label>
            <div class="layui-input-inline">
                <input type="Date" id="ordertime" name="ordertime" required="" lay-verify="required"
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
        loadCategory();
        //loadBrand();

        //监听提交
        form.on('submit(update)', function (data) {
            $.ajax({
                data: $("#editToForm").serialize(),
                dataType: "text",
                type: "post",
                url: "${pageContext.request.contextPath}/orderEdit",
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

    //下拉选项的回显
    function loadCategory() {
        //去后台查询所有的分类信息
        $.ajax({
            dataType: "json",
            type: "GET",
            url: "${pageContext.request.contextPath}/userSelect",
            success: function (data) {

                var uname = document.getElementById("uid");
                for (var i = 0; i < data.length; i++) {
                    //将后台返回的json格式的分类信息,逐个添加到select中option
                    var option = document.createElement("option");
                    option.setAttribute("value", data[i].uid);
                    option.innerText = data[i].username;

                    uname.appendChild(option);
                    form.render('select');
                    //判断当前的cname(写了个隐藏的input标签)
                    if (data[i].username == $("#username").val()) {
                        //将该option改为selected状态
                        document.getElementById("uid")[i+1].selected = true;
                    }

                }
            }
        });
    }


</script>


</body>

</html>
