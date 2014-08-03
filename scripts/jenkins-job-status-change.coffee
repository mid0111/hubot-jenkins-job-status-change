# Description:
#   Allows hubot to disable the specify jenkins's jobs, or enable it from hubot.
#   The target jobs for this script are defined in environment variable.
#
# Dependencies:
#   none
#
# Configuration:
#   This script requires the following environment variables.
#     HUBOT_JENKINS_USER_NAME: User name for jenkins.
#     HUBOT_JENKINS_PASSWORD: Passwordf for jenkins.
#     HUBOT_JENKINS_URL: Jenkins root url. e.g. "http://127.0.0.1:8080/jenkins"
#     HUBOT_JENKINS_JOBS: Jenkins job name you want to change status by this script.
#       You can specify multiple jobs, comma delimited. e.g. "test1, test2, hoge"
#
#   If you use hubot under proxy environment, then you specify proxy settings.
#     HTTP_PROXY: Proxy settings. "http://【UserName】:【password】@【ProxyHost】:【ProxyPort】/"
#
# Commands:
#   hubot jenkins status disable -  disable jenkins's jobs dfined in environment variable
#   hubot jenkins status enable -  enable jenkins's jobs dfined in environment variable
#   hubot jenkins status list -  list up jenkins's jobs dfined in environment variable
#
# Author:
#   mid0111
#

auth = 'Basic ' + new Buffer(process.env.HUBOT_JENKINS_USER_NAME + ':' + process.env.HUBOT_JENKINS_PASSWORD).toString('base64');
jobs = process.env.HUBOT_JENKINS_JOBS.split(',');
jenkinsUrl = process.env.HUBOT_JENKINS_URL;
 
module.exports = (robot) ->
  robot.hear /j(?:enkins)? s(?:tatus*)? (.*)/i, (msg) ->
    process = msg.match[1]
 
    if process isnt 'enable' and process isnt 'disable' and process isnt 'list'
      msg.send 'Usage: jenkins status [disable | enable | list]'
      return

    if process is 'list'
      msg.send 'Target jobs list: [' + jobs + ']'
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


