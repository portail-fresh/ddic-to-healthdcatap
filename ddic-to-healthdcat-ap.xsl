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
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
    exclude-result-prefixes="xsl">

    <xsl:output method="xml" indent="yes" />

    <xsl:template match="/ddi:codeBook">
        <rdf:RDF>
            <dcat:Dataset>

                <!-- dct:identifier -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:IDNo">
                    <dct:identifier>
                        <xsl:value-of select="." />
                    </dct:identifier>
                </xsl:for-each>

                <!-- dct:title -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:titl">
                    <dct:title>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="@xml:lang" />
                        </xsl:attribute>
                        <xsl:value-of select="." />
                    </dct:title>
                </xsl:for-each>

                <!-- dct:alternative -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:altTitl">
                    <dct:alternative>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="@xml:lang" />
                        </xsl:attribute>
                        <xsl:value-of select="." />
                    </dct:alternative>
                </xsl:for-each>

                <!-- dct:creator -->
                <xsl:if test="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty">
                    <dct:creator>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of
                                select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty[1]/@xml:lang" />
                        </xsl:attribute>
                        <xsl:value-of select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty[1]" />
                    </dct:creator>
                </xsl:if>
                
                
                <!-- PIs -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty">
                    <prov:qualifiedAttribution>
                        <prov:Attribution>
                            <dcat:hadRole>Primary Investigator</dcat:hadRole>
                            <prov:agent>
                                <foaf:Person>
                                    <foaf:name>
                                        <xsl:attribute name="xml:lang">
                                            <xsl:value-of select="@xml:lang" />
                                        </xsl:attribute>
                                        <xsl:value-of select="." />
                                    </foaf:name>
                                    <xsl:if test="@affiliation">
                                        <foaf:organization>
                                            <foaf:Organization>
                                                <foaf:name>
                                                    <xsl:value-of select="@affiliation" />
                                                </foaf:name>
                                            </foaf:Organization>
                                        </foaf:organization>
                                    </xsl:if>
                                </foaf:Person>
                            </prov:agent>
                        </prov:Attribution>
                    </prov:qualifiedAttribution>
                </xsl:for-each>
                
                <!-- contributors -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:othId">
                    <prov:qualifiedAttribution>
                        <prov:Attribution>
                            <dcat:hadRole>
                                <xsl:value-of select="@role" />
                            </dcat:hadRole>
                            <prov:agent>
                                <foaf:Person>
                                    <foaf:name>
                                        <xsl:attribute name="xml:lang">
                                            <xsl:value-of select="@xml:lang" />
                                        </xsl:attribute>
                                        <xsl:value-of select="." />
                                    </foaf:name>
                                    <xsl:if test="@affiliation">
                                        <foaf:organization>
                                            <foaf:Organization>
                                                <foaf:name>
                                                    <xsl:value-of select="@affiliation" />
                                                </foaf:name>
                                            </foaf:Organization>
                                        </foaf:organization>
                                    </xsl:if>
                                </foaf:Person>
                            </prov:agent>
                        </prov:Attribution>
                    </prov:qualifiedAttribution>
                </xsl:for-each>
                
                <!-- dcat:contactPoint -->
                <xsl:for-each select="ddi:stdyDscr/ddi:citation/ddi:contact">
                    <dcat:contactPoint>
                        <vcard:Individual>
                            <vcard:fn>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="@xml:lang" />
                                </xsl:attribute>
                                <xsl:value-of select="." />
                            </vcard:fn>
                            <xsl:if test="@affiliation">
                                <vcard:organization-name>
                                    <xsl:value-of select="@affiliation" />
                                </vcard:organization-name>
                            </xsl:if>
                            <xsl:if test="@email">
                                <vcard:hasEmail>
                                    <vcard:Email>
                                        <rdf:value>
                                            <xsl:value-of select="concat('mailto:', @email)" />
                                        </rdf:value>
                                    </vcard:Email>
                                </vcard:hasEmail>
                            </xsl:if>
                        </vcard:Individual>
                    </dcat:contactPoint>
                </xsl:for-each>
                

                <!-- dpv:hasLegalBasis -->
                <xsl:for-each
                    select="ddi:stdyDscr/ddi:studyAuthorization/ddi:authorizationStatement">
                    <dpv:hasLegalBasis>
                        <dct:description>
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="@xml:lang" />
                            </xsl:attribute>
                            <xsl:value-of select="." />
                        </dct:description>
                    </dpv:hasLegalBasis>
                </xsl:for-each>

                <!-- dcat:keyword -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:keyword">
                    <dcat:keyword>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="@xml:lang" />
                        </xsl:attribute>
                        <xsl:value-of select="." />
                    </dcat:keyword>
                </xsl:for-each>

                <!-- dct:description / dct:purpose -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:abstract">
                    <xsl:choose>
                        <xsl:when test="@contentType = 'purpose'">
                            <dct:purpose>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="@xml:lang" />
                                </xsl:attribute>
                                <xsl:value-of select="." />
                            </dct:purpose>
                        </xsl:when>
                        <xsl:otherwise>
                            <dct:description>
                                <xsl:attribute name="xml:lang">
                                    <xsl:value-of select="@xml:lang" />
                                </xsl:attribute>
                                <xsl:value-of select="." />
                            </dct:description>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>

                <!-- health:healthTheme -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:topcClas">
                    <health:healthTheme>
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="@xml:lang" />
                        </xsl:attribute>
                        <xsl:value-of select="." />
                    </health:healthTheme>
                </xsl:for-each>
                
                <!-- health:populationCoverage con xml:lang -->
                <xsl:for-each select="ddi:stdyDscr/ddi:stdyInfo/ddi:sumDscr/ddi:universe[@level = 'Type de population']">
                    <health:populationCoverage >
                        <xsl:if test="@xml:lang">
                            <xsl:attribute name="xml:lang">
                                <xsl:value-of select="@xml:lang" />
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="normalize-space(.)"/>
                    </health:populationCoverage>
                </xsl:for-each>
                

            </dcat:Dataset>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>