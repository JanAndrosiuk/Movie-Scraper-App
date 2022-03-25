% rebase('base.tpl', title='Charts')
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
              <h3 class="page-header"><i class="icon_piechart"></i>Charts</h3>
              <ol class="breadcrumb">
                <li><i class="fa fa-home"></i><a href="/">Home</a></li>
                <li><i class="icon_piechart"></i>Charts 1</li>

              </ol>
            </div>
          </div>
          <div class="row">
            <!-- chart morris start -->
            <div class="col-lg-12">
              <section class="panel">
                <header class="panel-heading">
                  <h3></Char>
                      </header>
                      <div class="panel-body">
                        <div class="tab-pane" id="chartjs">
                      <div class="row">
                          <!-- Line -->
                          <div class="col-lg-12">
                              <section class="panel">
                                  <header class="panel-heading">
                                      BoxOffice Scatter plot
                                  </header>
                                  <div class="panel-body text-center">
                                    

									<body>
										<div style="width: 90%; height: 90%;" >
										<canvas id="chartJSContainer"></canvas>
										</div>
										<script>
											var ctx = document.getElementById('chartJSContainer').getContext('2d');
											var scatterChart = new Chart(ctx, {
												type: 'scatter',
												data: {
													datasets: {{!data_scatter}}
												},
												options: {
													scales: {
														xAxes: [{
															type: 'linear',
															position: 'bottom',
															scaleLabel: {
																labelString: 'Budget',
																display: true
															}
														}],
														yAxes: [{
															type: 'linear',
															position: 'bottom',
															scaleLabel: {
																labelString: 'Box Office',
																display: true
															}
														}]
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
                                      Revenue Bar chart
                                  </header>
                                  <div class="panel-body text-center">
																		
									<body>
										<div id="myDiv" style="width: 90%; height: 90%;"></div>
										<canvas id="chartJSContainer"></canvas>
										<script>
											var data = {{!data_box}};
											var layout = {
												title: 'Average movies revenue of 20 largest producers [USD]',
											};
											Plotly.newPlot('myDiv', data, layout);
										</script>
									</body>
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