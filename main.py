from routes import *
from bottle import run


def main():

    run(host='localhost', port=8001, debug=True)

    return 1


if __name__ == "__main__":
    main()
