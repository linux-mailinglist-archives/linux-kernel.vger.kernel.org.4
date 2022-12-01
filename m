Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5263E63EA4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLAH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAHZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:25:59 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F93AC07;
        Wed, 30 Nov 2022 23:25:57 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0767C24E37C;
        Thu,  1 Dec 2022 15:25:56 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 15:25:55 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 15:25:55 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Thu, 1 Dec 2022 15:25:56 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Topic: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Index: AQHZBH/4vZHP2U3n+EalaiuTkXOjPK5W7jsAgAGzxIA=
Date:   Thu, 1 Dec 2022 07:25:56 +0000
Message-ID: <37089b7591f74034aad58c7d29021c3d@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
 <6de013d9-f2ab-a2d8-1022-2474c037c737@linaro.org>
In-Reply-To: <6de013d9-f2ab-a2d8-1022-2474c037c737@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDMwLCAyMDIyIDk6MjIgUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhvQHN0
YXJmaXZldGVjaC5jb20+OyBIZXJiZXJ0IFh1DQo+IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcu
YXU+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDYvNl0gcmlzY3Y6IGR0czogc3RhcmZpdmU6IEFkZCBjcnlwdG8gYW5kIERNQSBu
b2RlIGZvcg0KPiBWaXNpb25GaXZlIDINCj4gDQo+IE9uIDMwLzExLzIwMjIgMDY6NTIsIEppYSBK
aWUgSG8gd3JvdGU6DQo+ID4gQWRkaW5nIFN0YXJGaXZlIGNyeXB0byBJUCBhbmQgRE1BIGNvbnRy
b2xsZXIgbm9kZSB0byBWaXNpb25GaXZlIDIgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmlhIEppZSBIbyA8amlhamllLmhvQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSHVhbiBGZW5nIDxodWFuLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLXYyLmR0cyAgICAgICAgIHwgIDggKysrKysN
Cj4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaSAgICAgIHwgMzYg
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZp
dmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzDQo+ID4gYi9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLXYyLmR0cw0KPiA+IGlu
ZGV4IDQ1MGU5MjAyMzZhNS4uZGEyYWE0ZDU5N2YzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtdjIuZHRzDQo+
ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlz
aW9uZml2ZS12Mi5kdHMNCj4gPiBAQCAtMTE1LDMgKzExNSwxMSBAQCAmdGRtX2V4dCB7DQo+ID4g
ICZtY2xrX2V4dCB7DQo+ID4gIAljbG9jay1mcmVxdWVuY3kgPSA8NDkxNTIwMDA+Ow0KPiA+ICB9
Ow0KPiA+ICsNCj4gPiArJnNlY19kbWEgew0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArJmNyeXB0byB7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gK307
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0
c2kNCj4gPiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kNCj4gPiBp
bmRleCA0YWMxNTlkNzlkNjYuLjc0NWE1NjUwODgyYyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9i
b290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiA+IEBAIC00NTUsNSArNDU1LDQxIEBAIHVh
cnQ1OiBzZXJpYWxAMTIwMjAwMDAgew0KPiA+ICAJCQlyZWctc2hpZnQgPSA8Mj47DQo+ID4gIAkJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPiArDQo+ID4gKwkJc2VjX2RtYTog
c2VjX2RtYUAxNjAwODAwMCB7DQo+IA0KPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLg0K
PiBodHRwczovL2RldmljZXRyZWUtc3BlY2lmaWNhdGlvbi5yZWFkdGhlZG9jcy5pby9lbi9sYXRl
c3QvY2hhcHRlcjItDQo+IGRldmljZXRyZWUtYmFzaWNzLmh0bWwjZ2VuZXJpYy1uYW1lcy1yZWNv
bW1lbmRhdGlvbg0KPiANCj4gTm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1lcy4NCj4gDQo+IERv
ZXMgbm90IGxvb2sgbGlrZSB5b3UgdGVzdGVkIHRoZSBEVFMgYWdhaW5zdCBiaW5kaW5ncy4gUGxl
YXNlIHJ1biBgbWFrZQ0KPiBkdGJzX2NoZWNrYCAoc2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy93cml0aW5nLXNjaGVtYS5yc3QNCj4gZm9yIGluc3RydWN0aW9ucykuDQoNCkkn
bGwgZml4IHRoZSBub2RlIG5hbWUgYW5kIHJ1biBkdGJzX2NoZWNrIGZvciB0aGUgcmV2aXNlZCBz
ZXJpZXMuDQpSZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIHRpbWUgYW5kIGVmZm9ydCByZXZpZXdpbmcg
dGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KSmlhIEppZQ0K
