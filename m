Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365463E9CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLAGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAGRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:17:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B62BE4;
        Wed, 30 Nov 2022 22:17:34 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A77A424E1C7;
        Thu,  1 Dec 2022 14:17:26 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 14:17:26 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 14:17:26 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Thu, 1 Dec 2022 14:17:26 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Topic: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Index: AQHZBH/4vZHP2U3n+EalaiuTkXOjPK5WreUAgAHaqdA=
Date:   Thu, 1 Dec 2022 06:17:26 +0000
Message-ID: <4ddddceba3dc437daca27374dd2f6fd7@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
 <1673ef8b-179e-3b03-b3f8-8d347c70d8c3@microchip.com>
In-Reply-To: <1673ef8b-179e-3b03-b3f8-8d347c70d8c3@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IuRG9vbGV5QG1p
Y3JvY2hpcC5jb20gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDMwLCAyMDIyIDU6MzEgUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhv
QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGhlcmJlcnRAZ29u
ZG9yLmFwYW5hLm9yZy5hdTsgbGludXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGtlcm5l
bEBlc21pbC5kazsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA2LzZdIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBBZGQgY3J5cHRvIGFu
ZCBETUEgbm9kZSBmb3INCj4gVmlzaW9uRml2ZSAyDQo+IA0KPiBIZXkgSmlhIEppZSBIbywNCj4g
DQo+IE9uIDMwLzExLzIwMjIgMDU6NTIsIEppYSBKaWUgSG8gd3JvdGU6DQo+ID4gW1lvdSBkb24n
dCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqaWFqaWUuaG9Ac3RhcmZpdmV0ZWNoLmNvbS4gTGVhcm4g
d2h5DQo+ID4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0NCj4gPg0KPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4gPiB0aGUgY29u
dGVudCBpcyBzYWZlDQo+ID4NCj4gPiBBZGRpbmcgU3RhckZpdmUgY3J5cHRvIElQIGFuZCBETUEg
Y29udHJvbGxlciBub2RlIHRvIFZpc2lvbkZpdmUgMiBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKaWEgSmllIEhvIDxqaWFqaWUuaG9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBIdWFuIEZlbmcgPGh1YW4uZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiANCj4gT3V0
IG9mIGN1cmlvc2l0eSwgd2hhdCB3YXMgSHVhbiBGZW5nJ3MgY29udHJpYnV0aW9uIHRvIHRoaXMg
cGF0Y2g/DQo+IERpZCB0aGV5IGNvLWRldmVsb3AgaXQsIG9yIGlzIHRoZXJlIHNvbWUgb3RoZXIg
cmVhc29uPw0KPiANCkhpIENvbm9yLCANClllcywgSHVhbiBGZW5nIGNvLWRldmVsb3BlZCB0aGlz
IGRyaXZlci4NCg0KPiA+IC0tLQ0KPiA+ICAgLi4uL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZl
LXYyLmR0cyAgICAgICAgIHwgIDggKysrKysNCj4gPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3Rh
cmZpdmUvamg3MTEwLmR0c2kgICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysNCj4gDQo+IEkg
ZmlndXJlIEVtaWwgd2lsbCBsaWtlbHkgc2VlIGFueXdheSwgYnV0IHdoZW5ldmVyIHlvdSBnZXQg
YWN0dWFsIHJldmlldw0KPiBjb21tZW50cyBhbmQgc2VuZCBhIHYyIC0gcGxlYXNlIGRvbid0IGRy
b3AgcGVvcGxlIHRoYXQgZ2V0X21haW50YWluZXIucGwNCj4gdGVsbHMgeW91IGFyZSByZXNwb25z
aWJsZSBmb3IgdGhlIGNvZGUgaW4gcXVlc3Rpb24uDQo+IA0KSSB3aWxsIGluY2x1ZGUgZXZlcnlv
bmUgaW52b2x2ZWQgd2hlbiBzZW5kaW5nIHRoZSBuZXcgcGF0Y2ggc2VyaWVzLg0KDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZp
dmUtdjIuZHRzDQo+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFy
Zml2ZS12aXNpb25maXZlLXYyLmR0cw0KPiA+IGluZGV4IDQ1MGU5MjAyMzZhNS4uZGEyYWE0ZDU5
N2YzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEw
LXN0YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS12Mi5kdHMNCj4gPiBAQCAtMTE1
LDMgKzExNSwxMSBAQCAmdGRtX2V4dCB7DQo+ID4gICAmbWNsa19leHQgew0KPiA+ICAgICAgICAg
IGNsb2NrLWZyZXF1ZW5jeSA9IDw0OTE1MjAwMD47DQo+ID4gICB9Ow0KPiA+ICsNCj4gPiArJnNl
Y19kbWEgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiArJmNyeXB0byB7DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+IA0K
PiBJbiB3aGF0IHNjZW5hcmlvIHdvdWxkIHlvdSBub3Qgd2FudCB0byBoYXZlIHRoZXNlIGVuYWJs
ZWQ/DQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANClRoZXNlIGRyaXZlcnMgYXJlIGFsd2F5
cyBlbmFibGVkLiANCklzIGV2ZXJ5dGhpbmcgb2sgd2l0aCB0aGUgZHRzIG5vZGUgZW50cmllcz8N
ClRoYW5rIHlvdSBmb3Igc3BlbmRpbmcgdGltZSByZXZpZXdpbmcgYW5kIHByb3ZpZGluZyBzdWdn
ZXN0aW9ucyBmb3IgdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCkppYSBKaWUNCg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpDQo+ID4gYi9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpDQo+ID4gaW5kZXggNGFjMTU5
ZDc5ZDY2Li43NDVhNTY1MDg4MmMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3Rh
cmZpdmUvamg3MTEwLmR0c2kNCj4gPiBAQCAtNDU1LDUgKzQ1NSw0MSBAQCB1YXJ0NTogc2VyaWFs
QDEyMDIwMDAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnLXNoaWZ0ID0gPDI+
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+
ICAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHNlY19kbWE6
IHNlY19kbWFAMTYwMDgwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYXJtLHBsMDgwIiwgImFybSxwcmltZWNlbGwiOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGFybSxwcmltZWNlbGwtcGVyaXBoaWQgPSA8MHgwMDA0MTA4MD47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDE2MDA4MDAwIDB4MCAweDQwMDA+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJzZWNfZG1hIjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDI5PjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBjbG9ja3MgPSA8JnN0Z2NyZyBKSDcxMTBfU1RHQ0xLX1NFQ19IQ0xLPiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnN0Z2NyZyBKSDcxMTBfU1RHQ0xL
X1NFQ19NSVNDQUhCPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9
ICJzZWNfaGNsayIsImFwYl9wY2xrIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXNl
dHMgPSA8JnN0Z2NyZyBKSDcxMTBfU1RHUlNUX1NFQ19UT1BfSFJFU0VUTj47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmVzZXQtbmFtZXMgPSAic2VjX2hyZSI7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgbGxpLWJ1cy1pbnRlcmZhY2UtYWhiMTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBtZW0tYnVzLWludGVyZmFjZS1haGIxOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIG1lbWNweS1idXJzdC1zaXplID0gPDI1Nj47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgbWVtY3B5LWJ1cy13aWR0aCA9IDwzMj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgI2RtYS1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgY3J5cHRvOiBjcnlwdG9AMTYwMDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWNyeXB0byI7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDE2MDAwMDAwIDB4MCAweDQwMDA+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJzZWNyZWciOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3RnY3JnIEpINzExMF9TVEdDTEtfU0VDX0hD
TEs+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc3RnY3JnIEpINzEx
MF9TVEdDTEtfU0VDX01JU0NBSEI+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2Nr
LW5hbWVzID0gInNlY19oY2xrIiwic2VjX2FoYiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmVzZXRzID0gPCZzdGdjcmcgSkg3MTEwX1NUR1JTVF9TRUNfVE9QX0hSRVNFVE4+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0LW5hbWVzID0gInNlY19ocmUiOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZS1zaWRlLWNoYW5uZWwtbWl0aWdhdGlvbjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBlbmFibGUtZG1hOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGRtYXMgPSA8JnNlY19kbWEgMSAyPiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZzZWNfZG1hIDAgMj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZG1hLW5hbWVzID0gInNlY19tIiwic2VjX3AiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gICAgICAg
ICAgfTsNCj4gPiAgIH07DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1yaXNj
diBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K
DQo=
