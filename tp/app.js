/*
* Main app for Target Process API
*
*
*/

// Include config file
var config = require('app-config');

var idTP = process.argv.slice(2);

var request = require('request'),
    username = config.tp.username,
    password = config.tp.password,
    url = config.tp.url,
    auth = "Basic " + new Buffer(username + ":" + password).toString("base64");

if(idTP) {
	
	idTP = parseInt(idTP);
	
	var postData = {
		Id: idTP,
		Tags: "Ready to Deploy"
	};
	
	request(
		{
			headers : {
				"Authorization" : auth
			},
			method: 'post',
			body: postData,
			json: true,
			url : url + "api/v1/Bugs/?resultFormat=json&resultInclude=[Id,Tags]"
		},
		function (error, response, body) {
			console.log(body);
		}
	);	
}
	

