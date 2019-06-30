
<!--<!DOCTYPE stylesheet [
<!ENTITY le "@le;">
]>-->
<xsl:stylesheet version="2.0" 
					 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
					 xmlns:xs="http://www.w3.org/2001/XMLSchema"
					 exclude-result-prefixes="xs">

<xsl:output method="html" indent="yes" version="5.0"/>
	<xsl:template match="/">
	   <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>	   
		<html lang="en">
			<head>
				<title>Design Calculation of Splice Connection</title>
				<link rel="stylesheet" type="text/css" href="main.css"/>
			</head>
			<body>
				<h1>Design of Splice Connection</h1>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
   <xsl:template match="//units"/>
   <xsl:template match="job-info"/>   
	<xsl:template match="//component[@name='bolts']/check[@name='tension']">
		<h3>1.0 Design of the Web Connection (Bolts):</h3>
		<!--Bolt Tensile Strength Calculations-->
	   <xsl:comment>Bolt Tensile Strength Calculations</xsl:comment>
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
				<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
		<br/>
		<table class="summary">
			<tr>
				<td class="desc"></td>
				<td class="asd">Allowable Stress Design</td>
				<td class="lrfd">Load Resistance Factor Design</td>
			</tr>
			<tr>
				<td class="desc">Reduction Factor/Safety Factor for Axial Tension</td>
				<td class="asd"><xsl:value-of select="omega"/></td>
				<td class="lrfd"><xsl:value-of select="phi"/></td>
			</tr>
			<tr>
				<td class="desc">Design Axial Tensile Strength</td>
				<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
				<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="//component[@name='bolts']/check[@name='shear']">
		<!--Bolt Shear Strength Calculations-->
	   <xsl:comment>Bolt Shear Strength Calculations</xsl:comment>
		<h4>1.2 Shear Strength:</h4>
		<table class="calc">
			<tr>
				<td class="f-left">Nominal Shear Strength of each bolt [Single/Double Shear]:</td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">F<sub>nv</sub>A<sub>b</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
		<br/>
		<table class="summary">
			<tr>
				<td class="desc"></td>
				<td class="asd">Allowable Stress Design</td>
				<td class="lrfd">Load Resistance Factor Design</td>
			</tr>
			<tr>
				<td class="desc">Reduction Factor/Safety Factor for Shear</td>
				<td class="asd"><xsl:value-of select="omega"/></td>
				<td class="lrfd"><xsl:value-of select="phi"/></td>
			</tr>
			<tr>
				<td class="desc">Design Shear Strength</td>
				<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
				<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="//component[@name='bolts']/check[@name='combined']">
		<!--Combined Tension and Shear Calculations-->
	   <xsl:comment>Combined Tension and Shear Calculations</xsl:comment>
		<h4>1.3 Combined Tension and Shear:</h4>
		<table class="calc">
			<tr>
				<td class="f-left">Nominal Strength of each bolt in combined tension and shear:</td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">F'<sub>nt</sub>A<sub>b</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
		<br/>
		<!-- Where Section -->
	   <xsl:comment>Where Section</xsl:comment>
		<table class="where">
			<tr>
				<td colspan="3">Where,</td>
			</tr>
			<tr>
				<td class="where-left">F'<sub>nt</sub></td>
				<td class="where-equal">=</td>
				<td class="where-right">Min(1.3F<sub>nt</sub>-(F<sub>nt</sub>/<!--&Phi-->;F<sub>nv</sub>)f<sub>rv</sub>,F<sub>nt</sub>) for LRFD</td>
			</tr>
			<tr>
				<td class="where-left"></td>
				<td class="where-equal">=</td>
				<td class="where-right">Min(1.3F<sub>nt</sub>-(<!--&Omega;-->F<sub>nt</sub>/F<sub>nv</sub>)f<sub>rv</sub>,F<sub>nt</sub>) for ASD</td>
			</tr>
			<tr>
				<td class="where-left"></td>
				<td class="where-equal">=</td>
				<td class="where-right"><xsl:value-of select="Fdashnt"/> <xsl:value-of select="//stress"/><sup>2</sup></td>
			</tr>
			<tr>
				<td class="where-left">f<sub>rv</sub></td>
				<td class="where-equal">=</td>
				<td class="where-right"><xsl:value-of select="frv"/> <xsl:value-of select="//stress"/><sup>2</sup></td>
			</tr>
		</table>
		<br/>
		<table class="summary">
			<tr>
				<td class="desc"></td>
				<td class="asd">Allowable Stress Design</td>
				<td class="lrfd">Load Resistance Factor Design</td>
			</tr>
			<tr>
				<td class="desc">Reduction Factor/Safety Factor for Combined Forces</td>
				<td class="asd"><xsl:value-of select="omega"/></td>
				<td class="lrfd"><xsl:value-of select="phi"/></td>
			</tr>
			<tr>
				<td class="desc">Design Strength under Combined Tension and Shear</td>
				<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
				<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
		<br/>
	</xsl:template>
	<xsl:template  match="//component[@name='bolts']/check[@name='bearing']">
		<!--Bearing Strength Calculations-->
	   <xsl:comment>Bearing Strength Calculations</xsl:comment>
		<h4>1.4a Bearing Strength at Bolt Holes <span class="h4-small">[For one line of bolts in force direction][For Plates]</span></h4>
		<p>a) When deformation at the bolt hole at service load is a design consideration</p>
		<table class="calc">
			<tr>
				<td class="f-left"></td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">1.2L<sub>c</sub>tF<sub>ug</sub></td>
				<td class="f-equal"><!--&le;--></td>
				<td class="f-right">2.4dtF<sub>ug</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="//element[@name='plates']/nominal-strength[@deformation-criteria='yes']"/><xsl:value-of select="//force"/></td>
				<td class="f-equal"></td>
				<td class="f-right"></td>
			</tr>
		</table>
		<p>b) When deformation at the bolt hole at service load is NOT a design consideration</p>
		<table class="calc">
			<tr>
				<td class="f-left"></td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">1.5L<sub>c</sub>tF<sub>ug</sub></td>
				<td class="f-equal"><!--&le;--></td>
				<td class="f-right">3.0dtF<sub>ug</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="//element[@name='plates']/nominal-strength[@deformation-criteria='no']"/><xsl:value-of select="//force"/></td>
				<td class="f-equal"></td>
				<td class="f-right"></td>
			</tr>
		</table>
		<br/>
		<h4>1.4b Bearing Strength at Bolt Holes <span class="h4-small">[For one line of bolts in force direction][For Main Member Web]</span></h4>
		<p>a) When deformation at the bolt hole at service load is a design consideration</p>
		<table class="calc">
			<tr>
				<td class="f-left"></td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">1.2L<sub>c</sub>tF<sub>ug</sub></td>
				<td class="f-equal"><!--&le;--></td>
				<td class="f-right">2.4dtF<sub>ug</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="//element[@name='profile']/nominal-strength[@deformation-criteria='yes']"/><xsl:value-of select="//force"/></td>
				<td class="f-equal"></td>
				<td class="f-right"></td>
			</tr>
		</table>
		<p>b) When deformation at the bolt hole at service load is NOT a design consideration</p>
		<table class="calc">
			<tr>
				<td class="f-left"></td>
				<td class="f-main">R<sub>n</sub></td>
				<td class="f-equal">=</td>
				<td class="f-right">1.5L<sub>c</sub>tF<sub>ug</sub></td>
				<td class="f-equal"><!--&le;--></td>
				<td class="f-right">3.0dtF<sub>ug</sub></td>
			</tr>
			<tr>
				<td class="f-left"></td>
				<td class="f-main"></td>
				<td class="f-equal">=</td>
				<td class="f-right"><xsl:value-of select="//element[@name='profile']/nominal-strength[@deformation-criteria='no']"/><xsl:value-of select="//force"/></td>
				<td class="f-equal"></td>
				<td class="f-right"></td>
			</tr>
		</table>
		<br/>
		<!-- Where Section -->
	   <xsl:comment>Where Section</xsl:comment>
		<table class="where">
			<tr>
				<td colspan="3">Where,</td>
			</tr>
			<tr>
				<td class="where-left">L<sub>c</sub></td>
				<td class="where-equal">=</td>
				<td class="where-right"><xsl:value-of select="bearing-length"/><xsl:value-of select="//length"/></td>
			</tr>
		</table>
		<br/>
		<table class="summary">
			<tr>
				<td class="desc"></td>
				<td class="asd">Allowable Stress Design</td>
				<td class="lrfd">Load Resistance Factor Design</td>
			</tr>
			<tr>
				<td class="desc">Reduction Factor/Safety Factor for Bearing</td>
				<td class="asd"><xsl:value-of select="omega"/></td>
				<td class="lrfd"><xsl:value-of select="phi"/></td>
			</tr>
			<tr>
				<td class="desc">Design Strength under Bearing</td>
				<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
				<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>
			</tr>
		</table>
		<br/>
	</xsl:template>

   <xsl:template match="//component[@name='plate-web']/check[@name='tensile-yielding']">
	  <!--Design Checks for Plates - Web Connection-->
	  <xsl:comment>Design Checks for Plates - Web Connection</xsl:comment>
	  <h3>2.0 Design of the Web Connection (Plates):</h3>
	  <h4>2.1 Tensile Yielding:</h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in tensile yielding[One/Both Sides]:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>yp</sub>A<sub>g</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Tensile Yielding</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Tensile Yielding</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>
		 </tr>		 
	  </table>
	  <br/>
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='tensile-rupture']">
	  <h4>2.2 Tensile Rupture:</h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in tensile rupture[One/Both Sides]:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>up</sub>A<sub>e</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Tensile Rupture</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Tensile Rupture</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>		 
	  </table>
	  <br/>	 
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='shear-yielding']">
	  	  <h4>2.3 Shear Yielding:</h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in shear yielding[One/Both Sides]:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>yp</sub>A<sub>gv</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Shear Yielding</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Shear Yielding</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>		 
	  </table>
	  <br/>	  
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='shear-rupture']">
	  <h4>2.4 Shear Rupture:</h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in shear rupture[One/Both Sides]:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>up</sub>A<sub>nv</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Shear Rupture</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Shear Rupture</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>		 
	  </table>
	  <br/>	
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='block-shear']/element[@name='plate']">
	  	  <h4>2.5a Block Shear Strength <span class="h4-small">[For Plates]:</span></h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in block shear [One/Both Sides]:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>up</sub>A<sub>nv</sub>+U<sub>bs</sub>F<sub>up</sub>A<sub>nt</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>yp</sub>A<sub>gv</sub>+U<sub>bs</sub>F<sub>up</sub>A<sub>nt</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <!-- Where Section -->
	  <xsl:comment>Where Section</xsl:comment>
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">U<sub>bs</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="ubs"/></td>
		 </tr>
		 <tr>
			<td class="where-left">A<sub>nv</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="anv"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
		 <tr>
			<td class="where-left">A<sub>gv</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="agv"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
		 <tr>
			<td class="where-left">A<sub>nt</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="ant"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Block Shear</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Block Shear</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>		 
	  </table>
	  <br/>	  
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='block-shear']/element[@name='profile']">
	  	  <h4>2.5b Block Shear Strength <span class="h4-small">[Main Member Web]:</span></h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the plate in block shear:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>up</sub>A<sub>nv</sub>+U<sub>bs</sub>F<sub>up</sub>A<sub>nt</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right">0.60F<sub>yp</sub>A<sub>gv</sub>+U<sub>bs</sub>F<sub>up</sub>A<sub>nt</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <!-- Where Section -->
	  <xsl:comment>Where Section</xsl:comment>
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">U<sub>bs</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="ubs"/></td>
		 </tr>
		 <tr>
			<td class="where-left">A<sub>nv</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="anv"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
		 <tr>
			<td class="where-left">A<sub>gv</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="agv"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
		 <tr>
			<td class="where-left">A<sub>nt</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="ant"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Block Shear</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Block Shear</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>		 
	  </table>
	  <br/>	  
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='compression']">
	  	  <h4>2.6 Compression Strength <span class="h4-small">[Each Plate]:</span></h4>
	  <p>a) When KL/r <!--&le;--> 25</p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the connecting plate in compression:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>yp</sub>A<sub>g</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength[@case='case-a']"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <p>b) When KL/r <!--&gt;--> 25</p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the connecting plate in compression:</td>
			<td class="f-main">R<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>crp</sub>A<sub>g</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength[@case='case-b']"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>
	  <!-- Where Section -->
	  <xsl:comment>Where Section</xsl:comment>
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">K</td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="k"/></td>
		 </tr>
		 <tr>
			<td class="where-left">L</td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="l"/><xsl:value-of select="//length"/></td>
		 </tr>		 
		 <tr>
			<td class="where-left">r</td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="r"/><xsl:value-of select="//length"/></td>
		 </tr>		 
		 <tr>
			<td class="where-left">F<sub>e</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="fe"/><xsl:value-of select="//force"/></td>
		 </tr>
		 <tr>
			<td class="where-left">F<sub>crp</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right">0.658<sup>(F<sub>y</sub>/F<sub>e</sub>)</sup> When (KL/r) <!--&le;--> 4.71 <!--&radic;-->(E/F<sub>y</sub>)</td>
		 </tr>		 
		 <tr>
			<td class="where-left"></td>
			<td class="where-equal">=</td>
			<td class="where-right">0.877F<sub>e</sub> When (KL/r) <!--&gt;--> 4.71 <!--&radic;-->(E/F<sub>y</sub>)</td>
		 </tr>		 		 
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Compression</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Compression</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>
		 <tr>
			<td colspan="3" class="desc">Note: This calculation takes the total number of web plates in to consideration</td>
		 </tr>
	  </table>
	  <br/>	  
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='flexure']">
	  <h4>2.7 Flexural Strength <span class="h4-small">[Each Plate]:</span></h4>
	  <p>a) For Rectangular bars with (L<sub>b</sub>d/t<sup>2</sup>) <!--&le;--> 0.08E/F<sub>y</sub></p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the connecting plate in Flexure:</td>
			<td class="f-main">M<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>yp</sub>Z</td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength[@case='case-a']"/><xsl:value-of select="//moment"/></td>
		 </tr>
	  </table>
	  <p>b) For Rectangular bars with 0.08E/F<sub>y</sub> <!--&lt;-->(L<sub>b</sub>d/t<sup>2</sup>) <!--&le;--> 1.9E/F<sub>y</sub></p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the connecting plate in Flexure:</td>
			<td class="f-main">M<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">C<sub>b</sub>[1.52-0.274(L<sub>b</sub>d/t<sup>2</sup>)(F<sub>y</sub>/E)]M<sub>y</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal"><!--&le;--></td>
			<td class="f-right">M<sub>p</sub></td>
		 </tr>		 
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength[@case='case-b']"/><xsl:value-of select="//moment"/></td>
		 </tr>
	  </table>
	  <p>c) For Rectangular bars with 1.9E/F<sub>y</sub> <!--&lt;-->(L<sub>b</sub>d/t<sup>2</sup>)</p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the connecting plate in Flexure:</td>
			<td class="f-main">M<sub>n</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">F<sub>cr</sub>S<sub>x</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal"><!--&le;--></td>
			<td class="f-right">M<sub>p</sub></td>
		 </tr>		 
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="nominal-strength[@case='case-c']"/><xsl:value-of select="//moment"/></td>
		 </tr>
	  </table>	  
	  <!-- Where Section -->
	  <xsl:comment>Where Section</xsl:comment>
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">F<sub>cr</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right">1.9EC<sub>b</sub>/(L<sub>b</sub>d/t<sup>2</sup>)</td>
		 </tr>
		 <tr>
			<td class="where-left">L</td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="l"/><xsl:value-of select="//length"/></td>
		 </tr>		 
	  </table>
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Flexure</td>
			<td class="asd"><xsl:value-of select="omega"/></td>
			<td class="lrfd"><xsl:value-of select="phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Flexure</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//moment"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//moment"/></td>			
		 </tr>
		 <tr>
			<td colspan="3" class="desc">Note: This calculation takes the total number of web plates in to consideration</td>
		 </tr>
	  </table>
	  <br/>
   </xsl:template>
   <xsl:template match="//component[@name='plate-web']/check[@name='weld']">
	  <h3>3.0 Design of Welds</h3>
	  <h4>3.1a Strength of Welds <span class="h4-small">[Each Plate - Based on Weld Material]:</span></h4>
	  <p>a) For Longitudinal Welds</p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the linear fillet weld group:</td>
			<td class="f-main">R<sub>nwl</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">n<sub>wf</sub>F<sub>nw</sub>A<sub>we</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='longitudinal']/nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>

	  <!-- Where Section -->
	  <xsl:comment>Where Section</xsl:comment>
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">F<sub>nw</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='longitudinal']/fnw"/><xsl:value-of select="//stress"/><sup>2</sup></td>
		 </tr>
		 <tr>
			<td class="where-left">n<sub>wf</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right">No.of weld faces</td>
		 </tr>
		 <tr>
			<td class="where-left"></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='longitudinal']/nwf"/></td>
		 </tr>
		 <tr>
			<td class="where-left">A<sub>we</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='longitudinal']/awe"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
	  </table>

	  <p>b) For Transverse Welds</p>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the linear fillet weld group:</td>
			<td class="f-main">R<sub>nwt</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">n<sub>wf</sub>F<sub>nw</sub>A<sub>we</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='transverse']/nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>

	  <!-- Where Section -->
	  <table class="where">
		 <tr>
			<td colspan="3">Where,</td>
		 </tr>
		 <tr>
			<td class="where-left">F<sub>nw</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='transverse']/fnw"/><xsl:value-of select="//stress"/><sup>2</sup></td>
		 </tr>
		 <tr>
			<td class="where-left">n<sub>wf</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right">No.of weld faces</td>
		 </tr>
		 <tr>
			<td class="where-left"></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='transverse']/nwf"/></td>
		 </tr>
		 <tr>
			<td class="where-left">A<sub>we</sub></td>
			<td class="where-equal">=</td>
			<td class="where-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/element[@name='transverse']/awe"/><xsl:value-of select="//length"/><sup>2</sup></td>
		 </tr>		 
	  </table>	  
	  <table class="calc">
		 <tr>
			<td class="f-left" colspan="4">Total Nominal strength of the weld group [Equation J2-10a, J2-10b] shall be maximum of the below:</td>
		 </tr>		 
		 <tr>
			<td class="f-left"></td>
			<td class="f-main">R<sub>nw</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">R<sub>nwl</sub>+R<sub>nwt</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal"><!--&ge;--></td>
			<td class="f-right">0.85R<sub>nwl</sub>+1.5R<sub>nwt</sub></td>
		 </tr>		 
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="criteria[@name='weld-filler-metal']/nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>	  
	  <br/>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Weld Strength</td>
			<td class="asd"><xsl:value-of select="criteria[@name='weld-filler-metal']/omega"/></td>
			<td class="lrfd"><xsl:value-of select="criteria[@name='weld-filler-metal']/phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Weld Strength (Filler Metal)</td>
			<td class="asd"><xsl:value-of select="criteria[@name='weld-filler-metal']/asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="criteria[@name='weld-filler-metal']/asd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>
		 <tr>
			<td colspan="3" class="desc">Note: This calculation takes the total number of web plates in to consideration</td>
		 </tr>
	  </table>
	  <br/>	 	  
	  <h4>3.1b Strength of Welds <span class="h4-small">[Based on Base Matal - Member Web <!--&amp;--> Splice Plates]:</span></h4>
	  <table class="calc">
		 <tr>
			<td class="f-left">Nominal strength of the linear fillet weld group:</td>
			<td class="f-main">R<sub>n,BM</sub></td>
			<td class="f-equal">=</td>
			<td class="f-right">n<sub>mf</sub>F<sub>BM</sub>A<sub>BM</sub></td>
		 </tr>
		 <tr>
			<td class="f-left"></td>
			<td class="f-main"></td>
			<td class="f-equal">=</td>
			<td class="f-right"><xsl:value-of select="criteria[@name='base-metal']/nominal-strength"/><xsl:value-of select="//force"/></td>
		 </tr>
	  </table>

	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Reduction Factor/Safety Factor for Weld Strength</td>
			<td class="asd"><xsl:value-of select="criteria[@name='base-metal']/omega"/></td>
			<td class="lrfd"><xsl:value-of select="criteria[@name='base-metal']/phi"/></td>			
		 </tr>
		 <tr>
			<td class="desc">Design Strength under Weld Strength (Base Metal)</td>
			<td class="asd"><xsl:value-of select="criteria[@name='base-metal']/asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="criteria[@name='base-metal']/lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>
	  </table>
	  <p>Design Strength of Weld Group:</p>
	  <table class="summary">
		 <tr>
			<td class="desc"></td>
			<td class="asd">Allowable Stress Design</td>
			<td class="lrfd">Load Resistance Factor Design</td>
		 </tr>
		 <tr>
			<td class="desc">Design Strength of Weld Group (Minimum of the Above Two Cases)</td>
			<td class="asd"><xsl:value-of select="asd-strength"/><xsl:value-of select="//force"/></td>
			<td class="lrfd"><xsl:value-of select="lrfd-strength"/><xsl:value-of select="//force"/></td>			
		 </tr>
	  </table>	  
	  <br/>	
   </xsl:template>
</xsl:stylesheet>
