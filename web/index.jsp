<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <link rel="stylesheet" href="/css/style.css">

</head>
<body>


<!-- Slideshow container -->
<div class="slideshow-container">

    <!-- Full-width images with number and caption text -->
    <div class="mySlides fade">
        <div class="numbertext">1 / 3</div>
        <img src="/image/img1.jpeg" style="width:100%">
        <%--        <div class="text"></div>--%>
    </div>

    <div class="mySlides fade">
        <div class="numbertext">2 / 3</div>
        <img src="/image/img2.jpeg" style="width:100%">
        <%--        <div class="text"></div>--%>
    </div>

    <div class="mySlides fade">
        <div class="numbertext">3 / 3</div>
        <img src="/image/img3.jpeg" style="width:100%">
        <%--        <div class="text"></div>--%>
    </div>

    <!-- Next and previous buttons -->
    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<br>

<!-- The dots/circles -->
<div style="text-align:center">
    <span class="dot" onclick="currentSlide(1)"></span>
    <span class="dot" onclick="currentSlide(2)"></span>
    <span class="dot" onclick="currentSlide(3)"></span>
</div>


<div class="main">
    <form action="/login" method="post" onsubmit="return validate()">
        <p id="p" style="color: red"></p>
        <input type="text" id="email" name="email" placeholder="Input you email"><br>
        <input type="password" id="password" name="password" placeholder="Input you password"><br>
        <input type="submit" value="login" style="text-transform: uppercase">
    </form>
</div>
<p id="pid" class="p" style="width: 100px; height: 100px; border: 1px solid black"></p>
<button id="hide">hide</button>
<button id="show">show</button>
</body>

COMMENDD<%--commentSSSS--%>COMMENDD<%--commentSSSS--%>
<script src="/js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="/js/slider.js" type="text/javascript"></script>
<script>
    // $(document).ready(function () {
    //     $('#hide').on('click', function () {
    //         $('#pid').hide(1000)
    //     })
    //     $('#show').on('click', function () {
    //         $('#pid').show()
    //     })
    //
    // })


    function validate() {
        var email = document.getElementById("email")
        var password = document.getElementById("password")

                if (!email.value ) {
                    email.style.border = "2px solid red";
                    document.getElementById("p").innerHTML = "please input email and password";
                    return false;
                }
                if (!password.value ) {
                    password.style.border = "2px solid red";
                    document.getElementById("p").innerHTML = "please input email and password"
                    return false;
                }


        return true;
    }

    // }


    //    let p = document.getElementById("pid")
    //    let button = document.getElementById("click");/.
    //    button.onclick = function() {
    //p.style.width = "200px"
    //        p.style["border"] = "2px solid red"
    //    }

</script>
</html>
