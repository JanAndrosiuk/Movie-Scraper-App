<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Pierwsze aplikacja stworzona w Bottle">
  <meta name="author" content="Maciej Wilamowski">

  <!-- Na potrzeby tworzenia aplikacji wyłączmy cachowanie zawartości.  -->
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
<title>{{title or 'Moja wspaniałą aplikacja'}}</title>

  <!-- Bootstrap core CSS -->
  <link href="/static/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
    <div class="container">
      <a class="navbar-brand" href="#">Super App!</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="#">Home
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Zakładka 1</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Zakładka 2</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
        {{!base}}
      </div>
    </div>
    <!-- Page Footer -->
    <div class="row">
    <footer class="page-footer small">
      <div class="col-lg-12">
        <div>Tutaj jest stopka, która pojawia się na każdej stronie.</div>
      </div>
    </footer>
    </div>
  </div>

  <!-- Bootstrap core JavaScript -->
  <script src="/static/vendor/jquery/jquery.slim.min.js"></script>
  <script src="/static/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
