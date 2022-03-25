from visualize import *
from scraper import *
from bottle import route, run, template, static_file
import pandas as pd
from IPython.display import display, HTML
import os


@route('/static/<path:path>', name='static')
def static(path):
    return static_file(path, root='./static')


@route('/')
def glowna():
    return template(
        'index',
        zawartosc='<strong><u>Main Page</u></strong><p></p>'
    )


@route("/wykresy")
@route("/wykresy/")
def wykresy():
    return template(
        "chart-chartjs", data_scatter=scatter(),
        data_box=bar_plot(), zawartosc='<strong><u>Wykresy</u></strong><p></p>'
    )


@route("/wykresy2")
@route("/wykresy2/")
def wykresy2():
    return template(
        "chart-chartjs2", labels_pie=pie_chart()[0], dane_pie=pie_chart()[1],
        dane_radar=radar_chart(), zawartosc='<strong><u>Wykresy2</u></strong><p></p>'
    )


@route('/kod')
@route('/kod/')
def kod():
    return template('kod', zawartosc='<strong><u>Kod</u></strong><p></p>')


@route('/basic_table')
@route('/basic_table/')
def table():
    merg = pd.read_csv("data/test500.csv")
    z = HTML(merg.to_html())
    tables = merg.to_html()
    return template('table', tabela=tables, zawartosc='<strong><u>Tabela</u></strong><p></p>')


@route("/scrap")
@route("/scrap/")
def scrap():
    n_pages = input('Select number of Filmweb pages to scrap: ')
    wejscie = 0
    wynik2 = pd.DataFrame()

    if wejscie == 0:
        df_check = wynik2
        wejscie += 1
    else:
        df_check = wynik2

    basic_scrapped = pre_process_basic(basic_info_list(5))
    dane_detailed = pre_process_detailed(basic_scrapped)

    wynik = pd.concat([basic_scrapped, dane_detailed], axis=1)
    wynik.dropna(inplace=True)
    wynik.reset_index(drop=True, inplace=True)

    nagrody = (
        pd.DataFrame(
            np.asarray(
                [award_split(x) for x in wynik['Awards_Nominations'].values.tolist()]
            ),
            columns=['Main Awards', 'Additional Awards', 'Nominations']
        )
    )

    wynik2 = pd.concat([wynik, nagrody], axis=1)
    if not os.path.isdir('visualizations/'):
        os.mkdir('visualizations/')
    wynik2.to_csv(r'data/test500.csv')

    if df_check.equals(wynik):
        return template('scrap_porazka', zawartosc='<strong><u>Scrap failure</u></strong><p></p>')
    else:
        return template('scrap_sukces', zawartosc='<strong><u>Scrap success</u></strong><p></p>')

    return 1
