rem Custom deployment script to enable us to have code in the src folder.
rem
rem @see https://stackoverflow.com/a/40532400/1982136
rem @see https://github.com/projectkudu/kudu/wiki/Customizing-deployments#deploying-with-custom-script

@echo off
echo Copying function for deployment...
xcopy "%DEPLOYMENT_SOURCE%\src" %DEPLOYMENT_TARGET% /Y /S
