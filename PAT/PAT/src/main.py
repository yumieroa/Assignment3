from flask import Flask, url_for, jsonify, request, render_template, send_from_directory, redirect
from flask.ext.httpauth import HTTPBasicAuth
from flask.ext.uploads import UploadSet, configure_uploads, IMAGES
import sys, os, flask
import model
from werkzeug.utils import secure_filename
import psycopg2


UPLOAD_FOLDER = 'upload'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__)
auth = HTTPBasicAuth()

photos = UploadSet('photos', IMAGES)

app.config['UPLOADED_PHOTOS_DEST'] = 'templates/img'
configure_uploads(app, photos)


def spcall(qry, param, commit=False):
    try:
        dbo = model.DBconn()
        cursor = dbo.getcursor()
        cursor.callproc(qry, param)
        res = cursor.fetchall()
        if commit:
            dbo.dbcommit()
        return res
    except:
        res = [("Error: " + str(sys.exc_info()[0]) + " " + str(sys.exc_info()[1]),)]
    return res

@auth.get_password
def getpassword(username):
    return 'akolagini'


@app.route('/login/', methods=['POST'])
def login():

    params = request.get_json()
    password = params["password"]
    email = params["email"]

    res = spcall('login', (email, password), True)
    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error'})

    return jsonify({'status': 'ok'})

@app.route('/childinfo_edit', methods=['POST'])
def edit_child():

    params = request.get_json()
    first_name = params["first_name"]
    last_name = params["last_name"]
    birthdate = params["birthdate"]
    age = params["age"]
    diagnosis = params["diagnosis"]

    res = spcall("edit_child",(first_name, last_name, birthdate, age, diagnosis), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'ok', 'message': res[0][0]})
    # recs = []
    # for r in res:
    #     recs.append({"first_name": str(r[0]), "last_name": str(r[0]), "birthdate": str(r[0]), "age": str(r[0]),"diagnosis": str(r[0])})
    # return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/newinfo', methods=['GET'])
def getinfo_child():
    res = spcall('getinfo_child', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"first_name": str(r[0]), "last_name": str(r[1]), "birthdate": str(r[2]), "age": str(r[3]),"diagnosis": str(r[4])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/parentinfo_edit', methods=['POST'])
def edit_parent():

    params = request.get_json()
    first_name = params["first_name"]
    last_name = params["last_name"]
    birthdate = params["birthdate"]
    age = params["age"]
    relationship = params["relationship"]

    res = spcall("edit_parent",(first_name, last_name, birthdate, age, relationship), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'ok', 'message': res[0][0]})
#
# @app.route('/upload', methods=['GET', 'POST'])
# def upload():
#     params = request.get_json()
#     food_name = params["food_name"]
#     food_img = params["food_img"]
#
#     if request.method == 'POST' and 'photo' in request.files:
#         food_img = photos.save(request.files['photo'])
#         return food_img
#
#     res = spcall("upload",(food_name, food_img), True)
#
#     if 'Error' in res[0][0]:
#         return jsonify({'status': 'error', 'message': res[0][0]})
#     return jsonify({'status': 'ok', 'message': res[0][0]})


# @app.route("/upload", methods=["POST"])
# def upload():
#
#     params = request.get_json()
#     food_name = params["food_name"]
#     food_img = params["food_img"]
#
#     target = os.path.join(APP_ROOT, 'food/')
#     print(target)
#     if not os.path.isdir(target):
#             os.mkdir(target)
#     else:
#         print("Couldn't create upload directory: {}".format(target))
#     print(request.files.getlist("file"))
#     for upload in request.files.getlist("file"):
#         print(upload)
#         print("{} is the file name".format(upload.food_img))
#         food_img = upload.food_img
#         destination = "/".join([target, food_img])
#         print ("Accept incoming file:", food_img)
#         print ("Save it to:", destination)
#         upload.save(destination)
#
#     res = spcall("upload",(food_name, food_img), True)
#
#     if 'Error' in res[0][0]:
#         return jsonify({'status': 'error', 'message': res[0][0]})
#     return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/newinfo_parent', methods=['GET'])
def getinfo_parent():
    res = spcall('getinfo_parent', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"first_name": str(r[0]), "last_name": str(r[1]), "birthdate": str(r[2]), "age": str(r[3]), "relationship": str(r[4])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/edit_settings', methods=['POST'])
def edit_settings():

    params = request.get_json()
    email = params["email"]
    username = params["username"]
    password = params["password"]

    res = spcall("edit_settings",(email, username, password), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'ok', 'message': res[0][0]})
    # recs = []
    # for r in res:
    #     recs.append({"first_name": str(r[0]), "last_name": str(r[0]), "birthdate": str(r[0]), "age": str(r[0]),"diagnosis": str(r[0])})
    # return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/new_settings', methods=['GET'])
def new_settings():
    res = spcall('new_settings', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"email": str(r[0]), "username": str(r[1]), "password": str(r[2])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})


