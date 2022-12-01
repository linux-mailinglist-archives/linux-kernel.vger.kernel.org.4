Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3806263ECB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLAJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:43:49 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82593EBF;
        Thu,  1 Dec 2022 01:43:47 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 65BF924E161;
        Thu,  1 Dec 2022 17:43:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 17:43:42 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 17:43:42 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Thu, 1 Dec 2022 17:43:42 +0800
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
Subject: RE: [PATCH 1/6] crypto: starfive - Add StarFive crypto engine support
Thread-Topic: [PATCH 1/6] crypto: starfive - Add StarFive crypto engine
 support
Thread-Index: AQHZBH/rqnMRzesHF0+7VtyEEKwoza5W7JSAgAGlN8D//62vgIAAiNrQ
Date:   Thu, 1 Dec 2022 09:43:42 +0000
Message-ID: <291d6d792df648afa9033e7fe8c7a0f4@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-2-jiajie.ho@starfivetech.com>
 <aafb1c32-bc00-2db2-edbd-aa4771f33ac7@linaro.org>
 <60ad0da0116044d3a1fe575e9904e22c@EXMBX068.cuchost.com>
 <6028b265-bc8a-3a06-b17c-56aa772a4782@linaro.org>
In-Reply-To: <6028b265-bc8a-3a06-b17c-56aa772a4782@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMSwgMjAyMiA1OjI5IFBNDQo+IFRvOiBKaWFKaWUgSG8gPGppYWppZS5ob0BzdGFy
Zml2ZXRlY2guY29tPjsgSGVyYmVydCBYdQ0KPiA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1
PjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IENjOiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzZdIGNyeXB0bzogc3RhcmZpdmUgLSBBZGQgU3RhckZpdmUgY3J5cHRvIGVuZ2lu
ZQ0KPiBzdXBwb3J0DQo+IA0KPiBPbiAwMS8xMi8yMDIyIDA3OjUyLCBKaWFKaWUgSG8gd3JvdGU6
DQo+IA0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbmxpbmUgdTMyIHN0YXJmaXZlX3NlY19yZWFk
KHN0cnVjdCBzdGFyZml2ZV9zZWNfZGV2ICpzZGV2LA0KPiA+Pj4gK3UzMiBvZmZzZXQpIHsNCj4g
Pj4+ICsJcmV0dXJuIF9fcmF3X3JlYWRsKHNkZXYtPmlvX2Jhc2UgKyBvZmZzZXQpOw0KPiA+Pg0K
PiA+PiBJIGRvbid0IHRoaW5rIHRoZXNlIHJlYWQvd3JpdGUgd3JhcHBlcnMgaGVscCBhbnlob3cu
Li4NCj4gPj4NCj4gPg0KPiA+IFRoZXNlIHdyYXBwZXJzIGFyZSB1c2VkIGJ5IHRoZSBjcnlwdG8g
cHJpbWl0aXZlcyBpbiB0aGlzIHBhdGNoIHNlcmllcy4NCj4gPiBJJ2xsIG1vdmUgdGhlc2UgdG8g
c3Vic2VxdWVudCBwYXRjaGVzIHdoZW4gdGhleSBhcmUgZmlyc3QgdXNlZC4NCj4gPg0KPiA+IFRo
YW5rIHlvdSBmb3Igc3BlbmRpbmcgdGltZSByZXZpZXdpbmcgYW5kIHByb3ZpZGluZyBoZWxwZnVs
IGNvbW1lbnRzDQo+ID4gZm9yIHRoaXMgZHJpdmVyLg0KPiA+DQo+IA0KPiBKdXN0IGRyb3AgdGhl
IHdyYXBwZXJzLiBJIHNhaWQgdGhleSBkbyBub3QgaGVscCBhbmQgeW91ciBhbnN3ZXIgImFyZSB1
c2VkIg0KPiBkb2VzIG5vdCBleHBsYWluIGFueXRoaW5nLiBJZiB5b3UgaW5zaXN0IG9uIGtlZXBp
bmcgdGhlbSwgcGxlYXNlIGV4cGxhaW4gd2hhdA0KPiBhcmUgdGhlIGJlbmVmaXRzIGV4Y2VwdCBt
b3JlIGNvZGUgYW5kIG1vcmUgaW5kaXJlY3Rpb25zL2xheWVycyBtYWtpbmcgaXQNCj4gbW9yZSBk
aWZmaWN1bHQgdG8gcmVhZD8NCj4gDQoNCkknbGwgZHJvcCB0aGVzZSBpbiB0aGUgbmV4dCB2ZXJz
aW9uLg0KVGhhbmtzIGFnYWluIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KUmVnYXJkcywNCkppYSBK
aWUNCg==
