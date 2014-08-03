auth = 'Basic ' + new Buffer(process.env.HUBOT_JENKINS_USER_NAME + ':' + process.env.HUBOT_JENKINS_PASSWORD).toString('base64');
jobs = process.env.HUBOT_JENKINS_JOBS.split(',');
jenkinsUrl = process.env.HUBOT_JENKINS_URL;
 
module.exports = (robot) ->
  robot.hear /j(?:enkins)? s(?:tatus[s]*)? (.*)/i, (msg) ->
    process = msg.match[1]
 
    if process isnt 'enable' and process isnt 'disable'
      msg.send 'Usage: jenkins job [disable | enable]'
      return

    for job in jobs
      jobName = job.trim()
      robot.http(jenkinsUrl + '/job/' + jobName + '/' + process)
        .header('Authorization', auth)
        .post() (err, res, body) ->
          if err
            msg.send 'Failed to send request. reason [' + err + ']'
          else if res.statusCode isnt 302
            msg.send 'Failed to change status. host: [' + res.req._headers.host + '] path: [' + res.req.path+ '] code: [' + res.statusCode + ']'
          else
            msg.send 'success: [' + res.headers['location'] + '] '
