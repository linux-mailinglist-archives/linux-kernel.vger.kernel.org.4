Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA43663A18
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAJHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjAJHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:41:33 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FE19027;
        Mon,  9 Jan 2023 23:41:29 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DF60024E15C;
        Tue, 10 Jan 2023 15:41:26 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 15:41:26 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 15:41:26 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for VisionFive
 2
Thread-Topic: [PATCH v3 3/3] riscv: dts: starfive: Add TRNG node for
 VisionFive 2
Thread-Index: AQHZJEs2/69byV6q60qz9odnDfnRWq6V2l8AgAD5KdD//+qOgIAAhumw
Date:   Tue, 10 Jan 2023 07:41:26 +0000
Message-ID: <572dca7419a64ac99f1f2103ef5fbbf8@EXMBX168.cuchost.com>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
 <20230109165249.110279-4-jiajie.ho@starfivetech.com> <Y7xWtFZO/Y7GaYRQ@spud>
 <31f6c05b2836450d86560c3efda4abf2@EXMBX168.cuchost.com>
 <50178BB5-4698-4A52-AD89-7235C3802411@kernel.org>
In-Reply-To: <50178BB5-4698-4A52-AD89-7235C3802411@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.190.108.220]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPg0KPiBTZW50OiAxMCBKYW51YXJ5LCAyMDIzIDM6MzcgUE0NCj4gVG86
IEppYUppZSBIbyA8amlhamllLmhvQHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBPbGl2aWEgTWFj
a2FsbCA8b2xpdmlhQHNlbGVuaWMuY29tPjsgSGVyYmVydCBYdQ0KPiA8aGVyYmVydEBnb25kb3Iu
YXBhbmEub3JnLmF1PjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IEVtaWwg
UmVubmVyDQo+IEJlcnRoaW5nIDxrZXJuZWxAZXNtaWwuZGs+OyBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPjsNCj4gbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggdjMgMy8zXSByaXNjdjogZHRzOiBzdGFyZml2ZTogQWRkIFRSTkcgbm9kZSBmb3IgVmlzaW9u
Rml2ZQ0KPiAyDQo+IA0KPiA+PiBXaGljaCBjbG9jayBzb3VyY2UgaXMgdGhpcz8gSSBzZWUgc3lz
Y3JnIGFuZCBhb25jcmcgaW4gdGhlIHYzDQo+ID4+IGRldmljZXRyZWU6DQo+ID4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjIxMjIwMDExMjQ3LjM1NTYwLTctDQo+ID4+
IGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20vDQo+ID4+DQo+ID4+IEhhdmUgYSBtaXNzZWQgYSBw
YXRjaHNldCB3aGljaCBhZGRzIHN1cHBvcnQgZm9yIHRoaXMgcGFydGljdWxhciBjbG9jaw0KPiA+
PiBjb250cm9sbGVyPyBBdCB0aGUgdmVyeSBsZWFzdCwgSSBkb24ndCB0aGluayBvbmUgaGFzIHJl
YWNoZWQgdGhlDQo+ID4+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdC4NCj4gPj4gVGhlIGNsb2Nr
IGRyaXZlciBwYXRjaHNldCBvbmx5IGhhcyBhb25jcmcgJiBzeXNjcmc6DQo+ID4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjIxMjIwMDA1MDU0LjM0NTE4LTEtDQo+ID4+
IGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20vDQo+ID4+DQo+ID4NCj4gPkhpIENvbm9yLA0KPiA+
DQo+ID5UaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCj4gPlllcywgdGhlIHBhdGNo
IGZvciBzdGcgZG9tYWluIGhhc24ndCBiZWVuIHN1Ym1pdHRlZCB5ZXQuDQo+ID5JbiB0aGlzIGNh
c2Ugc2hvdWxkIEkgZHJvcCB0aGlzIHBhdGNoIGZyb20gdGhlIHNlcmllcyB1bnRpbCB0aGUgcmVs
YXRlZCBwYXRjaGVzDQo+IHJlYWNoIHRoZSBtYWlsaW5nIGxpc3Q/DQo+IA0KPiBTaW5jZSBpdCBk
b2Vzbid0IGFwcGx5IGFueXdheSwgbm8gaGFybSBrZWVwaW5nIGl0IElNTy4NCj4gSGF2aW5nIHRo
ZSBkdHMgY2FuIG1ha2UgaXQgZWFzaWVyLCBhbHRob3VnaCBub3QgaW4gdGhpcyBjYXNlLCB0byBs
b29rIGF0IHRoZQ0KPiBiaW5kaW5nIGFuZCBkcml2ZXIuDQo+IEp1c3QgbWVudGlvbiBpdCBpbiB0
aGUgY292ZXIgbGV0dGVyIGlmL3doZW4geW91IHNlbmQgYW5vdGhlciB2ZXJzaW9uLg0KPiANCg0K
U3VyZSwgSSdsbCBkbyB0aGlzLg0KDQpUaGFua3MsDQpKaWEgSmllDQo=
