Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667C8711D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbjEZCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjEZCEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:04:41 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3294A3;
        Thu, 25 May 2023 19:04:38 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23310:1:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Fri, 26 May 2023 10:04:23 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.47; Fri, 26 May 2023 10:04:23 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::b840:bb05:862c:855c]) by
 sphcmbx02.sunplus.com.tw ([fe80::15f8:1252:3f23:8595%12]) with mapi id
 15.00.1497.047; Fri, 26 May 2023 10:04:23 +0800
From:   =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: RE: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Topic: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Index: AQHZjzgEDweniQBlI0+p2RKJIg01Hq9rzFlA
Date:   Fri, 26 May 2023 02:04:23 +0000
Message-ID: <ee46e6d5d9a74265915345e2887338a3@sphcmbx02.sunplus.com.tw>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
 <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
 <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
In-Reply-To: <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
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

SGksDQoNCj4gTGUgMjUvMDUvMjAyMyDDoCAwNToyMiwgV2VsbHMgTHUg5ZGC6Iqz6aiwIGEgw6lj
cml0wqA6DQo+ID4+IExlIDIzLzA1LzIwMjMgw6AgMjE6MzcsIGFuZHkuc2hldmNoZW5rb0BnbWFp
bC5jb20gYSDDqWNyaXTCoDoNCj4gPj4+IFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDA1OjM5OjUxUE0g
KzAwMDAsIFdlbGxzIEx1IOWRguiKs+mosCBraXJqb2l0dGk6DQo+ID4+Pj4+PiBGaXggU21hdGNo
IHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+ID4+Pj4+PiBwb3RlbnRpYWwgbnVsbCBkZXJlZmVy
ZW5jZSAnY29uZmlncycuIChrbWFsbG9jIHJldHVybnMgbnVsbCkNCj4gPj4+DQo+ID4+PiAuLi4N
Cj4gPj4+DQo+ID4+Pj4+PiAgICAJCQljb25maWdzID0ga21hbGxvYyhzaXplb2YoKmNvbmZpZ3Mp
LCBHRlBfS0VSTkVMKTsNCj4gPj4+Pj4+ICsJCQlpZiAoIWNvbmZpZ3MpDQo+ID4+Pj4+DQo+ID4+
Pj4+PiArCQkJCXJldHVybiAtRU5PTUVNOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAiRml4aW5nIiBieSBh
ZGRpbmcgYSBtZW1vcnkgbGVhayBpcyBub3QgcHJvYmFibHkgYSBnb29kIGFwcHJvYWNoLg0KPiA+
Pj4+DQo+ID4+Pj4gRG8geW91IG1lYW4gSSBuZWVkIHRvIGZyZWUgYWxsIG1lbW9yeSB3aGljaCBh
cmUgYWxsb2NhdGVkIGluIHRoaXMNCj4gPj4+PiBzdWJyb3V0aW5lIGJlZm9yZSByZXR1cm4gLUVO
T01FTT8NCj4gPj4+DQo+ID4+PiBUaGlzIGlzIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGNvZGUu
IEJ1dCBhcyBJIHNhaWQuLi4gKHNlZSBiZWxvdykNCj4gPj4+DQo+ID4+PiAuLi4NCj4gPj4+DQo+
ID4+Pj4+PiAgICAJCQljb25maWdzID0ga21hbGxvYyhzaXplb2YoKmNvbmZpZ3MpLCBHRlBfS0VS
TkVMKTsNCj4gPj4+Pj4+ICsJCQlpZiAoIWNvbmZpZ3MpDQo+ID4+Pj4+PiArCQkJCXJldHVybiAt
RU5PTUVNOw0KPiA+Pj4+Pg0KPiA+Pj4+PiBEaXR0by4NCj4gPj4+DQo+ID4+PiAuLi4NCj4gPj4+
DQo+ID4+Pj4+IEl0IG1pZ2h0IGJlIHRoYXQgSSdtIG1pc3Rha2VuLiBJbiB0aGlzIGNhc2UgcGxl
YXNlIGFkZCBhbg0KPiA+Pj4+PiBleHBsYW5hdGlvbiB3aHkgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KPiA+Pj4NCj4gPj4+IF5eXg0KPiA+Pj4NCj4gPj4NCj4gPj4gSG1tbSwgbm90IHNvIHN1cmUu
DQo+ID4+DQo+ID4+IFNob3VsZCBiZSBsb29rZWQgYXQgbW9yZSBjYXJlZnVsbHksIGJ1dA0KPiA+
PiAgICAgZHRfdG9fbWFwX29uZV9jb25maWcJCShpbiAvZHJpdmVycy9waW5jdHJsL2RldmljZXRy
ZWUuYykNCj4gPj4gICAgICAgLmR0X25vZGVfdG9fbWFwDQo+ID4+ICAgICAgICAgLS0+IHNwcGN0
bF9kdF9ub2RlX3RvX21hcA0KPiA+Pg0KPiA+PiBTaG91bGQgZHRfdG9fbWFwX29uZV9jb25maWco
KSBmYWlsLCBwaW5jdHJsX2R0X2ZyZWVfbWFwcygpIGlzIGNhbGxlZA0KPiA+PiAoc2VlDQo+ID4+
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjQtcmMxL3NvdXJjZS9kcml2ZXJz
L3BpbmN0cmwvZGV2aQ0KPiA+PiBjZXRyZWUuYyNMMjgxKQ0KPiA+Pg0KPiA+PiBwaW5jdHJsX2R0
X2ZyZWVfbWFwcygpIGNhbGxzIGR0X2ZyZWVfbWFwKCksIHdoaWNoIGNhbGxzIC5kdF9mcmVlX21h
cCwNCj4gPj4gc28NCj4gPj4gcGluY3RybF91dGlsc19mcmVlX21hcCgpDQo+ID4+IChzZWUNCj4g
Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC1yYzEvc291cmNlL2RyaXZl
cnMvcGluY3RybC9zdW5wDQo+ID4+IGx1cy9zcHBjdGwuYyNMOTcNCj4gPj4gOCkNCj4gPj4NCj4g
Pj4gRmluYWxseSB0aGUgbmVlZGVkIGtmcmVlIHNlZW0gdG8gYmUgY2FsbGVkIGZyb20gaGVyZS4N
Cj4gPj4gKHNlZQ0KPiA+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni40LXJj
MS9zb3VyY2UvZHJpdmVycy9waW5jdHJsL3BpbmMNCj4gPj4gdHJsLXV0aWxzLmMjTDExOQ0KPiA+
PiApDQo+ID4+DQo+ID4+DQo+ID4+ICpUaGlzIHNob3VsZCBvYnZpb3VzbHkgYmUgZG91YmxlIGNo
ZWNrZWQqLCBidXQgbG9va3Mgc2FmZSB0byBtZS4NCj4gPj4NCj4gPj4NCj4gPj4gQlVULCBpbiB0
aGUgc2FtZSBmdW5jdGlvbiwgdGhlIG9mX2dldF9wYXJlbnQoKSBzaG91bGQgYmUgdW5kb25lIGlu
DQo+ID4+IGNhc2Ugb2YgZXJyb3IsIGFzIGRvbmUgYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24s
IGluIHRoZSBub3JtYWwgcGF0aC4NCj4gPj4gVGhpcyBvbmUgc2VlbXMgdG8gYmUgbWlzc2luZywg
c2hvdWxkIGEgbWVtb3J5IGFsbG9jYXRpb24gZXJyb3Igb2NjdXIuDQo+ID4+DQo+ID4+DQo+ID4+
IEp1c3QgbXkgMmMsDQo+ID4+DQo+ID4+IENKDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIg
Y29tbWVudHMuDQo+ID4NCj4gPiAgRnJvbSB0aGUgcmVwb3J0IG9mIGttZW1sZWFrLCByZXR1cm5p
bmcgLUVOT01FTSBkaXJlY3RseSBjYXVzZXMgbWVtb3J5DQo+ID4gbGVhay4gV2UgbmVlZCB0byBm
cmVlIGFueSBtZW1vcnkgYWxsb2NhdGVkIGluIHRoaXMgc3Vicm91dGluZSBiZWZvcmUgcmV0dXJu
aW5nIC1FTk9NRU0uDQo+ID4NCj4gPiBJJ2xsIHNlbmQgYSBuZXcgcGF0Y2ggdGhhdCB3aWxsIGZy
ZWUgdGhlIGFsbG9jYXRlZCBtZW1vcnkgYW5kIGNhbGwNCj4gPiBvZl9ub2RlX3B1dCgpIHdoZW4g
YW4gZXJyb3IgaGFwcGVucy4NCj4gDQo+IEhpLA0KPiAoYWRkaW5nIERhbiBpbiBjb3B5IGJlY2F1
c2UgdGhlIGluaXRpYWwgcmVwb3J0IGlzIHJlbGF0ZWQgdG8gc21hdGNoKQ0KPiANCj4gSSBkb24n
dCB1c2Uga21lbWxlYWssIGJ1dCBjb3VsZCB5b3Ugc2hhcmUgc29tZSBpbnB1dCBhYm91dCBpdHMg
cmVwb3J0Pw0KPiANCj4gDQo+IEkndmUgbm90IHJlY2hlY2tlZCBteSBhbmFseXNpcywgYnV0IGl0
IGxvb2tlZCBwcm9taXNpbmcuDQo+IE1heWJlIERhbiBjb3VsZCBhbHNvIGdpdmUgYSBsb29rIGF0
IGl0IGFuZCBjb25maXJtIHlvdXIgZmluZGluZywgb3IgZGlnIGZ1cnRoZXIgd2l0aCBzbWF0Y2gN
Cj4gdG8gbWFrZSBzdXJlIHRoYXQgaXRzIHN0YXRpYyBhbmFseXNpcyB3YXMgY29tcGxldGUgZW5v
dWdoLg0KPiANCj4gQ0oNCg0KSSBmb3JjZWQgc3BwY3RsX2R0X25vZGVfdG9fbWFwKCkgdG8gYWx3
YXlzIHJldHVybiAtRU5PTUVNIHdoZW4gaXQgY29uZmlncyBHUElPIHBpbnMuIA0KSGVyZSBpcyB0
aGUgcmVwb3J0IG9mIGttZW1sZWFrOg0KDQp+ICMgZWNobyBzY2FuID4gL3N5cy9rZXJuZWwvZGVi
dWcva21lbWxlYWsNClsgICAgOS4xMzY0NjRdIGttZW1sZWFrOiAyIG5ldyBzdXNwZWN0ZWQgbWVt
b3J5IGxlYWtzIChzZWUgL3N5cy9rZXJuZWwvZGVidWcva21lbWxlYWspDQp+ICMgDQp+ICMgY2F0
IC9zeXMva2VybmVsL2RlYnVnL2ttZW1sZWFrDQp1bnJlZmVyZW5jZWQgb2JqZWN0IDB4YzI4NTJl
MDAgKHNpemUgNjQpOg0KICBjb21tICJrd29ya2VyL3U4OjMiLCBwaWQgMzYsIGppZmZpZXMgNDI5
NDkzNzMxMiAoYWdlIDEzLjYxMHMpDQogIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQogICAg
MDAgMDAgMDAgMDAgMTQgN2MgZmYgZGYgMDMgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIC4uLi4ufC4u
Li4uLi4uLi4NCiAgICBjNCA4ZiAzYSBjMCAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAgLi46Li4uLi4uLi4uLi4uLg0KICBiYWNrdHJhY2U6DQogICAgWzwocHRydmFsKT5dIHNs
YWJfcG9zdF9hbGxvY19ob29rLmNvbnN0cHJvcC4xNisweDRiLzB4NTINCiAgICBbPChwdHJ2YWwp
Pl0gX19rbWVtX2NhY2hlX2FsbG9jX25vZGUrMHg1Ny8weDc4DQogICAgWzwocHRydmFsKT5dIF9f
a21hbGxvYysweDMzLzB4M2ENCiAgICBbPChwdHJ2YWwpPl0gc3BwY3RsX2R0X25vZGVfdG9fbWFw
KzB4NzcvMHgzY2MNCiAgICBbPChwdHJ2YWwpPl0gcGluY3RybF9kdF90b19tYXArMHgxNmYvMHgy
MGUNCiAgICBbPChwdHJ2YWwpPl0gY3JlYXRlX3BpbmN0cmwrMHgzZC8weDIyNA0KICAgIFs8KHB0
cnZhbCk+XSBkZXZtX3BpbmN0cmxfZ2V0KzB4MjMvMHg1MA0KICAgIFs8KHB0cnZhbCk+XSBwaW5j
dHJsX2JpbmRfcGlucysweDMxLzB4MTkwDQogICAgWzwocHRydmFsKT5dIHJlYWxseV9wcm9iZSsw
eDg5LzB4MjNlDQogICAgWzwocHRydmFsKT5dIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDEzMS8w
eDE2NA0KICAgIFs8KHB0cnZhbCk+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MmQvMHg4OA0KICAg
IFs8KHB0cnZhbCk+XSBfX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4OGQvMHhhNA0KICAgIFs8KHB0
cnZhbCk+XSBidXNfZm9yX2VhY2hfZHJ2KzB4NjMvMHg3Mg0KICAgIFs8KHB0cnZhbCk+XSBfX2Rl
dmljZV9hdHRhY2grMHg4OS8weGUyDQogICAgWzwocHRydmFsKT5dIGJ1c19wcm9iZV9kZXZpY2Ur
MHgxZi8weDVhDQogICAgWzwocHRydmFsKT5dIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweDY5
LzB4ODgNCnVucmVmZXJlbmNlZCBvYmplY3QgMHhjMjg1MmRjMCAoc2l6ZSA2NCk6DQogIGNvbW0g
Imt3b3JrZXIvdTg6MyIsIHBpZCAzNiwgamlmZmllcyA0Mjk0OTM3MzEyIChhZ2UgMTMuNjEwcykN
CiAgaGV4IGR1bXAgKGZpcnN0IDMyIGJ5dGVzKToNCiAgICAwMSAwNSAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLg0KICAgIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDU0IDQ0IDAwIDAwIDAwIDAwIDAwIDAyICAuLi4uLi4uLlRELi4uLi4u
DQogIGJhY2t0cmFjZToNCiAgICBbPChwdHJ2YWwpPl0gc2xhYl9wb3N0X2FsbG9jX2hvb2suY29u
c3Rwcm9wLjE2KzB4NGIvMHg1Mg0KICAgIFs8KHB0cnZhbCk+XSBfX2ttZW1fY2FjaGVfYWxsb2Nf
bm9kZSsweDU3LzB4NzgNCiAgICBbPChwdHJ2YWwpPl0ga21hbGxvY190cmFjZSsweDExLzB4MTYN
CiAgICBbPChwdHJ2YWwpPl0gc3BwY3RsX2R0X25vZGVfdG9fbWFwKzB4MTRiLzB4M2NjDQogICAg
WzwocHRydmFsKT5dIHBpbmN0cmxfZHRfdG9fbWFwKzB4MTZmLzB4MjBlDQogICAgWzwocHRydmFs
KT5dIGNyZWF0ZV9waW5jdHJsKzB4M2QvMHgyMjQNCiAgICBbPChwdHJ2YWwpPl0gZGV2bV9waW5j
dHJsX2dldCsweDIzLzB4NTANCiAgICBbPChwdHJ2YWwpPl0gcGluY3RybF9iaW5kX3BpbnMrMHgz
MS8weDE5MA0KICAgIFs8KHB0cnZhbCk+XSByZWFsbHlfcHJvYmUrMHg4OS8weDIzZQ0KICAgIFs8
KHB0cnZhbCk+XSBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHgxMzEvMHgxNjQNCiAgICBbPChwdHJ2
YWwpPl0gZHJpdmVyX3Byb2JlX2RldmljZSsweDJkLzB4ODgNCiAgICBbPChwdHJ2YWwpPl0gX19k
ZXZpY2VfYXR0YWNoX2RyaXZlcisweDhkLzB4YTQNCiAgICBbPChwdHJ2YWwpPl0gYnVzX2Zvcl9l
YWNoX2RydisweDYzLzB4NzINCiAgICBbPChwdHJ2YWwpPl0gX19kZXZpY2VfYXR0YWNoKzB4ODkv
MHhlMg0KICAgIFs8KHB0cnZhbCk+XSBidXNfcHJvYmVfZGV2aWNlKzB4MWYvMHg1YQ0KICAgIFs8
KHB0cnZhbCk+XSBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMrMHg2OS8weDg4DQp+ICMNCg0KDQpC
ZXN0IHJlZ2FyZHMsDQpXZWxscyBMdQ0KDQo=
