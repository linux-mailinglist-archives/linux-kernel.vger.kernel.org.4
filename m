Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5690C639D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiK0VmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK0VmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:42:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F76CE03
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:42:12 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-114-m5WpA0fOM4eLpNBtIAxzKg-1; Sun, 27 Nov 2022 21:42:09 +0000
X-MC-Unique: m5WpA0fOM4eLpNBtIAxzKg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 27 Nov
 2022 21:42:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sun, 27 Nov 2022 21:42:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joe Perches" <joe@perches.com>
Subject: RE: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
Thread-Topic: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
Thread-Index: AdkA3jB+9p3HVKOjROWboToCz6X2bgBwb9KAAAEizAA=
Date:   Sun, 27 Nov 2022 21:42:06 +0000
Message-ID: <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com>
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
 <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjcgTm92ZW1iZXIgMjAyMiAyMDozNw0KPiAN
Cj4gT24gRnJpLCBOb3YgMjUsIDIwMjIgYXQgNzowMCBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IC0gU2tpcCB0aGUgdHlwZSB0ZXN0IGlm
IGVpdGhlciBhcmd1bWVudCBpcyBhIHBvc2l0aXZlICdpbnQnIGNvbnN0YW50Lg0KPiA+ICAgSW5z
dGVhZCBjYXN0IHRoZSBjb25zdGFudCB0byAnaW50JywgdGhlIGNvbXBpbGVyIG1heSBwcm9tb3Rl
IGl0DQo+ID4gICBiYWNrIHRvICd1bnNpZ25lZCBpbnQnIHdoZW4gZG9pbmcgdGhlIHRlc3QuDQo+
IA0KPiBOby4gVGhpcyBsb29rcyB2ZXJ5IHdyb25nIHRvIG1lLg0KPiANCj4gTWF5YmUgSSdtIG1p
cy1yZWFkaW5nIHNvbWV0aGluZywgYnV0IGl0IGxvb2tzIGxpa2UgdGhpcyBtYWtlcyBhDQo+ICJz
aXplb2YoKSIgZXNzZW50aWFsbHkgYmUgY29tcGF0aWJsZSB3aXRoIGFuICJpbnQiIHZhcmlhYmxl
Lg0KPiANCj4gVGhhdCBpcyBob3JyZW5kb3VzbHkgd3JvbmcuIEl0IHNob3VsZCB3YXJuLg0KPiAN
Cj4gSWYgeW91IGFyZSBkb2luZyBhICJtaW4oaSxzaXplb2YoWCkpIiwgYW5kICJpIiBpcyBhIHNp
Z25lZCBpbnRlZ2VyLA0KPiB0aGVuIHNvbWV0aGluZyBpcyB3cm9uZy4gV2hhdCBkb2VzIHRoYXQg
Y29kZSBleHBlY3Q/IEl0IHNob3VsZG4ndA0KPiBzaWxlbnRseSBzYXkgInRoaXMgaXMgb2siLCBi
ZWNhdXNlIGl0IG1vc3QgZGVmaW5pdGVseSBpc24ndC4NCg0KV2h5IHNob3VsZCBpdCBiZSBhIHBy
b2JsZW0/DQptaW4oLTQsIHNpemVvZihYKSkgYmVjb21lcyBtaW4oLTQsIChpbnQpc2l6ZW9mKFgp
KSBhbmQgdGh1cyAtNC4NCldpdGhvdXQgdGhlIGNhc3QgdGhlIC00IGlzIGNvbnZlcnRlZCB0byBh
IHZlcnkgbGFyZ2UgdW5zaWduZWQNCnZhbHVlIHNvIHRoZSByZXN1bHQgaXMgc2l6ZW9mKFgpIC0g
bm90IGF0IGFsbCBleHBlY3RlZC4NCg0KQnV0IGl0IGlzIG11Y2ggbW9yZSBsaWtlbHkgdGhhdCB0
aGVyZSBpcyBhbiBlYXJsaWVyIHRlc3QgZm9yDQpuZWdhdGl2ZSB2YWx1ZXMsIHNvIHRoZSBkb21h
aW4gb2YgJ2knIGlzIG5vbi1uZWdhdGl2ZS4NClRoZW4gdGhlIHR5cGUtY2hlY2sganVzdCBmb3Jj
ZXMgdGhlIGNvZGVyIHRvIHVzZSBtaW5fdCgpDQphbmQgcGljayBzb21lIHR5cGUgdG8gJ3NodXQg
dGhlIGNvbXBpbGVyIHVwJy4NCg0KU28gSSdtIGp1c3QgdHJlYXRpbmcgYm90aCBtaW4oaSwgMTYp
IGFuZCBtaW4oaSwgMTZ1KSBhcyBzaWduZWQNCm9wZXJhdGlvbnMuDQoNCj4gU28gbWF5YmUgSSdt
ICBtaXMtcmVhZGluZyB0aGlzIGFsbCBhbmQgaXQgZG9lc24ndCBhY3R1YWxseSBkbyB3aGF0IEkN
Cj4gdGhpbmsgaXQgZG9lcywgYnV0IHRoaXMgc2VlbXMgdG8gcmVsYXggdGhpbmdzICptdWNoKiB0
b28gbXVjaC4NCg0KSSBkaWQgbWFuYWdlIHRvIGYqY2sgdXAgdGhlIHBhdGNoIGluIHNvbWUgc3Vi
dGxlIHdheXMuDQpNb3N0bHkgZHVlIHRvIHRoZSBub24taW50dWl0aXZlIG5hdHVyZSBvZiB0aGUg
J3ZvaWQgKicgdHJpY2suDQoNCj4gVGhlcmUncyBhIHJlYXNvbiB3ZSByZXF1aXJlIHR5cGVzIHRv
IGJlIGNvbXBhdGlibGUsIGFuZCB5b3UganVzdA0KPiByZW1vdmVkIHNvbWUgb2YgdGhlIGltcG9y
dGFudCBzaWduZWRuZXNzIGNoZWNrcy4NCg0KSSdkIGFzc3VtZWQgdGhlIG1haW4gcmVhc29uIHdh
cyB0byBhdm9pZCBuZWdhdGl2ZSBpbnRlZ2VycyBiZWluZw0KY29udmVydGVkIHRvIHZlcnkgbGFy
Z2UgdW5zaWduZWQgdmFsdWVzLg0KVGhhdCBpcyBkZWZpbml0ZWx5IGEgZ29vZCBpZGVhLg0KDQpB
cyB3ZWxsIGFzIHRoZSBjb21wYXJpc29ucyBvZiBpbnQgdiBzbWFsbC11bnNpZ25lZCBjb25zdGFu
dHMNCnRoZXJlIGFyZSBzb21lIG90aGVycyB3aGljaCBhcmUgY3VycmVudGx5IHJlamVjdGVkLg0K
DQpDb25zaWRlciBtaW4odThfdmFyLCAxNnUpIG5vIHJlYXNvbiB0byByZWplY3QgdGhhdCBvbmUu
DQpCdXQgdGhlIHR5cGVzIGRvbid0IG1hdGNoLCBhbmQgdGhlIHU4X3ZhciBpcyBmaXJzdCBjb252
ZXJ0ZWQNCnRvIHNpZ25lZCBpbnQgYW5kIHRoZW4gdG8gdW5zaWduZWQgaW50IGJlZm9yZSB0aGUg
Y29tcGFyaXNvbi4NCg0KSSBhbHNvIGZvdW5kIG1hbnkgZXhhbXBsZXMgb2YgY29kZSB0cnlpbmcg
dG8gYm91bmQgdTggdmFyaWFibGVzIHVzaW5nDQondThfdmFyID0gbWluX3QodTgsIFt1OF92YXJ8
Y29uc3RhbnRfYmVsb3dfMjU2XSwgdW5zaWduZWRfZXhwcmVzc2lvbiknLg0KTWF5YmUgdGhlIGNv
bnN0YW50IHNob3VsZCBiZSB1bnNpZ25lZCwgYnV0IHRoZSAndTgnIGNhc3QgaXMganVzdA0KcGxh
aW4gd3JvbmcuDQpBbGwgdGhlIGZhbHNlLXBvc2l0aXZlcyBpbiB0aGUgdHlwZSBjaGVjayBpbiBt
aW4oKSBqdXN0IG1ha2UgdGhlc2UNCm1vcmUgbGlrZWx5Lg0KDQpJJ20gbG9va2luZyBhdCBhbHNv
IGFsbG93aW5nOg0KCSdhbnkgdW5zaWduZWQgdHlwZScgdiAnYW55IHVuc2lnbmVkIHR5cGUnDQoJ
J2FueSBzaWduZWQgdHlwZScgdiAnYW55IHNpZ25lZCB0eXBlJw0KTmVpdGhlciBvZiB3aGljaCBl
dmVyIGRvZXMgYW55dGhpbmcgb3RoZXIgdGhhbiB3aGF0IGlzIGV4cGVjdGVkLg0KQW5kIGFsc286
DQoJJ2FueSBzaWduZWQgdHlwZScgdiAnYW55IHNtYWxsZXIgdW5zaWduZWQgdHlwZScNCndoaWNo
IGlzIGFsc28gb2sgYmVjYXVzZSB0aGUgY29tcGlsZXIgY29udmVydHMgdGhlIHVuc2lnbmVkDQp0
eXBlIHRvIHRoZSBsYXJnZXIgc2lnbmVkIG9uZSBhbmQgZG9lcyBhbiB1bnNpZ25lZCBjb21wYXJl
Lg0KKEhlcmUgdGhlICdzaWduZWQgdHlwZScgY2FuIGJlIGFzc3VtZWQgdG8gYmUgYXQgbGVhc3Qg
J2ludCcNCmR1ZSB0byB0aGUgaW50ZWdlciBwcm9tb3Rpb25zIGJlZm9yZSBhbnkgYXJpdGhtZXRp
Yy4pDQoNCkkgbmVlZCB0byBmaW5kIGEgY29tcGlsZS10aW1lIGNoZWNrIGZvciBhIHNpZ25lZCB0
eXBlIHRoYXQNCmRvZXNuJ3QgYmFyZiBvbiBhIHBvaW50ZXIhDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

