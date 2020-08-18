`aws lambda add-permission --function-name DemoAuthorizer --action lambda:InvokeFunction --statement-id apigateway \
--principal apigateway.amazonaws.com --output text`