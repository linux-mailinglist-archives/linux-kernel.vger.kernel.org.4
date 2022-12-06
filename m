Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C64643EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiLFIdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiLFIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:32:42 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0252DC2;
        Tue,  6 Dec 2022 00:32:40 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3CCF724E277;
        Tue,  6 Dec 2022 16:32:39 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 16:32:39 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Tue, 6 Dec 2022 16:32:39 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto
 driver
Thread-Topic: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive
 crypto driver
Thread-Index: AQHZBH/2P5dLP9b8iUC7OZp9LCFzsa5W9X0AgAlLclD//8izgIAAh0AA
Date:   Tue, 6 Dec 2022 08:32:38 +0000
Message-ID: <15fcb91a5214438fb69535bcf2df576e@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
 <166981596611.1846501.537832446745968339.robh@kernel.org>
 <14a3facb1fe642cba0048f2f2d0eb2e9@EXMBX068.cuchost.com>
 <0a2056f9-0126-4dd7-55fa-930ce61e2e81@linaro.org>
In-Reply-To: <0a2056f9-0126-4dd7-55fa-930ce61e2e81@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciA2LCAyMDIyIDQ6MjYgUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhvQHN0YXJm
aXZldGVjaC5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBDYzogbGludXgt
Y3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
Um9iDQo+IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEhlcmJlcnQgWHUNCj4gPGhlcmJl
cnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBk
YXZlbWxvZnQubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gZHQtYmluZGluZ3M6IGNy
eXB0bzogQWRkIGJpbmRpbmdzIGZvciBTdGFyZml2ZSBjcnlwdG8NCj4gZHJpdmVyDQo+IA0KPiBP
biAwNi8xMi8yMDIyIDA0OjQ4LCBKaWFKaWUgSG8gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IFRoZSAj
aW5jbHVkZSBpbiBleGFtcGxlIGhhdmUgZGVwZW5kZW5jaWVzIG9uIHRoZSBmb2xsb3dpbmcgcGF0
Y2hlczoNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlz
Y3YvY292ZXIvMjAyMjExMTgwMTA2MjcuDQo+ID4gNzA1NzYtMS1oYWwuZmVuZ0BzdGFyZml2ZXRl
Y2guY29tLw0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1y
aXNjdi9jb3Zlci8yMDIyMTExODAxMTcxNC4NCj4gPiA3MDg3Ny0xLWhhbC5mZW5nQHN0YXJmaXZl
dGVjaC5jb20vDQo+ID4gSSd2ZSBub3RlZCB0aGVtIGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+ID4g
SG93IGRvIEkgYWRkIHRoZW0gaW4gdGhpcyBwYXRjaD8NCj4gDQo+IFlvdSBjYW5ub3QuIFRlc3Rp
bmcgYm90IGRvZXMgbm90IHRha2UgZGVwZW5kZW5jaWVzLCBzbyBpdCBkaWQgbm90IGhhdmUNCj4g
YWJvdmUgY2xvY2sgSURzLiBUaGlzIGFsc28gc2hvdWxkIHBvaW50IHlvdXIgYXR0ZW50aW9uIHRo
YXQgaWYgY3J5cHRvDQo+IG1haW50YWluZXJzIHBpY2sgdXAgdGhpcyBwYXRjaCwgdGhleSBhbHNv
IHdvbid0IGhhdmUgdGhlIGNsb2NrIElEcyBzbyB0aGVpciB0cmVlDQo+IHdpbGwgaGF2ZSBzdWNo
IGZhaWx1cmUgYXMgd2VsbC4NCj4gDQo+IFlvdSBjYW4gd2FpdCB3aXRoIHlvdXIgcGF0Y2ggdGls
bCBkZXBlbmRlbmN5IGhpdHMgbWFpbmxpbmUgb3IgeW91IGNhbiBqdXN0DQo+IHJlcGxhY2UgY2xv
Y2sgSURzIHdpdGggbnVtYmVycyBhbmQgZHJvcCB0aGUgaGVhZGVyIChhbmQgbGF0ZXIgeW91IGNh
bg0KPiBjb3JyZWN0IHRoZSBleGFtcGxlIGlmIG5lZWRlZC4uLiBvciBsZWF2ZSBpdCBhcyBpcyku
DQo+IA0KSSdsbCByZXBsYWNlIHRoZSBJRHMgYW5kIGRyb3AgdGhlIGhlYWRlciB0aGVuLg0KVGhh
bmtzLg0KDQpSZWdhcmRzLA0KSmlhIEppZQ0K
