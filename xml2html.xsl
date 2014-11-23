<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <xsl:template match="root">
    <html>
      <head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"/>
      </head>
      <body class="container">
	<h2>Individu</h2>
	<table class="table">
	  <thead>
	    <tr>
	      <th>Prenom</th>
	      <th>Nom</th>
	      <th> ... </th>
	    </tr>
	  </thead>
	  <tbody>
	    <xsl:apply-templates select="indi">
	      <xsl:sort select="name/fname"/>
	    </xsl:apply-templates>
	  </tbody>
	</table>
	<h2>Famille</h2>
	<table class="table">
	  <thead>
	    <tr>
	      <th>Husband</th>
	      <th>Wife</th>
	      <th>Children</th>
	    </tr>
	  </thead>
	  <tbody>
	    <xsl:apply-templates select="fam"/>
	  </tbody>
	</table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="indi">
    <xsl:element name="tr">
      <xsl:apply-templates select="@id" />
      <xsl:apply-templates select="name" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="name">
    <td><xsl:value-of select="fname"/></td>
    <td><xsl:value-of select="lname"/></td>
    <td> ... </td>
  </xsl:template>

  <xsl:template match="fam">
    <xsl:element name="tr">
      <xsl:apply-templates select="@id" />
      <td>
	<xsl:element name="a">
	  <xsl:apply-templates select="husb/@idref" />
	  <xsl:value-of select="/indi[@id = ]/name/fname" />
	</xsl:element>
      </td>
      <td>
	<xsl:element name="a">
	  <xsl:apply-templates select="wife/@idref" />
	  Wife
	</xsl:element>
      </td>
      <td>
	<ul>
	  <xsl:for-each select="chil">
	    <li>
	      <xsl:element name="a">
		<xsl:apply-templates select="@idref"/>
		child
	      </xsl:element>
	  </li>
	  </xsl:for-each>
	</ul>
      </td>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*" name="a">

  </xsl:template>

  <xsl:template match="@id">
    <xsl:attribute name="{name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@idref">
    <xsl:attribute name="href">
      #<xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>
