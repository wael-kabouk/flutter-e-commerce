const mongose = require('mongoose');

const productShcema = mongose.Schema({
    name:{
        type:String,
        required:true,
        trim:true
    },
    description:{
        type:String,
        required:true,
        trim:true
    },
    
    
    price:{
        type:Number,
        required:true,
    },
    quantity:{
        type:Number,
        required:true,
    },
    imagesUrls:[{

        type:String,
        required:true,

    }],
    category:{
        type:String,
        required:true,
        trim:true
    },


});

const Product = mongose.model('Product', productShcema);

module.exports = Product;