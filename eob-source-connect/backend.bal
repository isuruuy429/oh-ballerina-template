import ballerina/uuid;
import ballerina/log;
import ballerina/http;
import ballerina/url;
import wso2healthcare/healthcare.fhir.r4;

listener http:Listener httpListener = new (9595);

service / on httpListener {

    isolated resource function get search(string params) returns json[]|error {

        log:printInfo("[SEARCH] Backend Search operation invoked");
        string paramsDecoded = check url:decode(params, "UTF-8");
        json|error parsed = paramsDecoded.fromJsonString();
        map<r4:RequestSearchParameter[]> arr;
        if parsed is map<json> {
            arr = check parsed.cloneWithType();
            
            log:printInfo("searchParamRecord: " + arr.get("_profile")[0].name);
        } 

        lock {
            return fhirResources.cloneReadOnly().toArray();
        }
    }

    resource function get read/[string id]() returns json {

        log:printInfo("[READ] Backend Read operation invoked");

        lock {
            return fhirResources.get(id).jsonResource.cloneReadOnly();
        }
    }

    isolated resource function get [string id]/_history/[string vid]() returns json {
        return "Hello " + id;
    }

    isolated resource function put [string id]() returns json {
        return "Hello " + id;
    }

    isolated resource function patch [string id]() returns json {
        return "Hello " + id;
    }

    isolated resource function delete [string id]() returns json {

        log:printInfo("[DELETE] Backend Delete operation invoked");
        return "Delete " + id;
    }

    isolated resource function post create(@http:Payload json payload) returns string {

        log:printInfo("[CREATE] Backend Create operation invoked");

        //add to table
        string id = uuid:createType1AsString();
        lock {

            fhirResources.put({id: id, jsonResource: payload.cloneReadOnly()});
        }
        return "Hello " + "id";
    }
}
