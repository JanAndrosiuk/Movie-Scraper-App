# MovieScraperApp
_Jan Androsiuk [[GitHub]](https://github.com/JanAndrosiuk) & Szymon Socha [[GitHub]](https://github.com/szymonsocha)_, January 2021

We present a simple python WebApp made in _bottle_ library. The app scrapes movie data from popular polish movie database `Filmweb.pl` and stores information about 
community ratings, budget, boxoffice, oscar nominations, and reviews for each movie.
Based on downloaded data, we make simple visualizations using _plotly_ library and JavaScript.

<p align="center">
  <img width="400" height="240" src="https://user-images.githubusercontent.com/58808512/160018314-dd00181c-cd58-41bb-84cb-e4e608230a69.png", style="border-radius:50%">
</p>

## First Run
The App requires no data at the first run. Simply run the _main.py_ and open http://localhost:8001/. After that navigate to left side-panel and click *Data - Update Dataset*. Then, get back to python console where you've run the code, and input the number of filmweb pages you woud like to scrape (1 page ~ 10 movie records). You can track the download progress as well as various warnings in the console output. Once the scraping process is done, you may check plotly visualizations by navigating in sidebar panel.

## References
[Used Bootstrap Template](https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/)

## License
MIT License | Copyright (c) 2021 Jan Androsiuk, Szymon Socha
