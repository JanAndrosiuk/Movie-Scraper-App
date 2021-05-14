% rebase('bbase.tpl', title='Kontakt')
{{!zawartosc or ''}}

%
<div>
<h3>Adres</h3>
<p>ul. Pajtonowa 3/5</p>
<p>Warszawa 02-997</p>
<h3>Dane kontaktowe</h3>
<p>tel: 934 587 987</p>
</div>

<html>
<head>
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
</head>
<body>
    <div id="myDiv" style="width:800px;height:600px;"></div>
    <script>
        var trace1 = {
			"miesiace" : ["styczeĹ„", "luty", "marzec", "kwiecieĹ„", "maj"],
			"y" : [120, 150, 160, 155, 110, 180],
			type: 'scatter',
			name: 'Klientow'
		};

		var trace2 = {
			"miesiace" : ["styczeĹ„", "luty", "marzec", "kwiecieĹ„", "maj"],
			"y" : [14, 18, 15, 16, 12, 19],
			type: 'scatter',
			name: 'Zakupow'
		};

		var data = [trace1, trace2];
		
		var layout = {
			title: 'Klienci',
			xaxis: {
				title: 'Miesiace',
				showgrid: false,
				zeroline: false
			},
			yaxis: {
				title: 'Liczba',
				showline: false
			}
		};

		Plotly.newPlot('myDiv', data, layout);
    </script>
</body>
</html> 

<div>
<a style="text-decoration:none" href="http://localhost:8001/">Strona glowna</a>
</div>
% end
