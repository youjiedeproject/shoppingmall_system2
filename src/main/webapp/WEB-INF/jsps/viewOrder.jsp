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
    <title>订单详情</title>
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
<div style="width:1200px;margin: auto">
        <form action="settingOrder" id="form1" method="post">
            <div style="float: right">
                <a title="返回"  onclick="javascript:history.go(-1)" >
                    <i class="layui-btn layui-btn-normal" style="font-size:15px" >返回</i>
                </a>
            </div>
            <table style="width:100%;background-color:#C2BE9E;text-align: center" border="1" cellspacing="1" cellpadding="1">
                <tr>
                    <td style="text-align: center;color: red" colspan="10"><h1>订单详情界面</h1></td>
                </tr>
                <tr>
                    <td>创建时间：${order.ordertime}</td>
                    <td colspan="2" style="text-align: left">订单号：${order.oid}</td>
                    <td>总金额：${order.money}</td>
                </tr>
                <tr >
                    <td>商品图片</td>
                    <td>商品名称</td>
                    <td>商品价格</td>
                    <td>商品简介</td>
                </tr>
                <c:forEach items="${productList}" var="pro">
                    <tr class="pro-tr">
                        <td style="width:300px">
                            <img src="${pageContext.request.contextPath}/images/${pro.pimage}" style="height: 140px">
                        </td>
                        <td style="text-align: center;width:200px">
                                ${pro.pname}
                        </td>
                        <td style="width: 100px">
                                ${pro.shop_price}
                        </td>
                        <td>
                                ${pro.pdesc}
                        </td>
                </c:forEach>
            </table>
        </form>
</div>
</body>
<script type="text/javascript">
    function removeOrders() {
        var cof=confirm("确定要删除吗？");
        if(cof){
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath }/order/removeOrders" ,//url
                data: $('#form1').serialize(),
                success: function (result) {
                    if(result!=null){
                        alert("删除成功");
                        location.reload();
                    }else{
                        alert("删除失败");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
        }
    }
    function removeOrder(oid){
        var cof=confirm("确定要删除吗？");
        if(cof){
            $.ajax({
                type: "GET",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath }/order/removeOrder" ,//url
                data:{"oid":oid},
                success: function (result) {
                    if(result!=null){
                        alert("删除成功");
                        location.reload();
                    }else{
                        alert("删除失败");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
        }
    }
</script>
<script type="text/javascript">
    function  CheckShopCar(uid){
        if(uid!=null){
            location.href="${pageContext.request.contextPath}/CheckShopCar?uid="+uid;
        }else {
            alert("您还没有登录！")
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