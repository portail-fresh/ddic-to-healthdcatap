<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ddi="ddi:codebook:2_5"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:dpv="http://www.w3.org/ns/dpv#"
    xmlns:health="http://eurohealthnet.eu/ontologies/healthdcat-ap#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:prov="http://www.w3.org/ns/prov#"
    exclude-result-prefixes="xsl">

    <xsl:output method="xml" indent="yes" />

    <!-- Root template -->
    <xsl:template match="/ddi:codeBook">
        <rdf:RDF>
            <dcat:Dataset>

                <!-- dct:title -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:titl">
                    <dct:title>
                        <xsl:value-of select="." />
                    </dct:title>
                </xsl:for-each>
                
                <!-- dct:identifier -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:IDNo">
                    <dct:identifier>
                        <xsl:value-of select="." />
                    </dct:identifier>
                </xsl:for-each>

                <!-- dct:alternative -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:altTitl">
                    <dct:alternative>
                        <xsl:value-of select="." />
                    </dct:alternative>
                </xsl:for-each>

                <!-- dpv:hasLegalBasis -->
                <xsl:for-each
                    select="ddi:stdyDscr/ddi:studyAuthorization/ddi:authorizationStatement">
                    <dpv:hasLegalBasis>
                        <dct:description>
                            <xsl:value-of select="." />
                        </dct:description>
                    </dpv:hasLegalBasis>
                </xsl:for-each>

                <!-- dcat:keyword -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:keyword">
                    <dcat:keyword>
                        <xsl:value-of select="." />
                    </dcat:keyword>
                </xsl:for-each>

                <!-- dct:description -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:abstract">
                    <dct:description>
                        <xsl:value-of select="." />
                    </dct:description>
                </xsl:for-each>

                <!-- health:healthTheme -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:topcClas">
                    <health:healthTheme>
                        <xsl:value-of select="." />
                    </health:healthTheme>
                </xsl:for-each>

                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty">
                    <prov:qualifiedAttribution>
                        <prov:Attribution>
                            <dcat:hadRole
                                rdf:resource="https://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/processor" />
                            <prov:agent>
                                <foaf:Person>
                                    <foaf:name>
                                        <xsl:value-of select="." />
                                    </foaf:name>
                                    <xsl:if test="@affiliation">
                                        <foaf:organization>
                                            <xsl:value-of select="@affiliation" />
                                        </foaf:organization>
                                    </xsl:if>
                                </foaf:Person>
                            </prov:agent>
                        </prov:Attribution>
                    </prov:qualifiedAttribution>
                </xsl:for-each>

            </dcat:Dataset>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>