Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40487685F31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBAFsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBAFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:48:17 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD64B76A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:48:08 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 17DB324E203;
        Wed,  1 Feb 2023 13:48:05 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 13:48:04 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 13:48:04 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 1 Feb 2023 13:48:04 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v3 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Topic: [PATCH v3 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Index: AQHZMi9WxT1gIxNRXUer5+u3a86Dx663AUwAgACtmgCAAe0oYA==
Date:   Wed, 1 Feb 2023 05:48:04 +0000
Message-ID: <27844cccf1894529a75106edeb7026bb@EXMBX066.cuchost.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-4-jeeheng.sia@starfivetech.com>
 <Y9g9XGzF/X3OwXdP@spud>
 <CAHVXubh2P5TxdMsbW2TY7NxemSFX81UuvgO9schnTEBvzuAn2Q@mail.gmail.com>
In-Reply-To: <CAHVXubh2P5TxdMsbW2TY7NxemSFX81UuvgO9schnTEBvzuAn2Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEdoaXRp
IDxhbGV4Z2hpdGlAcml2b3NpbmMuY29tPg0KPiBTZW50OiBUdWVzZGF5LCAzMSBKYW51YXJ5LCAy
MDIzIDQ6MTkgUE0NCj4gVG86IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj4gQ2M6
IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgcGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsg
bGludXgtDQo+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPjsgTWFz
b24gSHVvDQo+IDxtYXNvbi5odW9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAzLzRdIFJJU0MtVjogbW06IEVuYWJsZSBodWdlIHBhZ2Ugc3VwcG9ydCB0byBrZXJu
ZWxfcGFnZV9wcmVzZW50KCkgZnVuY3Rpb24NCj4gDQo+IEhpLA0KPiANCj4gT24gTW9uLCBKYW4g
MzAsIDIwMjMgYXQgMTA6NTcgUE0gQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPiB3cm90
ZToNCj4gPg0KPiA+ICtDQyBBbGV4DQo+ID4NCj4gPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCAw
NToxMDo1MFBNICswODAwLCBTaWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4gPiBDdXJyZW50bHkga2Vy
bmVsX3BhZ2VfcHJlc2VudCgpIGZ1bmN0aW9uIGRvZXNuJ3Qgc3VwcG9ydCBodWdlIHBhZ2UNCj4g
PiA+IGRldGVjdGlvbiBjYXVzZXMgdGhlIGZ1bmN0aW9uIHRvIG1pc3Rha2VubHkgcmV0dXJuIGZh
bHNlIHRvIHRoZQ0KPiA+ID4gaGliZXJuYXRpb24gY29yZS4NCj4gPg0KPiA+IFRoaXMgc291bmRz
IGxpa2UgYSBidWcgJiBzaG91bGQgaGF2ZSBhIGZpeGVzIHRhZywgbm8/IEkgYXNzdW1lIGZvcg0K
PiA+IHdoYXRldmVyIGNvbW1pdCBlbmFibGVkIGh1Z2UgcGFnZSBzdXBwb3J0Li4uDQo+ID4gV2Ug
ZG9uJ3Qgc3VwcG9ydCBzZXRfbWVtb3J5LCB3aGljaCBieSB0aGUgbG9va3Mgb2YgdGhpbmdzIGlz
IHRoZSBvdGhlcg0KPiA+IHVzZWNhc2UgZm9yIHRoaXMgZnVuY3Rpb24sIHNvIHByb2JhYmx5IGRv
ZXNuJ3QgbmVlZCBiYWNrcG9ydGluZy4NCj4gDQo+IE1heWJlIGFkZCB0aGlzIHBhdGNoIGluIHRo
ZSBGaXhlcyB0YWc6IGNvbW1pdCA5ZTk1M2NkYTVjZGYgKCJyaXNjdjoNCj4gSW50cm9kdWNlIGh1
Z2UgcGFnZSBzdXBwb3J0IGZvciAzMi82NGJpdCBrZXJuZWwiKS4NClN1cmUsIHdpbGwgYWRkIHRo
ZSBmaXhlcyB0YWcuDQo+IA0KPiA+DQo+ID4gQWxleCwgZG9lcyB0aGlzIGNoYW5nZSBsb29rIGdv
b2QgdG8geW91Pw0KPiANCj4gWWVzLCBqdXN0IG9uZSB0aGluZyB0aG91Z2g6IHdoYXQgYWJvdXQg
YSBwZ2RfbGVhZigpIHRlc3Q/IEV2ZW4gaWYgdmVyeQ0KPiB1bmxpa2VseSAoSSBzZWUgeDg2IGRv
ZXMgbm90IGV2ZW4gdGVzdCBpdCksIHRoZSBwcml2aWxlZ2VkIHNwZWMgc3RhdGVzDQo+IGl0IGlz
IHBvc3NpYmxlIHRvIGhhdmUgYSAyNTZUQiBwYWdlLg0KSSBjYW4gYWRkIGl0IGluLiBCdXQgYXMg
eW91IGFyZSBwcm9iYWJseSBhd2FyZSB0aGF0IHg4NiBhbmQgQVJNIGRvbid0IGV2ZW4gdGVzdGVk
IGl0LiBUaGFua3MuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBBbGV4DQo+IA0KPiA+DQo+ID4gPiBB
ZGQgaHVnZSBwYWdlIGRldGVjdGlvbiB0byB0aGUgZnVuY3Rpb24gdG8gc29sdmUgdGhlIHByb2Js
ZW0uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2lhIEplZSBIZW5nIDxqZWVoZW5nLnNp
YUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5
Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBNYXNvbiBIdW8g
PG1hc29uLmh1b0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9yaXNj
di9tbS9wYWdlYXR0ci5jIHwgNiArKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vcGFnZWF0
dHIuYyBiL2FyY2gvcmlzY3YvbW0vcGFnZWF0dHIuYw0KPiA+ID4gaW5kZXggODZjNTY2MTZlNWRl
Li43OTJiOGQxMGNkZmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3Jpc2N2L21tL3BhZ2VhdHRy
LmMNCj4gPiA+ICsrKyBiL2FyY2gvcmlzY3YvbW0vcGFnZWF0dHIuYw0KPiA+ID4gQEAgLTIyMSwx
NCArMjIxLDIwIEBAIGJvb2wga2VybmVsX3BhZ2VfcHJlc2VudChzdHJ1Y3QgcGFnZSAqcGFnZSkN
Cj4gPiA+ICAgICAgIHA0ZCA9IHA0ZF9vZmZzZXQocGdkLCBhZGRyKTsNCj4gPiA+ICAgICAgIGlm
ICghcDRkX3ByZXNlbnQoKnA0ZCkpDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gPiA+ICsgICAgIGlmIChwNGRfbGVhZigqcDRkKSkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIHRydWU7DQo+ID4gPg0KPiA+ID4gICAgICAgcHVkID0gcHVkX29mZnNldChwNGQsIGFkZHIp
Ow0KPiA+ID4gICAgICAgaWYgKCFwdWRfcHJlc2VudCgqcHVkKSkNCj4gPiA+ICAgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgaWYgKHB1ZF9sZWFmKCpwdWQpKQ0KPiA+ID4g
KyAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiA+DQo+ID4gPiAgICAgICBwbWQgPSBwbWRf
b2Zmc2V0KHB1ZCwgYWRkcik7DQo+ID4gPiAgICAgICBpZiAoIXBtZF9wcmVzZW50KCpwbWQpKQ0K
PiA+ID4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArICAgICBpZiAocG1kX2xl
YWYoKnBtZCkpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ID4NCj4gPiA+
ICAgICAgIHB0ZSA9IHB0ZV9vZmZzZXRfa2VybmVsKHBtZCwgYWRkcik7DQo+ID4gPiAgICAgICBy
ZXR1cm4gcHRlX3ByZXNlbnQoKnB0ZSk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4gPg0K
