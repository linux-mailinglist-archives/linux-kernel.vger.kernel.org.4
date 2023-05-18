Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8A70785A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjERDQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjERDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:16:19 -0400
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850C2D53
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:16:13 -0700 (PDT)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTPS id 34I3Fqqc012150
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 18 May 2023 11:15:52 +0800 (GMT-8)
        (envelope-from zhengyan@asrmicro.com)
Received: from exch03.asrmicro.com (10.1.24.118) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 18 May
 2023 11:15:54 +0800
Received: from exch03.asrmicro.com ([::1]) by exch03.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Thu, 18 May 2023 11:15:54 +0800
From:   =?utf-8?B?WWFuIFpoZW5n77yI5Lil5pS/77yJ?= <zhengyan@asrmicro.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?R2FvIE1laXRhb++8iOmrmOeOq+a2m++8iQ==?= 
        <meitaogao@asrmicro.com>,
        =?utf-8?B?WmhvdSBRaWFvKOWRqOS+qCk=?= <qiaozhou@asrmicro.com>,
        =?utf-8?B?WmhhbmcgWmhpemhvdSjlvKDmsrvmtLIp?= 
        <zhizhouzhang@asrmicro.com>
Subject: RE: [PATCH] irqchip/gic-v3: workaround for ASR8601 when reading
 mpidr
Thread-Topic: [PATCH] irqchip/gic-v3: workaround for ASR8601 when reading
 mpidr
Thread-Index: AQHZiJTvP0JzizWi8EWX3jYwRrRS6a9dnPCAgACenBD//6v7gIABZivg
Date:   Thu, 18 May 2023 03:15:54 +0000
Message-ID: <05d97f210e484a07887f1e476fa4cae5@exch03.asrmicro.com>
References: <20230517075500.43516-1-zhengyan@asrmicro.com>
        <86ttwbl5nq.wl-maz@kernel.org>
        <9dcef1c9343041c49a92ec8cd40d6331@exch03.asrmicro.com>
 <86sfbvktas.wl-maz@kernel.org>
