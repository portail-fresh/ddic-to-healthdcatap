<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ddi="ddi:codebook:2_5"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:dpv="http://www.w3.org/ns/dpv#"
    xmlns:health="http://eurohealthnet.eu/ontologies/healthdcat-ap#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:prov="http://www.w3.org/ns/prov#"
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
    exclude-result-prefixes="xsl ddi dct dcat foaf dpv health prov vcard">

  <xsl:output method="xml" indent="yes"/>

  <!-- ROOT template -->
  <xsl:template match="/ddi:codeBook">
    <rdf:RDF>
      <dcat:Dataset>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:IDNo" mode="identifier"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:titl" mode="title"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:titlStmt/ddi:altTitl" mode="alternative"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty" mode="creator"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:AuthEnty" mode="pi"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:rspStmt/ddi:othId" mode="contributor"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:citation/ddi:contact" mode="contact"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:studyAuthorization/ddi:authorizationStatement" mode="legalBasis"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:keyword" mode="keyword"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:stdyInfo/ddi:abstract" mode="description"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:stdyInfo/ddi:subject/ddi:topcClas" mode="healthTheme"/>
        <xsl:apply-templates select="ddi:stdyDscr/ddi:stdyInfo/ddi:sumDscr/ddi:universe[@level='Type de population']" mode="populationCoverage"/>
      </dcat:Dataset>
    </rdf:RDF>
  </xsl:template>

  <!-- Identifier -->
  <xsl:template match="ddi:IDNo" mode="identifier">
    <dct:identifier>
      <xsl:value-of select="."/>
    </dct:identifier>
  </xsl:template>

  <!-- Title -->
  <xsl:template match="ddi:titl" mode="title">
    <dct:title>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:value-of select="."/>
    </dct:title>
  </xsl:template>

  <!-- Alternative title -->
  <xsl:template match="ddi:altTitl" mode="alternative">
    <dct:alternative>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:value-of select="."/>
    </dct:alternative>
  </xsl:template>

  <!-- Creator (first AuthEnty only) -->
  <xsl:template match="ddi:AuthEnty" mode="creator">
    <xsl:if test="position() = 1">
      <dct:creator>
        <xsl:if test="@xml:lang">
          <xsl:attribute name="xml:lang" select="@xml:lang"/>
        </xsl:if>
        <xsl:value-of select="."/>
      </dct:creator>
    </xsl:if>
  </xsl:template>

  <!-- Primary Investigators -->
  <xsl:template match="ddi:AuthEnty" mode="pi">
    <prov:qualifiedAttribution>
      <prov:Attribution>
        <dcat:hadRole>Primary Investigator</dcat:hadRole>
        <prov:agent>
          <foaf:Person>
            <foaf:name>
              <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang" select="@xml:lang"/>
              </xsl:if>
              <xsl:value-of select="."/>
            </foaf:name>
            <xsl:if test="@affiliation">
              <foaf:organization>
                <foaf:Organization>
                  <foaf:name>
                    <xsl:value-of select="@affiliation"/>
                  </foaf:name>
                </foaf:Organization>
              </foaf:organization>
            </xsl:if>
          </foaf:Person>
        </prov:agent>
      </prov:Attribution>
    </prov:qualifiedAttribution>
  </xsl:template>

  <!-- Other contributors -->
  <xsl:template match="ddi:othId" mode="contributor">
    <prov:qualifiedAttribution>
      <prov:Attribution>
        <dcat:hadRole>
          <xsl:value-of select="@role"/>
        </dcat:hadRole>
        <prov:agent>
          <foaf:Person>
            <foaf:name>
              <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang" select="@xml:lang"/>
              </xsl:if>
              <xsl:value-of select="."/>
            </foaf:name>
            <xsl:if test="@affiliation">
              <foaf:organization>
                <foaf:Organization>
                  <foaf:name>
                    <xsl:value-of select="@affiliation"/>
                  </foaf:name>
                </foaf:Organization>
              </foaf:organization>
            </xsl:if>
          </foaf:Person>
        </prov:agent>
      </prov:Attribution>
    </prov:qualifiedAttribution>
  </xsl:template>

  <!-- Contact Point -->
  <xsl:template match="ddi:contact" mode="contact">
    <dcat:contactPoint>
      <vcard:Individual>
        <vcard:fn>
          <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
          </xsl:if>
          <xsl:value-of select="."/>
        </vcard:fn>
        <xsl:if test="@affiliation">
          <vcard:organization-name>
            <xsl:value-of select="@affiliation"/>
          </vcard:organization-name>
        </xsl:if>
        <xsl:if test="@email">
          <vcard:hasEmail>
            <vcard:Email>
              <rdf:value>
                <xsl:value-of select="concat('mailto:', @email)"/>
              </rdf:value>
            </vcard:Email>
          </vcard:hasEmail>
        </xsl:if>
      </vcard:Individual>
    </dcat:contactPoint>
  </xsl:template>

  <!-- Legal Basis -->
  <xsl:template match="ddi:authorizationStatement" mode="legalBasis">
    <dpv:hasLegalBasis>
      <dct:description>
        <xsl:if test="@xml:lang">
          <xsl:attribute name="xml:lang" select="@xml:lang"/>
        </xsl:if>
        <xsl:value-of select="."/>
      </dct:description>
    </dpv:hasLegalBasis>
  </xsl:template>

  <!-- Keyword -->
  <xsl:template match="ddi:keyword" mode="keyword">
    <dcat:keyword>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:value-of select="."/>
    </dcat:keyword>
  </xsl:template>

  <!-- Description or Purpose -->
  <xsl:template match="ddi:abstract" mode="description">
    <xsl:choose>
      <xsl:when test="@contentType = 'purpose'">
        <dct:purpose>
          <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
          </xsl:if>
          <xsl:value-of select="."/>
        </dct:purpose>
      </xsl:when>
      <xsl:otherwise>
        <dct:description>
          <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
          </xsl:if>
          <xsl:value-of select="."/>
        </dct:description>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Health Theme -->
  <xsl:template match="ddi:topcClas" mode="healthTheme">
    <health:healthTheme>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:value-of select="."/>
    </health:healthTheme>
  </xsl:template>

  <!-- Population Coverage -->
  <xsl:template match="ddi:universe" mode="populationCoverage">
    <health:populationCoverage>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
    </health:populationCoverage>
  </xsl:template>

</xsl:stylesheet>
