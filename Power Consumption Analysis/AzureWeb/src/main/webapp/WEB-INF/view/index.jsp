<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Power Consumption Analytics</title>
        <script type="text/javascript">
            function isNumber(evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    alert("You can enter only digits!")
                    return false;
                }
                return true;
            }
        </script>

        <script type="text/javascript">
            //<![CDATA[
            try {
                if (!window.CloudFlare) {
                    var CloudFlare = [{verbose: 0, p: 0, byc: 0, owlid: "cf", bag2: 1, mirage2: 0, oracle: 0, paths: {cloudflare: "/cdn-cgi/nexp/dok3v=1613a3a185/"}, atok: "b274a8634124cafa9b77ae2d5fbebca3", petok: "0c4931b11db65e057eed90a30d0139b933bb7b0a-1470431826-1800", zone: "easy-development.com", rocket: "0", apps: {"abetterbrowser": {"ie": "7"}}, sha2test: 0}];
                    !function (a, b) {
                        a = document.createElement("script"), b = document.getElementsByTagName("script")[0], a.async = !0, a.src = "//ajax.cloudflare.com/cdn-cgi/nexp/dok3v=0489c402f5/cloudflare.min.js", b.parentNode.insertBefore(a, b)
                    }()
                }
            } catch (e) {
            }
            ;
            //]]>
        </script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js"></script>
        <script>

            function getModel(select) {
                var selectedString = select.options[select.selectedIndex].value;
                if (selectedString == 1)
                {
                    document.getElementById("model_regression").style.display = "block";
                } else {
                    document.getElementById("model_regression").style.display = "none";
                }
                if (selectedString == 2) {
                    document.getElementById("model_classification").style.display = "block";
                    document.getElementById("consumption").style.display = "block";
                } else {
                    document.getElementById("model_classification").style.display = "none";
                    document.getElementById("consumption").style.display = "none";
                }

            }
        </script>
        <style>

            body {
                font: 400 15px Lato, sans-serif;
                line-height: 1.8;
                color: #818181;
            }
            h2 {
                font-size: 24px;
                text-transform: uppercase;
                color: #303030;
                font-weight: 600;
                margin-bottom: 30px;
            }
            h4 {
                font-size: 19px;
                line-height: 1.375em;
                color: #303030;
                font-weight: 400;
                margin-bottom: 30px;
            }  
            .jumbotron {
                background-color: #f96154;
                color: #fff;
                padding: 100px 25px;
                font-family: Montserrat, sans-serif;
            }
            .container-fluid {
                padding: 60px 50px;
            }
            .bg-grey {
                background-color: #f6f6f6;
            }
            .logo-small {
                color: #f96154;
                font-size: 50px;
            }
            .logo {
                color: #f96154;
                font-size: 200px;
            }
            .thumbnail {
                padding: 0 0 15px 0;
                border: none;
                border-radius: 0;
            }
            .thumbnail img {
                width: 100%;
                height: 100%;
                margin-bottom: 10px;
            }
            .carousel-control.right, .carousel-control.left {
                background-image: none;
                color: #f96154;
            }
            .carousel-indicators li {
                border-color: #f96154;
            }
            .carousel-indicators li.active {
                background-color: #f96154;
            }
            .item h4 {
                font-size: 19px;
                line-height: 1.375em;
                font-weight: 400;
                font-style: italic;
                margin: 70px 0;
            }
            .item span {
                font-style: normal;
            }
            .panel {
                border: 1px solid #f96154; 
                border-radius:0 !important;
                transition: box-shadow 0.5s;
            }
            .panel:hover {
                box-shadow: 5px 0px 40px rgba(0,0,0, .2);
            }
            .panel-footer .btn:hover {
                border: 1px solid #f96154;
                background-color: #fff !important;
                color: #f96154;
            }
            .panel-heading {
                color: #fff !important;
                background-color: #f96154 !important;
                padding: 25px;
                border-bottom: 1px solid transparent;
                border-top-left-radius: 0px;
                border-top-right-radius: 0px;
                border-bottom-left-radius: 0px;
                border-bottom-right-radius: 0px;
            }
            .panel-footer {
                background-color: white !important;
            }
            .panel-footer h3 {
                font-size: 32px;
            }
            .panel-footer h4 {
                color: #aaa;
                font-size: 14px;
            }
            .panel-footer .btn {
                margin: 15px 0;
                background-color: #f96154;
                color: #fff;
            }
            .navbar {
                margin-bottom: 0;
                background-color: #f96154;
                z-index: 9999;
                border: 0;
                font-size: 12px !important;
                line-height: 1.42857143 !important;
                letter-spacing: 4px;
                border-radius: 0;
                font-family: Montserrat, sans-serif;
            }
            .navbar li a, .navbar .navbar-brand {
                color: #fff !important;
            }
            .navbar-nav li a:hover, .navbar-nav li.active a {
                color: #f96154 !important;
                background-color: #fff !important;
            }
            .navbar-default .navbar-toggle {
                border-color: transparent;
                color: #fff !important;
            }
            footer .glyphicon {
                font-size: 20px;
                margin-bottom: 20px;
                color: #f96154;
            }
            .slideanim {visibility:hidden;}
            .slide {
                animation-name: slide;
                -webkit-animation-name: slide;
                animation-duration: 1s;
                -webkit-animation-duration: 1s;
                visibility: visible;
            }
            @keyframes slide {
                0% {
                    opacity: 0;
                    transform: translateY(70%);
                } 
                100% {
                    opacity: 1;
                    transform: translateY(0%);
                }
            }
            @-webkit-keyframes slide {
                0% {
                    opacity: 0;
                    -webkit-transform: translateY(70%);
                } 
                100% {
                    opacity: 1;
                    -webkit-transform: translateY(0%);
                }
            }
            @media screen and (max-width: 768px) {
                .col-sm-4 {
                    text-align: center;
                    margin: 25px 0;
                }
                .btn-lg {
                    width: 100%;
                    margin-bottom: 35px;
                }
            }
            @media screen and (max-width: 480px) {
                .logo {
                    font-size: 150px;
                }
            }
        </style>
    </head>    
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <c:if test="${not empty error}">
            <div class="form-group row">        	    	
                <div class="alert alert-danger">    		
                    <c:if test="${error == 'no_value'}">
                        One or more field is empty. Please enter the value!
                    </c:if> 
                    <c:if test="${error == 'hour'}">
                        Time can be only in between 0 and 23. Please re-enter the value!
                    </c:if>    	
                    <c:if test="${error == 'invalid'}">
                        Invalid Output!
                    </c:if>    	
                    <c:if test="${error == 'maxdigit'}">
                        Maximum 5 digits are allowed.
                    </c:if>   
                    <c:if test="${error=='regression'}">  
                        You need to run regression first
                    </c:if>    
                </div>	    		    		    	
            </div>
        </c:if>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="#myPage">Logo</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#about">Data Analysis</a></li>
                        <li><a target="_blank" href="resources/Doc.docx">Documentation</a></li>
                        <li><a target="_blank" href="https://public.tableau.com/profile/publish/PartIII_12/InfluenceofTemperatureoverElectricityConsumptionforeachBuilding">Tableau Dashboard</a></li>
                        <li><a target="_blank" href="https://github.com/datascience7290/Assignment3">Github</a></li>
                        <li><a target="_blank" href="resources/presentation.pptx">Presentation</a></li>
                        <li><a target="_blank" href="resources/testdata.xlsx">Sample Data</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="jumbotron text-center">
            <h1>Power Consumption Analytics</h1> 
            <p>We specialize in data analytics</p> 

        </div>

        <!-- Container (About Section) -->
        <div id="about" class="container-fluid">
            <div class="row">
                <div class="col-sm-8">

                    <form method="POST" action="service" name="form">    
                        <div class="form-group row col-lg-4 col-lg-offset-2">
                            <label for="hour" class="col-sm-6 col-form-label">Time in hours</label>
                            <div class="col-sm-5">
                                <select id="hours" name="hours" class="form-control">
                                    <option value="0">0</option>
                                    <option value="1">1</option>                
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>                
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>  
                                    <option value="10">10</option>
                                    <option value="11">11</option>                
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>                
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>  
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>                
                                    <option value="23">23</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row col-lg-4 col-lg-offset-2">
                            <label for="day" class="col-sm-2 col-form-label">Date</label>
                            <div class="col-sm-4">
                                <span>
                                    <select id="days" name="days" class="form-control">
                                        <option value="1">1</option>                
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>                
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>  
                                        <option value="10">10</option>
                                        <option value="11">11</option>                
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>                
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>  
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>                
                                        <option value="23">23</option>
                                        <option value="16">24</option>                
                                        <option value="17">25</option>
                                        <option value="18">26</option>
                                        <option value="19">27</option>  
                                        <option value="20">28</option>
                                        <option value="21">29</option>
                                        <option value="22">30</option>                
                                        <option value="23">31</option>
                                    </select>
                                </span>

                            </div>

                            <div class="col-sm-5">
                                <span> <select id="month" name ="month" class="form-control">
                                        <option value="1">January</option>
                                        <option value="2">February</option>                
                                        <option value="3">March</option>
                                        <option value="4">April</option>
                                        <option value="5">May</option>
                                        <option value="6">June</option>
                                        <option value="7">July</option>
                                        <option value="8">August</option>
                                        <option value="9">September</option>                
                                        <option value="10">October</option>
                                        <option value="11">November</option>
                                        <option value="12">December</option>
                                    </select></span>
                            </div>

                        </div>

                        <div class="form-group row col-lg-4 col-lg-offset-2">
                            <label for="hour" class="col-sm-6 col-form-label">Temperature</label>
                            <div class="col-sm-5">
                                <input type="number" min ="-459" max="212" step="0.01" class="form-control" id="temperature" value ="0" name="temperature" required="required">
                            </div>
                        </div>
                        <div class="form-group row col-lg-4 col-lg-offset-2">
                            <label for="model" class="col-sm-6 col-form-label">Choose the Model</label>
                            <div class="col-sm-4">
                                <select name="model" class="form-control" id="models" style="width:200px;" onchange="getModel(this)">
                                    <option value="0">Select</option>
                                    <option value="1">Regression</option>
                                    <option value="2">Classification</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row col-lg-4 col-lg-offset-2" id="consumption" style="display:none;">
                            <label for="consumption" class="col-sm-6 col-form-label">Consumption(in kWh)</label>
                            <div class="col-sm-4">
                                <div>
                                    <input type="number" class="form-control" min="0" max="3000" value ="0" name="consumption" required="required"/><br>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row col-lg-8 col-lg-offset-2">
                            <div class="col-lg-5">
                                <div id="model_types">
                                    <div id="model_regression" style="display:none;">
                                        <input type="radio" name="classification" value="neural_prediction" > Neural Network<br>
                                        <input type="radio" name="classification" value="random_prediction"> Random Forest <br>
                                        <input type="radio" name="classification" value="regression_prediction"> Regression Tree <br>
                                        <input type="radio" name="classification" value="knn_prediction">KNN Prediction<br>
                                    </div>
                                    <div id="model_classification" style="display:none;">
                                        <input type="radio" name="classification" value="neural_class" >Neural Network Classification<br>
                                        <input type="radio" name="classification" value="logistic_class" >Logistic Regression<br>
                                        <input type="radio" name="classification" value="forest_class" >Random Forest<br>
                                        <input type="radio" name="classification" value="knn_class">KNN<br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">     
                            <div class="col-lg-4 col-lg-offset-4">
                                <input type="submit" onclick="location.href = '#predicted';return Validate(this);" class="btn btn-primary" />
                            </div>
                        </div>
                    </form>


                </div>
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-signal logo"></span>
                </div>
            </div>
        </div>

        <div id="predicted" class="container-fluid bg-grey">
            <div class="row">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-globe logo slideanim"></span>
                </div>
                <div class="col-sm-8">
                    <h2>Predicted Values</h2><br>
                    <div class="nav-control">
                        <div class="form-group row">   
                            <c:if test="${not empty output}">
                                <div class="alert alert-success"> 
                                    <c:if test="${not empty output_cluster}">   
                                        <h3>Predicted consumption by model is:  <c:out value="${output}"></c:out></h3>
                                        <h3>The above predicted value lies in: <c:out value="${output_cluster}"></c:out> as per K-Means</h3></c:if>
                                        </div>
                                        <div class="alert alert-success"> 
                                    <c:if test = "${empty output_cluster}">
                                        <h3>Predicted consumption by model is: <c:out value="${output}"></c:out></h3></c:if>  
                                        </div>  
                            </c:if>    
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Container (Services Section) -->


        <!-- Container (Portfolio Section) -->


        <!-- Container (Pricing Section) -->


        <!-- Container (Contact Section) -->


        <!-- Add Google Maps -->


        <footer class="container-fluid text-center">
            <a href="#myPage" title="To Top">
                <span class="glyphicon glyphicon-chevron-up"></span>
            </a>

        </footer>
        <script>
            function Validate(form){
                 var e = document.getElementById("models").value;

                if(e==0)
                {
                    
                    alert("Please select a model");
                    
                    return false;
                }
                
            }
        </script>
        <script>
            $(document).ready(function () {
                // Add smooth scrolling to all links in navbar + footer link
                $(".navbar a, footer a[href='#myPage']").on('click', function (event) {
                    // Make sure this.hash has a value before overriding default behavior
                    if (this.hash !== "") {
                        // Prevent default anchor click behavior
                        event.preventDefault();

                        // Store hash
                        var hash = this.hash;

                        // Using jQuery's animate() method to add smooth page scroll
                        // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
                        $('html, body').animate({
                            scrollTop: $(hash).offset().top
                        }, 900, function () {

                            // Add hash (#) to URL when done scrolling (default click behavior)
                            window.location.hash = hash;
                        });
                    } // End if
                });

                $(window).scroll(function () {
                    $(".slideanim").each(function () {
                        var pos = $(this).offset().top;

                        var winTop = $(window).scrollTop();
                        if (pos < winTop + 600) {
                            $(this).addClass("slide");
                        }
                    });
                });
            });
        </script>
    </body>
</html>