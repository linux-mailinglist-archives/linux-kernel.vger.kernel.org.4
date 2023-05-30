Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49B717006
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjE3V5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjE3V5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:57:15 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458EBAA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:57:12 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5BE002C0596;
        Wed, 31 May 2023 09:57:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685483830;
        bh=0NNxU10y+54Q7T2s1ZCP7h88We4aYo4u8bAyIxwobg4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=epXBvqIQ16703dNQBxpOpXHBtjhWdLpKfk0ornIEuTjYKA80pFdkpw/AamspaeXL4
         B7mmsmzkNARgzaMIx63aV22x73TNGG/yQfQ8EKET7+mWtPK8GAu+88oMjNeInyAE2p
         kxt1khhMH+PegWBShva+Wr7k0SmMobm0gf2P7tyNvqDkV3ImNp3BdPvdsLlRNrGrX1
         m/JTngPk4liHmC+1dXlAHvl4ibMzvgN8KWib8+uMT53wsjRaP3mHaI+MxW2FAskddj
         Qs4jrKnn9XQwDbE/ujNkxwS5cUb6QTsnMP83kfGE0pKIX2lBbkKSsq+FvKBof43tjS
         ZCGyLqM99STzA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647671360001>; Wed, 31 May 2023 09:57:10 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:57:10 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 31 May 2023 09:57:09 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 31 May 2023 09:57:09 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZkpEvY3k2XQch4kKrVAHkTx0+pa9x9QcAgAALQYCAAJTHgA==
Date:   Tue, 30 May 2023 21:57:09 +0000
Message-ID: <d720cc45-5c0e-cee2-da71-8fc713e63f4b@alliedtelesis.co.nz>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
 <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
 <20230530150439.7f287b7a@xps-13>
