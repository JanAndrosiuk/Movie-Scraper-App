import pandas as pd
import json


def scatter(path="data/test500.csv"):
    merg = pd.read_csv(path)
    Dict_scatter = {}
    Dict_scatter["label"] = 'Relationship between Box Office and movie budget'
    dane_scatter = merg[['BoxOffice', 'Budget']].rename(columns={'BoxOffice': 'y', 'Budget': 'x'})
    Dict_scatter["data"] = dane_scatter[["x", "y"]].to_dict('records')
    Dict_scatter["backgroundColor"] = 'rgb(65, 148, 217)'
    dane_scatter = json.dumps([Dict_scatter])

    return dane_scatter


def bar_plot(path="data/test500.csv"):
    merg = pd.read_csv(path)
    dataset = merg[['BoxOffice', 'Main Producer']].groupby('Main Producer').mean()
    dataset.sort_values(by=['BoxOffice'], inplace=True)
    dataset = dataset.tail(20)
    Dict_bar = {}
    Dict_bar['type'] = 'bar'
    Dict_bar['x'] = dataset.index.values.tolist()
    Dict_bar['y'] = dataset.BoxOffice.values.tolist()
    Dict_bar = json.dumps([Dict_bar])

    return Dict_bar


def pie_chart(path="data/test500.csv"):
    merg = pd.read_csv(path)

    dataset_pie = merg[['Main genre', 'BoxOffice']].groupby('Main genre').sum()
    dataset_pie.sort_values(by=['BoxOffice'], inplace=True)
    dataset_pie = dataset_pie.tail(5)
    dane_pie = json.dumps(dataset_pie.BoxOffice.values.tolist())
    labels_pie = json.dumps(dataset_pie.index.values.tolist())

    return labels_pie, dane_pie


def radar_chart(path="data/test500.csv"):
    merg = pd.read_csv(path)

    data_radar_1 = merg[['BoxOffice', 'Budget', 'Number of reviews', 'Average Rating', 'Nominations']]
    data_radar_1 -= data_radar_1.min()
    data_radar_1 /= data_radar_1.max()
    data_radar_1 *= 100
    data_radar_1 = pd.concat([data_radar_1, merg['Main genre']], axis=1)
    data_radar_1 = data_radar_1.loc[data_radar_1['Main genre'].isin(['Dramat', 'Akcja', 'Fantasy'])]
    data_radar_1 = data_radar_1.groupby('Main genre').mean()

    list_radar = json.dumps(
        [{
            'type': 'scatterpolar',
            'r': data_radar_1.iloc[0].values.tolist(),
            'theta': data_radar_1.columns.tolist(),
            'fill': 'toself',
            'name': data_radar_1.index[0]
        }, {
            'type': 'scatterpolar',
            'r': data_radar_1.iloc[1].values.tolist(),
            'theta': data_radar_1.columns.tolist(),
            'fill': 'toself',
            'name': data_radar_1.index[1]
        }, {
            'type': 'scatterpolar',
            'r': data_radar_1.iloc[2].values.tolist(),
            'theta': data_radar_1.columns.tolist(),
            'fill': 'toself',
            'name': data_radar_1.index[2]
        }]
    )

    return list_radar
