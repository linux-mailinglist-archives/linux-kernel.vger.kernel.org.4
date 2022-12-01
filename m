Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFC63EBDC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLAJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLAJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:02:08 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1E47336;
        Thu,  1 Dec 2022 01:02:05 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6D70224E255;
        Thu,  1 Dec 2022 17:01:58 +0800 (CST)
Received: from EXMBX064.cuchost.com (172.16.6.64) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 17:01:58 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX064.cuchost.com
 (172.16.6.64) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 17:01:57 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Thu, 1 Dec 2022 17:01:58 +0800
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
Thread-Index: AQHZBH/2P5dLP9b8iUC7OZp9LCFzsa5W7gcAgAHFddA=
Date:   Thu, 1 Dec 2022 09:01:58 +0000
Message-ID: <aa388c8c99b74436ad556aeb47a5c60a@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
 <8a8f502e-e0ed-d638-0b56-74edcbca2134@linaro.org>
In-Reply-To: <8a8f502e-e0ed-d638-0b56-74edcbca2134@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDMwLCAyMDIyIDk6MjEgUE0NCj4gVG86IEppYUppZSBIbyA8amlhamllLmhvQHN0
YXJmaXZldGVjaC5jb20+OyBIZXJiZXJ0IFh1DQo+IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcu
YXU+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDUvNl0gZHQtYmluZGluZ3M6IGNyeXB0bzogQWRkIGJpbmRpbmdzIGZvciBTdGFy
Zml2ZSBjcnlwdG8NCj4gZHJpdmVyDQo+IA0KPiBPbiAzMC8xMS8yMDIyIDA2OjUyLCBKaWEgSmll
IEhvIHdyb3RlOg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIFN0YXJmaXZlIGNy
eXB0byBkcml2ZXIgYmluZGluZ3MuDQo+IA0KPiBQbGVhc2Ugd3JhcCBjb21taXQgbWVzc2FnZSBh
Y2NvcmRpbmcgdG8gTGludXggY29kaW5nIHN0eWxlIC8gc3VibWlzc2lvbg0KPiBwcm9jZXNzOg0K
PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xOC0NCj4gcmM0L3NvdXJjZS9E
b2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCNMNTg2DQo+IA0KPiAN
Cj4gU3ViamVjdDogZHJvcCBzZWNvbmQsIHJlZHVuZGFudCAiYmluZGluZ3MiLg0KPiANCj4gDQoN
CkknbGwgZml4IHRoZSBjb21taXQgdGl0bGUgYW5kIG1lc3NhZ2UgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEppZSBIbyA8amlhamllLmhvQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhbiBGZW5nIDxodWFuLmZlbmdAc3Rh
cmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2NyeXB0by9zdGFyZml2
ZS1jcnlwdG8ueWFtbCAgICAgIHwgMTA5ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9zdGFyZml2ZS1jcnlwdG8u
eWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2NyeXB0by9zdGFyZml2ZS1jcnlwdG8ueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9zdGFyZml2ZS1jcnlwdG8ueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42Yjg1MmY3NzRjMzIN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2NyeXB0by9zdGFyZml2ZS1jcnlwdG8ueWFtbA0KPiANCj4gRmlsZW5hbWUgYmFzZWQg
b24gY29tcGF0aWJsZSwgc28gc3RhcmZpdmUsamg3MTEwLWNyeXB0by55YW1sDQo+IA0KDQpXaWxs
IHVwZGF0ZSBmaWxlbmFtZS4NCg0KPiA+IEBAIC0wLDAgKzEsMTA5IEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAx
LjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY3J5
cHRvL3N0YXJmaXZlLWNyeXB0by55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBTdGFyRml2
ZSBDcnlwdG8gQ29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KPiANCj4gRHJvcCAiRGV2
aWNlIFRyZWUgQmluZGluZ3MiDQo+IA0KDQpXaWxsIHVwZGF0ZSB0aXRsZS4NCg0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKaWEgSmllIEhvIDxqaWFqaWUuaG9Ac3RhcmZpdmV0
ZWNoLmNvbT4NCj4gPiArICAtIFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsg
ICAgY29uc3Q6IHN0YXJmaXZlLGpoNzExMC1jcnlwdG8NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcmVnLW5hbWVzOg0KPiA+ICsgICAgaXRl
bXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHNlY3JlZw0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHJl
Zy1uYW1lcyBmb3Igb25lIGVudHJ5Pw0KPiANCg0KV2lsbCByZW1vdmUgbmVlZCBvZiByZWctbmFt
ZXMgYW5kIHVwZGF0ZSBwcm9iZSBmdW5jdGlvbiBhY2NvcmRpbmdseS4NCg0KPiA+ICsNCj4gPiAr
ICBjbG9ja3M6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSGFy
ZHdhcmUgcmVmZXJlbmNlIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFIQiByZWZl
cmVuY2UgY2xvY2sNCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBpdGVtczoN
Cj4gPiArICAgICAgLSBjb25zdDogc2VjX2hjbGsNCj4gPiArICAgICAgLSBjb25zdDogc2VjX2Fo
Yg0KPiANCj4gc2VjIHNlZW1zIHJlZHVuZGFudCwgc28ganVzdCAiYWhiIi4gVGhlIGZpcnN0IGNs
b2NrIHRoZW4gImhjbGsiIG9yICJyZWYiPw0KPiANCg0KV2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9u
Lg0KDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAg
ICAgLSBkZXNjcmlwdGlvbjogSW50ZXJydXB0IHBpbiBmb3IgYWxnbyBjb21wbGV0aW9uDQo+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IEludGVycnVwdCBwaW4gZm9yIERNQSB0cmFuc2ZlciBjb21w
bGV0aW9uDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdC1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAtIGNvbnN0OiBzZWNpcnENCj4gPiArICAgICAgLSBjb25zdDogZG1haXJxDQo+
IA0KPiBEcm9wICJpcnEiIGZyb20gYm90aC4NCj4gDQoNCldpbGwgZml4Lg0KDQo+ID4gKw0KPiA+
ICsgIHJlc2V0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBT
VEcgZG9tYWluIHJlc2V0IGxpbmUNCj4gPiArDQo+ID4gKyAgcmVzZXQtbmFtZXM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogc2VjX2hyZQ0KPiANCj4gRHJvcCAic2VjIi4g
V2h5IGRvIHlvdSBuZWVkIHRoZSBuYW1lcyBmb3Igb25lIGVudHJ5Pw0KPiANCg0KV2lsbCByZW1v
dmUgbmFtZXMuDQoNCj4gPiArDQo+ID4gKyAgZW5hYmxlLXNpZGUtY2hhbm5lbC1taXRpZ2F0aW9u
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IEVuYWJsZSBzaWRlLWNoYW5uZWwtbWl0aWdhdGlvbiBm
ZWF0dXJlIGZvciBBRVMgbW9kdWxlLg0KPiA+ICsgICAgICAgIEVuYWJsaW5nIHRoaXMgZmVhdHVy
ZSB3aWxsIGFmZmVjdCB0aGUgc3BlZWQgcGVyZm9ybWFuY2Ugb2YNCj4gPiArICAgICAgICBjcnlw
dG8gZW5naW5lLg0KPiA+ICsgICAgdHlwZTogYm9vbGVhbg0KPiANCj4gV2h5IGV4YWN0bHkgdGhp
cyBpcyBhIGhhcmR3YXJlIChEVCkgcHJvcGVydHksIG5vdCBydW50aW1lPw0KPiANCg0KVGhpcyBp
cyBhIGhhcmR3YXJlIHNldHRpbmcgcHJvdmlkZWQgaW4gU3RhckZpdmUgY3J5cHRvIGVuZ2luZSBv
bmx5Lg0KVGhlIGNyeXB0byBBUEkgZG9lc24ndCBjb250cm9sIHRoaXMgc2V0dGluZyBkdXJpbmcg
cnVudGltZSBhbmQgbGVhdmluZyB0aGlzIGFsd2F5cyBvbiB3aWxsIGltcGFjdCBzcGVlZCBwZXJm
b3JtYW5jZS4NClNvLCBJIGFkZGVkIHRoaXMgcHJvcGVydHkgdG8gYWxsb3cgdXNlciB0byBjb250
cm9sIHRoaXMgaW4gZHRiLg0KDQo+ID4gKw0KPiA+ICsgIGVuYWJsZS1kbWE6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjogRW5hYmxlIGRhdGEgdHJhbnNmZXIgdXNpbmcgZGVkaWNhdGVkIERNQSBjb250
cm9sbGVyLg0KPiA+ICsgICAgdHlwZTogYm9vbGVhbg0KPiANCj4gVXN1YWxseSB0aGUgcHJlc2Vu
Y2Ugb2YgZG1hcyBpbmRpY2F0ZXMgd2hldGhlciB0byB1c2Ugb3Igbm90IHRvIHVzZSBETUEuDQo+
IERvIHlvdSBleHBlY3QgYSBjYXNlIHdoZXJlIERNQSBjaGFubmVscyBhcmUgcHJvdmlkZWQgYnkg
eW91IGRvbid0IHdhbnQNCj4gRE1BPyBFeHBsYWluIHN1Y2ggY2FzZSBhbmQgZGVzY3JpYmUgd2h5
IGl0IGlzIGEgaGFyZHdhcmUvc3lzdGVtIGludGVncmF0aW9uDQo+IHByb3BlcnR5Lg0KPiANCg0K
SSdsbCByZW1vdmUgdGhpcyBwcm9wZXJ0eSBhcyBETUEgaXMgYWx3YXlzIGVuYWJsZWQuDQoNCj4g
PiArDQo+ID4gKyAgZG1hczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBUWCBETUEgY2hhbm5lbA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSWCBETUEgY2hh
bm5lbA0KPiA+ICsNCj4gPiArICBkbWEtbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAg
ICAgLSBjb25zdDogc2VjX20NCj4gDQo+IHR4DQo+IA0KDQpXaWxsIGZpeC4NCg0KPiA+ICsgICAg
ICAtIGNvbnN0OiBzZWNfcA0KPiANCj4gcngNCj4gDQoNCldpbGwgZml4Lg0KDQo+ID4gKw0KPiA+
ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0g
cmVnLW5hbWVzDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAg
LSByZXNldHMNCj4gPiArICAtIHJlc2V0LW5hbWVzDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJv
cGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLWpoNzExMC5oPg0KPiA+ICsg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jlc2V0L3N0YXJmaXZlLWpoNzExMC5oPg0KPiA+ICsN
Cj4gPiArICAgIHNvYyB7DQo+ID4gKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
PiA+ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gDQo+IFVzZSA0IHNwYWNlcyBm
b3IgZXhhbXBsZSBpbmRlbnRhdGlvbi4NCg0KSSdsbCBmaXggdGhlIGluZGVudGF0aW9uLg0KDQpU
aGFuayB5b3UgZm9yIHRha2luZyB0aW1lIHRvIHJldmlldyBhbmQgcHJvdmlkZSBoZWxwZnVsIGNv
bW1lbnRzIGZvciB0aGlzIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpKaWEgSmllDQo=
