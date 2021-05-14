% rebase('base.tpl', title=None)
{{!zawartosc}}

    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!--overview start-->
        <div class="row">
          <div class="col-lg-12">
            <h3 class="page-header"><i class="fa fa-laptop"></i> Nasz kod</h3>
            <ol class="breadcrumb">
              <li><i class="fa fa-home"></i><a href="/">Home</a></li>
              <li><i class="fa fa-laptop"></i>Nasz kod</li>
            </ol>
          </div>
        </div>

        <div class="row">
			<div class="col-lg-4 col-md-6 col-sm-12">
			<h4>Autorami aplikacji sa: Jan Androsiuk i Szymon Socha</h4>
			<p class="text-justify"> kod Python: </p>
			</div>

        </div>



<!-- HTML generated using hilite.me --><div style="background: #ffffff; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #008800; font-weight: bold">from</span> <span style="color: #bb0066; font-weight: bold">bottle</span> <span style="color: #008800; font-weight: bold">import</span> route, run, template, static_file
<span style="color: #008800; font-weight: bold">import</span> <span style="color: #bb0066; font-weight: bold">requests</span>
<span style="color: #008800; font-weight: bold">import</span> <span style="color: #bb0066; font-weight: bold">json</span>
<span style="color: #008800; font-weight: bold">import</span> <span style="color: #bb0066; font-weight: bold">re</span>
<span style="color: #008800; font-weight: bold">from</span> <span style="color: #bb0066; font-weight: bold">bs4</span> <span style="color: #008800; font-weight: bold">import</span> BeautifulSoup
<span style="color: #008800; font-weight: bold">import</span> <span style="color: #bb0066; font-weight: bold">pandas</span> <span style="color: #008800; font-weight: bold">as</span> <span style="color: #bb0066; font-weight: bold">pd</span>
<span style="color: #008800; font-weight: bold">import</span> <span style="color: #bb0066; font-weight: bold">numpy</span> <span style="color: #008800; font-weight: bold">as</span> <span style="color: #bb0066; font-weight: bold">np</span>
<span style="color: #008800; font-weight: bold">from</span> <span style="color: #bb0066; font-weight: bold">time</span> <span style="color: #008800; font-weight: bold">import</span> sleep
<span style="color: #008800; font-weight: bold">from</span> <span style="color: #bb0066; font-weight: bold">tqdm</span> <span style="color: #008800; font-weight: bold">import</span> tqdm_notebook <span style="color: #008800; font-weight: bold">as</span> tqdm <span style="color: #888888"># Progress bar</span>
<span style="color: #888888"># tqdm().pandas()</span>
<span style="color: #008800; font-weight: bold">from</span> <span style="color: #bb0066; font-weight: bold">IPython.display</span> <span style="color: #008800; font-weight: bold">import</span> display, HTML

wejscie = <span style="color: #0000DD; font-weight: bold">0</span>
df = pd.DataFrame()

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/static/&lt;path:path&gt;&#39;</span>, name=<span style="color: #dd2200; background-color: #fff0f0">&#39;static&#39;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">static</span>(path):
    <span style="color: #008800; font-weight: bold">return</span> static_file(path, root=<span style="color: #dd2200; background-color: #fff0f0">&#39;./static&#39;</span>)

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/&#39;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">glowna</span>():
    <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&#39;index&#39;</span>, zawartosc=<span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Strona główna&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;/wykresy&quot;</span>)
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;/wykresy/&quot;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">wykresy</span>():
    <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&quot;chart-chartjs&quot;</span>, data_scatter=dane_scatter, data_box=Dict_bar, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Wykresy&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;/wykresy2&quot;</span>)
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;/wykresy2/&quot;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">wykresy2</span>():
    <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&quot;chart-chartjs2&quot;</span>, labels_pie=labels_pie, dane_pie=dane_pie, dane_radar=list_radar, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Wykresy2&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/kod&#39;</span>)
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/kod/&#39;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">kod</span>():
    <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&#39;kod&#39;</span>, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Kod&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)

