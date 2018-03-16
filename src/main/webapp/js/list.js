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
                field: 'pid',title: 'ID',sort: true
            }, {
                field: 'pname',title: '标题',templet: '#usernameTpl'
            }, {
                field: 'pdate',title: '发布时间',sort: true
            }, {
                field: 'cname',title: '分类',sort: true
            },{
                field: 'statusName',title: '商品状态',sort: true
            }, {
                field: 'pdesc',title: '简介',sort: true
            },  {
                field: 'operate',title: '操作',toolbar: '#operateTpl',unresize: true
            }]
        ],
        url:"../../items",
        page: true,
    limits:[10,20,50]
    });
    var active = {
        reload:function(){
            var title = $.trim($('#title').val());
            table.reload("articleList",{
                page:{curr:1},
                where:{title:title}
            });
        },
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
    $('.we-search .layui-btn').on('click', function() {
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
