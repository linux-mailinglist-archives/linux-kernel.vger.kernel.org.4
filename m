Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE664AFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiLMGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:32:17 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22F1F2DF;
        Mon, 12 Dec 2022 22:32:15 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A1A0424E023;
        Tue, 13 Dec 2022 14:32:07 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 14:32:07 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 14:32:07 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Tue, 13 Dec 2022 14:32:07 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 0/6] crypto: starfive: Add driver for cryptographic engine
Thread-Topic: [PATCH 0/6] crypto: starfive: Add driver for cryptographic
 engine
Thread-Index: AQHZBH/pPWRKQfsetk2izJkM4PGjPq5jvsYw//+A4ICAAIfRMIAHH2GAgACIHJA=
Date:   Tue, 13 Dec 2022 06:32:07 +0000
Message-ID: <8680f0d88b1046d1b554825651ed21c1@EXMBX068.cuchost.com>
References: <a0bd9060bab348eba1044cd911653bd7@EXMBX068.cuchost.com>
 <mhng-181c038e-a986-4dac-9745-9405d6814c84@palmer-ri-x1c9>
In-Reply-To: <mhng-181c038e-a986-4dac-9745-9405d6814c84@palmer-ri-x1c9>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFsbWVyIERhYmJlbHQg
PHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTMsIDIwMjIg
MjoyMCBQTQ0KPiBUbzogSmlhSmllIEhvIDxqaWFqaWUuaG9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4g
Q2M6IGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgaGVyYmVydEBnb25kb3IuYXBhbmEu
b3JnLmF1Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXgtY3J5cHRvQHZnZXIua2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggMC82XSBjcnlwdG86IHN0YXJmaXZlOiBBZGQgZHJpdmVyIGZvciBjcnlwdG9n
cmFwaGljIGVuZ2luZQ0KPiANCj4gPj4NCj4gPj4gWW91IHJlY2VpdmVkIHNvbWUgY29tbWVudHMg
c28gdGhlIGV4cGVjdGF0aW9uIGlzIHRvIHNlbmQgYSB2Mi4NCj4gPj4NCj4gPg0KPiA+IFN1cmUs
IEknbGwgZG8gdGhhdCB0aGVuLg0KPiANCj4gTm90IHN1cmUgaWYgSSBtaXNzZWQgaXQsIGJ1dCBJ
IGNhbid0IGZpbmQgYSB2Mi4NCg0KSGkgUGFsbWVyLA0KDQpJJ20gc3RpbGwgd29ya2luZyBvbiB0
aGUgcGF0Y2hlcy4gIEknbGwgc2VuZCB0aGVtIG91dCBzb29uLg0KDQpUaGFua3MsDQpKaWEgSmll
DQo=
