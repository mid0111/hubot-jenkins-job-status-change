hubot-jenkins-job-status-change
=========================

[hubot](https://github.com/github/hubot) script for jenkins to change jobs status, disable or enable on batch processing.

## Description

You can disable the specify jenkins's jobs, or enable it from hubot.  
The target jobs for this script are defined in environment variable.

## Usage

### disable jobs

```bash
> hubot jenkins status disable
> hubot j s disable
```

### enable jobs

```bash
> hubot jenkins status enable
> hubot j s enable
```

### list target jobs changed status by this script

```bash
> hubot jenkins status list
> hubot j s list
```

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

If you use hubot under proxy environment, then you specify proxy settings.

`HTTP_PROXY`: Proxy settings. "http://【ユーザ名】:【パスワード】@【Proxyサーバ】:【ポート番号】/"

````bash
$ HUBOT_JENKINS_USER_NAME="user" \
HUBOT_JENKINS_PASSWORD="password" \
HUBOT_JENKINS_URL="http://127.0.0.1:8080/jenkins" \
HUBOT_JENKINS_JOBS="test1, test2, test3" \
./bin/hubot
```

## Licence

MIT

## Author

[mid0111](https://github.com/mid0111)