<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/basic_table&#39;</span>)
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/basic_table/&#39;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">table</span>():
    merg = pd.read_csv(<span style="color: #dd2200; background-color: #fff0f0">&quot;test500.csv&quot;</span>)
    z = HTML(merg.to_html())
    tables=merg.to_html()
    <span style="color: #888888">#tables = HTML( merg.to_html().replace(&quot;\\n&quot;,&quot;&lt;br&gt;&quot;))</span>
    <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&#39;table&#39;</span>, tabela=tables, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Tabela&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)
      
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/scrap&#39;</span>)
<span style="color: #555555">@route</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;/scrap/&#39;</span>)
<span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">scrap</span>():
    <span style="color: #008800; font-weight: bold">global</span> wejscie
    <span style="color: #008800; font-weight: bold">global</span> df
    <span style="color: #008800; font-weight: bold">global</span> dane_scatter
    <span style="color: #008800; font-weight: bold">global</span> Dict_bar
    <span style="color: #008800; font-weight: bold">if</span> (wejscie == <span style="color: #0000DD; font-weight: bold">0</span>):
        df_check = pd.DataFrame()
        wejscie+=<span style="color: #0000DD; font-weight: bold">1</span>
    <span style="color: #008800; font-weight: bold">else</span>:
        df_check = df
        
