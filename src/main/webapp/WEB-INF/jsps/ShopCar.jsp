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
            $(".sumPrice").val(total_money);
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
    <c:if test="${shopCars.size()!=0 }">
    <form action="settingOrder" id="form1" method="post">
    <table style="width:100%;background-color:lightcoral;text-align: center" border="1" cellspacing="1" cellpadding="1">
        <tr>
            <td style="text-align: center;color: red" colspan="5"><h1>购物车界面</h1></td>
        </tr>
        <tr >
            <td>选择</td>
            <td>商品图片</td>
            <td>商品名称</td>
            <td>商品价格</td>
            <td>操作</td>
        </tr>
        <c:forEach items="${shopCars}" var="sc">
            <tr class="pro-tr">
                <td style="width: 100px;height: 50px">
                    <input type="checkbox" class="selectOne"  value="${sc.car_id}" name="delBox" style="zoom:180%"/>
                </td>
                <td style="width:120px;height:140px;text-align: center">
                    <img src="${pageContext.request.contextPath}/images/${sc.pimage}" alt="找不到该图片" style="width:110px;height:120px">
                </td>
                <td>
                        ${sc.pname}
                </td>
                <td class="one-price">${sc.shop_price}</td>
                <td>
                    <a title="删除"   onclick="deleteShopCar(${sc.car_id})">
                    <i class="layui-btn layui-btn-normal" style="font-size:15px" >删除</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        <tr style="height:140px">
            <td>
                <input type="checkbox" id="select" style="zoom:180%"/>
                <br/>全选/全部选
            </td>
            <td colspan="2">总计</td>
            <td>
                <span id="span1"></span>
            </td>
            <td rowspan="2">
                <a title="结算" onclick="calMoney()">
                    <i class="layui-btn layui-btn-normal" style="font-size:15px" >结算</i>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <a title="删除" onclick="delAll()">
                    <i class="layui-btn layui-btn-normal" style="font-size:15px" >全部删除</i>
                </a>
            </td>
            <td colspan="2" >
                    商品数量
            </td>
            <td>
                <span id="span2"></span>
            </td>
        </tr>
        <tr>
            <td colspan="5" style="text-align: right">
                <input type="text" hidden name="sumPrice" class="sumPrice">
              <input type="submit" value="提交订单" class="layui-btn layui-btn-normal" style="font-size:15px">
            </td>
        </tr>
    </table>
    </form>
    </c:if>
    <c:if test="${shopCars.size()==0 }">
        <div style="text-align: center;margin-top: 250px;color: red">
            <h2><a href="${pageContext.request.contextPath }/product/" style="color: red" class="myc7">您还没有添加任何商品,快去选购吧</a></h2>
            <br />

        </div>
    </c:if>
</div>
</body>
<script type="text/javascript">
    function delAll() {
        var cof=confirm("确定要删除吗？");
        if(cof){
        $.ajax({
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "${pageContext.request.contextPath }/delAll" ,//url
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
    function deleteShopCar(car_id){
        var cof=confirm("确定要删除吗？");
        if(cof){
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath }/deleteShopCar" ,//url
                data:{"car_id":car_id},
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