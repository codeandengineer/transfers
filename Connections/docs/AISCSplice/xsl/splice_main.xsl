<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/><!-- indent="yes"/>-->
</xsl:stylesheet>
<xsl:template match="/">
	<html>
		<title>Design of Splice Connection per AISC 360-05</title>
		<link rel="stylesheet" type="text/css" href="styles/main-noflex.css"/>				
		<body>
			<xsl:apply-templates/>
		</body>
	</html>
</xsl:template>
<xsl:template match="connection/component/check[@name='tension']/nominal-strength">
<h3>1.0 Design of the Web Connection (Bolts):</h3>
<!--Bolt Tensile Strength Calculations-->
<h4>1.1 Tensile Strength:</h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal Tensile Strength of each bolt:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>nt</sub>A<sub>b</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right">551.3kN</td>			
		 </tr>
	  </table>
	  <br/>
</xsl:template>