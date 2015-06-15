jedox-palo-tools
================

Jedox Palo Server testing tools.

<img src="https://img.shields.io/dub/l/vibe-d.svg" />

<h2><a name="about" class="anchor" href="#about"><span class="mini-icon mini-icon-link"></span></a>About</h2>

Jedox Palo Server tools, you can control server by using SOAP or commandline based on Windows. 

<img src="http://i.imgur.com/4Oh8Dzc.jpg" />
<img src="http://i.imgur.com/KuCwZAF.jpg" />

<h2><a name="example" class="anchor" href="#example"><span class="mini-icon mini-icon-link"></span></a>Example</h2>

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:etl="http://ns.jedox.com/ETL-Server">
<soapenv:Header/>
<soapenv:Body>
<etl:getLocators>
<!--Optional:-->
<etl:locator></etl:locator>
</etl:getLocators>
</soapenv:Body>
</soapenv:Envelope>
```

<h2><a name="changelog" class="anchor" href="#changelog"><span class="mini-icon mini-icon-link"></span></a>Changelog</h2>

<h4>1.1</h4/>
- Added Autoit 3.3.12.0 compiler supported. 
- Fixed some bugs.

<h2><a name="author" class="anchor" href="#author"><span class="mini-icon mini-icon-link"></span></a>Author</h2>
* 2011 rchockxm (rchockxm.silver@gmail.com)

<h2><a name="credits" class="anchor" href="#credits"><span class="mini-icon mini-icon-link"></span></a>Credits</h2>
