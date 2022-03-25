import numpy as np
import pandas as pd
import re
from time import sleep
import requests
from bs4 import BeautifulSoup
from tqdm import tqdm


def basic_info_list(num_pages):
    dane_ranking = []
    for i, x in enumerate(tqdm(range(1, num_pages + 1))):
        bs = BeautifulSoup(
            requests.get(
                "https://www.filmweb.pl/films/search?orderBy=popularity&descending=true&page=" + str(x)).text
        )
        lista = bs.find('ul', {'class': ['resultsList', 'hits']})
        for j, li in enumerate(lista):
            single = []
            # if there is no foreign title, pick polish one
            if li.find('div', {"class": "filmPreview__originalTitle"}) is not None:
                single.append(li.find('div', {"class": "filmPreview__originalTitle"}).text)
            else:
                single.append(li.find(
                    'h2', {"class": "filmPreview__title", "itemprop": "name"}).text
                              )

            # MAIN GENRE:
            single.append(li.find('div', {"class": "filmPreview__info--genres"}).find('a').text)

            # DATE
            single.append(li.find(
                'div',
                {"class": "filmPreview__year", "itemprop": "datePublished"})['content']
                          )
            # DIRECTOR:
            single.append(li.find(
                'div', {"class": "filmPreview__info--directors"}).find('span', {"itemprop": "name"}).text
                          )

            # RATING
            single.append(li.find('span', {'class': 'rateBox__rate', 'itemprop': 'ratingValue'}).text)

            # NUMBER OF REVIEWS:
            single.append(li.find(
                'div',
                {"class": "filmPreview__extends"}
            ).findChildren(
                'span',
                {
                    "class": [
                        "rateBox__votes", "rateBox__votes--count"],
                    "itemprop": "ratingCount"
                })[0]['content']
                          )

            # MOVIE LINK:
            single.append(
                "https://www.filmweb.pl" + li.find(
                    'a', {"class": "filmPreview__link", "itemprop": "url"}
                )['href']
            )
            dane_ranking.append(single)
    return dane_ranking


def pre_process_basic(ll):
    df = pd.DataFrame(
        ll, columns=[
            "Title", "Main genre", "Date", "Director", "Average Rating", "Number of reviews", "Link"
        ])
    df.dropna(inplace=True)
    df.reset_index(drop=True, inplace=True)
    df['Date'] = pd.to_datetime(df['Date'])
    df['Number of reviews'] = df['Number of reviews'].astype(int)
    df['Average Rating'] = df['Average Rating'].map(lambda x: x.replace(',', '.'))
    return df


def detailed(basic_scrapped):
    movie_list = basic_scrapped.Link.values
    dane_detail = []
    for i, x in enumerate(tqdm(movie_list)):
        single = []
        bs = BeautifulSoup(requests.get(x).text)
        tabela_header = bs.find(
            'div',
            {
                'class': 'filmOtherInfoSection__group'
            }
        ).findAll('div', {'class': 'filmInfo__header'})
        tabela_info = bs.find(
            'div',
            {'class': 'filmOtherInfoSection__group'}
        ).findAll('div', {'class': 'filmInfo__info'})
        slownik = dict(
            [[o.text, j] for o, j in zip(tabela_header, tabela_info) if o.text in ['boxoffice', 'budżet', 'studio']]
        )

        # BOX OFFICE:
        if 'boxoffice' in slownik.keys():
            try:
                single.append(slownik['boxoffice'].find('div', {'class': [None, 'boxoffice']}).text)
            except:
                print("ERROR w BOXOFFICE", basic_scrapped.loc[[i]].Title)
        else:
            single.append(np.nan)
            print(
                "NO INFORMATION ABOUT BOXOFFICE",
                basic_scrapped.loc[[i]].Title,
                '\n----------------------------------------------'
            )

        # BUDGET:
        if 'budżet' in slownik.keys():
            single.append(slownik['budżet'].text)
        else:
            single.append(np.nan)
            print(
                "NO INFORMATION ABOUT BUDGET",
                basic_scrapped.loc[[i]].Title,
                '\n----------------------------------------------'
            )

        # PRODUCTION COMPANY:
        if 'studio' in slownik.keys():
            single.append(slownik['studio'].text)
        else:
            single.append(np.nan)
            print(
                "NO INFORMATION ABOUT PRODUCER",
                basic_scrapped.loc[[i]].Title,
                '\n----------------------------------------------'
            )

        # AWARDS:
        try:
            single.append(bs.find('a', {'class': 'awards__link'}).text)
        except:
            print(
                "NO INFORMATION ABOUT AWARDS",
                '\n----------------------------------------------'
            )
            single.append('0')
        if (i + 1) % 30 == 0 & i + 1 != len(movie_list):
            print(
                """
                    ----------------------------------------------\n
                    SLEEP
                    \n----------------------------------------------
                """
            )
            sleep(1)
        dane_detail.append(single)
    return dane_detail


def producent(x):
    if re.search(r'\(', x):
        return re.search(r'(.*)(?= \()', x).group(0)
    return x


def pre_process_detailed(basic_scrapped):
    dane_detailed = pd.DataFrame(
        detailed(basic_scrapped),
        columns=['BoxOffice', 'Budget', 'Producer', 'Awards_Nominations']
    )
    dane_detailed.dropna(inplace=True)
    dane_detailed.BoxOffice = dane_detailed.BoxOffice.map(
        lambda x: re.search(r'[0-9]+', re.sub(" ", "", x)).group(0), na_action='ignore'
    )
    dane_detailed.Budget = dane_detailed.Budget.map(
        lambda x: re.search(r'[0-9]+', re.sub(" ", "", x)).group(0), na_action='ignore'
    )
    dane_detailed.Producer = dane_detailed.Producer.map(
        lambda x: re.split(r'  /  ', x), na_action='ignore'
    )

    # MAIN PRODUCER:
    main_producer = dane_detailed['Producer'].values.tolist()
    dane_detailed['Main Producer'] = dane_detailed['Producer'].map(lambda x: producent(x[0]))
    return dane_detailed


def award_split(string):
    if string == '0': return ['0', '0', '0']
    award_list = re.split(r', | i | oraz | i', string)
    award_output = []
    for i, x in enumerate(award_list):
        # 3 AWARD/NOMINATIONS TYPES:
        if len(award_list) == 3:
            if re.search('ę', x) is not None:
                award_output.append(1)
                continue
            else:
                award_output.append(re.search(r'([0-9]+)', x).group(0))
                continue
        # 2 AWARD/NOMINATIONS TYPES:
        elif len(award_list) == 2:
            if i == 1:
                award_output.append(0)
            if re.search('ę', x) is not None:
                award_output.append(1)
                continue
            if re.search('ę', x) is None:
                award_output.append(re.search(r'([0-9]+)', x).group(0))
                continue
        # 1 AWARD/NOMINATION TYPE:
        elif len(award_list) == 1:
            if i == 0:
                award_output.extend(('0', '0'))
            if re.search('ę', x) is not None:
                award_output.append(1)
                continue
            if re.search('ę', x) is None:
                award_output.append(re.search(r'([0-9]+)', x).group(0))
                continue
    return award_output