In-Reply-To: <20230530150439.7f287b7a@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <73504296B2D88B468D629E567D88DD32@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=KKAkSRfTAAAA:8 a=g8kJ_gb0AAAA:8 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=P-IC7800AAAA:8 a=wgtUDZu64lvNrKWHAxcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=ecSNLfPMzbq-p5zXJZOg:22 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMS8wNS8yMyAwMTowNCwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gSGkgS3J6eXN6dG9m
LA0KPg0KPiBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmcgd3JvdGUgb24gVHVlLCAzMCBN
YXkgMjAyMyAxNDoyNDoyMiArMDIwMDoNCj4NCj4+IE9uIDMwLzA1LzIwMjMgMDI6NTMsIENocmlz
IFBhY2toYW0gd3JvdGU6DQo+Pj4gRnJvbTogVmFkeW0gS29jaGFuIDx2YWR5bS5rb2NoYW5AcGx2
aXNpb24uZXU+DQo+Pj4NCj4+PiBTd2l0Y2ggdGhlIERUIGJpbmRpbmcgdG8gYSBZQU1MIHNjaGVt
YSB0byBlbmFibGUgdGhlIERUIHZhbGlkYXRpb24uDQo+Pj4NCj4+PiBEcm9wcGVkIGRlcHJlY2F0
ZWQgY29tcGF0aWJsZXMgYW5kIHByb3BlcnRpZXMgZGVzY3JpYmVkIGluIHR4dCBmaWxlLg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogVmFkeW0gS29jaGFuIDx2YWR5bS5rb2NoYW5AcGx2aXNpb24u
ZXU+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gTm90ZXM6DQo+Pj4gICAgICBDaGFu
Z2VzIGluIHY2Og0KPj4+ICAgICAgLSByZW1vdmUgcHJvcGVydGllcyBjb3ZlcmVkIGJ5IG5hbmQt
Y29udHJvbGxlci55YW1sDQo+Pj4gICAgICAtIGFkZCBleGFtcGxlIHVzaW5nIGFybWFkYS04ayBj
b21wYXRpYmxlDQo+Pj4gICAgICANCj4+PiAgICAgIGVhcmxpZXIgY2hhbmdlczoNCj4+PiAgICAg
IA0KPj4+ICAgICAgdjU6DQo+Pj4gICAgICAgICAxKSBHZXQgYmFjayAibGFiZWwiIGFuZCAicGFy
dGl0aW9ucyIgcHJvcGVydGllcyBidXQgd2l0aG91dA0KPj4gV2hlcmUgYXJlIHRoZXk/IERpZCB5
b3UgZHJvcCB0aGVtIGluIHY2Pw0KPiBsYWJlbCBhbmQgcGFydGl0aW9ucyBhcmUgZGVmaW5lZCBp
biBwYXJ0aXRpb25zL3BhcnRpdGlvbi55YW1sLA0KPiByZWZlcmVuY2VkIGJ5IHBhcnRpdGlvbnMu
eWFtbCwgcmVmZXJlbmNlZCBieSBtdGQueWFtbCwgcmVmZXJlbmNlZCBieQ0KPiBuYW5kLWNoaXAu
eWFtbCwgcmVmZXJlbmNlZCBieSBuYW5kLWNvbnRyb2xsZXIueWFtbCwgaXRzZWxmIHJlZmVyZW5j
ZWQNCj4gaW4gdGhpcyBmaWxlIDotKQ0KPg0KPiBTbyBJIGJlbGlldmUgdGhlcmUgaXMgbm90aGlu
ZyBlbHNlIHRvIGFkZCBpbiB0aGUgY29udHJvbGxlcidzIGJpbmRpbmcNCj4gZm9yIHRoZXNlIHR3
byBwcm9wZXJ0aWVzPyBUaGV5IGFyZSB2ZXJ5IGdlbmVyaWMsIGl0IHdvdWxkIG5vdCBiZQ0KPiBv
cHRpbWFsIGlmIHdlIGhhZCB0byB0YWtlIGNhcmUgYWJvdXQgdGhlbS4NCkhtbSBpdCBkb2Vzbid0
IGFwcGVhciB0IGJlIHBpY2tpbmcgdGhlbSB1cC4gSSB3YXMgb25seSBnZXR0aW5nIGF3YXkgd2l0
aCANCml0IGJlY2F1c2UgSSBkaWRuJ3QgaGF2ZSB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNl
Lg0KPj4+ICAgICAgICAgICAgcmVmIHRvIHRoZSAicGFydGl0aW9uLnlhbWwiIHdoaWNoIHdhcyB3
cm9uZ2x5IHVzZWQuDQo+Pg0KPj4+ICAgICAgDQo+Pj4gICAgICAgICAyKSBBZGQgImFkZGl0aW9u
YWxQcm9wZXJ0aWVzOiBmYWxzZSIgZm9yIG5hbmRAIGJlY2F1c2UgYWxsIHBvc3NpYmxlDQo+Pj4g
ICAgICAgICAgICBwcm9wZXJ0aWVzIGFyZSBkZXNjcmliZWQuDQo+PiBXaGVyZT8gVGhpcyBjYW5u
b3QgYmUgc2lsZW50bHkgZHJvcHBlZCENCj4+DQo+Pj4gICAgICANCj4+PiAgICAgIHY0Og0KPj4+
ICAgICAgICAgMSkgUmVtb3ZlICJsYWJlbCIgYW5kICJwYXJ0aXRpb25zIiBwcm9wZXJ0aWVzDQo+
Pj4gICAgICANCj4+PiAgICAgICAgIDIpIFVzZSAyIGNsb2NrcyBmb3IgQTdLLzhLIHBsYXRmb3Jt
IHdoaWNoIGlzIGEgcmVxdWlyZW1lbnQNCj4+PiAgICAgIA0KPj4+ICAgICAgdjM6DQo+Pj4gICAg
ICAgIDEpIFJlbW92ZSB0eHQgdmVyc2lvbiBmcm9tIHRoZSBNQUlOVEFJTkVSUyBsaXN0DQo+Pj4g
ICAgICANCj4+PiAgICAgICAgMikgVXNlIGVudW0gZm9yIHNvbWUgb2YgY29tcGF0aWJsZSBzdHJp
bmdzDQo+Pj4gICAgICANCj4+PiAgICAgICAgMykgRHJvcDoNCj4+PiAgICAgICAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMNCj4+PiAgICAgICAgICAgICAgI3NpemUtY2VsbHM6DQo+Pj4gICAgICANCj4+
PiAgICAgICAgICAgYXMgdGhleSBhcmUgaW5oZXJpdGVkIGZyb20gdGhlIG5hbmQtY29udHJvbGxl
ci55YW1sDQo+Pj4gICAgICANCj4+PiAgICAgICAgNCkgQWRkIHJlc3RyaWN0aW9uIHRvIHVzZSAy
IGNsb2NrcyBmb3IgQThLIFNvQw0KPj4+ICAgICAgDQo+Pj4gICAgICAgIDUpIERyb3BwZWQgZGVz
Y3JpcHRpb24gZm9yIGNsb2NrLW5hbWVzIGFuZCBleHRlbmQgaXQgd2l0aA0KPj4+ICAgICAgICAg
ICBtaW5JdGVtczogMQ0KPj4+ICAgICAgDQo+Pj4gICAgICAgIDYpIERyb3AgZGVzY3JpcHRpb24g
Zm9yICJkbWFzIg0KPj4+ICAgICAgDQo+Pj4gICAgICAgIDcpIFVzZSAidW5ldmFsYXV0ZWRQcm9w
ZXJ0aWVzOiBmYWxzZSINCj4+PiAgICAgIA0KPj4+ICAgICAgICA4KSBEcm9wIHF1aXRlcyBmcm9t
IHlhbWwgcmVmcy4NCj4+PiAgICAgIA0KPj4+ICAgICAgICA5KSBVc2UgNC1zcGFjZSBpbmRlbnRh
dGlvbiBmb3IgdGhlIGV4YW1wbGUgc2VjdGlvbg0KPj4+ICAgICAgDQo+Pj4gICAgICB2MjoNCj4+
PiAgICAgICAgMSkgRml4ZWQgd2FybmluZyBieSB5YW1sbGludCB3aXRoIGluY29ycmVjdCBpbmRl
bnRhdGlvbiBmb3IgY29tcGF0aWJsZSBsaXN0DQo+Pj4NCj4+PiAgIC4uLi9iaW5kaW5ncy9tdGQv
bWFydmVsbCxuYW5kLWNvbnRyb2xsZXIueWFtbCB8IDE5MCArKysrKysrKysrKysrKysrKysNCj4+
PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLW5hbmQudHh0ICB8IDEyNiAt
LS0tLS0tLS0tLS0NCj4+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSAtDQo+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDE5MCBpbnNlcnRpb25zKCsp
LCAxMjcgZGVsZXRpb25zKC0pDQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLG5hbmQtY29udHJvbGxlci55YW1sDQo+
Pj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L210ZC9tYXJ2ZWxsLW5hbmQudHh0DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLG5hbmQtY29udHJvbGxlci55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLG5hbmQtY29udHJv
bGxlci55YW1sDQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAw
MDAuLmM0YjAwM2Y1ZmE5Zg0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlhbWwN
Cj4+PiBAQCAtMCwwICsxLDE5MCBAQA0KPj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+PiArJVlBTUwgMS4yDQo+Pj4gKy0tLQ0K
Pj4+ICskaWQ6IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9OWZUMTVN
b0JobXlDMEJXc1g4WDdSa2hwc3lZcGNFTDl2SzdCbG1qTVl3JnU9aHR0cCUzYSUyZiUyZmRldmlj
ZXRyZWUlMmVvcmclMmZzY2hlbWFzJTJmbXRkJTJmbWFydmVsbCUyY25hbmQtY29udHJvbGxlciUy
ZXlhbWwlMjMNCj4+PiArJHNjaGVtYTogaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9
MjA5ODgmZD05ZlQxNU1vQmhteUMwQldzWDhYN1JraHBzeVlwY0VMOXZLcVVsVzJhTmcmdT1odHRw
JTNhJTJmJTJmZGV2aWNldHJlZSUyZW9yZyUyZm1ldGEtc2NoZW1hcyUyZmNvcmUlMmV5YW1sJTIz
DQo+Pj4gKw0KPj4+ICt0aXRsZTogTWFydmVsbCBOQU5EIEZsYXNoIENvbnRyb2xsZXIgKE5GQykN
Cj4+PiArDQo+Pj4gK21haW50YWluZXJzOg0KPj4+ICsgIC0gTWlxdWVsIFJheW5hbCA8bWlxdWVs
LnJheW5hbEBib290bGluLmNvbT4NCj4+IElzIGl0IGNvcnJlY3QgcGVyc29uIGZvciBNYXJ2ZWxs
IE5BTkQ/IFRoaXMgc2hvdWxkIGJlIG5vdCBhIHN1YnN5c3RlbQ0KPj4gbWFpbnRhaW5lciwgYnV0
IGEgZGV2aWNlIG1haW50YWluZXIuDQo+IEkgZGlkIG5vdCBib3RoZXIgY29udmVydGluZyB0aGlz
IGZpbGUgeWV0IGJ1dCBJIGFjdHVhbGx5IHJld3JvdGUgdGhlDQo+IGNvcnJlc3BvbmRpbmcgTGlu
dXggZHJpdmVyICg1IHllYXJzIGFnbykgZW50aXJlbHkgc28gSSBkb24ndCBtaW5kLg0KPg0KPj4+
ICsNCj4+PiArcHJvcGVydGllczoNCj4+PiArICBjb21wYXRpYmxlOg0KPj4+ICsgICAgb25lT2Y6
DQo+Pj4gKyAgICAgIC0gaXRlbXM6DQo+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFy
bWFkYS04ay1uYW5kLWNvbnRyb2xsZXINCj4+PiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGws
YXJtYWRhMzcwLW5hbmQtY29udHJvbGxlcg0KPiBJIGRvbid0IHRoaW5rIHdlIGV2ZXIgd2FudGVk
IGhhdmluZyB0aGVzZSB0d28gY29tcGF0aWJsZXMgdG8gZGVzY3JpYmUgYQ0KPiBzaW5nbGUgaGFy
ZHdhcmUgYmxvY2s/DQo+DQo+Pj4gKyAgICAgIC0gZW51bToNCj4+PiArICAgICAgICAgIC0gbWFy
dmVsbCxhcm1hZGEzNzAtbmFuZC1jb250cm9sbGVyDQo+Pj4gKyAgICAgICAgICAtIG1hcnZlbGws
cHhhM3h4LW5hbmQtY29udHJvbGxlcg0KPj4gWW91IG1pc3MgaGVyZSBkZXByZWNhdGVkIGNvbXBh
dGlibGVzLCB3aGljaCBhcmUgQlRXIHN0aWxsIHVzZWQuIERvbid0DQo+PiBkcm9wIHByb3BlcnRp
ZXMgYW5kIGNvbXBhdGlibGVzIGR1cmluZyBjb252ZXJzaW9uLg0KPj4NCj4+PiArDQo+Pj4gKyAg
cmVnOg0KPj4+ICsgICAgbWF4SXRlbXM6IDENCj4+PiArDQo+Pj4gKyAgaW50ZXJydXB0czoNCj4+
PiArICAgIG1heEl0ZW1zOiAxDQo+Pj4gKw0KPj4+ICsgIGNsb2NrczoNCj4+PiArICAgIGRlc2Ny
aXB0aW9uOg0KPj4+ICsgICAgICBTaGFsbCByZWZlcmVuY2UgdGhlIE5BTkQgY29udHJvbGxlciBj
bG9ja3MsIHRoZSBzZWNvbmQgb25lIGlzDQo+Pj4gKyAgICAgIGlzIG9ubHkgbmVlZGVkIGZvciB0
aGUgQXJtYWRhIDdLLzhLIFNvQ3MNCj4+PiArICAgIG1pbkl0ZW1zOiAxDQo+Pj4gKyAgICBtYXhJ
dGVtczogMg0KPj4+ICsNCj4+PiArICBjbG9jay1uYW1lczoNCj4+IE1pc3NpbmcgbWluSXRlbXM6
IDENCj4+DQo+Pj4gKyAgICBpdGVtczoNCj4+PiArICAgICAgLSBjb25zdDogY29yZQ0KPj4+ICsg
ICAgICAtIGNvbnN0OiByZWcNCj4+PiArDQo+Pj4gKyAgZG1hczoNCj4+PiArICAgIG1heEl0ZW1z
OiAxDQo+Pj4gKw0KPj4+ICsgIGRtYS1uYW1lczoNCj4+PiArICAgIGl0ZW1zOg0KPj4+ICsgICAg
ICAtIGNvbnN0OiByeHR4DQo+Pj4gKw0KPj4+ICsgIG1hcnZlbGwsc3lzdGVtLWNvbnRyb2xsZXI6
DQo+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxl
DQo+Pj4gKyAgICBkZXNjcmlwdGlvbjogU3lzY29uIG5vZGUgdGhhdCBoYW5kbGVzIE5BTkQgY29u
dHJvbGxlciByZWxhdGVkIHJlZ2lzdGVycw0KPj4+ICsNCj4+PiArcGF0dGVyblByb3BlcnRpZXM6
DQo+Pj4gKyAgIl5uYW5kQFswLTNdJCI6DQo+Pj4gKyAgICB0eXBlOiBvYmplY3QNCj4+IE1pc3Np
bmcgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZSBvbiB0aGlzIGxldmVsLg0KPj4NCj4+PiAr
ICAgIHByb3BlcnRpZXM6DQo+Pj4gKyAgICAgIHJlZzoNCj4+PiArICAgICAgICBtaW5pbXVtOiAw
DQo+Pj4gKyAgICAgICAgbWF4aW11bTogMw0KPiBTYW1lIGFzIGJlbG93LCBpdCBpcyBhbiBhcnJh
eSBhcyB3ZWxsIElJUkMuDQo+DQo+Pj4gKw0KPj4+ICsgICAgICBuYW5kLXJiOg0KPj4+ICsgICAg
ICAgIG1pbmltdW06IDANCj4+PiArICAgICAgICBtYXhpbXVtOiAxDQo+PiBJdCdzIGFuIGFycmF5
LCBzbyB0aGlzIGRvZXMgbm90IHNvdW5kIHJpZ2h0LiBZb3UgbWlnaHQgd2FudCB0byBwdXQgaXQN
Cj4+IHVuZGVyIGl0ZW1zOi4gIFRoZW4geW91IGFsc28gbWlzcyBtaW4vbWF4SXRlbXMuDQo+IFRo
YXQncyB0cnVlLCB5b3UgY2FuIGhhdmUgZWl0aGVyIG9uZSBvciB0d28gbWVtYmVycyB3aXRoIHRo
ZSB2YWx1ZQ0KPiBbMC0xXSwgc28geW91IG5lZWQgYm90aC4NCj4NCj4+PiArDQo+Pj4gKyAgICAg
IG5hbmQtZWNjLXN0ZXAtc2l6ZToNCj4+PiArICAgICAgICBjb25zdDogNTEyDQo+Pj4gKw0KPj4+
ICsgICAgICBuYW5kLWVjYy1zdHJlbmd0aDoNCj4+PiArICAgICAgICBlbnVtOiBbMSwgNCwgOF0N
Cj4gVGhlIGNvbnRyb2xsZXIgKGFuZCB0aGUgZHJpdmVyKSBhY3R1YWxseSBzdXBwb3J0cyAxLCA0
LCA4LCAxMiwgMTYuDQo+DQo+Pj4gKw0KPj4+ICsgICAgICBtYXJ2ZWxsLG5hbmQta2VlcC1jb25m
aWc6DQo+Pj4gKyAgICAgICAgZGVzY3JpcHRpb246IHwNCj4+PiArICAgICAgICAgIE9yZGVycyB0
aGUgZHJpdmVyIG5vdCB0byB0YWtlIHRoZSB0aW1pbmdzIGZyb20gdGhlIGNvcmUgYW5kDQo+Pj4g
KyAgICAgICAgICBsZWF2aW5nIHRoZW0gY29tcGxldGVseSB1bnRvdWNoZWQuIEJvb3Rsb2FkZXIg
dGltaW5ncyB3aWxsIHRoZW4NCj4+PiArICAgICAgICAgIGJlIHVzZWQuDQo+Pj4gKyAgICAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPj4+ICsNCj4+PiAr
ICAgICAgbWFydmVsbCxuYW5kLWVuYWJsZS1hcmJpdGVyOg0KPj4+ICsgICAgICAgIGRlc2NyaXB0
aW9uOiB8DQo+Pj4gKyAgICAgICAgICBUbyBlbmFibGUgdGhlIGFyYml0ZXIsIGFsbCBib2FyZHMg
YmxpbmRseSB1c2VkIGl0LA0KPj4+ICsgICAgICAgICAgdGhpcyBiaXQgd2FzIHNldCBieSB0aGUg
Ym9vdGxvYWRlciBmb3IgbWFueSBib2FyZHMgYW5kIGV2ZW4gaWYNCj4+PiArICAgICAgICAgIGl0
IGlzIG1hcmtlZCByZXNlcnZlZCBpbiBzZXZlcmFsIGRhdGFzaGVldHMsIGl0IG1pZ2h0IGJlIG5l
ZWRlZCB0byBzZXQNCj4+PiArICAgICAgICAgIGl0IChvdGhlcndpc2UgaXQgaXMgaGFybWxlc3Mp
IHNvIHdoZXRoZXIgb3Igbm90IHRoaXMgcHJvcGVydHkgaXMgc2V0LA0KPj4+ICsgICAgICAgICAg
dGhlIGJpdCBpcyBzZWxlY3RlZCBieSB0aGUgZHJpdmVyLg0KPiBNYXliZSB3ZSBzaG91bGQgc2xp
Z2h0bHkgcmVwaHJhc2UgdGhpcyB0byBhdm9pZCBkcml2ZXIgcmVsYXRlZA0KPiBpbmZvcm1hdGlv
bi4NCj4NCj4+PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9mbGFnDQo+Pj4gKyAgICAgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPj4+ICsNCj4+PiArICAgIHJl
cXVpcmVkOg0KPj4+ICsgICAgICAtIHJlZw0KPj4+ICsgICAgICAtIG5hbmQtcmINCj4+PiArDQo+
Pj4gK2FsbE9mOg0KPj4+ICsgIC0gJHJlZjogbmFuZC1jb250cm9sbGVyLnlhbWwNCj4+PiArDQo+
Pj4gKyAgLSBpZjoNCj4+PiArICAgICAgcHJvcGVydGllczoNCj4+PiArICAgICAgICBjb21wYXRp
YmxlOg0KPj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+Pj4gKyAgICAgICAgICAgIGNvbnN0OiBt
YXJ2ZWxsLHB4YTN4eC1uYW5kLWNvbnRyb2xsZXINCj4+PiArICAgIHRoZW46DQo+Pj4gKyAgICAg
IHJlcXVpcmVkOg0KPj4+ICsgICAgICAgIC0gZG1hcw0KPj4+ICsgICAgICAgIC0gZG1hLW5hbWVz
DQo+Pj4gKw0KPj4+ICsgIC0gaWY6DQo+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+Pj4gKyAgICAg
ICAgY29tcGF0aWJsZToNCj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+ICsgICAgICAgICAg
ICBjb25zdDogbWFydmVsbCxhcm1hZGEtOGstbmFuZC1jb250cm9sbGVyDQo+Pj4gKyAgICB0aGVu
Og0KPj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4+ICsgICAgICAgIGNsb2NrczoNCj4+PiArICAg
ICAgICAgIG1pbkl0ZW1zOiAyDQo+Pj4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPj4gRHJvcCBt
YXhJdGVtcy4gWW91IGRvbid0IGhhdmUgaXQgaW4gY2xvY2stbmFtZXMuDQo+Pg0KPj4+ICsNCj4+
PiArICAgICAgICBjbG9jay1uYW1lczoNCj4+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+Pj4g
Kw0KPj4+ICsgICAgICByZXF1aXJlZDoNCj4+PiArICAgICAgICAtIG1hcnZlbGwsc3lzdGVtLWNv
bnRyb2xsZXINCj4+PiArICAgIGVsc2U6DQo+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+Pj4gKyAg
ICAgICAgY2xvY2tzOg0KPj4+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4+PiArDQo+Pj4gKyAg
ICAgICAgY2xvY2stbmFtZXM6DQo+Pj4gKyAgICAgICAgICBtYXhJdGVtczogMQ0KPj4gSSBkb3Vi
dCB0aGF0IHlvdSB0ZXN0ZWQgaXQgaW4gYWJvdmUgdmFyaWFudC4uLg0KPj4NCj4+PiArDQo+Pj4g
K3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+PiArDQo+Pj4gK3JlcXVpcmVkOg0KPj4+
ICsgIC0gY29tcGF0aWJsZQ0KPj4+ICsgIC0gcmVnDQo+Pj4gKyAgLSBpbnRlcnJ1cHRzDQo+Pj4g
KyAgLSBjbG9ja3MNCj4+PiArDQo+Pj4gK2V4YW1wbGVzOg0KPj4+ICsgIC0gfA0KPj4+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4+
PiArICAgIG5hbmRfY29udHJvbGxlcjogbmFuZC1jb250cm9sbGVyQGQwMDAwIHsNCj4+PiArICAg
ICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhMzcwLW5hbmQtY29udHJvbGxlciI7DQo+
Pj4gKyAgICAgICAgcmVnID0gPDB4ZDAwMDAgMHg1ND47DQo+Pj4gKyAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+Pj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+Pg0KPj4gQmVz
dCByZWdhcmRzLA0KPj4gS3J6eXN6dG9mDQo+Pg0KPiBUaGFua3MgZm9yIGRvaW5nIHRoaXMhDQo+
DQo+IE1pcXXDqGw=
