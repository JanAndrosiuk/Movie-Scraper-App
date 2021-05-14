from bottle import route, run, template

import pandas as pd
import json
iris = pd.read_csv("iris.csv")

datasets = []
myColor = ["#2CBFCE","#93C667","#52AA5E","#F45B69","#01BAEF"] 
for i, (name, group) in enumerate(iris.groupby("target")):
    print(name)
    groupDict = {}
    groupDict["label"] = name
    datapoints = []
    for row in group.itertuples():
        datapoints.append({"x":row._1, "y":row._2, "r":row._5+3})
    groupDict["data"] = datapoints.copy()
    groupDict["backgroundColor"] = myColor[i]
    groupDict["hoverBackgroundColor"] = myColor[i]
    datasets.append(groupDict.copy())
data = json.dumps(datasets)
@route("/")
@route("/plot")
def plot():
    return template("plot", data = data)

run(host='localhost', port=8001, debug=True)
