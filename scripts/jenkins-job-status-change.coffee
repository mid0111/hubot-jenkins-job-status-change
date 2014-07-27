request = require 'request'

auth = 'Basic ' + new Buffer(process.env.HUBOT_JENKINS_USER_NAME + ':' + process.env.HUBOT_JENKINS_PASSWORD).toString('base64');
jobs = process.env.HUBOT_JENKINS_JOBS.split(',');
jenkinsUrl = process.env.HUBOT_JENKINS_URL;
 
module.exports = (robot) ->
  robot.hear /j(?:enkins)? j(?:ob[s]*)? (.*)/i, (msg) ->
    process = msg.match[1];
 
    if process isnt 'enable' and process isnt 'disable'
      msg.send 'Usage: jenkins job [disable | enable]'
      return

    for job in jobs
      jobName = job.trim()
      options = 
        url: jenkinsUrl + '/job/' + jobName + '/' + process
        headers : {
          'Authorization' : auth
        }
      
      request.post options, (error, res, body) ->
        if not error and res.statusCode is 302
          msg.send 'success: [' + res.headers['location'] + '] '
        else
          msg.send 'error: [' + res.request.href+ '] ' + res.statusCode

