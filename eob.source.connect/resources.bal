import ballerinax/health.fhir.r4 as r4;

// const is not supported in Ballerina 6.x, hence we need to use this way
isolated final r4:ExplanationOfBenefit sampleEoB = {
    "resourceType": "ExplanationOfBenefit",
    "id": "EB3500",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">A human-readable rendering of the ExplanationOfBenefit</div>"
    },
    "identifier": [
        {
            "system": "http://www.BenefitsInc.com/fhir/explanationofbenefit",
            "value": "987654321"
        }
    ],
    "status": "active",
    "type": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/claim-type",
                "code": "oral"
            }
        ]
    },
    "use": "claim",
    "patient": {
        "reference": "Patient/pat1"
    },
    "created": "2014-08-16",
    "enterer": {
        "reference": "Practitioner/1"
    },
    "insurer": {
        "reference": "Organization/3"
    },
    "provider": {
        "reference": "Practitioner/1"
    },
    "payee": {
        "type": {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/payeetype",
                    "code": "provider"
                }
            ]
        },
        "party": {
            "reference": "Organization/2"
        }
    },
    "facility": {
        "reference": "Location/1"
    },
    "claim": {
        "reference": "Claim/100150"
    },
    "claimResponse": {
        "reference": "ClaimResponse/R3500"
    },
    "outcome": "complete",
    "disposition": "Claim settled as per contract.",
    "careTeam": [
        {
            "sequence": 1,
            "provider": {
                "reference": "Practitioner/example"
            }
        }
    ],
    "insurance": [
        {
            "focal": true,
            "coverage": {
                "reference": "Coverage/9876B1"
            }
        }
    ],
    "total": [
        {
            "category": {
                "coding": [
                    {
                        "code": "submitted"
                    }
                ]
            },
            "amount": {
                "value": 135.57,
                "currency": "USD"
            }
        },
        {
            "category": {
                "coding": [
                    {
                        "code": "benefit"
                    }
                ]
            },
            "amount": {
                "value": 96.00,
                "currency": "USD"
            }
        }
    ]
};

isolated final r4:ExplanationOfBenefit sampleEoBAlt = {
    "resourceType": "ExplanationOfBenefit",
    "id": "EB3501",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">A human-readable rendering of the ExplanationOfBenefit</div>"
    },
    "identifier": [
        {
            "system": "http://www.BenefitsInc.com/fhir/explanationofbenefit",
            "value": "987654321"
        }
    ],
    "status": "active",
    "type": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/claim-type",
                "code": "oral"
            }
        ]
    },
    "use": "claim",
    "patient": {
        "reference": "Patient/pat2"
    },
    "created": "2014-08-16",
    "enterer": {
        "reference": "Practitioner/1"
    },
    "insurer": {
        "reference": "Organization/3"
    },
    "provider": {
        "reference": "Practitioner/1"
    },
    "payee": {
        "type": {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/payeetype",
                    "code": "provider"
                }
            ]
        },
        "party": {
            "reference": "Organization/2"
        }
    },
    "facility": {
        "reference": "Location/1"
    },
    "claim": {
        "reference": "Claim/100150"
    },
    "claimResponse": {
        "reference": "ClaimResponse/R3500"
    },
    "outcome": "complete",
    "disposition": "Claim settled as per contract.",
    "careTeam": [
        {
            "sequence": 1,
            "provider": {
                "reference": "Practitioner/example"
            }
        }
    ],
    "insurance": [
        {
            "focal": true,
            "coverage": {
                "reference": "Coverage/9876B1"
            }
        }
    ],
    "total": [
        {
            "category": {
                "coding": [
                    {
                        "code": "submitted"
                    }
                ]
            },
            "amount": {
                "value": 135.57,
                "currency": "USD"
            }
        },
        {
            "category": {
                "coding": [
                    {
                        "code": "benefit"
                    }
                ]
            },
            "amount": {
                "value": 96.00,
                "currency": "USD"
            }
        }
    ]
};

isolated function getSampleEoB() returns r4:ExplanationOfBenefit {
    lock {
        return sampleEoB.cloneReadOnly();
    }
}

isolated function getSampleEoBAlt() returns r4:ExplanationOfBenefit {
    lock {
        return sampleEoBAlt.cloneReadOnly();
    }
}

isolated table<record {|readonly string id; r4:ExplanationOfBenefit fhirResource;|}> key(id) fhirResources = table [
    {id: "uuid1", fhirResource: getSampleEoB()},
    {id: "uuid2", fhirResource: getSampleEoBAlt()}
];
