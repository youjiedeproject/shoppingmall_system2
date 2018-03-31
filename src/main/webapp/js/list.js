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
                field: 'pimage',title: '图片',templet:'<div><img src="../../images/{{d.pimage}}"></div>',style:'height:48px;width:48px;line-height:48px!important;'
            },{
                field: 'cname',title: '分类',sort: true
            },{
                field: 'statusName',title: '商品状态',sort: true
            }, {
                field: 'pnumber',title: '库存量',sort: true
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
window.product_del = function (obj) {
    layer.confirm('确认要删除吗？', function (index) {
        var id = $(obj).parents("tr").children("[data-field='pid']").text();
        //提交ajax
        var ids=[];
        ids.push(id);
        $.ajax({
            data: {'ids[]': ids},
            dataType: "text",
            type: "POST",
            url: "../../items/delete",
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
 table.on('tool(demo)', function (obj) {
    var data = obj.data //获得当前行数据
        , layEvent = obj.event; //获得 lay-event 对应的值
    if (layEvent === 'edit') {
        var cid = data.cid;
//               layer.msg(data.cid);
        var title = "修改商品";
        var url = "../../pages/article/product_edit";
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
                body.contents().find("#pid").val(data.pid);
                body.contents().find("#pname").val(data.pname);
                body.contents().find("#marketprice").val(data.market_price);
                body.contents().find("#shopprice").val(data.shop_price);
                body.contents().find("#pimage").val(data.pimage);
                body.contents().find("#pdate").val(data.pdate);
                body.contents().find("#hot").val(data.is_hot);
                body.contents().find("#pdesc").val(data.pdesc);
                body.contents().find("#cname").val(data.cname);
                body.contents().find("#sname").val(data.statusName);
                body.contents().find("#pnumber").val(data.pnumber);
            },
            error: function (layero, index) {
                alert("修改失败");
            }
        });
    }
});

});
