Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C636653CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiLVILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:11:34 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E607218B1;
        Thu, 22 Dec 2022 00:11:30 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DE0D124E36E;
        Thu, 22 Dec 2022 16:11:16 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 16:11:16 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX063.cuchost.com
 (172.16.6.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 16:11:16 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Thu, 22 Dec 2022 16:11:16 +0800
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
Subject: RE: [PATCH 3/3] riscv: dts: starfive: Add TRNG node for VisionFive 2
Thread-Topic: [PATCH 3/3] riscv: dts: starfive: Add TRNG node for VisionFive 2
Thread-Index: AQHZFRwZSE/lt9EBpUOGdiBQvIWXRa53klOAgAH8thA=
Date:   Thu, 22 Dec 2022 08:11:16 +0000
Message-ID: <ee96fa9cdf9442169dab277647a3bae3@EXMBX168.cuchost.com>
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-4-jiajie.ho@starfivetech.com>
 <cbbf719b-a027-f91b-bd2c-6e6b43447b97@linaro.org>
In-Reply-To: <cbbf719b-a027-f91b-bd2c-6e6b43447b97@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSByaXNjdjogZHRzOiBz
dGFyZml2ZTogQWRkIFRSTkcgbm9kZSBmb3IgVmlzaW9uRml2ZSAyDQo+IA0KPiA+ICsNCj4gPiAr
CQlybmc6IHJuZ0AxNjAwYzAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3
MTEwLXRybmciOw0KPiA+ICsJCQlyZWcgPSA8MHgwIDB4MTYwMEMwMDAgMHgwIDB4NDAwMD47DQo+
ID4gKwkJCWNsb2NrcyA9IDwmc3RnY3JnIEpINzExMF9TVEdDTEtfU0VDX0hDTEs+LA0KPiA+ICsJ
CQkJIDwmc3RnY3JnIEpINzExMF9TVEdDTEtfU0VDX01JU0NBSEI+Ow0KPiA+ICsJCQljbG9jay1u
YW1lcyA9ICJoY2xrIiwgImFoYiI7DQo+ID4gKwkJCXJlc2V0cyA9IDwmc3RnY3JnDQo+IEpINzEx
MF9TVEdSU1RfU0VDX1RPUF9IUkVTRVROPjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDwzMD47DQo+
ID4gKwkJCXN0YXR1cyA9ICJva2F5IjsNCj4gDQo+IERyb3AuIEl0J3MgYnkgZGVmYXVsdC4NCj4g
DQpJJ2xsIGZpeCB0aGlzIGluIHYyLg0KDQpUaGFua3MsDQpKaWEgSmllDQo=
