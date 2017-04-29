# Getting started with Terraform, Lamdba for a public API, .netCore, and DynamoDb


###### Setup Your Machine

1. Download and install [The AWS CLI]
2. Download and install [Terraform] -> This is just an exe that you run on windows. -> I put my copy in a folder called c:\devtools.
3. Add c:\devtools to your path. `[Environment]::SetEnvironmentVariable("Path", $env:Path + ";c:\devtools", [EnvironmentVariableTarget]::Machine)` in powershell.
4. Restart PowerShell
5. I confirmed this on windows by using the `$Env:Path` command in PowerShell.
6. Install [AWS Toolkit for VS2017]

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

1. Open up Visual Studio
2. Goto File -> New -> Project
3. Goto Visual C# -> AWS Lambda
4. Create a new AWS Lambda Project with Test(.NET Core)
5. Name it `FirstLambda`
6. Select Empty Project
7. Build in release mode
8. Run this [Powershell Script]

Now you have a deployment package for Lambda @ `terraform-lambda-dynamo\FirstLambda\FirstLambda-CurrentDeploy.zip`!

The package is the default. It takes a string and make it uppercase.

##### Running Terraform

The terraform_config.tf file has been set up to deploy to aws lambda.

1. Goto the `terraform-lambda-dynamo` folder in Powershell
2. Run `terraform plan` -> This will show you what will happen when you run the Script
3. If all looks good run `terraform apply` -> This will create the service
4. Run `terraform show` to see that everything is working well.


##### Invoking Your function

1. Type `aws lambda list-functions` to see your function
2. This should show your new function.
3. 

##### Destroying

1. Type `terraform destroy` to delete the services in the `.tf` file

###### Helpful links

 - [Helpful Blog on Terraform]
 - [Serverless C# on AWS Lambda (pt. 1) - Getting Started]
 - [write serverless functions using aws lambda and c#]
 - [Using Terraform to setup AWS API-Gateway and Lambda]

[The AWS CLI]: https://aws.amazon.com/cli/
[Terraform]: https://www.terraform.io/intro/getting-started/install.html
[Helpful Blog on Terraform]: https://seanmcgary.com/posts/how-to-deploy-an-aws-lambda-with-terraform
[these instructions]:http://stackoverflow.com/a/1618297/2740086
[AWS Security]: https://console.aws.amazon.com/iam/home?region=us-west-2#/security_credential
[Serverless C# on AWS Lambda (pt. 1) - Getting Started]: http://thingrepository.com/2017/02/05/Serverless-C-on-AWS-Lambda-pt-1/
[AWS Toolkit for VS2017]: https://aws.amazon.com/blogs/developer/preview-of-the-aws-toolkit-for-visual-studio-2017/
[write serverless functions using aws lambda and c#]: https://www.codeproject.com/Articles/1172832/write-serverless-functions-using-aws-lambda-and-cs
[PowerShell Script]: https://raw.githubusercontent.com/sobisar/terraform-lambda-dynamo/master/FirstLambda/packageLambda.ps1
[Using Terraform to setup AWS API-Gateway and Lambda]: https://andydote.co.uk/2017/03/17/terraform-aws-lambda-api-gateway/
