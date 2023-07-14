import ballerina/log;
import ballerina/http;
import ballerinax/health.fhir.r4.aubase410 as aubase;

listener http:Listener httpListener = new (9595);

type IdNotFound record {|
    *http:NotFound;
    record {
        string message;
    } body;
|};

service / on httpListener {

    // isolated resource function get [string fhirType](string searchParams) returns aubase:AUBasePatient[]|error {

    //     log:printInfo("[SEARCH] Backend Search operation invoked");
    //     map<r4:RequestSearchParameter[]> arr = check r4:decodeFhirSearchParameters(searchParams);
    //     // handle search parameters
    //     io:println("Search parameters: ", arr.length());
    //     lock {
    //         aubase:AUBasePatient[] eobs = [];
    //         foreach record {|readonly string id; aubase:AUBasePatient fhirResource;|} item in fhirResources {
    //             eobs.push(item.fhirResource.cloneReadOnly());
    //         }
    //         return eobs.cloneReadOnly();
    //     }
    // }

    isolated resource function get [string fhirType]/[string id]() returns aubase:AUBasePatient|IdNotFound|error {

        log:printInfo("[READ] Backend Read operation invoked");
        aubase:AUBasePatient auPatient = check getPatient(id);
        return auPatient;
    }

}
