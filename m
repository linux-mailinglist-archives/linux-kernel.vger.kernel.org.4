Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF269783C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjBOIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBOIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:34:19 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D01714
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:34:17 -0800 (PST)
Received: from canpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PGrs931PWzRs49;
        Wed, 15 Feb 2023 16:31:41 +0800 (CST)
Received: from canpemm500010.china.huawei.com (7.192.105.118) by
 canpemm100009.china.huawei.com (7.192.105.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 16:34:14 +0800
Received: from canpemm500010.china.huawei.com ([7.192.105.118]) by
 canpemm500010.china.huawei.com ([7.192.105.118]) with mapi id 15.01.2507.017;
 Wed, 15 Feb 2023 16:34:14 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     John Stultz <jstultz@google.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: RE: [Question] softlockup in run_timer_softirq
Thread-Topic: [Question] softlockup in run_timer_softirq
Thread-Index: AQHZP+XzD5YJ48ci7USTV771E31fma7PkEww
Date:   Wed, 15 Feb 2023 08:34:14 +0000
Message-ID: <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com>
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
 <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
In-Reply-To: <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBTdHVsdHogW21h
aWx0bzpqc3R1bHR6QGdvb2dsZS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDE0LCAy
MDIzIDQ6MDEgQU0NCj4gVG86IGxpdWppYW4gKENFKSA8bGl1amlhbjU2QGh1YXdlaS5jb20+DQo+
IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7IHNib3lkQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHBldGVyekBpbmZyYWRlYWQub3JnOyBQYXVsIEUuIE1jS2VubmV5
IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUXVlc3Rpb25dIHNvZnRsb2Nr
dXAgaW4gcnVuX3RpbWVyX3NvZnRpcnENCj4gDQo+IE9uIEZyaSwgRmViIDEwLCAyMDIzIGF0IDE6
NTEgQU0gbGl1amlhbiAoQ0UpIDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBEdXJpbmcgdGhlIHN5eiB0ZXN0LCB3ZSBlbmNvdW50ZXJlZCBtYW55IHByb2JsZW1zIHdpdGgg
dmFyaW91cyB0aW1lcg0KPiA+IGhhbmRsZXIgZnVuY3Rpb25zIHNvZnRsb2NrdXAuDQo+ID4NCj4g
PiBXZSBhbmFseXplIF9fcnVuX3RpbWVycygpIGFuZCBmaW5kIHRoZSBmb2xsb3dpbmcgcHJvYmxl
bS4NCj4gPg0KPiA+IEluIHRoZSB3aGlsZSBsb29wIG9mIF9fcnVuX3RpbWVycygpLCBiZWNhdXNl
IHRoZXJlIGFyZSB0b28gbWFueSB0aW1lcnMNCj4gPiBvciBpbXByb3BlciB0aW1lciBoYW5kbGVy
IGZ1bmN0aW9ucywgaWYgdGhlIHByb2Nlc3NpbmcgdGltZSBvZiB0aGUNCj4gPiBleHBpcmVkIHRp
bWVycyBpcyBhbHdheXMgZ3JlYXRlciB0aGFuIHRoZSB0aW1lIHdoZWVsJ3MgbmV4dF9leHBpcnks
DQo+ID4gdGhlIGZ1bmN0aW9uIHdpbGwgbG9vcCBpbmZpbml0ZWx5Lg0KPiA+DQo+ID4gVGhlIGZv
bGxvd2luZyBleHRyZW1lIHRlc3QgY2FzZSBjYW4gYmUgdXNlZCB0byByZXByb2R1Y2UgdGhlIHBy
b2JsZW0uDQo+ID4gQW4gZXh0cmVtZSB0ZXN0IGNhc2VbMV0gaXMgY29uc3RydWN0ZWQgdG8gcmVw
cm9kdWNlIHRoZSBwcm9ibGVtLg0KPiANCj4gVGhhbmtzIGZvciByZXBvcnRpbmcgYW5kIHNlbmRp
bmcgb3V0IHRoaXMgZGF0YToNCj4gDQo+IEZpcnN0LCBhbnkgY2hhbmNlIHlvdSBtaWdodCBzdWJt
aXQgdGhpcyBhcyBhIGluLWtlcm5lbC1zdHJlc3MgdGVzdD8NCj4gTWF5YmUgdXRpbGl6aW5nIHRo
ZSBrZXJuZWwvdG9ydHVyZS5jIGZyYW1ld29yaz8NCj4gDQpPa2F5LCAgIEknbGwgbGVhcm4gdGhp
cyBmcmFtZXdvcmsgYW5kIGRvIHRoaXMgdGhpbmcuDQo+IChUaG91Z2ggdGhlIHRlc3QgbWF5IG5l
ZWQgdG8gb2NjYXNpb25hbGx5IHRha2UgYSBicmVhayBzbyB0aGUgc3lzdGVtIGNhbg0KPiBldmVu
dHVhbGx5IGNhdGNoIHVwKQ0KPiANCj4gPiBJcyB0aGlzIGEgcHJvYmxlbSBvciBhbiB1bnJlYXNv
bmFibGUgdXNlPw0KPiA+DQo+ID4gQ2FuIHdlIGxpbWl0IHRoZSBydW5uaW5nIHRpbWUgb2YgX19y
dW5fdGltZXJzKCkgWzJdPw0KPiA+DQo+ID4gRG9lcyBhbnlvbmUgaGF2ZSBhIGdvb2QgaWRlYSB0
byBzb2x2ZSB0aGlzIHByb2JsZW0/DQo+IA0KPiBTbyB5b3VyIHBhdGNoIHJlbWluZHMgbWUgb2Yg
UGV0ZXIncyBzb2Z0aXJxX25lZWRzX2JyZWFrKCkgbG9naWM6DQo+IA0KPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZXRlcnovcXVldWUuZ2l0L2xvZy8/
aD1jbw0KPiByZS9zb2Z0aXJxDQo+IA0KPiBNYXliZSBpdCBjb3VsZCBleHRlbmQgdGhhdCBzZXJp
ZXMgZm9yIHRoZSB0aW1lciBzb2Z0aXJxIGFzIHdlbGw/DQo+IA0KVGhhbmsgeW91LiBZZXMuDQpC
YXNlIG9uIHRoZSBwYXRjaHNldCBhbmQgdGhlIGV4dGVuZGVkIHBhdGNoIGZvciB0aW1lciBbMV0s
IHRoZSBzb2Z0IGxvY2t1cCBwcm9ibGVtIGRvZXMgbm90IG9jY3VyLg0KDQpCeSB0aGUgd2F5LCBJ
IHNlZSB0aGlzIGlzIGEgdmVyeSBvbGQgcGF0Y2hzZXQ/ICBXaWxsIHRoaXMgcGF0Y2hzZXQgcHVz
aCB0aGUgbWFpbiBsaW5lPyBASm9obiBAUGV0ZXINCg0KDQogWzFdDQpBdXRob3I6IExpdSBKaWFu
IDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4NCkRhdGU6ICAgVHVlIEZlYiAxNCAwOTo1Mzo0NiAyMDIz
ICswODAwDQoNCiAgICBzb2Z0aXJxLCB0aW1lcjogVXNlIHNvZnRpcnFfbmVlZHNfYnJlYWsoKQ0K
ICAgIA0KICAgIEluIHRoZSB3aGlsZSBsb29wIG9mIF9fcnVuX3RpbWVycygpLCBiZWNhdXNlIHRo
ZXJlIGFyZSB0b28gbWFueSB0aW1lcnMgb3INCiAgICBpbXByb3BlciB0aW1lciBoYW5kbGVyIGZ1
bmN0aW9ucywgaWYgdGhlIHByb2Nlc3NpbmcgdGltZSBvZiB0aGUgZXhwaXJlZA0KICAgIHRpbWVy
cyBpcyBhbHdheXMgZ3JlYXRlciB0aGFuIHRoZSB0aW1lIHdoZWVsJ3MgbmV4dF9leHBpcnksIHRo
ZSBmdW5jdGlvbg0KICAgIHdpbGwgbG9vcCBpbmZpbml0ZWx5Lg0KICAgIA0KICAgIFRvIHByZXZl
bnQgdGhpcywgdXNlIHRoZSB0aW1lb3V0L2JyZWFrIGxvZ2ljIHByb3ZpZGVkIGJ5IFNvZnRJUlFz
LklmIHRoZQ0KICAgIHJ1bm5pbmcgdGltZSBleGNlZWRzIHRoZSBsaW1pdCwgYnJlYWsgdGhlIGxv
b3AgYW5kIGFuIGFkZGl0aW9uYWwNCiAgICBUSU1FUl9TT0ZUSVJRIGlzIHRyaWdnZXJlZC4NCiAg
ICANCiAgICBTaWduZWQtb2ZmLWJ5OiBMaXUgSmlhbiA8bGl1amlhbjU2QGh1YXdlaS5jb20+DQoN
CmRpZmYgLS1naXQgYS9rZXJuZWwvdGltZS90aW1lci5jIGIva2VybmVsL3RpbWUvdGltZXIuYw0K
aW5kZXggNjNhOGNlNzE3N2RkLi43MDc0NGE0NjlhMzkgMTAwNjQ0DQotLS0gYS9rZXJuZWwvdGlt
ZS90aW1lci5jDQorKysgYi9rZXJuZWwvdGltZS90aW1lci5jDQpAQCAtMTk5Miw3ICsxOTkyLDcg
QEAgdm9pZCB0aW1lcl9jbGVhcl9pZGxlKHZvaWQpDQogICogX19ydW5fdGltZXJzIC0gcnVuIGFs
bCBleHBpcmVkIHRpbWVycyAoaWYgYW55KSBvbiB0aGlzIENQVS4NCiAgKiBAYmFzZTogdGhlIHRp
bWVyIHZlY3RvciB0byBiZSBwcm9jZXNzZWQuDQogICovDQotc3RhdGljIGlubGluZSB2b2lkIF9f
cnVuX3RpbWVycyhzdHJ1Y3QgdGltZXJfYmFzZSAqYmFzZSkNCitzdGF0aWMgaW5saW5lIHZvaWQg
X19ydW5fdGltZXJzKHN0cnVjdCB0aW1lcl9iYXNlICpiYXNlLCBzdHJ1Y3Qgc29mdGlycV9hY3Rp
b24gKmgpDQogew0KICAgICAgICBzdHJ1Y3QgaGxpc3RfaGVhZCBoZWFkc1tMVkxfREVQVEhdOw0K
ICAgICAgICBpbnQgbGV2ZWxzOw0KQEAgLTIwMjAsNiArMjAyMCwxMiBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgX19ydW5fdGltZXJzKHN0cnVjdCB0aW1lcl9iYXNlICpiYXNlKQ0KIA0KICAgICAgICAg
ICAgICAgIHdoaWxlIChsZXZlbHMtLSkNCiAgICAgICAgICAgICAgICAgICAgICAgIGV4cGlyZV90
aW1lcnMoYmFzZSwgaGVhZHMgKyBsZXZlbHMpOw0KKw0KKyAgICAgICAgICAgICAgIGlmIChzb2Z0
aXJxX25lZWRzX2JyZWFrKGgpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBpZiAodGltZV9h
ZnRlcl9lcShqaWZmaWVzLCBiYXNlLT5uZXh0X2V4cGlyeSkpDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF9fcmFpc2Vfc29mdGlycV9pcnFvZmYoVElNRVJfU09GVElSUSk7DQorICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgICAgICAgICB9DQogICAgICAgIH0N
CiAgICAgICAgcmF3X3NwaW5fdW5sb2NrX2lycSgmYmFzZS0+bG9jayk7DQogICAgICAgIHRpbWVy
X2Jhc2VfdW5sb2NrX2V4cGlyeShiYXNlKTsNCkBAIC0yMDMyLDkgKzIwMzgsOSBAQCBzdGF0aWMg
X19sYXRlbnRfZW50cm9weSB2b2lkIHJ1bl90aW1lcl9zb2Z0aXJxKHN0cnVjdCBzb2Z0aXJxX2Fj
dGlvbiAqaCkNCiB7DQogICAgICAgIHN0cnVjdCB0aW1lcl9iYXNlICpiYXNlID0gdGhpc19jcHVf
cHRyKCZ0aW1lcl9iYXNlc1tCQVNFX1NURF0pOw0KIA0KLSAgICAgICBfX3J1bl90aW1lcnMoYmFz
ZSk7DQorICAgICAgIF9fcnVuX3RpbWVycyhiYXNlLCBoKTsNCiAgICAgICAgaWYgKElTX0VOQUJM
RUQoQ09ORklHX05PX0haX0NPTU1PTikpDQotICAgICAgICAgICAgICAgX19ydW5fdGltZXJzKHRo
aXNfY3B1X3B0cigmdGltZXJfYmFzZXNbQkFTRV9ERUZdKSk7DQorICAgICAgICAgICAgICAgX19y
dW5fdGltZXJzKHRoaXNfY3B1X3B0cigmdGltZXJfYmFzZXNbQkFTRV9ERUZdKSwgaCk7DQogfQ0K
IA0KIC8qDQo+IHRoYW5rcw0KPiAtam9obg0KDQo=
