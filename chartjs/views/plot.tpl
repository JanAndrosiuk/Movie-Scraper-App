<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
</head>

    <body>
    <div style="width: 90%; height: 90%;" >
    <canvas id="chartJSContainer"></canvas>
    </div>
<script>
    var options = {
        responsive: true,
        maintainAspectRatio: false,
        type: 'bubble',
        data: {
            datasets: {{!data}}
        }
        }

var ctx = document.getElementById('chartJSContainer').getContext('2d');
new Chart(ctx, options);
</script>
    
</body>
</html> 
