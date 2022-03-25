<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Creative - Bootstrap 3 Responsive Admin Template">
  <meta name="author" content="Jan Androsiuk & Szymon Socha">
  <meta name="keyword" content="Python, Project, WebApp, Bootstrap">
  <link rel="shortcut icon" href="/static/img/favicon.png">

  <title>Creative - Bootstrap Admin Template</title>

  <!-- Bootstrap CSS -->
  <link href="/static/css/bootstrap.min.css" rel="stylesheet">
  <!-- bootstrap theme -->
  <link href="/static/css/bootstrap-theme.css" rel="stylesheet">
  <!--external css-->
  <!-- font icon -->
  <link href="/static/css/elegant-icons-style.css" rel="stylesheet" />
  <link href="/static/css/font-awesome.min.css" rel="stylesheet" />
  <!-- easy pie chart-->
  <link href="/static/assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen" />
  <!-- owl carousel -->
  <link rel="stylesheet" href="/static/css/owl.carousel.css" type="text/css">
  <link href="/static/css/jquery-jvectormap-1.2.2.css" rel="stylesheet">
  <!-- Custom styles -->
  <link href="/static/css/widgets.css" rel="stylesheet">
  <link href="/static/css/style.css" rel="stylesheet">
  <link href="/static/css/style-responsive.css" rel="stylesheet" />
  <link href="/static/css/xcharts.min.css" rel=" stylesheet">
  <link href="/static/css/jquery-ui-1.10.4.min.css" rel="stylesheet">


  <!-- =======================================================
    Theme Name: NiceAdmin
    Theme URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
    Author: BootstrapMade
    Author URL: https://bootstrapmade.com
  ======================================================= -->
</head>

<body>
  <!-- container section start -->
  <section id="container" class="">


    <header class="header dark-bg">
      <div class="toggle-nav">
        <div class="icon-reorder tooltips" data-original-title="Toggle Navigation" data-placement="bottom"><i class="icon_menu"></i></div>
      </div>

      <!--logo start-->
      <a href="/" class="logo">Project <span class="lite">Python</span></a>
      <!--logo end-->
    </header>
    <!--header end-->

    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu">
          <li class="active">
            <a class="" href="/">
                          <i class="icon_documents_alt"></i>
                          <span>Our code</span>
                      </a>
          </li>
          <li class="sub-menu">
            <a href="javascript:;" class="">
            
                          <i class="icon_piechart"></i>
                          <span>Plots</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
            <ul class="sub">
			  <li><a class="" href="/wykresy/">Charts - 1st group</a></li>
              <li><a class="" href="/wykresy2/">Charts - 2nd group</a></li>
            </ul>
                      </a>

          </li>

          <li class="sub-menu">
            <a href="javascript:;" class="">
                          <i class="icon_table"></i>
                          <span>Data</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
            <ul class="sub">
              <li><strong><a style="color: MediumSeaGreen; border:2px solid MediumSeaGreen; border-radius: 10px;" class="" href="/scrap/">Update dataset</a></strong></li>
              <li><a class="" href="/basic_table/">Dataframe</a></li>
            </ul>
          </li>
        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
	
	{{!base}}

  </section>
  <!-- container section start -->

  <!-- javascripts -->
  <script src="/static/js/jquery.js"></script>
  <script src="/static/js/jquery-ui-1.10.4.min.js"></script>
  <script src="/static/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="/static/js/jquery-ui-1.9.2.custom.min.js"></script>
  <!-- bootstrap -->
  <script src="/static/js/bootstrap.min.js"></script>
  <!-- nice scroll -->
  <script src="/static/js/jquery.scrollTo.min.js"></script>
  <script src="/static/js/jquery.nicescroll.js" type="text/javascript"></script>
  <!-- charts scripts -->
  <script src="/static/assets/jquery-knob/js/jquery.knob.js"></script>
  <script src="/static/js/jquery.sparkline.js" type="text/javascript"></script>
  <script src="/static/assets/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
  <script src="/static/js/owl.carousel.js"></script>
      <!--script for this page only-->
    <script src="/static/js/jquery.rateit.min.js"></script>
    <!-- custom select -->
    <script src="/static/js/jquery.customSelect.min.js"></script>
    <script src="/static/assets/chart-master/Chart.js"></script>

    <!--custome script for all page-->
    <script src="/static/js/scripts.js"></script>
    <!-- custom script for this page-->
    <script src="/static/js/sparkline-chart.js"></script>
    <script src="/static/js/easy-pie-chart.js"></script>
    <script src="/static/js/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="/static/js/jquery-jvectormap-world-mill-en.js"></script>
    <script src="/static/js/xcharts.min.js"></script>
    <script src="/static/js/jquery.autosize.min.js"></script>
    <script src="/static/js/jquery.placeholder.min.js"></script>
    <script src="/static/js/gdp-data.js"></script>
    <script src="/static/js/morris.min.js"></script>
    <script src="/static/js/sparklines.js"></script>
    <script src="/static/js/charts.js"></script>
    <script src="/static/js/jquery.slimscroll.min.js"></script>
	
    <!-- custom chart script for this page only-->
    <script src="/static/js/chartjs-custom.js"></script>
	
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>


    <script>


      //knob
      $(function() {
        $(".knob").knob({
          'draw': function() {
            $(this.i).val(this.cv + '%')
          }
        })
      });

      //carousel
      $(document).ready(function() {
        $("#owl-slider").owlCarousel({
          navigation: true,
          slideSpeed: 300,
          paginationSpeed: 400,
          singleItem: true

        });
      });

      //custom select box

      $(function() {
        $('select.styled').customSelect();
      });

      /* ---------- Map ---------- */
      $(function() {
        $('#map').vectorMap({
          map: 'world_mill_en',
          series: {
            regions: [{
              values: gdpData,
              scale: ['#000', '#000'],
              normalizeFunction: 'polynomial'
            }]
          },
          backgroundColor: '#eef3f7',
          onLabelShow: function(e, el, code) {
            el.html(el.html() + ' (GDP - ' + gdpData[code] + ')');
          }
        });
      });
    </script>

</body>

</html>