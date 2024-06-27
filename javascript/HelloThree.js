const { app } = require('@azure/functions');

app.http('HttpExample', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);

        let interpreter = '';

        const name = request.query.get('name') || await request.text() || 'world';
        const apl  = request.query.get('apl')  || await request.text() || 'aplw';

        switch(apl) {
        case 'dyalog':
            interpreter = 'Dyalog APL';
            break;
        case 'apl64':
            interpreter = 'APL64';
            break;
        case 'aplw':
            interpreter = 'APL+Win';
            break;
        default:
            interpreter = 'a stranger';
            break;
        }

        // stub to test the arguments; no actual APL involved
        return { body: `Hello, ${name} from ${interpreter}!` };
    }
});
