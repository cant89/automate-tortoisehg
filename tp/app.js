/*
* Main app for Target Process API
*
*
*/

var request = require('request'),
    username = "",
    password = "",
    url = "",
    auth = "Basic " + new Buffer(username + ":" + password).toString("base64");

request(
    {
        url : url,
        headers : {
            "Authorization" : auth
        }
    },
    function (error, response, body) {
        // Do more stuff with 'body' here
		console.log(body);
    }
);