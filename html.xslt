<xsl:stylesheet version="1.0"
     xmlns:tb="http://www.talkbank.org/ns/talkbank" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <xsl:template match="tb:CHAT">
       <html>
         <head>
           <meta name="date" scheme="DD-MMM-YYYY">
            <xsl:attribute name="content">
              <xsl:value-of select="tb:comment[@type='Date']/text()"/>
            </xsl:attribute>
           </meta>
         </head>
         <body>
	   <div class="chat">
	      <xsl:apply-templates select="tb:u"/>
	   </div>
         </body>
       </html>
     </xsl:template>
     <xsl:template match="tb:u">
          <div>
            <xsl:attribute name="data-type">utterance</xsl:attribute>
            <xsl:attribute name="speaker">s<xsl:value-of select="@who"/></xsl:attribute>
            <xsl:for-each select="./*">
              <xsl:choose>
                <xsl:when test="name(.)='tb:e'">
                  &#160;\\Empty
                </xsl:when>
                <xsl:when test="name(.)='tb:w'">
                  &#160;<xsl:apply-templates />
                </xsl:when>
                <xsl:otherwise>
                  &#160;<xsl:value-of select=".//tb:w/text()"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </div>
     </xsl:template>

     <xsl:template match="tb:w/text()">
       <xsl:value-of select="."/>
     </xsl:template>
     <xsl:template match="tb:w/tb:shortening">
       (<xsl:value-of select="text()"/>)
     </xsl:template>
     <xsl:template match="tb:w/tb:wk[@type='cli']">
       <xsl:value-of select="text()"/>
     </xsl:template>
 </xsl:stylesheet>
