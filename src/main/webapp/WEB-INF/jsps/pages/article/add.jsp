
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head >
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <title>添加商品-后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form" id="addToForm"  enctype="multipart/form-data"  method="post">
        <div class="layui-form-item">
            <label for="pname" class="layui-form-label">商品名称</label>
            <div class="layui-input-inline">
                <input type="text" id="pname" name="pname" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="market_price" class="layui-form-label">市场价格</label>
            <div class="layui-input-inline">
                <input type="text" id="market_price" name="market_price" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="shop_price" class="layui-form-label">商铺价格</label>
            <div class="layui-input-inline">
                <input type="text" id="shop_price" name="shop_price" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="pnumber" class="layui-form-label">库存量</label>
            <div class="layui-input-inline">
                <input type="text" id="pnumber" name="pnumber" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="file" class="layui-form-label">商品图片</label>
            <div class="layui-input-inline">
                <input type="file" id="file" name="file" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="pdesc" class="layui-form-label">简介</label>
            <div class="layui-input-inline">
                <textarea id="pdesc" name="pdesc" style="width: 300px;height: 100px" lay-verify="required"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>分类</label>
            <div class="layui-input-block">
                <select name="cid" id="cid" required="" lay-verify="required" lay-filter="cid">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="we-red">*</span>是否热门</label>
            <div class="layui-input-block">
                <select name="is_hot" id="is_hot" required="" lay-verify="required" lay-filter="is_hot">
                    <option value="">请选择</option>
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select>
                <input type="text" hidden id="hot">
            </div>
        </div>
        <div class="layui-form-item">
           <input type="button" value="添加" class="layui-btn" onclick="sub()">
        </div>
    </form>
</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    var form;
    var $;
    layui.use(['form','layer'], function(){
        form = layui.form;
        var layer = layui.layer;
        $ = layui.jquery;
        loadCategory();

        //监听提交
       /* form.on('submit(insert)', function (data) {
            $.ajax({
                data: $("#addToForm").serialize(),
                type: "post",
                url: "/product/addProduct",
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
        });*/

    });
//查询分类
    function loadCategory() {
        //去后台查询所有的分类信息
        $.ajax({
            dataType: "json",
            type: "GET",
            url: "${pageContext.request.contextPath}/product/categorySelect",
            success: function (data) {
                var category = document.getElementById("cid");
                for (var i = 0; i < data.length; i++) {
                    //将后台返回的json格式的分类信息,逐个添加到select中option
                    var option = document.createElement("option");
                    option.setAttribute("value", data[i].cid);
                    option.innerText = data[i].cname;
                    category.appendChild(option);
                    form.render('select');
                }
            }
        });
    }

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryform.js"></script>
<script type="text/javascript">
    function sub() {
        $("#addToForm").ajaxSubmit({
            type : "POST",
            url : "${pageContext.request.contextPath}/product/addProduct",
            dataType : "json",
            success : function(data) {
                if (data !=null) {
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
    }
</script>
</body>

</html>
