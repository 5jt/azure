const { app } = require('@azure/functions');

// https://stackoverflow.com/questions/12941083/execute-and-get-the-output-of-a-shell-command-in-node-js
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);

// filesystem root
const fsroot = 'D:\\home\\';

app.http('HttpExample', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const fs = require('node:fs');

        context.log(`Http function processed request for url "${request.url}"`);

        var interpreter = '', command = '';

        const name = request.query.get('name') || await request.text() || 'world';

        const apl  = request.query.get('apl')  || await request.text() || '';

        switch(apl) {
        case 'dyalog':
            command     = 'dyalogrt.exe reverser.dws';
            interpreter = 'Dyalog APL';
            break;
        case 'apl64':
            interpreter = 'APL64';
            command     = 'CLOUD.exe';
            break;
        case 'aplw':
            interpreter = 'APL+Win';
            command     = 'aplwr.exe REVERSER.w3';
            break;
        default:
            return { body: `Hello, ${[...name].reverse().join("")} from JavaScript!` };
        }

        // Write string to file
        fs.writeFileSync( `${fsroot}input.txt`, name );
        
        const aplOutput = await exec(command);

        if (aplOutput.error) {
            return { body: `error: ${aplOutput.error.message}`};
        } else if (aplOutput.stderr) {
            return { body: `stderr: ${aplOutput.stderr}`};
        } else {
            // read and return file written by APL
            const rslt = fs.readFileSync( `${fsroot}output.txt` );
            return { body: `Hello, ${rslt} from ${interpreter}!` };
        }
    }
});
