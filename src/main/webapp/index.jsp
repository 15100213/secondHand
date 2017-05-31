<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sh.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sh.dao.*" %>
<%@ page import="com.sh.dao.impl.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>电子商城</title>
    <!--根据设备的宽度调整缩放比例   -->
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/sweetalert2.min.css">
    <link rel="stylesheet" href="css/leftMenu.css">
    <link rel="stylesheet" href="css/head.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/my.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <!-- 引入自定义css文件 style.css -->
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
    <style type="text/css">
        #banner img {
            max-width: 100%;
            max-height: 460px;
        }
    </style>
</head>
<body>
<!--创建整体布局DIV-->
<div  class="container">
    <!-- 头部DIV -->
    <%@include file="head.jsp" %>
    <!--左侧菜单-->
    <div class="left-menu">
        <ul>
            <li><a href="index.jsp" >首页</a></li>
            <c:forEach var="kind" items="${sessionScope.listKind}">
                <li><a href="product_list_by_kid.jsp?kid=${kind.id}" >${kind.kname}</a></li>
            </c:forEach>
            <li><a href="#miao">回到顶部</a></li>
        </ul>
    </div>
    <!---左侧菜单结束->
    <!--创建imgDIV-->
    <div class="container">
        <script>
            $(function () {
                // 初始化轮播
                $(".start-slide").click(function () {
                    $("##carousel-example-generic").carousel('cycle');
                });
            });
        </script>
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000"
             style="height:450px">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <%! List<Hot> listHot;
                %>
                <%
                    HotDAO hd = new HotDAOImpl();
                    listHot = hd.findAll();
                    session.setAttribute("listHot", listHot);
                %>
                <li data-target="#carousel-example-generic" data-slide-to="0"
                    class="active"></li>
                <c:forEach var="index" begin="1" end="${fn:length(listHot)-1}" step="1">
                    <li data-target="#carousel-example-generic" data-slide-to="${index}"></li>
                </c:forEach>
            </ol>

            <!-- Wrapper for slides -->
            <div id="banner" class="carousel-inner" role="listbox">
                <div class="item active">
                    <%
                        ProductDAO productDao = new ProductDAOImpl();
                        Integer id = listHot.get(0).getPid();
                        Product product = productDao.select(id);
                        session.setAttribute("product",product);
                    %>
                    <a href="product_info.jsp?id=${sessionScope.listHot[0].pid}">
                        <img src="${sessionScope.product.pimage}" alt="${sessionScope.product.pname}">
                    </a>
                </div>
                <c:forEach var="index" begin="1" end="${fn:length(listHot)-1}" step="1">
                    <c:set var="index1" value="${index}" scope="session"></c:set>
                    <div class="item">
                        <%
                            int index = (int)session.getAttribute("index1");
                            id = listHot.get(index).getPid();
                            product = productDao.select(id);
                            session.setAttribute("product",product);
                        %>
                        <a href="product_info.jsp?id=${sessionScope.listHot[index].id}">
                            <img src="${sessionScope.product.pimage}" alt="${sessionScope.product.pname}" width="100%" height="100%">
                        </a>
                    </div>
                </c:forEach>
            </div>
            <!-- Controls -->
            <a class="carousel-control left" href="#carousel-example-generic"
               role="button" data-slide="prev"> <span
                    class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic"
               role="button" data-slide="next"> <span
                    class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    <!--创建adDIV-->

    <!--创建newProductDIV-->
    <div class="container">
        <div class="row">
            <h3>所有商品</h3>
        </div>
        <jsp:include page="product_list.jsp"></jsp:include>

    </div>
</div>
<%@ include file="foot.jsp" %>
</body>

</html>