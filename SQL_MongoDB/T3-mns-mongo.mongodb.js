// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T3-mns-mongo.mongodb.js

// Student ID: 31240291
// Student Name: Dizhen Liang
// Unit Code: FIT3171
// Applied Class No:

//Comments for your marker:

// ===================================================================================
// Do not modify or remove any of the comments in this document (items marked with //)
// ===================================================================================

//Use (connect to) your database - you MUST update xyz001
//with your authcate username

use("dlia0009");

// 3(b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Drop collection 
db.assignment.drop();

// Create collection and insert documents
db.assignment.insertMany(
    [
        {"_id":1,"datetime":"08/09/2023 10:00","provider_code":"ORS001","provider_name":"Dr Jessica Jones","item_totalcost":250,"no_of_items":2,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":97},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":98}]},
        {"_id":3,"datetime":"08/09/2023 12:00","provider_code":"ORS001","provider_name":"Dr Jessica Jones","item_totalcost":2260,"no_of_items":19,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":990},{"id":15,"desc":"Absorbable suture","standardcost":3,"quantity":498},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":145},{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":480},{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":98}]},
        {"_id":5,"datetime":"08/09/2023 16:00","provider_code":"GEN001","provider_name":"Dr Bruce Striplin","item_totalcost":155,"no_of_items":1,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":97}]},
        {"_id":7,"datetime":"08/09/2023 12:00","provider_code":"GEN002","provider_name":"Dr Amalia Morris","item_totalcost":133,"no_of_items":1,"items":[{"id":18,"desc":"Fluid composite","standardcost":78,"quantity":49}]},
        {"_id":8,"datetime":"08/09/2023 12:00","provider_code":"END001","provider_name":"Dr Mark Stanton","item_totalcost":753,"no_of_items":3,"items":[{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":98},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":145},{"id":6,"desc":"Universal Clamp","standardcost":15,"quantity":149}]},
        {"_id":9,"datetime":"11/09/2023 15:00","provider_code":"ORS001","provider_name":"Dr Jessica Jones","item_totalcost":195,"no_of_items":10,"items":[{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":480}]},
        {"_id":10,"datetime":"11/09/2023 09:15","provider_code":"PER002","provider_name":"Dr Joseph Hazelton","item_totalcost":336,"no_of_items":2,"items":[{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":98},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":145}]},
        {"_id":11,"datetime":"11/09/2023 15:00","provider_code":"PED002","provider_name":"Dr  Lee","item_totalcost":250,"no_of_items":2,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":97},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":98}]},
        {"_id":18,"datetime":"14/09/2023 10:00","provider_code":"PER001","provider_name":"Dr April Manahan","item_totalcost":380,"no_of_items":3,"items":[{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":98},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":145}]},
        {"_id":19,"datetime":"14/09/2023 14:00","provider_code":"END001","provider_name":"Dr Mark Stanton","item_totalcost":975,"no_of_items":7,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":990},{"id":16,"desc":"Universal composite","standardcost":48,"quantity":99},{"id":5,"desc":"Sterile K NiTi files","standardcost":7,"quantity":149}]},
        {"_id":20,"datetime":"14/09/2023 09:00","provider_code":"PED001","provider_name":"Dr Kevin Barr","item_totalcost":470,"no_of_items":2,"items":[{"id":22,"desc":"Porcelain Etch","standardcost":35,"quantity":49},{"id":23,"desc":"Silane","standardcost":25,"quantity":49}]},
        {"_id":22,"datetime":"14/09/2023 10:00","provider_code":"ORT001","provider_name":"Dr Gerry Elliott","item_totalcost":7340,"no_of_items":44,"items":[{"id":9,"desc":"Metal Bracket","standardcost":1.5,"quantity":980},{"id":12,"desc":"Curved lingual button","standardcost":1,"quantity":992},{"id":11,"desc":"Archwire","standardcost":2,"quantity":996},{"id":10,"desc":"Molar mouth tube","standardcost":2,"quantity":988}]}
    ]
)

// List all documents you added
db.assignment.find();

// 3(c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.assignment.aggregate([
    {   //deconstruct the items array from the input documents
        //duplicate the input document to the number of item documents
        //each assigned with distinctive item document
        $unwind: "$items"
    },
    {   //group those duplicated input document
        //based on the id of input document
        //then sum up the totalCost and itemCount
        $group: { //group those items based on the  
            _id: "$_id",
            totalCost: { $sum: "$items.standardcost" },
            itemCount: { $sum: 1 }
        }
    },
    {
        $match: { //find the input document(appointment)
            $or: [ //that has total cost > 50 or itemCount > 2
                { totalCost: { $gt: 50 } },
                { itemCount: { $gt: 2 } }
            ]
        }
    }
])



// 3(d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.assignment.updateMany(
    {"items.id":1},
    {
        $set:
        {   //change only the first element with item id: 1 in the array
            "items.$.desc": "Paper points"
        }
    }
)


// // Illustrate/confirm changes made
db.assignment.find({"items.id": 1});


// 3(e)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

//insertMany can not only insert input documents with new id into database 

// db.assignment.updateMany(
//     {"_id": 20},
//     {
//         "$push":
//         {
//             "items": 
//             {
//                 $each: //add each item document to the documents array
//                 [
//                     {"id": 3, "desc": "EDTA Cleansing Gel 17%","standartcost": 8,"quantity": 1},
//                     {"id": 4, "desc": "Irrigation Solution 2% Chlorhexidine", "standardcost": 9, "quantity": 1},
//                     {"id": 8, "desc": "Irrigation Needle and Syringe", "standardcost": 2, "quantity": 2}
//                 ]
                        
              
//             }       
//         }
//     }
// )


// // Illustrate/confirm changes made
// db.assignment.find({"_id":20});