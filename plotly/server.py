from bottle import route, run, template

@route("/")
@route("/plot")
def plot():
    return template("plot")

run(host='localhost', port=8001, debug=True)
