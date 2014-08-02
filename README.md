hubot-jenkins-job-status-change
===============================

hubot script for jenkins to change jobs status (disable or enable).

## Install

```bash
$ cd hubot_directory
$ npm install --save hubot-jenkins-job-status-change
```

Then add "hubot-jenkins-job-status-change" to external-scripts.json.

```javascript
["hubot-jenkins-job-status-change"]
```

## Config

This script requires the following environment variables.

`HUBOT_JENKINS_USER_NAME`: User name for jenkins.  
`HUBOT_JENKINS_PASSWORD`: Passwordf for jenkins.  
`HUBOT_JENKINS_URL`: Jenkins root url. e.g. "http://127.0.0.1:8080/jenkins"  
`HUBOT_JENKINS_JOBS`: Jenkins job name you want to change status by this script.You can specify multiple jobs, comma delimited. e.g. "test1, test2, hoge"  

```bash
$ HUBOT_JENKINS_USER_NAME="user" \
HUBOT_JENKINS_PASSWORD="password" \
HUBOT_JENKINS_URL="http://127.0.0.1:8080/jenkins" \
HUBOT_JENKINS_JOBS="test1, test2, test3" \
./bin/hubot
```

## Commands

```
hubot jenkins job disable
hubot jenkins job enable
```
