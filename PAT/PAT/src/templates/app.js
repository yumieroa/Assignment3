function login() {
    console.log($('#email').val());
    console.log($('#password').val());
    $.ajax({
        url: 'http://127.0.0.1:5000/login/',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
            'email': $("#email").val(),
            'password': $("#password").val()
        }),
        type: "POST",
        dataType: "json",
        success: function (resp) {
            if (resp.status == 'ok') {
                window.location.replace('navigation.html');
            } else if (resp.status == 'error') {
                alert("Your email/password is incorrect!")
                window.location.replace('welcome.html');
            }

        },
        error: function (resp) {
            window.location.replace('/texts/404.html');
        }
    });
}

function edit_child() {
	var child_num = $('#child_num').val();


	$.ajax(
		{
			url: 'http://127.0.0.1:5000/childinfo_edit',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify({
				'first_name': $("#first_name").val(),
				'last_name': $("#last_name").val(),
				'birthdate': $("#birthdate").val(),
				'age': $("#age").val(),
				'diagnosis': $("#diagnosis").val()
			}),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                	alert("Successfully updated!")
                    window.location.replace('childinfo.html')

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function getinfo_child(){

	 $("#childinfo").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/newinfo',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   first_name = resp.entries[i].first_name;
									   last_name = resp.entries[i].last_name;
									   birthdate = resp.entries[i].birthdate;
									   age = resp.entries[i].age;
									   diagnosis = resp.entries[i].diagnosis;
                                       $("#childinfo").append(childinfo(first_name,last_name, birthdate, age, diagnosis));

                                  }



				} else
				{
                                       $("#childinfo").html("");
					alert(resp.message);
				}
    		}
		});
}

function childinfo(first_name,last_name,birthdate,age,diagnosis)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12" >' +
       '<p>First Name: '+ ' ' +first_name+  '</p>'+
       '<p>Last Name:'+ ' ' +last_name+ '</p>'+
       '<p>Birthdate:'+ ' ' +birthdate+ '</p>'+
       '<p>Age:'+ ' ' +age+ '</p>'+
       '<p>Diagnosis:'+ ' ' +diagnosis+  '</p>'
       '</div>'
}

function edit_parent() {
	var parent_num = $('#parent_num').val();


	$.ajax(
		{
			url: 'http://127.0.0.1:5000/parentinfo_edit',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify({
				'first_name': $("#first_name").val(),
				'last_name': $("#last_name").val(),
				'birthdate': $("#birthdate").val(),
				'age': $("#age").val(),
                'relationship': $("#relationship").val()
			}),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                	alert("Successfully updated!")
                    window.location.replace('parent.html')

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function getinfo_parent(){

	 $("#parent").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/newinfo_parent',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   first_name = resp.entries[i].first_name;
									   last_name = resp.entries[i].last_name;
									   birthdate = resp.entries[i].birthdate;
									   age = resp.entries[i].age;
									   relationship = resp.entries[i].relationship;
                                       $("#parent").append(parent(first_name,last_name, birthdate, age, relationship));

                                  }



				} else
				{
                                       $("#parent").html("");
					alert(resp.message);
				}
    		}
		});
}

function parent(first_name,last_name,birthdate,age,relationship)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12">' +
       '<p>First Name: '+ ' ' +first_name+  '</p>'+
       '<p>Last Name:'+ ' ' +last_name+ '</p>'+
       '<p>Birthdate:'+ ' ' +birthdate+ '</p>'+
       '<p>Age:'+ ' ' +age+ '</p>'+
       '<p>Relationship:'+ ' ' +relationship+ '</p>'+
       '</div>'
}

function edit_settings() {


	$.ajax(
		{
			url: 'http://127.0.0.1:5000/edit_settings',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify({
				'email': $("#email").val(),
				'username': $("#username").val(),
				'password': $("#password").val(),
				}),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                	alert("Successfully updated!")
                    window.location.replace('settings.html')

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function new_settings(){

	 $("#settings").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/new_settings',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   email = resp.entries[i].email;
									   username = resp.entries[i].username;
									   password = resp.entries[i].password;
									   $("#settings").append(settings(email,username, password));

                                  }



				} else
				{
                                       $("#settings").html("");
					alert(resp.message);
				}
    		}
		});
}

