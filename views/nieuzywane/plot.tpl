<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
</head>

    <body>
    <div style="width: 90%; height: 90%;" >
    <canvas id="myRadarChart"></canvas>
    </div>


<script>
	var ctx = document.getElementById('myRadarChart');
    var myRadarChart = new Chart(ctx,{
        type: 'radar',
        data: {
            labels:["1","2","3","4"],
			datasets:[{
				label:"Produkty",
				data:[120, 20, 230, 450]
			}]
        }
	});

</script>

</body>
</html> 