@app.route('/egg_rec', methods=['POST'])
def egg_clicks():

    res = spcall("egg_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/chicken_rec', methods=['POST'])
def chicken_clicks():

    res = spcall("chicken_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/hotdog_rec', methods=['POST'])
def hotdog_clicks():

    res = spcall("hotdog_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/pancakes_rec', methods=['POST'])
def pancakes_clicks():

    res = spcall("pancakes_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/cookies_rec', methods=['POST'])
def cookies_clicks():

    res = spcall("cookies_clicks", ('1'),True)
    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/burger_rec', methods=['POST'])
def burger_clicks():

    res = spcall("burger_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/bbq_rec', methods=['POST'])
def bbq_clicks():

    res = spcall("bbq_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/fries_rec', methods=['POST'])
def fries_clicks():

    res = spcall("fries_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/marshmallow_rec', methods=['POST'])
def marshmallow_clicks():

    res = spcall("marshmallow_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/lollipop_rec', methods=['POST'])
def lollipop_clicks():

    res = spcall("lollipop_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/icecream_rec', methods=['POST'])
def icecream_clicks():

    res = spcall("icecream_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/halo_rec', methods=['POST'])
def halo_clicks():

    res = spcall("halo_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/stack_rec', methods=['POST'])
def stack_clicks():

    res = spcall("stack_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/puzzle_rec', methods=['POST'])
def puzzle_clicks():

    res = spcall("puzzle_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/doodle_rec', methods=['POST'])
def doodle_clicks():

    res = spcall("doodle_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/rattle_rec', methods=['POST'])
def rattle_clicks():

    res = spcall("rattle_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/ball_rec', methods=['POST'])
def ball_clicks():

    res = spcall("ball_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/swing_rec', methods=['POST'])
def swing_clicks():

    res = spcall("swing_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/lego_rec', methods=['POST'])
def lego_clicks():

    res = spcall("lego_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/trampoline_rec', methods=['POST'])
def trampoline_clicks():

    res = spcall("trampoline_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/car_rec', methods=['POST'])
def car_clicks():

    res = spcall("car_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/teddy_rec', methods=['POST'])
def teddy_clicks():

    res = spcall("teddy_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/flash_rec', methods=['POST'])
def flash_clicks():

    res = spcall("flash_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/slide_rec', methods=['POST'])
def slide_clicks():

    res = spcall("slide_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/jollibee_rec', methods=['POST'])
def jollibee_clicks():

    res = spcall("jollibee_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/church_rec', methods=['POST'])
def church_clicks():

    res = spcall("church_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/mcdo_rec', methods=['POST'])
def mcdo_clicks():

    res = spcall("mcdo_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/school_rec', methods=['POST'])
def school_clicks():

    res = spcall("school_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/pool_rec', methods=['POST'])
def pool_clicks():

    res = spcall("pool_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/beach_rec', methods=['POST'])
def beach_clicks():

    res = spcall("beach_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/mall_rec', methods=['POST'])
def mall_clicks():

    res = spcall("mall_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/play_rec', methods=['POST'])
def play_clicks():

    res = spcall("play_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/panty_rec', methods=['POST'])
def panty_clicks():

    res = spcall("panty_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/shorts_rec', methods=['POST'])
def shorts_clicks():

    res = spcall("shorts_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/shirt_rec', methods=['POST'])
def shirt_clicks():

    res = spcall("shirt_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/jacket_rec', methods=['POST'])
def jacket_clicks():

    res = spcall("jacket_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/dress_rec', methods=['POST'])
def dress_clicks():

    res = spcall("dress_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/skirt_rec', methods=['POST'])
def skirt_clicks():

    res = spcall("skirt_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/pants_rec', methods=['POST'])
def pants_clicks():

    res = spcall("pants_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/sweater_rec', methods=['POST'])
def sweater_clicks():

    res = spcall("sweater_clicks", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/food_activity', methods=['GET'])
def getclicks_food():
    res = spcall('getclicks_food', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"food_name": str(r[0]), "clicks": str(r[1]), "casein": str(r[2]), "gluten": str(r[3]), "calories": str(r[4]), "calories_total": str(r[5]), "protein": str(r[6]), "protein_total": str(r[7]), "cholesterol": str(r[8]), "cholesterol_total": str(r[9])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/toys_activity', methods=['GET'])
def getclicks_toys():
    res = spcall('getclicks_toys', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"toy_name": str(r[0]), "clicks": str(r[1])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/places_activity', methods=['GET'])
def getclicks_places():
    res = spcall('getclicks_places', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"place_name": str(r[0]), "clicks": str(r[1])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/clothes_activity', methods=['GET'])
def getclicks_clothes():
    res = spcall('getclicks_clothes', (), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
     recs.append({"cloth_name": str(r[0]), "clicks": str(r[1])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/delete_food', methods=['POST'])
def delete_food():

    res = spcall("delete_food", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/delete_toys', methods=['POST'])
def delete_toys():

    res = spcall("delete_toys", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/delete_places', methods=['POST'])
def delete_places():

    res = spcall("delete_places", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/delete_clothes', methods=['POST'])
def delete_clothes():

    res = spcall("delete_clothes", ('1'),True)

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/new_food', methods=['POST', 'GET'])
def upload_food():

    params = request.get_json()
    food_name = params["food_name"]
    food_img = params["food_img"]

    res = spcall("upload_food", (food_name, food_img), True)
    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})



@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp


if __name__ == '__main__':
    app.run(threaded=True)