import ballerinax/health.fhir.r4.aubase410;
import ballerinax/mssql;
import ballerinax/mssql.driver as _;
import ballerina/log;

configurable string HOST = ?;
configurable string USERNAME = ?;
configurable string PASSWORD = ?;
configurable string DATABASE = ?;
configurable int PORT = ?;

//The Patient record to interact with the database.
public type Patient record {
    string id;
    string firstName;
    string lastname;
    string birthDate;
    string gender;
    string email;
    string address_city;
    string mobileNumber;
};

final mssql:Client dbClient = check new (
    HOST,
    USERNAME,
    PASSWORD,
    DATABASE,
    PORT
);

isolated function getPatient(string id) returns aubase410:AUBasePatient|error {
    Patient patient = check dbClient->queryRow(`SELECT * FROM patient_details WHERE id = ${id}`);
    aubase410:AUBasePatient transformResult = transform(patient);
    log:printInfo(transformResult.toBalString());
    return transformResult;
}

isolated function transform(Patient patient) returns aubase410:AUBasePatient => {
    id: patient.id,
    name: [
        {
            family: patient.lastname,
            given: [patient.firstName]
        }
    ],
    birthDate: patient.birthDate,
    address: [
        {
            city: patient.address_city
        }
    ],
    telecom: [
        {
            system: "email",
            value: patient.email
        },
        {
            system: "phone",
            value: patient.mobileNumber
        }
    ]

};
