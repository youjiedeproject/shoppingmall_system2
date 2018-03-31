layui.extend({
    admin: '{/}../../static/js/admin'
});
var table;
layui.use(['table', 'jquery', 'admin'], function() {
    var $ = layui.jquery,
        table = layui.table,
        admin = layui.admin;


    table.render({
        elem: '#articleList',
        cellMinWidth: 80,
        cols: [
            [{
                type: 'checkbox'
            }, {
                field: 'uid',title: 'ID',sort: true
            }, {
                field: 'username',title: '用户名',templet: '#usernameTpl'
            }, {
                field: 'sex',title: '性别',sort: true
            }, {
                field: 'telephone',title: '手机',sort: true
            },{
                field: 'email',title: '邮箱',sort: true
            }, {
                field: 'address',title: '地址',sort: true
            },  {
                field: 'udate',title: '加入时间',sort: true
            }, {
                field: 'operate',title: '操作',toolbar: '#operateTpl',unresize: true
            }]
        ],
        url:"../../user/message",
        page: true,
        limits:[1,5]
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
                        ids.push(data[i].uid)
                    }
                    $.post(
                        "../../user/delete",
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

    table.on('tool(demo)', function (obj) {
        var data = obj.data //获得当前行数据
            , layEvent = obj.event; //获得 lay-event 对应的值
        if (layEvent === 'edit') {
//               layer.msg(data.cid);
            var title = "修改会员";
            var url = "../../pages/member/user_edit";
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
                    body.contents().find("#uid").val(data.uid);
                    body.contents().find("#username").val(data.username);
                    body.contents().find("#password").val(data.password);
                    body.contents().find("#repass").val(data.password);
                    body.contents().find("#email").val(data.email);
                    body.contents().find("#telephone").val(data.telephone);
                    body.contents().find("#udate").val(data.udate);
                    body.contents().find("#sexname").val(data.sex);
                    body.contents().find("#address").val(data.address);
                    /* body.contents().find("#goods_brief").val(data.goods_brief);
                     body.contents().find("#goods_desc").val(data.goods_desc);
                     body.contents().find("#goods_img").val(data.goods_img);
                     body.contents().find("#goods_thumb").val(data.goods_thumb);*/
                    // body.contents().find("#is_new").val(data.is_new);
                    //body.contents().find("#is_hot").val(data.is_hot);
                    /* body.contents().find("#give_integral").val(data.give_integral);*/
                    //body.contents().find("#status").val(data.status);
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