<span style="color: #888888">###############################</span>
<span style="color: #888888">#POCZATEK SCRAPERA</span>
<span style="color: #888888">###############################</span>

    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">basic_info_list</span>(num_pages):
        dane_ranking=[]    
        <span style="color: #008800; font-weight: bold">for</span> i, x <span style="color: #008800">in</span> <span style="color: #003388">enumerate</span>(tqdm(<span style="color: #003388">range</span>(<span style="color: #0000DD; font-weight: bold">1</span>, num_pages+<span style="color: #0000DD; font-weight: bold">1</span>))):             
            bs = BeautifulSoup(requests.get(<span style="color: #dd2200; background-color: #fff0f0">&quot;https://www.filmweb.pl/films/search?orderBy=popularity&amp;descending=true&amp;page=&quot;</span>+<span style="color: #003388">str</span>(x)).text)
            lista = bs.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;ul&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;id&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;searchResult&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:[<span style="color: #dd2200; background-color: #fff0f0">&#39;resultsList&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;hits&#39;</span>]})
            <span style="color: #008800; font-weight: bold">for</span> j, li <span style="color: #008800">in</span> <span style="color: #003388">enumerate</span>(lista):
                single=[]
    <span style="color: #888888"># TITLE -&gt; JESLI NIE ZAGRANICZNY, TO KRAJOWY</span>
                <span style="color: #008800; font-weight: bold">if</span> (li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__originalTitle&quot;</span>}) != <span style="color: #003388">None</span>):
                    single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__originalTitle&quot;</span>}).text)
                <span style="color: #008800; font-weight: bold">else</span>: 
                    single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;h2&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__title&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;itemprop&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;name&quot;</span>}).text)
    <span style="color: #888888"># MAIN GENRE:     </span>
                single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__info--genres&quot;</span>}).find(<span style="color: #dd2200; background-color: #fff0f0">&#39;a&#39;</span>).text)
    <span style="color: #888888"># DATE            </span>
                single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__year&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;itemprop&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;datePublished&quot;</span>})[<span style="color: #dd2200; background-color: #fff0f0">&#39;content&#39;</span>])
    <span style="color: #888888"># DIRECTOR:</span>
                single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__info--directors&quot;</span>}).find(<span style="color: #dd2200; background-color: #fff0f0">&#39;span&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;itemprop&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;name&quot;</span>}).text)
    <span style="color: #888888"># RATING</span>
                single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;span&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;rateBox__rate&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;itemprop&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;ratingValue&#39;</span>}).text) 
    <span style="color: #888888"># NUMBER OF REVIEWS:            </span>
                single.append(li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__extends&quot;</span>}).findChildren(<span style="color: #dd2200; background-color: #fff0f0">&#39;span&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:[<span style="color: #dd2200; background-color: #fff0f0">&quot;rateBox__votes&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;rateBox__votes--count&quot;</span>], <span style="color: #dd2200; background-color: #fff0f0">&quot;itemprop&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;ratingCount&quot;</span>})[<span style="color: #0000DD; font-weight: bold">0</span>][<span style="color: #dd2200; background-color: #fff0f0">&#39;content&#39;</span>])
    <span style="color: #888888"># MOVIE LINK:</span>
                single.append(<span style="color: #dd2200; background-color: #fff0f0">&quot;https://www.filmweb.pl&quot;</span>+li.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;a&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&quot;class&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;filmPreview__link&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;itemprop&quot;</span>:<span style="color: #dd2200; background-color: #fff0f0">&quot;url&quot;</span>})[<span style="color: #dd2200; background-color: #fff0f0">&#39;href&#39;</span>])
                dane_ranking.append(single)
        <span style="color: #008800; font-weight: bold">return</span> dane_ranking
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">pre_process_basic</span>(ll):
        df = pd.DataFrame(ll, columns=[<span style="color: #dd2200; background-color: #fff0f0">&quot;Title&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Main genre&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Date&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Director&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Average Rating&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Number of reviews&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;Link&quot;</span>])
        df.dropna(inplace=<span style="color: #003388">True</span>)
        df.reset_index(drop=<span style="color: #003388">True</span>, inplace=<span style="color: #003388">True</span>)
        df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Date&#39;</span>]= pd.to_datetime(df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Date&#39;</span>])
        df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Number of reviews&#39;</span>] = df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Number of reviews&#39;</span>].astype(<span style="color: #003388">int</span>)
        df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Average Rating&#39;</span>] = df[<span style="color: #dd2200; background-color: #fff0f0">&#39;Average Rating&#39;</span>].map(<span style="color: #008800; font-weight: bold">lambda</span> x: x.replace(<span style="color: #dd2200; background-color: #fff0f0">&#39;,&#39;</span>,<span style="color: #dd2200; background-color: #fff0f0">&#39;.&#39;</span>))
        <span style="color: #008800; font-weight: bold">return</span> df
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">detailed</span>(basic_scrapped):
        movie_list = basic_scrapped.Link.values
        dane_detail=[]
        <span style="color: #008800; font-weight: bold">for</span> i, x <span style="color: #008800">in</span> <span style="color: #003388">enumerate</span>(tqdm(movie_list)):
            single=[]
            bs = BeautifulSoup(requests.get(x).text)   
            tabela_header = bs.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;filmOtherInfoSection__group&#39;</span>}).findAll(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;filmInfo__header&#39;</span>})
            tabela_info = bs.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;filmOtherInfoSection__group&#39;</span>}).findAll(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;filmInfo__info&#39;</span>})
            slownik = <span style="color: #003388">dict</span>([[o.text,j] <span style="color: #008800; font-weight: bold">for</span> o,j <span style="color: #008800">in</span> <span style="color: #003388">zip</span>(tabela_header, tabela_info) <span style="color: #008800; font-weight: bold">if</span> o.text <span style="color: #008800">in</span> [<span style="color: #dd2200; background-color: #fff0f0">&#39;boxoffice&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;budżet&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;studio&#39;</span>]])                                         
    <span style="color: #888888">#         print(slownik)</span>
        <span style="color: #888888"># BOX OFFICE:</span>
            <span style="color: #008800; font-weight: bold">if</span> (<span style="color: #dd2200; background-color: #fff0f0">&#39;boxoffice&#39;</span> <span style="color: #008800">in</span> slownik.keys()):
                <span style="color: #008800; font-weight: bold">try</span>:
                    single.append(slownik[<span style="color: #dd2200; background-color: #fff0f0">&#39;boxoffice&#39;</span>].find(<span style="color: #dd2200; background-color: #fff0f0">&#39;div&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>: [<span style="color: #003388">None</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;boxoffice&#39;</span>]}).text)
                <span style="color: #008800; font-weight: bold">except</span>:
                    <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;ERROR w BOXOFFICE&quot;</span>, basic_scrapped.loc[[i]].Title)
            <span style="color: #008800; font-weight: bold">else</span>: 
                single.append(np.nan)
                <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;BRAK INFORMACJI O BOXOFFICE&quot;</span>, basic_scrapped.loc[[i]].Title, <span style="color: #dd2200; background-color: #fff0f0">&#39;</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">----------------------------------------------&#39;</span>)   
        <span style="color: #888888"># BUDGET:</span>
            <span style="color: #008800; font-weight: bold">if</span> (<span style="color: #dd2200; background-color: #fff0f0">&#39;budżet&#39;</span> <span style="color: #008800">in</span> slownik.keys()):
                single.append(slownik[<span style="color: #dd2200; background-color: #fff0f0">&#39;budżet&#39;</span>].text)                                                       
            <span style="color: #008800; font-weight: bold">else</span>: 
                single.append(np.nan)
                <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;BRAK INFORMACJI O BUDZECIE&quot;</span>, basic_scrapped.loc[[i]].Title, <span style="color: #dd2200; background-color: #fff0f0">&#39;</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">----------------------------------------------&#39;</span>)
        <span style="color: #888888"># PRODUCTION COMPANY:</span>
            <span style="color: #008800; font-weight: bold">if</span> (<span style="color: #dd2200; background-color: #fff0f0">&#39;studio&#39;</span> <span style="color: #008800">in</span> slownik.keys()):
                single.append(slownik[<span style="color: #dd2200; background-color: #fff0f0">&#39;studio&#39;</span>].text)                                                       
            <span style="color: #008800; font-weight: bold">else</span>: 
                single.append(np.nan)
                <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;BRAK INFORMACJI O PRODUCENCIE&quot;</span>, basic_scrapped.loc[[i]].Title, <span style="color: #dd2200; background-color: #fff0f0">&#39;</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">----------------------------------------------&#39;</span>)            
        <span style="color: #888888"># AWARDS:</span>
            <span style="color: #008800; font-weight: bold">try</span>:
                single.append(bs.find(<span style="color: #dd2200; background-color: #fff0f0">&#39;a&#39;</span>, {<span style="color: #dd2200; background-color: #fff0f0">&#39;class&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;awards__link&#39;</span>}).text)
            <span style="color: #008800; font-weight: bold">except</span>:
                <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&quot;BRAK INFORMACJI O NAGRODACH&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">----------------------------------------------&#39;</span>)  
                single.append(<span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>)
            <span style="color: #008800; font-weight: bold">if</span> ((i+<span style="color: #0000DD; font-weight: bold">1</span>)%<span style="color: #0000DD; font-weight: bold">30</span>==<span style="color: #0000DD; font-weight: bold">0</span> &amp; i+<span style="color: #0000DD; font-weight: bold">1</span>!=<span style="color: #003388">len</span>(movie_list)): 
                <span style="color: #008800; font-weight: bold">print</span>(<span style="color: #dd2200; background-color: #fff0f0">&#39;----------------------------------------------</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">PRZERWA ANTYBOTOWA</span><span style="color: #0044dd; background-color: #fff0f0">\n</span><span style="color: #dd2200; background-color: #fff0f0">----------------------------------------------&#39;</span>)
                sleep(<span style="color: #0000DD; font-weight: bold">1</span>)
            dane_detail.append(single)
        <span style="color: #008800; font-weight: bold">return</span> dane_detail
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">producent</span>(x):
        <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;\(&#39;</span>, x)): <span style="color: #008800; font-weight: bold">return</span> re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;(.*)(?= \()&#39;</span>, x).group(<span style="color: #0000DD; font-weight: bold">0</span>)
        <span style="color: #008800; font-weight: bold">return</span> x
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">pre_process_detailed</span>(basic_scrapped):
        dane_detailed = pd.DataFrame(detailed(basic_scrapped), columns=[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Budget&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Producer&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Awards_Nominations&#39;</span>])
        dane_detailed.dropna(inplace=<span style="color: #003388">True</span>)
        dane_detailed.BoxOffice = dane_detailed.BoxOffice.map(<span style="color: #008800; font-weight: bold">lambda</span> x: re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;[0-9]+&#39;</span>, re.sub(<span style="color: #dd2200; background-color: #fff0f0">&quot; &quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;&quot;</span>, x)).group(<span style="color: #0000DD; font-weight: bold">0</span>), na_action=<span style="color: #dd2200; background-color: #fff0f0">&#39;ignore&#39;</span>)    
        dane_detailed.Budget = dane_detailed.Budget.map(<span style="color: #008800; font-weight: bold">lambda</span> x: re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;[0-9]+&#39;</span>, re.sub(<span style="color: #dd2200; background-color: #fff0f0">&quot; &quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;&quot;</span>, x)).group(<span style="color: #0000DD; font-weight: bold">0</span>), na_action=<span style="color: #dd2200; background-color: #fff0f0">&#39;ignore&#39;</span>)    
        dane_detailed.Producer = dane_detailed.Producer.map(<span style="color: #008800; font-weight: bold">lambda</span> x: re.split(<span style="color: #dd2200; background-color: #fff0f0">r&#39;  /  &#39;</span>, x), na_action=<span style="color: #dd2200; background-color: #fff0f0">&#39;ignore&#39;</span>)
        <span style="color: #888888"># MAIN PRODUCER:    </span>
        main_producer = dane_detailed[<span style="color: #dd2200; background-color: #fff0f0">&#39;Producer&#39;</span>].values.tolist()
        dane_detailed[<span style="color: #dd2200; background-color: #fff0f0">&#39;Main Producer&#39;</span>] = dane_detailed[<span style="color: #dd2200; background-color: #fff0f0">&#39;Producer&#39;</span>].map(<span style="color: #008800; font-weight: bold">lambda</span> x: producent(x[<span style="color: #0000DD; font-weight: bold">0</span>]))
        <span style="color: #008800; font-weight: bold">return</span> dane_detailed
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    <span style="color: #008800; font-weight: bold">def</span> <span style="color: #0066bb; font-weight: bold">award_split</span>(string):
        <span style="color: #008800; font-weight: bold">if</span> (string == <span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>): <span style="color: #008800; font-weight: bold">return</span> [<span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>]
        award_list = re.split(<span style="color: #dd2200; background-color: #fff0f0">r&#39;, | i | oraz | i&#39;</span>, string)
        award_output=[]
        <span style="color: #008800; font-weight: bold">for</span> i, x <span style="color: #008800">in</span> <span style="color: #003388">enumerate</span>(award_list):
    <span style="color: #888888"># 3 AWARD/NOMINATIONS TYPES:</span>
            <span style="color: #008800; font-weight: bold">if</span> (<span style="color: #003388">len</span>(award_list)==<span style="color: #0000DD; font-weight: bold">3</span>):
                <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">&#39;ę&#39;</span>, x) != <span style="color: #003388">None</span>): 
                    award_output.append(<span style="color: #0000DD; font-weight: bold">1</span>)
                    <span style="color: #008800; font-weight: bold">continue</span>
                <span style="color: #008800; font-weight: bold">else</span>: 
                    award_output.append(re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;([0-9]+)&#39;</span>, x).group(<span style="color: #0000DD; font-weight: bold">0</span>))
                    <span style="color: #008800; font-weight: bold">continue</span>
    <span style="color: #888888"># 2 AWARD/NOMINATIONS TYPES: </span>
            <span style="color: #008800; font-weight: bold">elif</span> (<span style="color: #003388">len</span>(award_list)==<span style="color: #0000DD; font-weight: bold">2</span>):
                <span style="color: #008800; font-weight: bold">if</span> (i==<span style="color: #0000DD; font-weight: bold">1</span>): 
                    award_output.append(<span style="color: #0000DD; font-weight: bold">0</span>)
                <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">&#39;ę&#39;</span>, x) != <span style="color: #003388">None</span>): 
                    award_output.append(<span style="color: #0000DD; font-weight: bold">1</span>)
                    <span style="color: #008800; font-weight: bold">continue</span>
                <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">&#39;ę&#39;</span>, x) == <span style="color: #003388">None</span>): 
                    award_output.append(re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;([0-9]+)&#39;</span>, x).group(<span style="color: #0000DD; font-weight: bold">0</span>))
                    <span style="color: #008800; font-weight: bold">continue</span>
    <span style="color: #888888"># 1 AWARD/NOMINATION TYPE:     </span>
            <span style="color: #008800; font-weight: bold">elif</span> (<span style="color: #003388">len</span>(award_list)==<span style="color: #0000DD; font-weight: bold">1</span>):
                <span style="color: #008800; font-weight: bold">if</span> (i==<span style="color: #0000DD; font-weight: bold">0</span>): 
                    award_output.extend((<span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;0&#39;</span>)) 
                <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">&#39;ę&#39;</span>, x) != <span style="color: #003388">None</span>): 
                    award_output.append(<span style="color: #0000DD; font-weight: bold">1</span>)
                    <span style="color: #008800; font-weight: bold">continue</span>
                <span style="color: #008800; font-weight: bold">if</span> (re.search(<span style="color: #dd2200; background-color: #fff0f0">&#39;ę&#39;</span>, x) == <span style="color: #003388">None</span>): 
                    award_output.append(re.search(<span style="color: #dd2200; background-color: #fff0f0">r&#39;([0-9]+)&#39;</span>, x).group(<span style="color: #0000DD; font-weight: bold">0</span>))
                    <span style="color: #008800; font-weight: bold">continue</span>
        <span style="color: #008800; font-weight: bold">return</span> award_output
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    basic_scrapped = pre_process_basic(basic_info_list(<span style="color: #0000DD; font-weight: bold">70</span>))
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    dane_detailed = pre_process_detailed(basic_scrapped)
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    wynik = pd.concat([basic_scrapped, dane_detailed],axis=<span style="color: #0000DD; font-weight: bold">1</span>)
    wynik.dropna(inplace=<span style="color: #003388">True</span>)
    wynik.reset_index(drop=<span style="color: #003388">True</span>, inplace=<span style="color: #003388">True</span>)
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    nagrody = (
        pd.DataFrame(
            np.asarray(
            [award_split(x) <span style="color: #008800; font-weight: bold">for</span> x <span style="color: #008800">in</span> wynik[<span style="color: #dd2200; background-color: #fff0f0">&#39;Awards_Nominations&#39;</span>].values.tolist()]
            ),
            columns=[<span style="color: #dd2200; background-color: #fff0f0">&#39;Main Awards&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Additional Awards&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Nominations&#39;</span>]
        )
    )
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    wynik2 = pd.concat([wynik, nagrody],axis=<span style="color: #0000DD; font-weight: bold">1</span>)
    <span style="color: #888888">#--------------------------------------------------------------------</span>
    wynik2.to_csv(<span style="color: #dd2200; background-color: #fff0f0">r&#39;C:\Users\szymo\Desktop\Nauka\Python\Projekt\Projekt Python\test500.csv&#39;</span>)
    
<span style="color: #888888">###############################</span>
<span style="color: #888888">#KONIEC SCRAPERA</span>
<span style="color: #888888">###############################</span>

    <span style="color: #888888">#SCATTER PLOT</span>
    merg = pd.read_csv(<span style="color: #dd2200; background-color: #fff0f0">&quot;test500.csv&quot;</span>)
    Dict_scatter={}
    Dict_scatter[<span style="color: #dd2200; background-color: #fff0f0">&quot;label&quot;</span>] = <span style="color: #dd2200; background-color: #fff0f0">&#39;Zależność Box Office od Budżetu&#39;</span>
    dane_scatter = merg[[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Budget&#39;</span>]].rename(columns = {<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;y&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Budget&#39;</span>:<span style="color: #dd2200; background-color: #fff0f0">&#39;x&#39;</span>})                                   
    Dict_scatter[<span style="color: #dd2200; background-color: #fff0f0">&quot;data&quot;</span>] = dane_scatter[[<span style="color: #dd2200; background-color: #fff0f0">&quot;x&quot;</span>, <span style="color: #dd2200; background-color: #fff0f0">&quot;y&quot;</span>]].to_dict(<span style="color: #dd2200; background-color: #fff0f0">&#39;records&#39;</span>)
    Dict_scatter[<span style="color: #dd2200; background-color: #fff0f0">&quot;backgroundColor&quot;</span>] = <span style="color: #dd2200; background-color: #fff0f0">&#39;rgb(65, 148, 217)&#39;</span>
    dane_scatter = json.dumps([Dict_scatter])
    
    <span style="color: #888888">#BOX PLOT</span>
    dataset = merg[[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Main Producer&#39;</span>]].groupby(<span style="color: #dd2200; background-color: #fff0f0">&#39;Main Producer&#39;</span>).mean()
    dataset.sort_values(by=[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>], inplace=<span style="color: #003388">True</span>)
    dataset = dataset.tail(<span style="color: #0000DD; font-weight: bold">20</span>)
    Dict_bar={}
    Dict_bar[<span style="color: #dd2200; background-color: #fff0f0">&#39;type&#39;</span>]=<span style="color: #dd2200; background-color: #fff0f0">&#39;bar&#39;</span>
    Dict_bar[<span style="color: #dd2200; background-color: #fff0f0">&#39;x&#39;</span>]=dataset.index.values.tolist()
    Dict_bar[<span style="color: #dd2200; background-color: #fff0f0">&#39;y&#39;</span>]=dataset.BoxOffice.values.tolist()
    Dict_bar = json.dumps([Dict_bar])

    <span style="color: #888888">#PIE PLOT</span>
    <span style="color: #008800; font-weight: bold">global</span> labels_pie
    <span style="color: #008800; font-weight: bold">global</span> dane_pie
    dataset_pie = merg[[<span style="color: #dd2200; background-color: #fff0f0">&#39;Main genre&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>]].groupby(<span style="color: #dd2200; background-color: #fff0f0">&#39;Main genre&#39;</span>).sum()
    dataset_pie.sort_values(by=[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>], inplace=<span style="color: #003388">True</span>)
    dataset_pie = dataset_pie.tail(<span style="color: #0000DD; font-weight: bold">5</span>)
    dane_pie = json.dumps(dataset_pie.BoxOffice.values.tolist())
    labels_pie = json.dumps(dataset_pie.index.values.tolist())
    <span style="color: #888888"># display(dane_pie, labels_pie)</span>
    
    <span style="color: #888888">#RADAR</span>
    <span style="color: #008800; font-weight: bold">global</span> list_radar 
    data_radar_1 = merg[[<span style="color: #dd2200; background-color: #fff0f0">&#39;BoxOffice&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Budget&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Number of reviews&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Average Rating&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Nominations&#39;</span>]]
    data_radar_1 -= data_radar_1.min()
    data_radar_1 /= data_radar_1.max()
    data_radar_1 *= <span style="color: #0000DD; font-weight: bold">100</span>
    data_radar_1 = pd.concat([data_radar_1, merg[<span style="color: #dd2200; background-color: #fff0f0">&#39;Main genre&#39;</span>]], axis= <span style="color: #0000DD; font-weight: bold">1</span>)
    data_radar_1 = data_radar_1.loc[data_radar_1[<span style="color: #dd2200; background-color: #fff0f0">&#39;Main genre&#39;</span>].isin([<span style="color: #dd2200; background-color: #fff0f0">&#39;Dramat&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Akcja&#39;</span>, <span style="color: #dd2200; background-color: #fff0f0">&#39;Fantasy&#39;</span>])]
    data_radar_1 = data_radar_1.groupby(<span style="color: #dd2200; background-color: #fff0f0">&#39;Main genre&#39;</span>).mean()

    list_radar = json.dumps([{<span style="color: #dd2200; background-color: #fff0f0">&#39;type&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;scatterpolar&#39;</span>, 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;r&#39;</span>: data_radar_1.iloc[<span style="color: #0000DD; font-weight: bold">0</span>].values.tolist(), 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;theta&#39;</span>: data_radar_1.columns.tolist(),
    <span style="color: #dd2200; background-color: #fff0f0">&#39;fill&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;toself&#39;</span>,
    <span style="color: #dd2200; background-color: #fff0f0">&#39;name&#39;</span>: data_radar_1.index[<span style="color: #0000DD; font-weight: bold">0</span>]},

    {<span style="color: #dd2200; background-color: #fff0f0">&#39;type&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;scatterpolar&#39;</span>, 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;r&#39;</span>: data_radar_1.iloc[<span style="color: #0000DD; font-weight: bold">1</span>].values.tolist(), 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;theta&#39;</span>: data_radar_1.columns.tolist(),
    <span style="color: #dd2200; background-color: #fff0f0">&#39;fill&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;toself&#39;</span>,
    <span style="color: #dd2200; background-color: #fff0f0">&#39;name&#39;</span>: data_radar_1.index[<span style="color: #0000DD; font-weight: bold">1</span>]},

    {<span style="color: #dd2200; background-color: #fff0f0">&#39;type&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;scatterpolar&#39;</span>, 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;r&#39;</span>: data_radar_1.iloc[<span style="color: #0000DD; font-weight: bold">2</span>].values.tolist(), 
    <span style="color: #dd2200; background-color: #fff0f0">&#39;theta&#39;</span>: data_radar_1.columns.tolist(),
    <span style="color: #dd2200; background-color: #fff0f0">&#39;fill&#39;</span>: <span style="color: #dd2200; background-color: #fff0f0">&#39;toself&#39;</span>,
    <span style="color: #dd2200; background-color: #fff0f0">&#39;name&#39;</span>: data_radar_1.index[<span style="color: #0000DD; font-weight: bold">2</span>]}])

    <span style="color: #888888">#SPRAWDZENIE</span>
    <span style="color: #008800; font-weight: bold">if</span> (df_check.equals(df)):
        <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&#39;scrap_porazka&#39;</span>, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Scrap porazka&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)
    <span style="color: #008800; font-weight: bold">else</span>:
        <span style="color: #008800; font-weight: bold">return</span> template(<span style="color: #dd2200; background-color: #fff0f0">&#39;scrap_sukces&#39;</span>, zawartosc= <span style="color: #dd2200; background-color: #fff0f0">&#39;&lt;strong&gt;&lt;u&gt;Scrap sukces&lt;/u&gt;&lt;/strong&gt;&lt;p&gt;&lt;/p&gt;&#39;</span>)
        
run(host=<span style="color: #dd2200; background-color: #fff0f0">&#39;localhost&#39;</span>, port=<span style="color: #0000DD; font-weight: bold">8001</span>, debug=<span style="color: #003388">True</span>)
</pre></div>





      </section>
      <div class="text-right">

      </div>
    </section>
    <!--main content end-->
