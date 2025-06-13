# DDI-Codebook 2.5 to HealthDCAT-AP mapping

Implementation of DDI Codebook 2.5 to HealthDCAT-AP schema mapping.

An XSLT 3.0 implementation of the mapping can be found in the project's root folder, under the file: `ddic-to-healthdcat-ap.xsl`.

Detailed documentation of the XSLT templates can be found at the link: TODO.

## Mapped entities

| Entity                | DDI Codebook 2.5                                    | HealthDCAT-AP                                                                  |
| --------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------ |
| Identification Number | IDNo                                                | dcat:Dataset/dct:identifier                                                    |
| Title                 | titl                                                | dcat:Dataset/dct:title                                                         |
| Alternative Title     | altTitl                                             | dcat:Dataset/dct:alternative                                                   |
| Creator               | AuthEnty                                            | dcat:Dataset/dct:creator                                                       |
| Primary Investigator  | AuthEnty                                            | dcat:Dataset/prov:qualifiedAttribution (dcat:hadRole = "Primary Investigator") |
| Other contributors    | othId                                               | dcat:Dataset/prov:qualifiedAttribution (dcat:hadRole = ddi:othId:role)         |
| Contact Point         | contact                                             | dcat:Dataset/dcat:contactPoint                                                 |
| Legal Basis           | authorizationStatement                              | dcat:Dataset/dpv:hasLegalBasis                                                 |
| Keyword               | keyword                                             | dcat:Dataset/dcat:keyword                                                      |
| Description           | abstract (abstract:contentType = ' ' or 'abstract') | dcat:Dataset/dct:description                                                   |
| Purpose               | abstract (abstract:contentType = 'purpose')         | dcat:Dataset/dct:purpose                                                       |
| Health Theme          | topcClas                                            | dcat:Dataset/health:healthTheme                                                |
| Population Coverage   | universe                                            | dcat:Dataset/health:populationCoverage                                         |
| Geographical Coverage | ddi:nation, ddi:geogCover, ddi:geogUnit"            | dcat:Dataset/dct:spatial/dct:Location                                          |
| Collection Frequency  | frequenc                                            | dcat:Dataset/dct:accrualPeriodicity/dct:Frequency                              |
| Collection Start      | collDate (collDate:start)                           | dcat:Dataset/dct:temporal/dct:PeriodOfTime/dcat:startDate                      |
| Collection End        | collDate (collDate:end)                             | dcat:Dataset/dct:temporal/dct:PeriodOfTime/dcat:endDate                        |


## Namespaces Glossary

| Namespace | Name                              | URI                                               |
| --------- | --------------------------------- | ------------------------------------------------- |
| dct       | DCMI Metadata Terms (Dublin Core) | http://purl.org/dc/terms/                         |
| dcat      | Data Catalog Vocabulary           | http://www.w3.org/ns/dcat#                        |
| foaf      | Friend of a Friend                | http://xmlns.com/foaf/0.1/                        |
| dpv       | Data Privacy Vocabulary           | http://www.w3.org/ns/dpv#                         |
| health    | Health DCAT-AP                    | http://eurohealthnet.eu/ontologies/healthdcat-ap# |
| rdf       | RDF Syntax Namespace              | http://www.w3.org/1999/02/22-rdf-syntax-ns#       |
| prov      | Provenance Ontology               | http://www.w3.org/ns/prov#                        |
| vcard     | vCard Ontology                    | http://www.w3.org/2006/vcard/ns#                  |

## Usage

In order to implement the mapping using the XSLT file, an XLST 3.0 processor is needed.

The following example shows how to perform the transformation of an input DDI file into a HealthDCAT-AP file using the `saxonche` library in Python.

```python
from saxonche import PySaxonProcessor

def execute_xsl_transformation(xml_file, xsl_file, output_file):
    try:
        with PySaxonProcessor(license=False) as proc:
            xsltproc = proc.new_xslt30_processor()
            
            # Parse the input XML
            xml_input = proc.parse_xml(xml_file_name=xml_file)
            
            # Compile and execute the XSLT
            xslt_exec = xsltproc.compile_stylesheet(stylesheet_file=xsl_file)
            xml_output = xslt_exec.transform_to_string(xdm_node=xml_input)
            
            if xml_output:
                with open(output_file, "w", encoding="utf-8") as f:
                    f.write(xml_output)
                print(f"Transformation complete. Output written to {output_file}")
            else:
                print("Transformation produced no output.")
    
    except Exception as e:
        print(f"An error occurred during transformation: {e}")

# Example usage
execute_xsl_transformation(
    "ddi-c-input.xml",
    "ddic-to-healthdcat-ap.xsl",
    "health-dcat-ap-output.rdf"
)
```
