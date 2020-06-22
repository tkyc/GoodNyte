#!/bin/sh

# First argument of script is the container id of the build environment
# Must set name of lambda
containerId=$1
lambdaName="rust-lambda-test"

if [ -z "$containerId" ];then
    echo "make-deploy: cannot build and deploy lambda function: Missing container id of build environment"
    exit 126
fi

sudo docker cp . $containerId:/build-dir
sudo docker exec $containerId cargo build --release
sudo docker cp $containerId:/build-dir/target/release/goodnyte ./bootstrap
zip lambda.zip bootstrap && rm -f bootstrap
aws lambda update-function-code --function-name $lambdaName --zip-file fileb://lambda.zip
rm lambda.zip
