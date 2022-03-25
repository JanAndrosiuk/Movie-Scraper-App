% rebase('base.tpl', title=None)
{{!zawartosc}}

    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!--overview start-->
        <div class="row">
          <div class="col-lg-12">
            <h3 class="page-header"><i class="fa fa-laptop"></i>Code used for scraping</h3>
            <ol class="breadcrumb">
              <li><i class="fa fa-home"></i><a href="/">Home</a></li>
              <li><i class="fa fa-laptop"></i>Simple Bottle Project</li>
            </ol>
          </div>
        </div>

        <div class="row">
			<div class="col-lg-4 col-md-6 col-sm-12">
			<h4>WebApp Authors: Jan Androsiuk and Szymon Socha</h4>
			<p class="text-justify"> Code for scrapper </p>
			</div>

        </div>
        <!-- HTML generated using hilite.me --><div style="background: #f8f8f8; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #008000; font-weight: bold">import</span> <span style="color: #0000FF; font-weight: bold">numpy</span> <span style="color: #008000; font-weight: bold">as</span> <span style="color: #0000FF; font-weight: bold">np</span>
        <span style="color: #008000; font-weight: bold">import</span> <span style="color: #0000FF; font-weight: bold">pandas</span> <span style="color: #008000; font-weight: bold">as</span> <span style="color: #0000FF; font-weight: bold">pd</span>
        <span style="color: #008000; font-weight: bold">import</span> <span style="color: #0000FF; font-weight: bold">re</span>
        <span style="color: #008000; font-weight: bold">from</span> <span style="color: #0000FF; font-weight: bold">time</span> <span style="color: #008000; font-weight: bold">import</span> sleep
        <span style="color: #008000; font-weight: bold">import</span> <span style="color: #0000FF; font-weight: bold">requests</span>
        <span style="color: #008000; font-weight: bold">from</span> <span style="color: #0000FF; font-weight: bold">bs4</span> <span style="color: #008000; font-weight: bold">import</span> BeautifulSoup
        <span style="color: #008000; font-weight: bold">from</span> <span style="color: #0000FF; font-weight: bold">tqdm</span> <span style="color: #008000; font-weight: bold">import</span> tqdm


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">basic_info_list</span>(num_pages):
            dane_ranking <span style="color: #666666">=</span> []
            <span style="color: #008000; font-weight: bold">for</span> i, x <span style="color: #AA22FF; font-weight: bold">in</span> <span style="color: #008000">enumerate</span>(tqdm(<span style="color: #008000">range</span>(<span style="color: #666666">1</span>, num_pages <span style="color: #666666">+</span> <span style="color: #666666">1</span>))):
                bs <span style="color: #666666">=</span> BeautifulSoup(
                    requests<span style="color: #666666">.</span>get(
                        <span style="color: #BA2121">&quot;https://www.filmweb.pl/films/search?orderBy=popularity&amp;descending=true&amp;page=&quot;</span> <span style="color: #666666">+</span> <span style="color: #008000">str</span>(x))<span style="color: #666666">.</span>text
                )
                lista <span style="color: #666666">=</span> bs<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;ul&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: [<span style="color: #BA2121">&#39;resultsList&#39;</span>, <span style="color: #BA2121">&#39;hits&#39;</span>]})
                <span style="color: #008000; font-weight: bold">for</span> j, li <span style="color: #AA22FF; font-weight: bold">in</span> <span style="color: #008000">enumerate</span>(lista):
                    single <span style="color: #666666">=</span> []
                    <span style="color: #408080; font-style: italic"># if there is no foreign title, pick polish one</span>
                    <span style="color: #008000; font-weight: bold">if</span> li<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__originalTitle&quot;</span>}) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #AA22FF; font-weight: bold">not</span> <span style="color: #008000">None</span>:
                        single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__originalTitle&quot;</span>})<span style="color: #666666">.</span>text)
                    <span style="color: #008000; font-weight: bold">else</span>:
                        single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(
                            <span style="color: #BA2121">&#39;h2&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__title&quot;</span>, <span style="color: #BA2121">&quot;itemprop&quot;</span>: <span style="color: #BA2121">&quot;name&quot;</span>})<span style="color: #666666">.</span>text
                                      )

                    <span style="color: #408080; font-style: italic"># MAIN GENRE:</span>
                    single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__info--genres&quot;</span>})<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;a&#39;</span>)<span style="color: #666666">.</span>text)

                    <span style="color: #408080; font-style: italic"># DATE</span>
                    single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(
                        <span style="color: #BA2121">&#39;div&#39;</span>,
                        {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__year&quot;</span>, <span style="color: #BA2121">&quot;itemprop&quot;</span>: <span style="color: #BA2121">&quot;datePublished&quot;</span>})[<span style="color: #BA2121">&#39;content&#39;</span>]
                                  )
                    <span style="color: #408080; font-style: italic"># DIRECTOR:</span>
                    single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(
                        <span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__info--directors&quot;</span>})<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;span&#39;</span>, {<span style="color: #BA2121">&quot;itemprop&quot;</span>: <span style="color: #BA2121">&quot;name&quot;</span>})<span style="color: #666666">.</span>text
                                  )

                    <span style="color: #408080; font-style: italic"># RATING</span>
                    single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;span&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;rateBox__rate&#39;</span>, <span style="color: #BA2121">&#39;itemprop&#39;</span>: <span style="color: #BA2121">&#39;ratingValue&#39;</span>})<span style="color: #666666">.</span>text)

                    <span style="color: #408080; font-style: italic"># NUMBER OF REVIEWS:</span>
                    single<span style="color: #666666">.</span>append(li<span style="color: #666666">.</span>find(
                        <span style="color: #BA2121">&#39;div&#39;</span>,
                        {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__extends&quot;</span>}
                    )<span style="color: #666666">.</span>findChildren(
                        <span style="color: #BA2121">&#39;span&#39;</span>,
                        {
                            <span style="color: #BA2121">&quot;class&quot;</span>: [
                                <span style="color: #BA2121">&quot;rateBox__votes&quot;</span>, <span style="color: #BA2121">&quot;rateBox__votes--count&quot;</span>],
                            <span style="color: #BA2121">&quot;itemprop&quot;</span>: <span style="color: #BA2121">&quot;ratingCount&quot;</span>
                        })[<span style="color: #666666">0</span>][<span style="color: #BA2121">&#39;content&#39;</span>]
                                  )

                    <span style="color: #408080; font-style: italic"># MOVIE LINK:</span>
                    single<span style="color: #666666">.</span>append(
                        <span style="color: #BA2121">&quot;https://www.filmweb.pl&quot;</span> <span style="color: #666666">+</span> li<span style="color: #666666">.</span>find(
                            <span style="color: #BA2121">&#39;a&#39;</span>, {<span style="color: #BA2121">&quot;class&quot;</span>: <span style="color: #BA2121">&quot;filmPreview__link&quot;</span>, <span style="color: #BA2121">&quot;itemprop&quot;</span>: <span style="color: #BA2121">&quot;url&quot;</span>}
                        )[<span style="color: #BA2121">&#39;href&#39;</span>]
                    )
                    dane_ranking<span style="color: #666666">.</span>append(single)
            <span style="color: #008000; font-weight: bold">return</span> dane_ranking


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">pre_process_basic</span>(ll):
            df <span style="color: #666666">=</span> pd<span style="color: #666666">.</span>DataFrame(
                ll, columns<span style="color: #666666">=</span>[
                    <span style="color: #BA2121">&quot;Title&quot;</span>, <span style="color: #BA2121">&quot;Main genre&quot;</span>, <span style="color: #BA2121">&quot;Date&quot;</span>, <span style="color: #BA2121">&quot;Director&quot;</span>, <span style="color: #BA2121">&quot;Average Rating&quot;</span>, <span style="color: #BA2121">&quot;Number of reviews&quot;</span>, <span style="color: #BA2121">&quot;Link&quot;</span>
                ])
            df<span style="color: #666666">.</span>dropna(inplace<span style="color: #666666">=</span><span style="color: #008000">True</span>)
            df<span style="color: #666666">.</span>reset_index(drop<span style="color: #666666">=</span><span style="color: #008000">True</span>, inplace<span style="color: #666666">=</span><span style="color: #008000">True</span>)
            df[<span style="color: #BA2121">&#39;Date&#39;</span>] <span style="color: #666666">=</span> pd<span style="color: #666666">.</span>to_datetime(df[<span style="color: #BA2121">&#39;Date&#39;</span>])
            df[<span style="color: #BA2121">&#39;Number of reviews&#39;</span>] <span style="color: #666666">=</span> df[<span style="color: #BA2121">&#39;Number of reviews&#39;</span>]<span style="color: #666666">.</span>astype(<span style="color: #008000">int</span>)
            df[<span style="color: #BA2121">&#39;Average Rating&#39;</span>] <span style="color: #666666">=</span> df[<span style="color: #BA2121">&#39;Average Rating&#39;</span>]<span style="color: #666666">.</span>map(<span style="color: #008000; font-weight: bold">lambda</span> x: x<span style="color: #666666">.</span>replace(<span style="color: #BA2121">&#39;,&#39;</span>, <span style="color: #BA2121">&#39;.&#39;</span>))
            <span style="color: #008000; font-weight: bold">return</span> df


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">detailed</span>(basic_scrapped):
            movie_list <span style="color: #666666">=</span> basic_scrapped<span style="color: #666666">.</span>Link<span style="color: #666666">.</span>values
            dane_detail <span style="color: #666666">=</span> []
            <span style="color: #008000; font-weight: bold">for</span> i, x <span style="color: #AA22FF; font-weight: bold">in</span> <span style="color: #008000">enumerate</span>(tqdm(movie_list)):
                single <span style="color: #666666">=</span> []
                bs <span style="color: #666666">=</span> BeautifulSoup(requests<span style="color: #666666">.</span>get(x)<span style="color: #666666">.</span>text)
                tabela_header <span style="color: #666666">=</span> bs<span style="color: #666666">.</span>find(
                    <span style="color: #BA2121">&#39;div&#39;</span>,
                    {
                        <span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;filmOtherInfoSection__group&#39;</span>
                    }
                )<span style="color: #666666">.</span>findAll(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;filmInfo__header&#39;</span>})
                tabela_info <span style="color: #666666">=</span> bs<span style="color: #666666">.</span>find(
                    <span style="color: #BA2121">&#39;div&#39;</span>,
                    {<span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;filmOtherInfoSection__group&#39;</span>}
                )<span style="color: #666666">.</span>findAll(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;filmInfo__info&#39;</span>})
                slownik <span style="color: #666666">=</span> <span style="color: #008000">dict</span>(
                    [[o<span style="color: #666666">.</span>text, j] <span style="color: #008000; font-weight: bold">for</span> o, j <span style="color: #AA22FF; font-weight: bold">in</span> <span style="color: #008000">zip</span>(tabela_header, tabela_info) <span style="color: #008000; font-weight: bold">if</span> o<span style="color: #666666">.</span>text <span style="color: #AA22FF; font-weight: bold">in</span> [<span style="color: #BA2121">&#39;boxoffice&#39;</span>, <span style="color: #BA2121">&#39;budżet&#39;</span>, <span style="color: #BA2121">&#39;studio&#39;</span>]]
                )

                <span style="color: #408080; font-style: italic"># BOX OFFICE:</span>
                <span style="color: #008000; font-weight: bold">if</span> <span style="color: #BA2121">&#39;boxoffice&#39;</span> <span style="color: #AA22FF; font-weight: bold">in</span> slownik<span style="color: #666666">.</span>keys():
                    <span style="color: #008000; font-weight: bold">try</span>:
                        single<span style="color: #666666">.</span>append(slownik[<span style="color: #BA2121">&#39;boxoffice&#39;</span>]<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;div&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: [<span style="color: #008000">None</span>, <span style="color: #BA2121">&#39;boxoffice&#39;</span>]})<span style="color: #666666">.</span>text)
                    <span style="color: #008000; font-weight: bold">except</span>:
                        <span style="color: #008000; font-weight: bold">print</span>(<span style="color: #BA2121">&quot;ERROR w BOXOFFICE&quot;</span>, basic_scrapped<span style="color: #666666">.</span>loc[[i]]<span style="color: #666666">.</span>Title)
                <span style="color: #008000; font-weight: bold">else</span>:
                    single<span style="color: #666666">.</span>append(np<span style="color: #666666">.</span>nan)
                    <span style="color: #008000; font-weight: bold">print</span>(
                        <span style="color: #BA2121">&quot;NO INFORMATION ABOUT BOXOFFICE&quot;</span>,
                        basic_scrapped<span style="color: #666666">.</span>loc[[i]]<span style="color: #666666">.</span>Title,
                        <span style="color: #BA2121">&#39;</span><span style="color: #BB6622; font-weight: bold">\n</span><span style="color: #BA2121">----------------------------------------------&#39;</span>
                    )

                <span style="color: #408080; font-style: italic"># BUDGET:</span>
                <span style="color: #008000; font-weight: bold">if</span> <span style="color: #BA2121">&#39;budżet&#39;</span> <span style="color: #AA22FF; font-weight: bold">in</span> slownik<span style="color: #666666">.</span>keys():
                    single<span style="color: #666666">.</span>append(slownik[<span style="color: #BA2121">&#39;budżet&#39;</span>]<span style="color: #666666">.</span>text)
                <span style="color: #008000; font-weight: bold">else</span>:
                    single<span style="color: #666666">.</span>append(np<span style="color: #666666">.</span>nan)
                    <span style="color: #008000; font-weight: bold">print</span>(
                        <span style="color: #BA2121">&quot;NO INFORMATION ABOUT BUDGET&quot;</span>,
                        basic_scrapped<span style="color: #666666">.</span>loc[[i]]<span style="color: #666666">.</span>Title,
                        <span style="color: #BA2121">&#39;</span><span style="color: #BB6622; font-weight: bold">\n</span><span style="color: #BA2121">----------------------------------------------&#39;</span>
                    )

                <span style="color: #408080; font-style: italic"># PRODUCTION COMPANY:</span>
                <span style="color: #008000; font-weight: bold">if</span> <span style="color: #BA2121">&#39;studio&#39;</span> <span style="color: #AA22FF; font-weight: bold">in</span> slownik<span style="color: #666666">.</span>keys():
                    single<span style="color: #666666">.</span>append(slownik[<span style="color: #BA2121">&#39;studio&#39;</span>]<span style="color: #666666">.</span>text)
                <span style="color: #008000; font-weight: bold">else</span>:
                    single<span style="color: #666666">.</span>append(np<span style="color: #666666">.</span>nan)
                    <span style="color: #008000; font-weight: bold">print</span>(
                        <span style="color: #BA2121">&quot;NO INFORMATION ABOUT PRODUCER&quot;</span>,
                        basic_scrapped<span style="color: #666666">.</span>loc[[i]]<span style="color: #666666">.</span>Title,
                        <span style="color: #BA2121">&#39;</span><span style="color: #BB6622; font-weight: bold">\n</span><span style="color: #BA2121">----------------------------------------------&#39;</span>
                    )

                <span style="color: #408080; font-style: italic"># AWARDS:</span>
                <span style="color: #008000; font-weight: bold">try</span>:
                    single<span style="color: #666666">.</span>append(bs<span style="color: #666666">.</span>find(<span style="color: #BA2121">&#39;a&#39;</span>, {<span style="color: #BA2121">&#39;class&#39;</span>: <span style="color: #BA2121">&#39;awards__link&#39;</span>})<span style="color: #666666">.</span>text)
                <span style="color: #008000; font-weight: bold">except</span>:
                    <span style="color: #008000; font-weight: bold">print</span>(
                        <span style="color: #BA2121">&quot;NO INFORMATION ABOUT AWARDS&quot;</span>,
                        <span style="color: #BA2121">&#39;</span><span style="color: #BB6622; font-weight: bold">\n</span><span style="color: #BA2121">----------------------------------------------&#39;</span>
                    )
                    single<span style="color: #666666">.</span>append(<span style="color: #BA2121">&#39;0&#39;</span>)
                <span style="color: #008000; font-weight: bold">if</span> (i <span style="color: #666666">+</span> <span style="color: #666666">1</span>) <span style="color: #666666">%</span> <span style="color: #666666">30</span> <span style="color: #666666">==</span> <span style="color: #666666">0</span> <span style="color: #666666">&amp;</span> i <span style="color: #666666">+</span> <span style="color: #666666">1</span> <span style="color: #666666">!=</span> <span style="color: #008000">len</span>(movie_list):
                    <span style="color: #008000; font-weight: bold">print</span>(
                        <span style="color: #BA2121; font-style: italic">&quot;&quot;&quot;</span>
        <span style="color: #BA2121; font-style: italic">                    ----------------------------------------------\n</span>
        <span style="color: #BA2121; font-style: italic">                    SLEEP</span>
        <span style="color: #BA2121; font-style: italic">                    \n----------------------------------------------</span>
        <span style="color: #BA2121; font-style: italic">                &quot;&quot;&quot;</span>
                    )
                    sleep(<span style="color: #666666">1</span>)
                dane_detail<span style="color: #666666">.</span>append(single)
            <span style="color: #008000; font-weight: bold">return</span> dane_detail


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">producent</span>(x):
            <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;\(&#39;</span>, x):
                <span style="color: #008000; font-weight: bold">return</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;(.*)(?= \()&#39;</span>, x)<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>)
            <span style="color: #008000; font-weight: bold">return</span> x


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">pre_process_detailed</span>(basic_scrapped):
            dane_detailed <span style="color: #666666">=</span> pd<span style="color: #666666">.</span>DataFrame(
                detailed(basic_scrapped),
                columns<span style="color: #666666">=</span>[<span style="color: #BA2121">&#39;BoxOffice&#39;</span>, <span style="color: #BA2121">&#39;Budget&#39;</span>, <span style="color: #BA2121">&#39;Producer&#39;</span>, <span style="color: #BA2121">&#39;Awards_Nominations&#39;</span>]
            )
            dane_detailed<span style="color: #666666">.</span>dropna(inplace<span style="color: #666666">=</span><span style="color: #008000">True</span>)
            dane_detailed<span style="color: #666666">.</span>BoxOffice <span style="color: #666666">=</span> dane_detailed<span style="color: #666666">.</span>BoxOffice<span style="color: #666666">.</span>map(
                <span style="color: #008000; font-weight: bold">lambda</span> x: re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;[0-9]+&#39;</span>, re<span style="color: #666666">.</span>sub(<span style="color: #BA2121">&quot; &quot;</span>, <span style="color: #BA2121">&quot;&quot;</span>, x))<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>), na_action<span style="color: #666666">=</span><span style="color: #BA2121">&#39;ignore&#39;</span>
            )
            dane_detailed<span style="color: #666666">.</span>Budget <span style="color: #666666">=</span> dane_detailed<span style="color: #666666">.</span>Budget<span style="color: #666666">.</span>map(
                <span style="color: #008000; font-weight: bold">lambda</span> x: re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;[0-9]+&#39;</span>, re<span style="color: #666666">.</span>sub(<span style="color: #BA2121">&quot; &quot;</span>, <span style="color: #BA2121">&quot;&quot;</span>, x))<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>), na_action<span style="color: #666666">=</span><span style="color: #BA2121">&#39;ignore&#39;</span>
            )
            dane_detailed<span style="color: #666666">.</span>Producer <span style="color: #666666">=</span> dane_detailed<span style="color: #666666">.</span>Producer<span style="color: #666666">.</span>map(
                <span style="color: #008000; font-weight: bold">lambda</span> x: re<span style="color: #666666">.</span>split(<span style="color: #BA2121">r&#39;  /  &#39;</span>, x), na_action<span style="color: #666666">=</span><span style="color: #BA2121">&#39;ignore&#39;</span>
            )

            <span style="color: #408080; font-style: italic"># MAIN PRODUCER:</span>
            main_producer <span style="color: #666666">=</span> dane_detailed[<span style="color: #BA2121">&#39;Producer&#39;</span>]<span style="color: #666666">.</span>values<span style="color: #666666">.</span>tolist()
            dane_detailed[<span style="color: #BA2121">&#39;Main Producer&#39;</span>] <span style="color: #666666">=</span> dane_detailed[<span style="color: #BA2121">&#39;Producer&#39;</span>]<span style="color: #666666">.</span>map(<span style="color: #008000; font-weight: bold">lambda</span> x: producent(x[<span style="color: #666666">0</span>]))
            <span style="color: #008000; font-weight: bold">return</span> dane_detailed


        <span style="color: #008000; font-weight: bold">def</span> <span style="color: #0000FF">award_split</span>(string):
            <span style="color: #008000; font-weight: bold">if</span> string <span style="color: #666666">==</span> <span style="color: #BA2121">&#39;0&#39;</span>: <span style="color: #008000; font-weight: bold">return</span> [<span style="color: #BA2121">&#39;0&#39;</span>, <span style="color: #BA2121">&#39;0&#39;</span>, <span style="color: #BA2121">&#39;0&#39;</span>]
            award_list <span style="color: #666666">=</span> re<span style="color: #666666">.</span>split(<span style="color: #BA2121">r&#39;, | i | oraz | i&#39;</span>, string)
            award_output <span style="color: #666666">=</span> []
            <span style="color: #008000; font-weight: bold">for</span> i, x <span style="color: #AA22FF; font-weight: bold">in</span> <span style="color: #008000">enumerate</span>(award_list):
                <span style="color: #408080; font-style: italic"># 3 AWARD/NOMINATIONS TYPES:</span>
                <span style="color: #008000; font-weight: bold">if</span> <span style="color: #008000">len</span>(award_list) <span style="color: #666666">==</span> <span style="color: #666666">3</span>:
                    <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">&#39;ę&#39;</span>, x) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #AA22FF; font-weight: bold">not</span> <span style="color: #008000">None</span>:
                        award_output<span style="color: #666666">.</span>append(<span style="color: #666666">1</span>)
                        <span style="color: #008000; font-weight: bold">continue</span>
                    <span style="color: #008000; font-weight: bold">else</span>:
                        award_output<span style="color: #666666">.</span>append(re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;([0-9]+)&#39;</span>, x)<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>))
                        <span style="color: #008000; font-weight: bold">continue</span>
                <span style="color: #408080; font-style: italic"># 2 AWARD/NOMINATIONS TYPES:</span>
                <span style="color: #008000; font-weight: bold">elif</span> <span style="color: #008000">len</span>(award_list) <span style="color: #666666">==</span> <span style="color: #666666">2</span>:
                    <span style="color: #008000; font-weight: bold">if</span> i <span style="color: #666666">==</span> <span style="color: #666666">1</span>:
                        award_output<span style="color: #666666">.</span>append(<span style="color: #666666">0</span>)
                    <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">&#39;ę&#39;</span>, x) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #AA22FF; font-weight: bold">not</span> <span style="color: #008000">None</span>:
                        award_output<span style="color: #666666">.</span>append(<span style="color: #666666">1</span>)
                        <span style="color: #008000; font-weight: bold">continue</span>
                    <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">&#39;ę&#39;</span>, x) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #008000">None</span>:
                        award_output<span style="color: #666666">.</span>append(re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;([0-9]+)&#39;</span>, x)<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>))
                        <span style="color: #008000; font-weight: bold">continue</span>
                <span style="color: #408080; font-style: italic"># 1 AWARD/NOMINATION TYPE:</span>
                <span style="color: #008000; font-weight: bold">elif</span> <span style="color: #008000">len</span>(award_list) <span style="color: #666666">==</span> <span style="color: #666666">1</span>:
                    <span style="color: #008000; font-weight: bold">if</span> i <span style="color: #666666">==</span> <span style="color: #666666">0</span>:
                        award_output<span style="color: #666666">.</span>extend((<span style="color: #BA2121">&#39;0&#39;</span>, <span style="color: #BA2121">&#39;0&#39;</span>))
                    <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">&#39;ę&#39;</span>, x) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #AA22FF; font-weight: bold">not</span> <span style="color: #008000">None</span>:
                        award_output<span style="color: #666666">.</span>append(<span style="color: #666666">1</span>)
                        <span style="color: #008000; font-weight: bold">continue</span>
                    <span style="color: #008000; font-weight: bold">if</span> re<span style="color: #666666">.</span>search(<span style="color: #BA2121">&#39;ę&#39;</span>, x) <span style="color: #AA22FF; font-weight: bold">is</span> <span style="color: #008000">None</span>:
                        award_output<span style="color: #666666">.</span>append(re<span style="color: #666666">.</span>search(<span style="color: #BA2121">r&#39;([0-9]+)&#39;</span>, x)<span style="color: #666666">.</span>group(<span style="color: #666666">0</span>))
                        <span style="color: #008000; font-weight: bold">continue</span>
            <span style="color: #008000; font-weight: bold">return</span> award_output
        </pre></div>

        </code>
        </pre>
    </section>
