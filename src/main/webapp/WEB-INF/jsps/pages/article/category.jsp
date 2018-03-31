
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
    <div class="weadmin-block demoTable">
        <button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon">&#xe640;</i>批量删除</button>
        <button class="layui-btn" onclick="WeAdminShow('添加用户','${pageContext.request.contextPath}/pages/article/categoryadd',600,400)"><i class="layui-icon">&#xe61f;</i>添加</button>
    </div>

    <div id="demo">
        <table class="layui-hide" id="articleList" lay-filter="demo"></table>
        <script type="text/html" id="operateTpl">
            <a title="编辑" lay-event="edit" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
            </a>
            <a title="删除" id="category_del" onclick="category_del(this)" href="javascript:;">
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
                            ids.push(data[i].cid)
                        }
                        $.post(
                            "../../category/delete",
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
                    layer.msg("请先选择需要删除的分类！");
                }

            },


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

        table.on('tool(demo)', function (obj) {
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'edit') {
                var cid = data.cid;
//               layer.msg(data.cid);
                var title = "修改分类";
                var url = "../../pages/article/categoryedit";
                var w = ($(window).width() * 0.9);

                var h = ($(window).height() - 50);


                layer.open({
                    type: 2,
                    area: [w + 'px', h + 'px'],
                    fix: false, //不固定
                    maxmin: true,
                    shadeClose: true,
                    shade: 0.4,
                    title: title,
                    content: url,
                    success: function (layero, index) {
                        //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150
                        var body = layer.getChildFrame('body', index);
                        //巧妙的地方在这里哦
                        body.contents().find("#cname").val(data.cname);
                        body.contents().find("#cid").val(data.cid);
                    },
                    error: function (layero, index) {
                        alert("修改失败");
                    }
                });
            }
        });



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


    /*商品-删除*/
    window.category_del = function (obj) {
        layer.confirm('确认要删除吗？', function (index) {
            var id = $(obj).parents("tr").children("[data-field='cid']").text();
            //提交ajax
            var ids=[];
            ids.push(id);
            $.ajax({
                data: {'ids[]': ids},
                dataType: "text",
                type: "POST",
                url: "../../category/delete",
                success: function (res) {
                    if (res!=null) {
                        $(obj).parents('tr').remove();
                        layer.msg('已删除!', {
                            icon: 1,
                            time: 1000
                        });
                    } else {
                        layer.msg('删除失败!', {
                            icon: 2,
                            time: 1000
                        });
                    }
                }
            });

        });
    }
</script>

</html>
