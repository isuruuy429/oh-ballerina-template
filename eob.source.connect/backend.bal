import ballerina/log;
import ballerina/http;
import ballerina/uuid;
import ballerinax/health.fhir.r4;
import ballerina/io;

listener http:Listener httpListener = new (9595);

type IdNotFound record {|
    *http:NotFound;
    record {
        string message;
    } body;
|};

service / on httpListener {

    isolated resource function get [string fhirType](string searchParams) returns r4:ExplanationOfBenefit[]|error {

        log:printInfo("[SEARCH] Backend Search operation invoked");
        map<r4:RequestSearchParameter[]> arr = check r4:decodeFhirSearchParameters(searchParams);
        // handle search parameters
        io:println("Search parameters: ", arr.length());
        lock {
            r4:ExplanationOfBenefit[] eobs = [];
            foreach record {|readonly string id; r4:ExplanationOfBenefit fhirResource;|} item in fhirResources {
                eobs.push(item.fhirResource.cloneReadOnly());
            }
            return eobs.cloneReadOnly();
        }
    }

    isolated resource function get [string fhirType]/[string id]() returns r4:ExplanationOfBenefit|IdNotFound {

        log:printInfo("[READ] Backend Read operation invoked");
        lock {
            if (!fhirResources.hasKey(id)) {
                return {body: {message: "No matching resource found."}};
            }
            return fhirResources.get(id).fhirResource.cloneReadOnly();
        }
    }

    isolated resource function post [string fhirType](@http:Payload json payload) returns r4:ExplanationOfBenefit|error {

        log:printInfo("[CREATE] Backend Create operation invoked");

        //add to table
        string id = uuid:createType1AsString();
        r4:ExplanationOfBenefit eob = check payload.cloneWithType(r4:ExplanationOfBenefit);
        lock {
            fhirResources.put({id: id, fhirResource: eob.cloneReadOnly()});
        }
        return eob;
    }

    // isolated resource function get [string fhirType]/[string id]/_history/[string vid]() returns json {
    //     return "Hello " + id;
    // }

    // isolated resource function put [string fhirType]/[string id]() returns json {
    //     return "Hello " + id;
    // }

    // isolated resource function patch [string fhirType]/[string id]() returns json {
    //     return "Hello " + id;
    // }

    // isolated resource function delete [string fhirType]/[string id]() returns json {

    //     log:printInfo("[DELETE] Backend Delete operation invoked");
    //     return "Delete " + id;
    // }
}
