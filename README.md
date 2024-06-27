# azure

Azure Functions and Durable Functions for deploying Superval on Microsoft Azure

Dependency: APL files in sibling folder; i.e. `../apl/`.


## Usage

All scripts display their usage when called with no parameter.

`new-project.sh <appname>`
: Create a Function App project locally in a new folder, with default script `HttpExample.js` from template `HttpTrigger`.

`make-apl-functionapp.sh <appname> <scriptname>`
: Replace function script `HttpExample.js` with JS from `javascript/`. Ensure APL files copied from `../apl/`.

`make-azure-functionapp.sh <appname>`
: Create a Function App on Azure with its own resource group and storage account.

`delete-azure-functionapp.sh <appname>`
: Delete Function App from Azure and associated resource group and storage account.

`get-fa-url.sh <appname>`
: Display URL for Function App on Azure.

`publish-functionapp <appname>`
: Publish local Function to Azure.

: **Watch out**: this process should be idempotent. 
	It should allow you to edit the function script and republish.
	In practice, the process may start looping on compression and upload and overflow disk space on the platform.

		❯ func azure functionapp publish revapl --node
		Getting site publishing info...
		[2024-06-27T19:18:25.483Z] Starting the function app deployment...
		Creating archive for current directory...
		Uploading 249.79 MB [#############################################################################]
		Creating archive for current directory...
		Uploading 249.79 MB [#############################################################################]
		Creating archive for current directory...
		Uploading 249.79 MB [#############################################################################]
		Error uploading archive (InternalServerError).
		Server Response: {"Message":"An error has occurred.","ExceptionMessage":"There is not enough space on the disk.\r\n","ExceptionType":"System.IO.IOException","StackTrace":"   at System.IO.__Error.WinIOError(Int32 errorCode, Str

	The workaround is to use `delete-azure-functionapp.sh` and `make-azure-functionapp.sh` then rerun `publish-functionapp.sh`.


## Current status

Works with JavaScript and APL+Win

https://revapl.azurewebsites.net/api/HttpExample?name=treboR&apl=aplw

https://revapl.azurewebsites.net/api/HttpExample?name=treboR


Fails with Dyalog (undiagnosed) and APL64 (EXE tries to read and write sibling files instead of in `D:\home\`.)