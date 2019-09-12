#!/bin/sh
# make sure to run this `. debug.sh Notice the pace after the dot. That is for the environmental variables to persist

# setting up my vars
# kong prefix- default /usr/local/kong/
export kPrefixPath=$(cat /usr/local/kong/.kong_env | grep "prefix = /." | cut -c 10-44)
echo Kong prefix= $kPrefixPath

# proxy log location- default logs/access.log
export proxyLogPath=$(cat /usr/local/kong/.kong_env | grep "proxy_access_log = " | cut -c 20-44)
echo Kong proxy log= $proxyLogPath

# proxy error log location default logs/error.log
export proxyErrorLogPath=$(cat /usr/local/kong/.kong_env | grep "proxy_error_log = " | cut -c 18-44)
echo Kong proxy error log= $proxyErrorLogPath

# admin access log location default logs/admin_access.log
export adminAccessLogPath=$(cat /usr/local/kong/.kong_env | grep "admin_access_log = " | cut -c 19-44)
echo Kong admin access log= $adminAccessLogPath

# admin error log location default logs/error.log 
export adminErrorLogPath=$(cat /usr/local/kong/.kong_env | grep "admin_error_log = " | cut -c 18-44)
echo Kong admin error log= $adminErrorLogPath


#now that I have everything variablized, I should be able to just print everything to a file
# I'll start by printing all of their environmental variables
cat /usr/local/kong/.kong_env > kongConfigurationInUse.txt
#print proxy log
cat $kPrefixPath/$proxyLogPath > proxyLog.txt
# print proxy errors
cat $kPrefixPath/$proxyErrorLogPath > proxyError.txt
#print admin access logs
cat $kPrefixPath/$adminAccessLogPath > adminAccess.txt
# print admin errors
cat $kPrefixPath/$adminErrorLogPath > adminError.txt

#create a diurectory to place he files into
mkdir debug
mv kongConfigurationInUse.txt debug
mv proxyLog.txt debug
mv proxyError.txt debug
mv adminAccess.txt debug
mv adminError.txt debug