In-Reply-To: <86sfbvktas.wl-maz@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.215]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: spam.asrmicro.com 34I3Fqqc012150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIFtt
YWlsdG86bWF6QGtlcm5lbC5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE3LCAyMDIzIDg6
NTkgUE0NCj4gVG86IFlhbiBaaGVuZ++8iOS4peaUv++8iSA8emhlbmd5YW5AYXNybWljcm8uY29t
Pg0KPiBDYzogdGdseEBsaW51dHJvbml4LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBHYW8gTWVpdGFv77yI6auY546r5rab77yJDQo+IDxtZWl0YW9nYW9AYXNybWljcm8uY29tPjsg
WmhvdSBRaWFvKOWRqOS+qCkgPHFpYW96aG91QGFzcm1pY3JvLmNvbT47DQo+IFpoYW5nIFpoaXpo
b3Uo5byg5rK75rSyKSA8emhpemhvdXpoYW5nQGFzcm1pY3JvLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gaXJxY2hpcC9naWMtdjM6IHdvcmthcm91bmQgZm9yIEFTUjg2MDEgd2hlbiByZWFk
aW5nDQo+IG1waWRyDQo+IA0KPiBPbiBXZWQsIDE3IE1heSAyMDIzIDExOjQ1OjIyICswMTAwLA0K
PiBZYW4gWmhlbmfvvIjkuKXmlL/vvIkgPHpoZW5neWFuQGFzcm1pY3JvLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogTWFyYyBaeW5naWVyIFttYWlsdG86bWF6QGtlcm5lbC5vcmddDQo+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAxNywgMjAyMyA0OjMyIFBNDQo+ID4gPiBUbzogWWFuIFpoZW5n77yI5Lil5pS/
77yJIDx6aGVuZ3lhbkBhc3JtaWNyby5jb20+DQo+ID4gPiBDYzogdGdseEBsaW51dHJvbml4LmRl
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHYW8NCj4gPiA+IE1laXRhb++8iOmrmOeO
q+a2m++8iQ0KPiA+ID4gPG1laXRhb2dhb0Bhc3JtaWNyby5jb20+OyBaaG91IFFpYW8o5ZGo5L6o
KSA8cWlhb3pob3VAYXNybWljcm8uY29tPjsNCj4gPiA+IFpoYW5nIFpoaXpob3Uo5byg5rK75rSy
KSA8emhpemhvdXpoYW5nQGFzcm1pY3JvLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGlycWNoaXAvZ2ljLXYzOiB3b3JrYXJvdW5kIGZvciBBU1I4NjAxIHdoZW4NCj4gPiA+IHJlYWRp
bmcgbXBpZHINCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDE3IE1heSAyMDIzIDA4OjU1OjAwICswMTAw
LA0KPiA+ID4gemhlbmd5YW4gPHpoZW5neWFuQGFzcm1pY3JvLmNvbT4gd3JvdGU6DQo+ID4gPiA+
DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkIHdvcmthcm91bmQgZm9yIEFTUjg2MDEsIHdoaWNoIHVz
ZXMgYW4gYXJtdjguMg0KPiA+ID4gPiBwcm9jZXNzb3Igd2l0aCBhIGdpYy01MDAuIEFSTXY4LjIg
dXNlcyBNdWx0aXByb2Nlc3NvciBBZmZpbml0eQ0KPiA+ID4gPiBSZWdpc3RlciB0byBpZGVudGlm
eSB0aGUgbG9naWNhbCBhZGRyZXNzIG9mIHRoZSBjb3JlIGJ5DQo+ID4gPiA+IHwgY2x1c3RlciB8
IGNvcmUgfCB0aHJlYWQgfC4NCj4gPiA+DQo+ID4gPiBOb3QgcXVpdGUuIFRoZSBBUk12OC4yIGFy
Y2hpdGVjdHVyZSBkb2Vzbid0IHNheSAqYW55KiBvZiB0aGF0LiBJdCBpcw0KPiA+ID4gQVJNJ3MN
Cj4gPiA+ICppbXBsZW1lbnRhdGlvbnMqIHRoYXQgZm9sbG93IHRoaXMgc2NoZW1lLg0KPiA+ID4N
Cj4gPg0KPiA+IFJlYWxseSB0aGFuayB5b3UgZm9yIHJhcGlkIHJlc3BvbnNlLA0KPiA+IFllcywg
YXMgYXJtIGRvY3VtZW50cw0KPiA+IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdWVudGF0
aW9uL2thMDAyMTA3L2xhdGVzdCBzYWlkDQo+IA0KPiBUaGlzIHBhZ2UgZG9lc24ndCBleGlzdC4N
Cj4gDQoNClNvcnJ5IGZvciBteSBtaXN0YWtlLA0KaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9k
b2N1bWVudGF0aW9uL2thMDAyMTA3L2xhdGVzdA0KZXh0cmFjdCBmcm9tIHRoZSBkb2NzOg0KVGhl
IEFybS12OC4wIENQVXMgdXNlIGFmZmluaXR5IDAgZm9yIGEgQ1BVIGFuZCBhZmZpbml0eSAxIGZv
ciBhIGNsdXN0ZXIuIA0KQWxsIEFybS12OC4yIENQVXMgdXNlIGFmZmluaXR5IDIgZm9yIGEgY2x1
c3RlciwgMSBmb3IgYSBDUFUsIGFuZCAwIGZvciBhIHRocmVhZC4NClRoZSBHSUMtNTAwIGRvZXMg
bm90IHN1cHBvcnQgYWZmaW5pdHkgMi4gVGhlcmVmb3JlLCB0aGUgR0lDLTUwMCBjYW5ub3Qgcm91
dGUgDQpTaGFyZWQgUGVyaXBoZXJhbCBJbnRlcnJ1cHRzIChTUElzKSBvciBTb2Z0d2FyZSBHZW5l
cmF0ZWQgSW50ZXJydXB0cyAoU0dJcykgDQpjb3JyZWN0bHkgZm9yIEFybS12OC4yIENQVXMuIA0K
VGhlIEdJQy01MDAgZG9lcyBub3QgaGF2ZSBjb3JyZWN0IGJ1c2VzIHRvIGNvbm5lY3QgdGhlIHN5
c3RlbSB0b2dldGhlci4NCg0KPiA+IEl0IGNvbWVzIGZyb20gYXJtdjguMiBnZXQgMyB0eXBlcyBm
b3IgYWZmaW5pdHkgKGFybSB2OC4wIGNwdXMgb25seSBnZXQNCj4gPiAyIHR5cGVzKSBBbmQgaXQn
cyBhbiBpbXBsZW1lbnRhdGlvbnMgaXNzdWUuDQo+IA0KPiBBZ2FpbiwgdGhpcyBoYXMgbm90aGlu
ZyB0byBkbyB3aXRoIHRoZSBBUk12OC4yIGFyY2hpdGVjdHVyZS4gTm9yIHRoZQ0KPiBBUk12OC4w
IGFyY2hpdGVjdHVyZS4gUGxlYXNlIHJlYWQgdGhlIEFSTSBBUk0sIHdoaWNoIHNheXMgYWJzb2x1
dGVseQ0KPiAqbm90aGluZyogb2Ygd2hhdCB0aGUgdmFyaW91cyBhZmZpbml0eSBsZXZlbHMgYXJl
IGZvci4NCj4gDQoNCkFzIHRoZSBleHRyYWN0IGZyb20gcGVydmlvdXMgcGFydCBtZW50aW9uZWQs
DQpJdCBzZWVtcyBsaWtlIHRoaXMgaXNzdWUgcmVsYXRlZCB0byB0aGF0PyBJIGp1c3Qgd2FudCB0
byBtZW50aW9uIHRoYXQNCnRoaXMgaXNzdWUgaXMgY2F1c2UgYnkgSFcgY2hvaWNlIGluIHRoZSBj
b21taXQgbWVzc2FnZS4NCg0KPiA+DQo+ID4gPiA+IEhvd2V2ZXIsIGdpYy01MDAgb25seSBzdXBw
b3J0cyB0b3BvbG9naWVzIHdpdGggYWZmaW5pdHkgbGV2ZWxzDQo+ID4gPiA+IGxlc3MgdGhhbiAy
IGFzDQo+ID4gPiA+IHwgY2x1c3RlciB8IGNvcmV8Lg0KPiA+ID4gPg0KPiA+ID4gPiBTbyBpdCBu
ZWVkcyB0aGlzIHBhdGNoIHRvIHNoaWZ0IHRoZSBNUElEUiB2YWx1ZXMgdG8gZW5zdXJlIHByb3Bl
cg0KPiA+ID4gPiBmdW5jdGlvbmFsaXR5DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IHpoZW5neWFuIDx6aGVuZ3lhbkBhc3JtaWNyby5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJx
LWdpYy12My5jDQo+ID4gPiA+IGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMuYyBpbmRleCA2
ZmNlZTIyMWYyMDEuLjQzNWI5OGE4NjQxZQ0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2lycWNo
aXAvaXJxLWdpYy12My5jDQo+ID4gPiA+IEBAIC0zOSw2ICszOSw3IEBADQo+ID4gPiA+DQo+ID4g
PiA+ICAjZGVmaW5lIEZMQUdTX1dPUktBUk9VTkRfR0lDUl9XQUtFUl9NU004OTk2CSgxVUxMIDw8
DQo+IDApDQo+ID4gPiA+ICAjZGVmaW5lIEZMQUdTX1dPUktBUk9VTkRfQ0FWSVVNX0VSUkFUVU1f
Mzg1MzkJKDFVTEwgPDwNCj4gMSkNCj4gPiA+ID4gKyNkZWZpbmUgRkxBR1NfV09SS0FST1VORF9N
UElEUl9BU1I4NjAxCQkoMVVMTCA8PCAyKQ0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgQVNSODYwMT8g
SXMgaXQgYSBzeXN0ZW0/IE9yIGFuIGVycmF0dW0gbnVtYmVyPyBGb3IgaXNzdWVzDQo+ID4gPiB0
aGF0IGFyZSB0aGUgcmVzdWx0IG9mIGEgSFcgaW50ZWdyYXRpb24gaXNzdWUsIHBsZWFzZSBwcm92
aWRlIGFuDQo+ID4gPiBvZmZpY2lhbCBlcnJhdHVtIG51bWJlciwgYW5kIHVwZGF0ZQ0KPiBEb2N1
bWVudGF0aW9uL2FybTY0L3NpbGljb24tZXJyYXRhLnJzdC4NCj4gPiA+DQo+ID4NCj4gPiBBU1I4
NjAxIGlzIG91ciBzb2MncyBuYW1lLCBhbmQgeWVzIGl04oCZcyBhIGtpbmQgb2YgSFcgaW50ZWdy
YXRpb24gaXNzdWUNCj4gPiBCdXQgbWF5YmUgaXTigJlzIG5vdCBhbiBlcnJhdHVtIHNpbmNlIG91
ciBIVyBkZXNpZ24gaXMgbGlrZSB0aGF0LA0KPiA+IGFsdGhvdWdoIEFybSBkb2Vzbid0IHJlY29t
bWVuZCB0aGlzIHdheS4NCj4gDQo+IFllcywgZm9yIGEgZ29vZCByZWFzb246IGl0IGRvZXNuJ3Qg
d29yay4gU28gdGhpcyBpcyAqZGVmaW5pdGVseSogYW4gZXJyYXR1bSwgbm8gaWZzLA0KPiBubyBi
dXRzLg0KPiANCg0KT2theSwgSSBhZ3JlZSB3aXRoIHlvdS4gVGhhbmtzIGZvciB5b3VyIGFkdmlj
ZXMuDQoNCj4gPiBBbmQgSSB3b3VsZCBsaWtlIHRvIGFkZCBtb3JlIGNvbW1lbnRzDQo+ID4gVW5k
ZXIgdGhlIG5leHQgcGFydCBiZWZvcmUgKmRlc2MJPSAiR0lDdjM6IEFTUiA4NjAxIE1QSURSIHNo
aWZ0IioNCj4gPiBNYXliZSB0aGlzIGlzIGEgYmV0dGVyIHdheT8gT3IgYWRkIHNvbWV0aGluZyB1
bmRlciBEb2N1bWVudGF0aW9u77yfDQo+IA0KPiBEb2N1bWVudGF0aW9uL2FybTY0L3NpbGljb24t
ZXJyYXRhLnJzdCBpcyB0aGUgcGxhY2UgdG8gcHV0IGl0LiBOb3doZXJlIGVsc2UuDQo+IA0KPiAJ
TS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0sIHByb2dyZXNz
IGlzIG5vdCBwb3NzaWJsZS4NCg==