function settings(email,username,password)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12">' +
       '<p>Email: '+ ' ' +email+  '</p>'+
       '<p>Username:'+ ' ' +username+ '</p>'+
       '<p>Password:'+ ' ' +password+ '</p>'+
       '</div>'
}


// function upload() {
// 	var form_data = new FormData($('#upload-file')[0]);
//
// 	$.ajax(
// 		{
// 			url: 'http://127.0.0.1:5000/upload',
// 			contentType: 'application/json; charset=utf-8',
// 			data: JSON.stringify({
//                 'food_name': $("#food_name").val(),
// 				'food_img': $("#food_img").val()
// 			}),
// 			type: "POST",
// 			dataType: "json",
// 			error: function (e) {
// 			},
// 			success: function (resp) {
//                 if (resp.status == 'ok') {
//                 	alert("Successfully uploaded!")
//                     window.location.replace('food.html')
//
//                  }
// 				else {
// 					alert("ERROR")
// 				}
//
// 			}
// 		});
// }
//
//          function egg_clicks() {
//                egg++;
// //               alert(egg);
//             }
//             function chicken_clicks() {
//                chicken++;
//                alert(chicken);
//             }
//
//             var egg = 0;
//             var chicken = 0;

function egg_clicks() {
	var egg=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/egg_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'egg': $("#egg").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        egg++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function chicken_clicks() {
	var chicken=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/chicken_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'chicken': $("#chicken").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        chicken++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function hotdog_clicks() {
	var hotdog=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/hotdog_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'hotdog': $("#hotdog").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        hotdog++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function pancakes_clicks() {
	var pancakes=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/pancakes_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'pancakes': $("#pancakes").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        pancakes++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function cookies_clicks() {
	var cookies=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/cookies_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'cookies': $("#cookies").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        cookies++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function burger_clicks() {
	var burger=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/burger_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'burger': $("#burger").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        burger++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function bbq_clicks() {
	var bbq=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/bbq_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'bbq': $("#bbq").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        bbq++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function fries_clicks() {
	var fries=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/fries_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'fries': $("#fries").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        fries++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function marshmallow_clicks() {
	var marshmallow=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/marshmallow_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'marshmallow': $("#marshmallow").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        marshmallow++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function lollipop_clicks() {
	var lollipop=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/lollipop_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'lollipop': $("#lollipop").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        lollipop++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function icecream_clicks() {
	var icecream=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/icecream_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'icecream': $("#icecream").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        icecream++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function halo_clicks() {
	var halo=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/halo_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'halo': $("#halo").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        halo++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}


function getclicks_food(){

	 $("#food_rec").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/food_activity',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   food_name = resp.entries[i].food_name;
									   clicks = resp.entries[i].clicks;
									   casein = resp.entries[i].casein;
									   gluten = resp.entries[i].gluten;
									   cholesterol = resp.entries[i].cholesterol;
									   cholesterol_total = resp.entries[i].cholesterol_total;
									   protein = resp.entries[i].protein;
									   protein_total = resp.entries[i].protein_total;
									   calories = resp.entries[i].calories;
									   calories_total = resp.entries[i].calories_total;
									   $("#food_rec").append(food_rec(food_name,clicks,casein,gluten,calories,calories_total,protein,protein_total,cholesterol,cholesterol_total));

                                  }



				} else
				{
                                       $("#food_rec").html("");
					alert(resp.message);
				}
    		}
		});
}


function food_rec(food_name,clicks,casein,gluten,calories,calories_total,protein,protein_total,cholesterol,cholesterol_total)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0px" >' +
       '<table class="table table-hover" cellspacing="0" cellpadding="0">'+
       '<thead class="table-head">'+
                         '<tr class="table-head">'+
                            '<th>Food Name</th>'+
                            '<th>Clicks</th>'+
                            '<th>Casein?</th>'+
                            '<th>Gluten?</th>'+
                            '<th>Calories</th>'+
                            '<th>Total Calories</th>'+
                            '<th>Protein</th>'+
                            '<th>Total Protein</th>'+
                            '<th>Cholesterol</th>'+
                            '<th>Total Cholesterol</th>'+
                        '</tr>'+
                    '</thead>'+
       '<tbody>'+
    '<tr><td>'+food_name+'</td>'+
    '<td>'+clicks+'</td>'+
    '<td>'+casein+'</td>'+
    '<td>'+gluten+'</td>'+
    '<td>'+calories+'</td>'+
    '<td>'+calories_total+'</td>'+
    '<td>'+protein+'</td>'+
    '<td>'+protein_total+'</td>'+
    '<td>'+cholesterol+'</td>'+
    '<td>'+cholesterol_total+'</td></tr>'+
    '</tbody>'+

       '</table></div>';

}

function stack_clicks() {
	var stack=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/stack_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'stack': $("#stack").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        stack++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function puzzle_clicks() {
	var puzzle=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/puzzle_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'puzzle': $("#puzzle").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        puzzle++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function doodle_clicks() {
	var doodle=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/doodle_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'doodle': $("#doodle").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        doodle++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function rattle_clicks() {
	var rattle=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/rattle_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'rattle': $("#rattle").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        rattle++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function ball_clicks() {
	var ball=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/ball_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'ball': $("#ball").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        ball++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function swing_clicks() {
	var swing=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/swing_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'swing': $("#swing").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        swing++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function lego_clicks() {
	var lego=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/lego_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'lego': $("#lego").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        lego++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function trampoline_clicks() {
	var trampoline=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/trampoline_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'trampoline': $("#trampoline").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        trampoline++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function car_clicks() {
	var car=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/car_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'car': $("#car").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        car++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function teddy_clicks() {
	var teddy=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/teddy_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'teddy': $("#teddy").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        teddy++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function flash_clicks() {
	var flash=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/flash_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'flash': $("#flash").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        flash++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function slide_clicks() {
	var slide=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/slide_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'slide': $("#slide").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        slide++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function getclicks_toys(){

	 $("#toys_rec").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/toys_activity',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   toy_name = resp.entries[i].toy_name;
									   clicks = resp.entries[i].clicks;
									   $("#toys_rec").append(toys_rec(toy_name,clicks));

                                  }



				} else
				{
                                       $("#toys_rec").html("");
					alert(resp.message);
				}
    		}
		});
}


function toys_rec(toy_name,clicks)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0px" >' +
       '<table class="table table-hover" cellspacing="0" cellpadding="0">'+
       '<thead class="table-head">'+
                         '<tr class="table-head">'+
                            '<th>Toy Name</th>'+
                            '<th>Clicks</th>'+
                        '</tr>'+
                    '</thead>'+
       '<tbody>'+
    '<tr><td>'+toy_name+'</td>'+
    '<td>'+clicks+'</td></tr>'+
    '</tbody>'+

       '</table></div>';


}

function jollibee_clicks() {
	var jollibee=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/jollibee_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'jollibee': $("#jollibee").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        jollibee++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function church_clicks() {
	var church=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/church_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'church': $("#church").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        church++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function mcdo_clicks() {
	var mcdo=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/mcdo_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'mcdo': $("#mcdo").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        mcdo++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function school_clicks() {
	var school=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/school_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'school': $("#school").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        school++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function pool_clicks() {
	var pool=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/pool_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'pool': $("#pool").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        pool++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function beach_clicks() {
	var beach=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/beach_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'beach': $("#beach").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        beach++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function mall_clicks() {
	var mall=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/mall_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'mall': $("#mall").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        mall++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function getclicks_places(){

	 $("#places_rec").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/places_activity',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   place_name = resp.entries[i].place_name;
									   clicks = resp.entries[i].clicks;
									   $("#places_rec").append(places_rec(place_name,clicks));

                                  }



				} else
				{
                                       $("#places_rec").html("");
					alert(resp.message);
				}
    		}
		});
}


function places_rec(place_name,clicks)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0px" >' +
       '<table class="table table-hover" cellspacing="0" cellpadding="0">'+
       '<thead class="table-head">'+
                         '<tr class="table-head">'+
                            '<th>Place</th>'+
                            '<th>Clicks</th>'+
                        '</tr>'+
                    '</thead>'+
       '<tbody>'+
    '<tr><td>'+place_name+'</td>'+
    '<td>'+clicks+'</td></tr>'+
    '</tbody>'+

       '</table></div>';

}

function play_clicks() {
	var play=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/play_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'play': $("#play").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        play++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function panty_clicks() {
	var panty=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/panty_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'panty': $("#panty").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        panty++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function shorts_clicks() {
	var shorts=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/shorts_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'shorts': $("#shorts").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        shorts++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function shirt_clicks() {
	var shirt=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/shirt_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'shirt': $("#shirt").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        shirt++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function jacket_clicks() {
	var jacket=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/jacket_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'jacket': $("#jacket").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        jacket++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function dress_clicks() {
	var dress=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/dress_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'dress': $("#dress").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        dress++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function skirt_clicks() {
	var skirt=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/skirt_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'skirt': $("#skirt").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        skirt++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function pants_clicks() {
	var pants=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/pants_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'pants': $("#pants").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        pants++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function sweater_clicks() {
	var sweater=0;
	$.ajax(
		{
			url: 'http://127.0.0.1:5000/sweater_rec',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'sweater': $("#sweater").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
			        sweater++;

                 }
				else {
					alert("ERROR")
				}

			}
		});
}


function getclicks_clothes(){

	 $("#clothes_rec").show();

$.ajax({
    		url: 'http://127.0.0.1:5000/clothes_activity',
    		type: "GET",
    		dataType: "json",
    		success: function(resp) {

				if (resp.status  == 'ok') {
				   for (i = 0; i < resp.count; i++)
                                  {
									   cloth_name = resp.entries[i].cloth_name;
									   clicks = resp.entries[i].clicks;
									   $("#clothes_rec").append(clothes_rec(cloth_name,clicks));

                                  }



				} else
				{
                                       $("#clothes_rec").html("");
					alert(resp.message);
				}
    		}
		});
}


function clothes_rec(cloth_name,clicks)
{
   return '<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0px" >' +
       '<table class="table table-hover" cellspacing="0" cellpadding="0">'+
       '<thead class="table-head">'+
                         '<tr class="table-head">'+
                            '<th>Clothes</th>'+
                            '<th>Clicks</th>'+
                        '</tr>'+
                    '</thead>'+
       '<tbody>'+
    '<tr><td>'+cloth_name+'</td>'+
    '<td>'+clicks+'</td></tr>'+
    '</tbody>'+

       '</table></div>';

}

//records
// $(document).ready(function() {
//     var activeSystemClass = $('.list-group-item.active');
//
//     //something is entered in search form
//     $('#system-search').keyup( function() {
//        var that = this;
//         // affect all table rows on in systems table
//         var tableBody = $('.table-list-search tbody');
//         var tableRowsClass = $('.table-list-search tbody tr');
//         $('.search-sf').remove();
//         tableRowsClass.each( function(i, val) {
//
//             //Lower text for case insensitive
//             var rowText = $(val).text().toLowerCase();
//             var inputText = $(that).val().toLowerCase();
//             if(inputText != '')
//             {
//                 $('.search-query-sf').remove();
//                 tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
//                     + $(that).val()
//                     + '"</strong></td></tr>');
//             }
//             else
//             {
//                 $('.search-query-sf').remove();
//             }
//
//             if( rowText.indexOf( inputText ) == -1 )
//             {
//                 //hide rows
//                 tableRowsClass.eq(i).hide();
//
//             }
//             else
//             {
//                 $('.search-sf').remove();
//                 tableRowsClass.eq(i).show();
//             }
//         });
//         //all tr elements are hidden
//         if(tableRowsClass.children(':visible').length == 0)
//         {
//             tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
//         }
//     });
// });

function delete_food() {

	$.ajax(
		{
			url: 'http://127.0.0.1:5000/delete_food',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'food': $("#food").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                alert("Successfully cleared!");
                window.location.replace("food_rec.html")

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function delete_toys() {

	$.ajax(
		{
			url: 'http://127.0.0.1:5000/delete_toys',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'toy': $("#toy").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                alert("Successfully cleared!");
                window.location.replace("toys_rec.html")

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function delete_places() {

	$.ajax(
		{
			url: 'http://127.0.0.1:5000/delete_places',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'place': $("#place").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                alert("Successfully cleared!");
                window.location.replace("places_rec.html")

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function delete_clothes() {

	$.ajax(
		{
			url: 'http://127.0.0.1:5000/delete_clothes',
			contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                 'cloth': $("#cloth").val()
             }),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                alert("Successfully cleared!");
                window.location.replace("clothes_rec.html")

                 }
				else {
					alert("ERROR")
				}

			}
		});
}

function upload_food() {


	$.ajax(
		{
			url: 'http://127.0.0.1:5000/new_food',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify({
				'food_name': $("#food_name").val(),
				'food_img': $("#food_img").val()
			}),
			type: "POST",
			dataType: "json",
			error: function (e) {
			},
			success: function (resp) {
                if (resp.status == 'ok') {
                	alert("Successfully updated!");

                 }
				else {
					alert("ERROR")
				}

			}
		});
}


// function upload() {
//     $('#upload-file-btn').click(function() {
//         var form_data = new FormData($('#upload-file')[0]);
//         $.ajax({
//             type: 'POST',
//             url: '/upload',
//             data: form_data,
//             contentType: false,
//             cache: false,
//             processData: false,
//             async: false,
//             success: function(data) {
//                 console.log('Success!');
//             },
//         });
//     });
// });



// function getinfo(){
//
// 				var child_num = $('#child_num').text();
//
//
// $.ajax({
//     		url: 'http://127.0.0.1:5000/child_info/',
//     		type:"GET",
//     		dataType: "json",
//     		success: function(resp) {
// 				$("#child_info").html("");
// 				if (resp.status  == 'ok') {
// 				   for (i = 0; i < resp.count; i++)
//                                   {
// 									   first_name = resp.entries[i].first_name;
// 									   last_name = resp.entries[i].last_name;
// 									   birthdate= resp.entries[i].birthdate;
// 									   age = resp.entries[i].age;
// 									   diagnosis = resp.entries[i].diagnosis;
//                                        $("#child_info").append(rowinfo(first_name, last_name, birthdate, age, diagnosis));
//                                   }
//
// 				} else
// 				{
//                                        $("#child_info").html("");
// 					alert(resp.message);
// 				}
//     		}
// 		});
// }
//
// $("input:checkbox").change(function () {
//     var checkname = $(this).attr("name");
//
//     if (this.checked) {
//
//         $("input:checkbox[name='" + checkname + "']").removeAttr("checked").parent().hide();
//         this.checked = true;
//         $(this).parent().show();
//     } else {
//         $("input:checkbox[name='" + checkname + "']").parent().show();
//     }
// });
//
//     function edit_food() {
//         console.log($('input[name="food"]:checked').serialize());
//
//         $.ajax({
//             url: 'http://127.0.0.1:5000/food.html/edited',
//             data: JSON.stringify({}),
//             type: "POST",
//             dataType: "json",
//             success: function (newSet) {
//                 $('input[name="food"]:checked');
//                 if (newSet.status == 'ok') {
//                     alert("SAVED!")
//                 }
//             },
//             error: function (e) {
//                 alert("Something went wrong!");
//             }
//         });
//
//        var $set = $('#set');
//
//         $.ajax({
//             url: 'http://127.0.0.1:5000/food.html/',
//             data: JSON.stringify({}),
//             type: "GET",
//             dataType: "json",
//             success: function (set) {
//                 $('input[name="food"]:checked');
//                 if (set.status == 'ok') {
//                     alert("SAVED!")
//                 }
//             },
//             error: function(e) {
//                 alert("Something went wrong!");
//             }
//         });
//     }
//
//         function cancel_edit() {
//             console.log("hello");
//             $.ajax({
//                 url: 'http://127.0.0.1:5000/login/',
//                 contentType: 'application/json; charset=utf-8',
//                 data: JSON.stringify({}),
//                 type: "POST",
//                 dataType: "json",
//                 success: function (resp) {
//                     if (resp.status == 'ok') {
//                         window.location.replace('food.html');
//                     } else if (resp.status == 'error') {
//                         window.location.replace('edit_food.html');
//                     }
//
//                 },
//                 error: function (resp) {
//                     window.location.replace('food.html');
//                 }
//             });
//         }
//
//         function clicks_food() {
//             console.log("hello");
//             $.ajax({
//                 url: 'http://127.0.0.1:5000/food/',
//                 type: "POST",
//                 data: JSON.stringify($(this).attr("id")),
//                 contentType: 'application/json;charset=UTF-8',
//                 success: function (data) {
//                     console.log(data);
//                 },
//                 dataType: "json"
//             });
//         }
// if i just lay here