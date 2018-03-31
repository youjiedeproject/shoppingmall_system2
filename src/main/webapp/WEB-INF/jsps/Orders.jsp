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
    <c:if test="${orderList.size()!=0 }">
        <form action="settingOrder" id="form1" method="post">
            <table style="width:100%;background-color:lightcoral;text-align: center" border="1" cellspacing="1" cellpadding="1">
                <tr>
                    <td style="text-align: center;color: red" colspan="10"><h1>订单界面</h1></td>
                </tr>
                <tr >
                    <td>选择</td>
                    <td>订单编号</td>
                    <td>收件人</td>
                    <td>金额</td>
                    <td>支付状态</td>
                    <td>配送方式</td>
                    <td>创建时间</td>
                    <td>收货地址</td>
                    <td>创建人</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${orderList}" var="odr">
                    <tr class="pro-tr">
                        <td style="width: 100px;height: 50px">
                            <input type="checkbox" class="selectOne"  value="${odr.oid}" name="delBox" style="zoom:180%"/>
                        </td>
                        <td>
                                ${odr.oid}
                        </td>
                        <td style="text-align: center">
                           ${odr.oname}
                        </td>
                        <td>
                                ${odr.money}
                        </td>
                        <td>
                                ${odr.paystatus}
                        </td>
                        <td>
                                ${odr.delivery}
                        </td>
                        <td>
                                ${odr.ordertime}
                        </td>
                        <td >
                                ${odr.address}
                        </td>
                        <td>
                                ${userlogin.username}
                        </td>
                        <td>
                            <a title="删除"   onclick="removeOrder(${odr.oid})">
                                <i class="layui-btn layui-btn-normal" style="font-size:15px" >删除</i>
                            </a>
                            <a title="查看详情"   onclick="deleteShopCar(${sc.car_id})">
                                <i class="layui-btn layui-btn-normal" style="font-size:15px" >查看详情</i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <tr style="height:140px">
                    <td>
                        <input type="checkbox" id="select" style="zoom:180%"/>
                        <br/>全选/全部选
                    </td>
                    <td colspan="2">
                        <a title="删除" onclick="removeOrders()">
                            <i class="layui-btn layui-btn-normal" style="font-size:15px" >全部删除</i>
                        </a>
                    </td>
                    <td colspan="7">
                        <span style="text-align: right">
                             <input type="submit" value="去支付" class="layui-btn layui-btn-normal" style="font-size:15px">
                        </span>
                    </td>
                </tr>

            </table>
        </form>
    </c:if>
    <c:if test="${orderList.size()==0 }">
        <div style="text-align: center;margin-top: 250px">
            <h2><a href="${pageContext.request.contextPath }/product/"  style="color: red" class="myc7">您还没有订单,快去选购吧</a></h2>
            <br />

        </div>
    </c:if>
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