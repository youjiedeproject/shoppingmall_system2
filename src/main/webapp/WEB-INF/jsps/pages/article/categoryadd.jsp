
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<!--
作者：github.com/WangEn
时间：2018-02-02
描述：添加文章类别
-->

<head>
    <meta charset="UTF-8">
    <title>添加分类-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
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

    <form id="addForm" class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">商品分类</label>
            <div class="layui-input-block">
                <input type="text" name="cname" id="category" lay-verify="required" jq-error="请输入分类名称" placeholder="请输入分类名称" autocomplete="off" class="layui-input ">
            </div>
            <div class="layui-input-block">
                <span id="span1"></span>
            </div>

        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="add">添加</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    //加载扩展模块 treeGird
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['admin','jquery','form', 'layer'], function() {
        var admin = layui.admin,
            $ = layui.jquery,
            form = layui.form,
            layer = layui.layer;

        //监听提交
        form.on('submit(add)', function (data) {
            $.ajax({
                data: $("#addForm").serialize(),
                dataType: "text",
                type: "post",
                url: "${pageContext.request.contextPath}/addCategory",
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
                        });
                    }

                }
            });
            return false;
        });

        $(function(){
            $("#category").blur(
                function(){
                    $.get(
                        "${pageContext.request.contextPath}/verifierCategory",
                        {"cname":this.value},
                        function(data){
                            if(data!=0){
                                //var val=data.username;
                                $("#span1").html("分类已存在");
                            }else{
                                $("#span1").html("分类可以使用");
                            }
                        },
                        "text"
                    );
                }
            );
        });

    });
</script>
</body>

</html>
