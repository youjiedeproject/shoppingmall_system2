
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>商品分类-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
		        <a href="">首页</a>
		        <a href="">商品管理</a>
		        <a><cite>商品分类</cite></a>
		      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">
    <div class="weadmin-block">
        <button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon">&#xe640;</i>批量删除</button>
        <button class="layui-btn" onclick="WeAdminShow('添加分类','${pageContext.request.contextPath}/pages/article/category-add')"><i class="layui-icon"></i>添加</button>
        <span class="fr" style="line-height:40px">共有数据：66 条</span>
    </div>

    <div id="demo">
        <table class="layui-hide" id="articleList"></table>
        <script type="text/html" id="operateTpl">
            <a title="编辑" onclick="WeAdminEdit('编辑','./edit', 2, 600, 400)" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
            </a>
            <a title="查看" onclick="WeAdminShow('查看文章','./show',600,400)" href="javascript:;">
                <i class="layui-icon">&#xe63c;</i>
            </a>
            <a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
                <i class="layui-icon">&#xe640;</i>
            </a>
        </script>
    </div>
</div>
</body>

<script type="text/javascript">
    layui.extend({
        admin: '{/}../../static/js/admin'
    });

    layui.use(['table', 'jquery', 'admin'], function() {
        var table = layui.table,
            $ = layui.jquery,
            admin = layui.admin;


        table.render({
            elem: '#articleList',
            cellMinWidth: 80,
            cols: [
                [{
                    type: 'checkbox'
                }, {
                    field: 'cid',title: 'ID',sort: true
                }, {
                    field: 'cname',title: '商品分类',templet: '#usernameTpl'
                }, {
                    field: 'status',title: '分类状态',sort: true
                }, {
                    field: 'operate',title: '操作',toolbar: '#operateTpl',unresize: true
                }]
            ],
            url:"../../items/category",
            page: true,
            limits:[1,5]
        });
        var active = {
            getCheckData: function() { //获取选中数据
                var checkStatus = table.checkStatus('articleList'),
                    data = checkStatus.data;
                //console.log(data);
                //layer.alert(JSON.stringify(data));
                if(data.length > 0) {
                    layer.confirm('确认要删除吗？' + JSON.stringify(data), function(index) {

                        //找到所有被选中的，发异步进行删除
                        $(".layui-table-body .layui-form-checked").parents('tr').remove();
                        var ids = [];
                        for(var i=0;i<data.length;i++){
                            ids.push(data[i].pid)
                        }
                        $.post(
                            "../../items/delete",
                            {"ids[]":ids},
                            function (date) {
                                console.log(data)
                            }
                        )
                        layer.msg('删除成功', {
                            icon: 1
                        });
                    });
                } else {
                    layer.msg("请先选择需要删除的文章！");
                }

            },
            Recommend: function() {
                var checkStatus = table.checkStatus('articleList'),
                    data = checkStatus.data;
                if(data.length > 0) {
                    layer.msg("您点击了推荐操作");
                    for(var i = 0; i < data.length; i++) {
                        console.log("a:" + data[i].recommend);
                        data[i].recommend = "checked";
                        console.log("aa:" + data[i].recommend);
                        form.render();
                    }

                } else {
                    console.log("b");
                    layer.msg("请先选择");
                }

                //$(".layui-table-body .layui-form-checked").parents('tr').children().children('input[name="zzz"]').attr("checked","checked");
            },
            Top: function() {
                layer.msg("您点击了置顶操作");
            },
            Review: function() {
                layer.msg(";");
            }

        };

        $('.demoTable .layui-btn').on('click', function() {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        /*用户-删除*/
        window.member_del = function(obj, id) {
            layer.confirm('确认要删除吗？', function(index) {
                //发异步删除数据
                $(obj).parents("tr").remove();
                layer.msg('已删除!', {
                    icon: 1,
                    time: 1000
                });
            });
        }

    });

    function delAll(argument) {
        var data = tableCheck.getData();
        layer.confirm('确认要删除吗？' + data, function(index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {
                icon: 1
            });
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }

</script>

</html>
