from flask import Flask, request
import subprocess


app = Flask(__name__)


@app.route("/")
def hello_world():
    cmd = ["date"]
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    # return jsonify(hello="world")
    return "hello world pythonondocker-pyptom.b4a.run {}, {}".format(result.stdout, result.stderr)


@app.route("/ls")
def ls():
    cmd = ["ls", "-la"]
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    # return jsonify(hello="world")
    return "hello world {}, {}".format(result.stdout, result.stderr)


@app.route("/exec")
def exec():
    params = request.args.get('cmd', type=str)
    param_list = params.split('%20')
    result = subprocess.run(param_list, shell=True, capture_output=True, text=True)
    # return jsonify(hello="world")
    return "hello world<br/>{}<br/>{}<br/>{}".format(params, result.stdout.replace('\n', '<br/>'), result.stderr)
