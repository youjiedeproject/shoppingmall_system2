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
    <script>
        window.onload=function(){
            var i=1;
            var time1=setInterval(time,3000);
            function time(){
                var a=document.getElementById("myd7");
                a.src="${pageContext.request.contextPath}/img/b"+i+".jpg";
                i++;
                if(i==3){
                    i=1;
                }
            }

        }
    </script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mycss1.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>
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
</head>
<body>
<div>
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
    <div id="myc1">
        <c:if test="${empty userlogin}">
            请登录
        </c:if>
        <c:if test="${!empty userlogin}">
            欢迎你${userlogin.username}
            <a href="${pageContext.request.contextPath}/user/exitRegister">注销</a>
        </c:if>
        <c:if test="${empty userlogin}">
            ${remind!=null?remind:""}
            <a href="${pageContext.request.contextPath}/login.jsp">登录</a>
            <a href="${pageContext.request.contextPath}/admin/register.jsp">注册</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/showCatServlet?username=${userlogin.username}">购物车</a>
    </div></div>
<div class="clear"></div>
<div id="myc2">
    <ul>
        <li><a href="${pageContext.request.contextPath}/product/">首页</a></li>
        <c:forEach items="${categoryList}" var="cat">
        <li><a href="${pageContext.request.contextPath}/categoryProductListServlet?cid=${cat.cid}">${cat.cname}</a><li>
        </c:forEach>
            <div style="float: right">
                <form action="searchProduct" method="post">
                    <input type="text" name="pname" value="${pname}">
                    <input type="submit" value="搜索" >
                </form>
            </div>
    </ul>
</div>
<div>
    <img src="${pageContext.request.contextPath}/img/b1.jpg"  class="myc3" id="myd7"/>
</div>
<div>
    <img src="${pageContext.request.contextPath}/img/tittle1.png" class="myc3" />
</div>
<div style="width:100% ">
    <c:forEach items="${pageBean.pageData}" var="Product" >
        <div style="width:25%;float:left;height:250px">
            <a href="${pageContext.request.contextPath}/shoppingCatServlet?pid=${Product.pid}"><img src="${pageContext.request.contextPath}/images/${Product.pimage}" width="130px" height="130px"/></a>
            <p>${Product.pname}<br/>店铺价格¥${Product.market_price}</p>
        </div>
    </c:forEach>
</div>
<div class="clear">
</div>
<div style="text-align:center">
    <ul id="pageUl">
        <c:if test="${pageBean.currentPage!=1 }">
            <li><a href="${pageContext.request.contextPath }/product/paging?currentPage=${pageBean.currentPage-1}&pname=${pname}">上一页</a></li>
        </c:if>
        <c:if test="${pageBean.currentPage==1 }">
            <li><a>上一页</a></li>
        </c:if>
        <c:forEach begin="1" end="${pageBean.totalPage }" var="page">
            <c:if test="${page!=pageBean.currentPage }">
                <li><a href="${pageContext.request.contextPath }/product/paging?currentPage=${page }&pname=${pname}">${page }</a></li>
            </c:if>
            <c:if test="${page==pageBean.currentPage }">
                <li><font size="40px">${page }</font></li>
            </c:if>
        </c:forEach>
        <c:if test="${pageBean.currentPage!=pageBean.totalPage }">
            <li><a href="${pageContext.request.contextPath }/product/paging?currentPage=${pageBean.currentPage+1}&pname=${pname}">下一页</a></li>
        </c:if>
        <c:if test="${pageBean.currentPage==pageBean.totalPage }">
            <li>下一页</li>
        </c:if>
    </ul>

</div>
<div>
    <img src="${pageContext.request.contextPath}/img/tittle2.png" style="width: 900px;"/>
</div>
<div>

</div>

<div>
    <img src="${pageContext.request.contextPath}/img/bottom.png" style="width: 900px;"/>
</div>
<!--关于我们 联系我们 招贤纳士 法律声明 友情链接 支付方式 配送方式 广告声明-->
<div id="myd3">
    <a href="#">关于我们</a>
    <a href="#">联系我们</a>
    <a href="#">招贤纳士</a>
    <a href="#">法律声明</a>
    <a href="#">友情链接</a>
    <a href="#">支付方式</a>
    <a href="#">配送方式</a>
    <a href="#">广告声明</a>
</div>
<div id="myd4">
    Copyright ©2010-2017  &nbsp小杰商城&nbsp; 版权所有
</div>
</body>
</html>