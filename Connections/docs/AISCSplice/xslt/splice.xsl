<?xml version="1.0" encoding="UTF-8"?>
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<head>
		<title>Design of Splice Connection per AISC 360-05</title>
		<link rel="stylesheet" type="text/css" href="main-noflex.css"/>				
	</head>
	<body>
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
				<td class="f-right">
						<xsl:value-of select="//check[@name='tension']/nominal-strength"/>kN</td>			
			 </tr>
		  </table>
		  <br/>	
	</body>
</html>