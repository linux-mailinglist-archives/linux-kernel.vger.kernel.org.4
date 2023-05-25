Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9222710346
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjEYDWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:22:44 -0400
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 409CFC5;
        Wed, 24 May 2023 20:22:40 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(55639:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Thu, 25 May 2023 11:22:28 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.47; Thu, 25 May 2023 11:22:28 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::b840:bb05:862c:855c]) by
 sphcmbx02.sunplus.com.tw ([fe80::15f8:1252:3f23:8595%12]) with mapi id
 15.00.1497.047; Thu, 25 May 2023 11:22:28 +0800
From:   =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Topic: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Index: AQHZja4A9WmSM0R1vk23IxEYxkRzTK9nwneAgAKNY0A=
Date:   Thu, 25 May 2023 03:22:28 +0000
Message-ID: <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
In-Reply-To: <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.39]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZSAyMy8wNS8yMDIzIMOgIDIxOjM3LCBhbmR5LnNoZXZjaGVua29AZ21haWwuY29tIGEgw6lj
cml0wqA6DQo+ID4gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMDU6Mzk6NTFQTSArMDAwMCwgV2VsbHMg
THUg5ZGC6Iqz6aiwIGtpcmpvaXR0aToNCj4gPj4+PiBGaXggU21hdGNoIHN0YXRpYyBjaGVja2Vy
IHdhcm5pbmc6DQo+ID4+Pj4gcG90ZW50aWFsIG51bGwgZGVyZWZlcmVuY2UgJ2NvbmZpZ3MnLiAo
a21hbGxvYyByZXR1cm5zIG51bGwpDQo+ID4NCj4gPiAuLi4NCj4gPg0KPiA+Pj4+ICAgCQkJY29u
ZmlncyA9IGttYWxsb2Moc2l6ZW9mKCpjb25maWdzKSwgR0ZQX0tFUk5FTCk7DQo+ID4+Pj4gKwkJ
CWlmICghY29uZmlncykNCj4gPj4+DQo+ID4+Pj4gKwkJCQlyZXR1cm4gLUVOT01FTTsNCj4gPj4+
DQo+ID4+PiAiRml4aW5nIiBieSBhZGRpbmcgYSBtZW1vcnkgbGVhayBpcyBub3QgcHJvYmFibHkg
YSBnb29kIGFwcHJvYWNoLg0KPiA+Pg0KPiA+PiBEbyB5b3UgbWVhbiBJIG5lZWQgdG8gZnJlZSBh
bGwgbWVtb3J5IHdoaWNoIGFyZSBhbGxvY2F0ZWQgaW4gdGhpcw0KPiA+PiBzdWJyb3V0aW5lIGJl
Zm9yZSByZXR1cm4gLUVOT01FTT8NCj4gPg0KPiA+IFRoaXMgaXMgbXkgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgY29kZS4gQnV0IGFzIEkgc2FpZC4uLiAoc2VlIGJlbG93KQ0KPiA+DQo+ID4gLi4uDQo+
ID4NCj4gPj4+PiAgIAkJCWNvbmZpZ3MgPSBrbWFsbG9jKHNpemVvZigqY29uZmlncyksIEdGUF9L
RVJORUwpOw0KPiA+Pj4+ICsJCQlpZiAoIWNvbmZpZ3MpDQo+ID4+Pj4gKwkJCQlyZXR1cm4gLUVO
T01FTTsNCj4gPj4+DQo+ID4+PiBEaXR0by4NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+PiBJdCBt
aWdodCBiZSB0aGF0IEknbSBtaXN0YWtlbi4gSW4gdGhpcyBjYXNlIHBsZWFzZSBhZGQgYW4NCj4g
Pj4+IGV4cGxhbmF0aW9uIHdoeSBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBeXl4N
Cj4gPg0KPiANCj4gSG1tbSwgbm90IHNvIHN1cmUuDQo+IA0KPiBTaG91bGQgYmUgbG9va2VkIGF0
IG1vcmUgY2FyZWZ1bGx5LCBidXQNCj4gICAgZHRfdG9fbWFwX29uZV9jb25maWcJCShpbiAvZHJp
dmVycy9waW5jdHJsL2RldmljZXRyZWUuYykNCj4gICAgICAuZHRfbm9kZV90b19tYXANCj4gICAg
ICAgIC0tPiBzcHBjdGxfZHRfbm9kZV90b19tYXANCj4gDQo+IFNob3VsZCBkdF90b19tYXBfb25l
X2NvbmZpZygpIGZhaWwsIHBpbmN0cmxfZHRfZnJlZV9tYXBzKCkgaXMgY2FsbGVkIChzZWUNCj4g
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC1yYzEvc291cmNlL2RyaXZlcnMv
cGluY3RybC9kZXZpY2V0cmVlLmMjTDI4MSkNCj4gDQo+IHBpbmN0cmxfZHRfZnJlZV9tYXBzKCkg
Y2FsbHMgZHRfZnJlZV9tYXAoKSwgd2hpY2ggY2FsbHMgLmR0X2ZyZWVfbWFwLCBzbw0KPiBwaW5j
dHJsX3V0aWxzX2ZyZWVfbWFwKCkNCj4gKHNlZQ0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92Ni40LXJjMS9zb3VyY2UvZHJpdmVycy9waW5jdHJsL3N1bnBsdXMvc3BwY3RsLmMj
TDk3DQo+IDgpDQo+IA0KPiBGaW5hbGx5IHRoZSBuZWVkZWQga2ZyZWUgc2VlbSB0byBiZSBjYWxs
ZWQgZnJvbSBoZXJlLg0KPiAoc2VlDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjQtcmMxL3NvdXJjZS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC11dGlscy5jI0wxMTkNCj4g
KQ0KPiANCj4gDQo+ICpUaGlzIHNob3VsZCBvYnZpb3VzbHkgYmUgZG91YmxlIGNoZWNrZWQqLCBi
dXQgbG9va3Mgc2FmZSB0byBtZS4NCj4gDQo+IA0KPiBCVVQsIGluIHRoZSBzYW1lIGZ1bmN0aW9u
LCB0aGUgb2ZfZ2V0X3BhcmVudCgpIHNob3VsZCBiZSB1bmRvbmUgaW4gY2FzZQ0KPiBvZiBlcnJv
ciwgYXMgZG9uZSBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbiwgaW4gdGhlIG5vcm1hbCBwYXRo
Lg0KPiBUaGlzIG9uZSBzZWVtcyB0byBiZSBtaXNzaW5nLCBzaG91bGQgYSBtZW1vcnkgYWxsb2Nh
dGlvbiBlcnJvciBvY2N1ci4NCj4gDQo+IA0KPiBKdXN0IG15IDJjLA0KPiANCj4gQ0oNCg0KVGhh
bmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KDQpGcm9tIHRoZSByZXBvcnQgb2Yga21lbWxlYWss
IHJldHVybmluZyAtRU5PTUVNIGRpcmVjdGx5IGNhdXNlcyBtZW1vcnkgbGVhay4gV2UgDQpuZWVk
IHRvIGZyZWUgYW55IG1lbW9yeSBhbGxvY2F0ZWQgaW4gdGhpcyBzdWJyb3V0aW5lIGJlZm9yZSBy
ZXR1cm5pbmcgLUVOT01FTS4NCg0KSSdsbCBzZW5kIGEgbmV3IHBhdGNoIHRoYXQgd2lsbCBmcmVl
IHRoZSBhbGxvY2F0ZWQgbWVtb3J5IGFuZCBjYWxsIG9mX25vZGVfcHV0KCkgDQp3aGVuIGFuIGVy
cm9yIGhhcHBlbnMuDQoNCg0KQmVzdCByZWdhcmRzLA0KV2VsbHMgTHUNCg==
