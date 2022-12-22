Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C611653D88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLVJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiLVJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:35:25 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABD275DD;
        Thu, 22 Dec 2022 01:35:21 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 33E1224E346;
        Thu, 22 Dec 2022 17:35:09 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 17:35:09 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Thu, 22 Dec 2022 17:35:09 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Topic: [PATCH 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Index: AQHZFRwx15kE4gLKu0uxN2CW96B+Oa53kqwAgAIT3RA=
Date:   Thu, 22 Dec 2022 09:35:08 +0000
Message-ID: <69dca1be673a40729d750c00d927b437@EXMBX168.cuchost.com>
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-3-jiajie.ho@starfivetech.com>
 <05aaa9f8-7a97-51c9-e18a-1c3753f2006b@linaro.org>
In-Reply-To: <05aaa9f8-7a97-51c9-e18a-1c3753f2006b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.229.243]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDIxLCAyMDIyIDU6NDkgUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhvQHN0
YXJmaXZldGVjaC5jb20+OyBPbGl2aWEgTWFja2FsbA0KPiA8b2xpdmlhQHNlbGVuaWMuY29tPjsg
SGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgUm9iDQo+IEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxrZXJu
ZWxAZXNtaWwuZGs+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
PjsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBod3JuZzogc3RhcmZp
dmUgLSBBZGQgVFJORyBkcml2ZXIgZm9yIFN0YXJGaXZlIFNvQw0KPiANCj4gT24gMjEvMTIvMjAy
MiAxMDowOCwgSmlhIEppZSBIbyB3cm90ZToNCj4gPiBUaGlzIGFkZHMgZHJpdmVyIHN1cHBvcnQg
Zm9yIHRoZSBoYXJkd2FyZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvciBpbg0KPiA+IFN0YXJmaXZl
IFNvQ3MgYW5kIGFkZHMgU3RhckZpdmUgVFJORyBlbnRyeSB0byBNQUlOVEFJTkVSUy4NCj4gPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogSmVubnkgWmhhbmcgPGplbm55LnpoYW5nQHN0YXJmaXZldGVj
aC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmVubnkgWmhhbmcgPGplbm55LnpoYW5nQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEppZSBIbyA8amlhamllLmhvQHN0
YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAgZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9LY29uZmln
ICAgICAgICAgfCAgMTEgKw0KPiA+ICBkcml2ZXJzL2NoYXIvaHdfcmFuZG9tL01ha2VmaWxlICAg
ICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvY2hhci9od19yYW5kb20vc3RhcmZpdmUtdHJuZy5j
IHwgNDAzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDQyMSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2No
YXIvaHdfcmFuZG9tL3N0YXJmaXZlLXRybmcuYw0KPiA+DQo+IA0KPiAoLi4uKQ0KPiANCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdHJuZ19kdF9pZHNbXSA9IHsNCj4gPiAr
CXsgLmNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLXRybmciIH0sDQo+ID4gKwl7IH0NCj4g
PiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgdHJuZ19kdF9pZHMpOw0KPiA+ICsN
Cj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc3RhcmZpdmVfdHJuZ19kcml2ZXIg
PSB7DQo+ID4gKwkucHJvYmUJPSBzdGFyZml2ZV90cm5nX3Byb2JlLA0KPiA+ICsJLmRyaXZlcgk9
IHsNCj4gPiArCQkubmFtZQkJPSAic3RhcmZpdmUtdHJuZyIsDQo+ID4gKwkJLnBtCQk9ICZzdGFy
Zml2ZV90cm5nX3BtX29wcywNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUJPSBvZl9tYXRjaF9wdHIo
dHJuZ19kdF9pZHMpLA0KPiANCj4gb2ZfbWF0Y2hfcHRyIGdvZXMgd2l0aCBfX21heWJlX3VudXNl
ZC4gWW91IHdpbGwgaGF2ZSBub3cgd2FybmluZ3MsIHNvDQo+IHBsZWFzZSB0ZXN0IG1vcmUgeW91
ciBwYXRjaGVzIChXPTEsIHNwYXJzZSwgc21hdGNoKS4NCj4gDQoNCkhpIEtyenlzenRvZiwNCg0K
VGhhbmtzIGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCkhvdyBkbyBJIHByb3Blcmx5IGhhbmRs
ZSBfX21heWJlX3VudXNlZCBmdW5jdGlvbnMgaW4gdGhpcyBzY2VuYXJpbz8NCldpbGwgaXQgaGVs
cCBpZiBJIGFkZCAjZGVmaW5lIGFzIGZvbGxvd3M6DQoNCiNpZmRlZiBDT05GSUdfUE0NCiNkZWZp
bmUgU1RBUkZJVkVfUk5HX1BNX09QUyAoJnN0YXJmaXZlX3JuZ19wbV9vcHMpDQojZWxzZQ0KI2Rl
ZmluZSBTVEFSRklWRV9STkdfUE1fT1BTIE5VTEwNCiNlbmRpZg0KDQpzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBzdGFyZml2ZV90cm5nX2RyaXZlciA9IHsNCiAgICAgICAgLnByb2JlICA9
IHN0YXJmaXZlX3RybmdfcHJvYmUsDQogICAgICAgIC5kcml2ZXIgPSB7DQogICAgICAgICAgICAg
ICAgLm5hbWUgICAgICAgICAgID0gInN0YXJmaXZlLXRybmciLA0KICAgICAgICAgICAgICAgIC5w
bSAgICAgICAgICAgICA9IFNUQVJGSVZFX1JOR19QTV9PUFMsDQogICAgICAgICAgICAgICAgLm9m
X21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHRybmdfZHRfaWRzKSwNCiAgICAgICAgfSwNCn07
DQoNCkkgZGlkIGJ1aWxkIHRoZSBwYXRjaGVzIHdpdGggdGhlIHRvb2xzIG1lbnRpb25lZCBidXQg
ZGlkIG5vdCBnZXQgd2FybmluZ3MuDQpEbyBJIG5lZWQgYSBzcGVjaWZpYyB2ZXJzaW9uLCBvciBo
YXZlIEkgZG9uZSBzb21ldGhpbmcgd3Jvbmc/DQoNCm1ha2UgQz0yIGRyaXZlcnMvY2hhci9od19y
YW5kb20vDQogIENIRUNLICAgc2NyaXB0cy9tb2QvZW1wdHkuYw0KICBDQUxMICAgIHNjcmlwdHMv
Y2hlY2tzeXNjYWxscy5zaA0KICBDSEVDSyAgIGFyY2gvcmlzY3Yva2VybmVsL3Zkc28vdmdldHRp
bWVvZmRheS5jDQogIENIRUNLICAgZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9jb3JlLmMNCiAgQ0hF
Q0sgICBkcml2ZXJzL2NoYXIvaHdfcmFuZG9tL3N0YXJmaXZlLXRybmcuYw0KDQpSZWdhcmRzLA0K
SmlhIEppZQ0K
