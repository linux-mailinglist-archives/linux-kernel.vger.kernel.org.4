Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915F643EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiLFIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiLFIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:35:34 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757A17A84;
        Tue,  6 Dec 2022 00:35:11 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1B97B24E277;
        Tue,  6 Dec 2022 16:35:09 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 16:35:09 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 16:35:09 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Tue, 6 Dec 2022 16:35:09 +0800
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
Subject: RE: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto
 driver
Thread-Topic: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive
 crypto driver
Thread-Index: AQHZBH/2P5dLP9b8iUC7OZp9LCFzsa5W7gcAgAHFddD//4unAIAIUqbQ
Date:   Tue, 6 Dec 2022 08:35:09 +0000
Message-ID: <e732d81f8d86499eb5e8fa9febc8cb68@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
 <8a8f502e-e0ed-d638-0b56-74edcbca2134@linaro.org>
 <aa388c8c99b74436ad556aeb47a5c60a@EXMBX068.cuchost.com>
 <2886dd64-435d-1cdb-168d-5851c37dc538@linaro.org>
In-Reply-To: <2886dd64-435d-1cdb-168d-5851c37dc538@linaro.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMSwgMjAyMiA1OjI3IFBNDQo+IFRvOiBKaWFKaWUgSG8gPGppYWppZS5ob0BzdGFy
Zml2ZXRlY2guY29tPjsgSGVyYmVydCBYdQ0KPiA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1
PjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IENjOiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCA1LzZdIGR0LWJpbmRpbmdzOiBjcnlwdG86IEFkZCBiaW5kaW5ncyBmb3IgU3RhcmZp
dmUgY3J5cHRvDQo+IGRyaXZlcg0KPiANCj4gT24gMDEvMTIvMjAyMiAxMDowMSwgSmlhSmllIEhv
IHdyb3RlOg0KPiANCj4gPj4+ICsNCj4gPj4+ICsgIGVuYWJsZS1zaWRlLWNoYW5uZWwtbWl0aWdh
dGlvbjoNCj4gPj4+ICsgICAgZGVzY3JpcHRpb246IEVuYWJsZSBzaWRlLWNoYW5uZWwtbWl0aWdh
dGlvbiBmZWF0dXJlIGZvciBBRVMgbW9kdWxlLg0KPiA+Pj4gKyAgICAgICAgRW5hYmxpbmcgdGhp
cyBmZWF0dXJlIHdpbGwgYWZmZWN0IHRoZSBzcGVlZCBwZXJmb3JtYW5jZSBvZg0KPiA+Pj4gKyAg
ICAgICAgY3J5cHRvIGVuZ2luZS4NCj4gPj4+ICsgICAgdHlwZTogYm9vbGVhbg0KPiA+Pg0KPiA+
PiBXaHkgZXhhY3RseSB0aGlzIGlzIGEgaGFyZHdhcmUgKERUKSBwcm9wZXJ0eSwgbm90IHJ1bnRp
bWU/DQo+ID4+DQo+ID4NCj4gPiBUaGlzIGlzIGEgaGFyZHdhcmUgc2V0dGluZyBwcm92aWRlZCBp
biBTdGFyRml2ZSBjcnlwdG8gZW5naW5lIG9ubHkuDQo+ID4gVGhlIGNyeXB0byBBUEkgZG9lc24n
dCBjb250cm9sIHRoaXMgc2V0dGluZyBkdXJpbmcgcnVudGltZSBhbmQgbGVhdmluZyB0aGlzDQo+
IGFsd2F5cyBvbiB3aWxsIGltcGFjdCBzcGVlZCBwZXJmb3JtYW5jZS4NCj4gPiBTbywgSSBhZGRl
ZCB0aGlzIHByb3BlcnR5IHRvIGFsbG93IHVzZXIgdG8gY29udHJvbCB0aGlzIGluIGR0Yi4NCj4g
DQo+IERldmljZXRyZWUgc2hvdWxkIG5vdCBkZXNjcmliZSBwb2xpY2llcywgc28gd2l0aG91dCBq
dXN0aWZpY2F0aW9uIGl0IGRvZXMgbm90DQo+IGxvb2sgbGlrZSBoYXJkd2FyZSBwcm9wZXJ0eS4g
RHJvcC4NCj4gDQpJJ2xsIHJlbW92ZSB0aGlzIGluIHYyIGFuZCBzZXQgdGhlIHZhbHVlIHVzaW5n
IG1vZHVsZSBwYXJhbSBpbnN0ZWFkLg0KVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpKaWEgSmll
DQo=
