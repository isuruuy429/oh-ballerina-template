

type SearchParameter record {
    readonly string name;
    readonly string value;
    readonly string 'type;
    readonly FHIRTypedSearchParameter typedValue;
};

type FHIRTypedSearchParameter record {
    readonly string name;
    readonly string? modifier;
};