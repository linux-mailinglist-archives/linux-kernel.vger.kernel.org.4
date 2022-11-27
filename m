Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C81639D94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0W0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK0W0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:26:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247CF642E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 14:26:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-88-1iRpMDN2PEKQmUM_Nnzjqg-1; Sun, 27 Nov 2022 22:26:15 +0000
X-MC-Unique: 1iRpMDN2PEKQmUM_Nnzjqg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 27 Nov
 2022 22:26:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sun, 27 Nov 2022 22:26:13 +0000
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
Thread-Index: AdkA3jB+9p3HVKOjROWboToCz6X2bgBwb9KAAAEizAAAAZNzAAAAy3Lw
Date:   Sun, 27 Nov 2022 22:26:13 +0000
Message-ID: <b96a46eb24c2482bb6081418bd2ace02@AcuMS.aculab.com>
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
 <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
 <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com>
 <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
In-Reply-To: <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjcgTm92ZW1iZXIgMjAyMiAyMTo1NA0KPiAN
Cj4gT24gU3VuLCBOb3YgMjcsIDIwMjIgYXQgMTo0MiBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdoeSBzaG91bGQgaXQgYmUgYSBwcm9i
bGVtPw0KPiA+IG1pbigtNCwgc2l6ZW9mKFgpKSBiZWNvbWVzIG1pbigtNCwgKGludClzaXplb2Yo
WCkpIGFuZCB0aHVzIC00Lg0KPiA+IFdpdGhvdXQgdGhlIGNhc3QgdGhlIC00IGlzIGNvbnZlcnRl
ZCB0byBhIHZlcnkgbGFyZ2UgdW5zaWduZWQNCj4gPiB2YWx1ZSBzbyB0aGUgcmVzdWx0IGlzIHNp
emVvZihYKSAtIG5vdCBhdCBhbGwgZXhwZWN0ZWQuDQo+IA0KPiBUaGF0IGlzIEVYQUNUTFkgdGhl
IHByb2JsZW0uDQo+IA0KPiBZb3UgZXZlbiBlbnVtZXJhdGUgaXQsIGFuZCB3b3JrIHRocm91Z2gg
ZXhhY3RseSB3aGF0IGhhcHBlbnMsIGFuZCB0aGVuDQo+IHlvdSBTVElMTCBzYXkgInRoaXMgaXMg
bm90IGEgcHJvYmxlbSIuDQo+IA0KPiBJdCBkYW1uIHdlbGwgaXMgYSBIVUdFIHByb2JsZW0uIFdo
ZW4gcGVvcGxlIHNheSAiSSBuZWVkIG15IG9mZnNldCB0bw0KPiBiZSBzbWFsbGVyIHRoYW4gdGhl
IHNpemUgb2YgdGhlIG9iamVjdCIsIHRoZW4gYSB2YWx1ZSBsaWtlIC00IElTIE5PVA0KPiBBQ0NF
UFRBQkxFLiBJdCBzaG91bGQgY2F1c2UgYSBodWdlIHR5cGUgd2FybmluZyBhYm91dCBob3cgdGhl
IHRlc3Qgd2FzDQo+IGJyb2tlbi4NCj4gDQo+IERhdmlkLCB0aGlzIGlzIGxpdGVyYWxseSAqRVhB
Q1RMWSogd2h5IHdlIGhhdmUgdGhvc2Ugc3RyaWN0IHR5cGUgaXNzdWVzLg0KPiANCj4gVGhlIGZh
Y3QgdGhhdCB5b3UgZG9uJ3QgZXZlbiBzZWVtIHRvIHJlYWxpemUgd2h5IHRoaXMgd291bGQgYmUg
YQ0KPiBwcm9ibGVtIG1ha2VzIG1lIE5BSyB0aGlzIHBhdGNoIHNvIGhhcmQgdGhhdCBpdCBpc24n
dCBldmVuIGZ1bm55Lg0KPiANCj4gQW5kcmV3LCBwbGVhc2UgcmVtb3ZlIHRoaXMgZnJvbSB5b3Vy
IHF1ZXVlLiBJdCdzIG5vdCBldmVuIHJlbW90ZWx5DQo+IGFjY2VwdGFibGUuIEkgd2FzIGhvcGlu
ZyBJIHdhcyBtaXNyZWFkaW5nIHRoZSBwYXRjaCwgYnV0IGl0IHR1cm5zIG91dA0KPiB0aGF0IHRo
aXMgInJlbGF4IHRoZSBydWxlcyB3YXkgdG9vIG11Y2giIHdhcyBhcHBhcmVudGx5IGludGVudGlv
bmFsLg0KDQpJIGd1ZXNzIHlvdSdyZSB0aGUgYm9zcyA6LSkNCg0KQnV0IHdoYXQgYWN0dWFsbHkg
aGFwcGVucyBpcyB0aGUgY29tcGlsZXIgYmxlYXRzIGFib3V0IG1pbigpDQpzbyByYXRoZXIgdGhl
biBjaGFuZ2UgYSBjb25zdGFudCB0byBiZSB1bnNpZ25lZCAoZXRjKSB0aGUgY29kZQ0KaXMgcmV3
cml0dGVuIHdpdGggbWluX3QoKSBhbmQgYm90aCBzaWRlcyBhcmUgY2FzdCB0byAodXN1YWxseSkN
CmFuIHVuc2lnbmVkIHR5cGUuDQpUaGVyZSBhcmUgYSBub24temVybyBudW1iZXIgb2YgY2FzZXMg
d2hlcmUgdGhlIGNhc3QgbWFza3MgaGlnaA0KYml0cyBvZmYgdGhlIGxhcmdlIHZhbHVlLg0KDQpH
aXZlbiB0aGUgbnVtYmVyIG9mIG1pbl90KHU4LHgseSkgYW5kIG1pbl90KHUxNix4LHkpIGl0IGlz
DQpwcmV0dHkgY2xlYXIgYSBsb3Qgb2YgcGVvcGxlIGRvbid0IGFjdHVhbGx5IGtub3cgdGhlIEMg
YXJpdGhtZXRpYw0KcHJvbW90aW9uIHJ1bGVzLg0KDQpGb3JjaW5nIGFuIHVuc2lnbmVkIGNvbXBh
cmlzb24gY2FuIGJlIGRvbmUgYnkgYWRkaW5nIGhhdmluZzoNCiNkZWZpbmUgbWluX3Vuc2lnbmVk
KHgsIHkpIG1pbigoeCkgKyAwdSArIDB1bGwsICh5KSArIDB1ICsgMHVsbCkNCnRoYXQgd2lsbCBu
ZXZlciBtYXNrIG9mZiBiaXRzIGFuZCBnZW5lcmF0ZXMgc2FuZSBjb2RlLg0KQWxtb3N0IGFsbCB0
aGUgbWluX3QoKSBjb3VsZCBiZSByZXBsYWNlZCBieSB0aGF0IGRlZmluaXRpb24uDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

