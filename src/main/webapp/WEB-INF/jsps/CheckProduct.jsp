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
<div style="width: 100%;width:1000px;margin: auto">
    <table style="width:100%">
        <tr>
            <td style="width: 50%">
                <div style="text-align: center">
                    <img src="${pageContext.request.contextPath}/images/${Product.pimage}" width="240px" height="300px"/>
                </div>
            </td>
            <td style="width: 50%">
                    <h1 style="color: red;text-align: center">商品详情</h1>
                    <table>
                        <tr>
                            <td style="width: 30%"><h3>商品名称</h3></td>
                            <td style="width: 70%"><h3>[精品]${Product.pname}</h3></td>
                        </tr>
                        <tr>
                            <td style="width: 30%"><h3>商品详情</h3></td>
                            <td style="width: 70%"> <h3>${Product.pdesc}</h3></td>
                        </tr>
                        <tr>
                            <td style="width: 30%"><h3>商品价格</h3></td>
                            <td style="width: 70%"> <h3>${Product.shop_price}</h3></td>
                        </tr>
                        <tr>
                            <td style="width: 30%"><h3>库存量</h3></td>
                            <td style="width: 70%"> <h3>${Product.pnumber}</h3></td>
                        </tr>
                        <tr>
                            <td style="width: 30%"><h3>加入购物车</h3></td>
                            <td style="width: 70%;text-align: center">
                                <a title="加入购物车" id="addShopCar"  href="javascript:;">
                                    <i class="layui-icon" style="font-size: 50px">&#xe657;</i>
                                </a>
                            </td>
                        </tr>
                    </table>
                <div style="text-align: center">
                <a title="返回"   onClick="javascript :history.back(-1)">
                    <i class="layui-btn layui-btn-normal" style="font-size: 15px">返回</i>
                </a>
               </div>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    $(function(){
        $("#addShopCar").click(
            function(){
                $.ajax({
                    type:"post",
                    url:"${pageContext.request.contextPath}/addShopCar?pid=${Product.pid}&uid=${userlogin.uid}",
                    success:function(data){
                        if(data!=null){
                            alert("添加成功！")
                        }else{
                            alert("添加失败！")
                        }
                    },
                    async:true
                });
            }
        )
    });
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