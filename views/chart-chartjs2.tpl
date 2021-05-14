% rebase('base.tpl', title='Wykresy')
{{!zawartosc or ''}}

%
      <head>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
		<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
	  </head>
	  
	  <!--main content start-->
      <section id="main-content">
        <section class="wrapper">
          <div class="row">
            <div class="col-lg-12">
              <h3 class="page-header"><i class="icon_piechart"></i> Chart</h3>
              <ol class="breadcrumb">
                <li><i class="fa fa-home"></i><a href="/">Home</a></li>
                <li><i class="icon_piechart"></i>Chart</li>

              </ol>
            </div>
          </div>
          <div class="row">
            <!-- chart morris start -->
            <div class="col-lg-12">
              <section class="panel">
                <header class="panel-heading">
                  <h3>General Chart</Char>
                      </header>
                      <div class="panel-body">
                        <div class="tab-pane" id="chartjs">
                      <div class="row">
                          <!-- Line -->
                          <div class="col-lg-12">
                              <section class="panel">
                                  <header class="panel-heading">
                                      Polar Chart
                                  </header>
                                  <div class="panel-body text-center">
                                    

									<body>
										<div style="width: 90%; height: 90%;" >
										<canvas id="chartJSContainer"></canvas>
										</div>
										<script>
											var ctx = document.getElementById('chartJSContainer').getContext('2d');
											var scatterChart = new Chart(ctx, {
												"type": "polarArea",
												"data" :{
													
													"labels": {{!labels_pie}},
													
													"datasets":[{
														"label":"Gatunki",
														"data": {{!dane_pie}},
														"backgroundColor":["rgb(255, 99, 132)","rgb(75, 192, 192)","rgb(255, 205, 86)","rgb(201, 203, 207)","rgb(54, 162, 235)"]
													}]

												},
												options: {
													scale: {
														ticks: {
															display: false,
															maxTicksLimit: 10
														}
													},
													title: {
														display: true,
														text: 'Gatunek a skumulowany Boxoffice'
													}
												}
											});

										</script>
									</body>
									
									
                                  </div>
                              </section>
                          </div>
                      </div>
                      <div class="row">
                          <!-- Bar -->
                          <div class="col-lg-12">
                              <section class="panel">
                                  <header class="panel-heading">
                                      Radar
                                  </header>
                                  <div class="panel-body text-center">
									<body>
										<div id="myDiv" style="width: 90%; height: 90%;"></div>
										<canvas id="chartJSContainer"></canvas>
										<script>
											var data = {{!dane_radar}};
											var layout = {
												title:'Podsumowujący',
												polar: {
													radialaxis: {
													visible: true,
													range: [0, 80]
													}
												}
											};
											Plotly.newPlot("myDiv", data, layout)
										</script>
                                  </div>
                              </section>
                          </div>

                  </div>
                      </div>
                      </div>
                    </section>
              </div>
              <!-- chart morris start -->
            </div>
      </section>
      <!--main content end-->

% end