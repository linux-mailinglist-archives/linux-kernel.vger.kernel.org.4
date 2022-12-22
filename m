Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA9653CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiLVIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:12:52 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD72229F;
        Thu, 22 Dec 2022 00:12:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9C3D324E342;
        Thu, 22 Dec 2022 16:12:44 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 16:12:44 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Thu, 22 Dec 2022 16:12:44 +0800
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
Subject: RE: [PATCH 1/3] dt-bindings: rng: Add StarFive TRNG module
Thread-Topic: [PATCH 1/3] dt-bindings: rng: Add StarFive TRNG module
Thread-Index: AQHZFRxUoXQEQibksUW9iWQOWN1q6q53kkEAgAH9dkA=
Date:   Thu, 22 Dec 2022 08:12:44 +0000
Message-ID: <3fe5be6168b94f62b2c9ce078e5e954a@EXMBX168.cuchost.com>
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-2-jiajie.ho@starfivetech.com>
 <3a26c733-6573-5954-f4e5-8a1f8abba140@linaro.org>
In-Reply-To: <3a26c733-6573-5954-f4e5-8a1f8abba140@linaro.org>
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
IERlY2VtYmVyIDIxLCAyMDIyIDU6NDggUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhvQHN0
YXJmaXZldGVjaC5jb20+OyBPbGl2aWEgTWFja2FsbA0KPiA8b2xpdmlhQHNlbGVuaWMuY29tPjsg
SGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgUm9iDQo+IEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxrZXJu
ZWxAZXNtaWwuZGs+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
PjsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczog
cm5nOiBBZGQgU3RhckZpdmUgVFJORyBtb2R1bGUNCj4gDQo+IE9uIDIxLzEyLzIwMjIgMTA6MDgs
IEppYSBKaWUgSG8gd3JvdGU6DQo+ID4gQWRkIGRvY3VtZW50YXRpb24gdG8gZGVzY3JpYmUgU3Rh
cmZpdmUgdHJ1ZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvcg0KPiA+IG1vZHVsZS4NCj4gPg0KPiA+
IENvLWRldmVsb3BlZC1ieTogSmVubnkgWmhhbmcgPGplbm55LnpoYW5nQHN0YXJmaXZldGVjaC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmVubnkgWmhhbmcgPGplbm55LnpoYW5nQHN0YXJmaXZl
dGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEppZSBIbyA8amlhamllLmhvQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9ybmcvc3RhcmZpdmUsamg3
MTEwLXRybmcueWFtbCAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDU1IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JuZy9zdGFyZml2ZSxqaDcxMTAtdHJuZy55
YW1sDQo+ID4NCj4gDQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCkhpIEtyenlzenRvZiwNCg0KVGhhbmsg
eW91IGZvciBzcGVuZGluZyB0aW1lIHJldmlld2luZyB0aGlzIHBhdGNoLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpKaWEgSmllDQoNCg==
