<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style type="text/css">
        body{
            background:url(${pageContext.request.contextPath}/images/mybackgroup2.jpg)
            fixed repeat top center;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mycss1.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商品详情</title>
    <style type="text/css">
        #pageUl{
            display: inline;
        }
        #pageUl li{
            font-size:30px;
            margin-right: 10px;
        }
        #pageUl a{
            text-decoration: none;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">
        $(function(){
            $("#select").change(
                function(){
                    $(".selectOne").attr("checked",this.checked);
                }
            );

        });
        function calMoney(){
            var total_money = 0;
            var total_count = 0;
            $(".selectOne").each(function () {
                if ($(this).is(":checked")) {
                    var goods = parseFloat($(this).parents(".pro-tr").find(".one-price").html());
                    var count = 1;
                    total_count += count;
                    total_money += goods;
                }
            });
            $("#span1").html("￥"+total_money);
            $("#span2").html(total_count);
        }
    </script>
</head>
<body>
<div style="width:1000px;margin: auto">
    <!--
        作者：offline
        时间：2017-11-21
        描述：logo
    -->
    <%--  <div>
          <img src="${pageContext.request.contextPath}/img/small07.jpg"class="myc3" id="myd8" style="display: none;"/>
      </div>--%>
    <div id="myc">
        <img src="${pageContext.request.contextPath}/img/mylogo.jpg" width="200px" height="100px"/>
    </div>
    <div id="myc1" style="font-size: 20px">
        <a href="${pageContext.request.contextPath}/product/">首页</a>
        <c:if test="${empty userlogin}">
            请登录
        </c:if>
        <c:if test="${!empty userlogin}">
            欢迎你${userlogin.username}
            <a href="${pageContext.request.contextPath}/user/exitRegister">注销</a>
        </c:if>
        <c:if test="${empty userlogin}">
            ${remind!=null?remind:""}
            <a href="${pageContext.request.contextPath}/user/">登录</a>
            <a href="${pageContext.request.contextPath}/user/register">注册</a>
        </c:if>
        <a onclick="CheckShopCar(${userlogin.uid})" href="javascript:void(0)">购物车</a>
        <a onclick="checkOrder(${userlogin.uid})" href="javascript:void(0)">我的订单</a>
    </div></div>
<div class="clear"></div>
<hr>
<div style="width:900px;margin: auto">
    <div style="text-align: center;margin: auto">
        <h2 style="color: red">订单信息完善</h2>
    </div>
    <form action="" id="form1" method="post">
        <div style="background-color: tan">
        <div class="weadmin-body" >
            <form class="layui-form" id="editToForm">
                <input type="text" hidden id="oid" name="oid">
                <div class="layui-form-item">
                    <label for="oname" class="layui-form-label">
                        <span class="we-red">*</span>收件人
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="oname" name="oname" required="" lay-verify="required"
                               autocomplete="off" placeholder="收件人..." class="layui-input">
                    </div>

                </div>

                <div class="layui-form-item">
                    <label for="money" class="layui-form-label">
                        <span class="we-red">*</span>金额
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="money" name="money" required="" lay-verify="required"
                               autocomplete="off"  class="layui-input" value="${sumPrice}">
                    </div>

                </div>
                <input type="text" hidden id="uid" value="${userlogin.uid}" name="uid">
                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="we-red">*</span>配送方式</label>
                    <div class="layui-input-block">
                        <select name="delivery" id="delivery" required="" lay-verify="required" lay-filter="delivery">
                            <option value="">请选择</option>
                            <option value="1">顺丰快递</option>
                            <option value="2">圆通快递</option>
                            <option value="3">中通快递</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label for="address" class="layui-form-label">地址</label>
                    <div class="layui-input-inline">
                        <textarea id="address" name="address" style="width: 300px;height: 100px" lay-verify="required"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <a title="提交" onclick="sub()">
                        <i class="layui-btn layui-btn-normal" style="font-size:15px" >提交</i>
                    </a>
                </div>
    </form>
</div>
</body>
<script type="text/javascript">
    function  CheckShopCar(uid){
        if(uid!=null){
            location.href="${pageContext.request.contextPath}/CheckShopCar?uid="+uid;
        }else {
            alert("您还没有登录！")
        }
    }
    function sub() {
        var cof=confirm("确定要提交吗？");
        if(cof){
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath }/shopcar/addOrder" ,//url
                data: $('#form1').serialize(),
                success: function (result) {
                    if(result!=null){
                        alert("提交成功");
                        location.href="${pageContext.request.contextPath }/product/";
                    }else{
                        alert("提交失败");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
        }
    }
    function  checkOrder(uid){
        if(uid!=null){
            location.href="${pageContext.request.contextPath}/checkOrder?uid="+uid;
        }else {
            alert("您还没有登录！")
        }
    }
</script>
</html>