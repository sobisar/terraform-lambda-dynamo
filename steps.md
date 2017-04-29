# Getting started with Terraform, Lamdba for a public API, .netCore, and DynamoDb


###### Setup Your Machine

1. Download and install [The AWS CLI]
2. Download and install [Terraform] -> This is just an exe that you run on windows. -> I put my copy in a folder called c:\devtools.
3. Add c:\devtools to your path. On windows I followed [these instructions].
4. I confirmed this on windows by using the `$Env:Path` command in PowerShell.
5. Install [AWS Toolkit for VS]

###### Add AWS Credentials

1. Open a command prompt. I used PowerShell.
2. Type the command `aws configure`
3. This prompts you for credentials. I went to [AWS Security]
4. Clicked on User
5. Added User
6. Created a new user called `Terraform-Test` and gave it programmatic access
7. I gave the user `SystemAdministrator` permissions
8. I then entered my credentials and gave it the default region of `us-east-2`
9. I left output format blank

###### Creating New C# Service

1. Navigate to your directory in your command prompt. For me this was `cd C:\GitHub\terraform-lambda-dynamo\`
2. Use the following command `serverless create --template aws-csharp --path first-function
`
3. I modified the `Handler.cs` file to respond with `return new Response("This is a response from Thomas Sobieck's lambda function.", request);` on line 9
4. I then ran `.\first-function\build.ps1`-> This didn't work because I didn't have a solution file
5. It output `.\first-function\`


###### Helpful links

 - [Helpful Blog on Terraform]
 - [Serverless C# on AWS Lambda (pt. 1) - Getting Started]
 - [write serverless functions using aws lambda and c#]

[The AWS CLI]: https://aws.amazon.com/cli/
[Terraform]: https://www.terraform.io/intro/getting-started/install.html
[Helpful Blog on Terraform]: https://seanmcgary.com/posts/how-to-deploy-an-aws-lambda-with-terraform
[these instructions]:http://stackoverflow.com/a/1618297/2740086
[AWS Security]: https://console.aws.amazon.com/iam/home?region=us-west-2#/security_credential
[Serverless C# on AWS Lambda (pt. 1) - Getting Started]: http://thingrepository.com/2017/02/05/Serverless-C-on-AWS-Lambda-pt-1/
[AWS Toolkit for VS]: https://aws.amazon.com/visualstudio/
[write serverless functions using aws lambda and c#]: https://www.codeproject.com/Articles/1172832/write-serverless-functions-using-aws-lambda-and-cs
