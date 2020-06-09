require( './config/config' );

const express = require( 'express' );
const app = express();

const bodyParser = require( 'body-parser' );

// Parse application/x-www-form-urlencoded
app.use( bodyParser.urlencoded({ extended: false }) )
// parse application json
app.use( bodyParser.json() );

app.get( '/usuario', ( req, res ) => {
    res.json( 'get Usuario' );
});

app.post( '/usuario', ( req, res ) => {
    let body =req.body;
    res.json( {
        persona : body
    } );
});
app.listen( process.env.PORT, () => {
    console.log( 'Escuchando el puerto AEA', process.env.PORT );
})