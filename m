Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F177A5FBE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJKXZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJKXY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:24:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A925585
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:24:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-112-GnkBwVzXNmW87uuPT0Ma2A-1; Wed, 12 Oct 2022 00:24:51 +0100
X-MC-Unique: GnkBwVzXNmW87uuPT0Ma2A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 12 Oct
 2022 00:24:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 12 Oct 2022 00:24:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "Jason A. Donenfeld" <zx2c4@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Thread-Topic: [crng-random:jd/get_random_u32_below 23/23]
 include/linux/random.h:64:69: sparse: sparse: cast truncates bits from
 constant value (1f4 becomes f4)
Thread-Index: AQHY3DtVD69rv9eDCUyAI1FFBLG+sa4H2CJggAABJoCAAfu+QA==
Date:   Tue, 11 Oct 2022 23:24:50 +0000
Message-ID: <4bbbde65cef74a579de34a75e6dba0a3@AcuMS.aculab.com>
References: <202210100722.Wc2gmfS6-lkp@intel.com>
 <a473cc4da4874235b2b98fd1a57e782e@AcuMS.aculab.com>
 <Y0RcL2j98CatloRr@zx2c4.com>
In-Reply-To: <Y0RcL2j98CatloRr@zx2c4.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDEwIE9jdG9iZXIgMjAyMiAxODo1NA0K
PiANCj4gT24gTW9uLCBPY3QgMTAsIDIwMjIgYXQgMDU6MTg6NDBQTSArMDAwMCwgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiA+IEZyb206IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiA+ID4gU2VudDogMTAgT2N0b2JlciAyMDIyIDAwOjMyDQo+ID4gPiBUbzogSmFzb24gQS4gRG9u
ZW5mZWxkIDx6eDJjNEBrZXJuZWwub3JnPg0KPiA+IC4uLg0KPiA+DQo+ID4gSSdtIG1pc3Npbmcg
dGhlIG1haW4gbWFpbGluZyBsaXN0IGVtYWlsIGZvciB0aGlzIGNoYW5nZS4NCj4gPiBJJ20gZ3Vl
c3NpbmcgdGhlIG5vbi1pbmxpbmVkIGNvZGUgZm9yIG5vbi1jb25zdGFudCBjZWlsDQo+ID4gaXMg
c2ltaWxhci4NCj4gDQo+IEl0J3MgcGFydCBvZiBhIGRldmVsb3BtZW50IHRyZWUgSSBhbHJlYWR5
IGxpbmtlZCB5b3UgdG8uIEl0J3Mgbm90IGRvbmUNCj4geWV0LiBUaGlzIGFsZXJ0IGlzIGp1c3Qg
YWJvdXQgbmVlZGluZyBhIF9fZm9yY2UuDQoNCkkga2VlcCB0aGlua2luZyBhYm91dCB0aGlzIG9u
ZS4NCnNwYXJzZSBpcyBiZWluZyBzdHVwaWQgYmVjYXVzZSBpdCBpcyBsb29raW5nIGF0IGNvZGUg
dGhhdCBjYWRlIGJlIHJlYWNoZWQuDQonY2VpbCcgbXVzdCBiZSA1MDAgc28gdGhlIHRlc3QgYXQg
bGluZSA2MiBpcyBmYWxzZS4NCkJ1dCB3aGF0IGlzIHRoZSBjYXN0IGZvcj8NCkxpbmUgNjQgaXMg
b25seSBleGVjdXRlZCB3aGVuIGNlaWwgaXMgPD0gMjU2IGFuZCB0aGUgY29uZGl0aW9uDQpvbmx5
IG1hdHRlcnMgd2hlbiBjZWlsIDw9IDI1NSAtIHNvIHRoZSBjYXN0IGNhbm5vdCBiZSBuZWVkZWQu
DQoNCkkgdGhpbmsgeW91IG1pZ2h0IGJlIHRyeWluZyB0byBkbyA4LWJpdCBhcml0aG1ldGljIC0g
YnV0IHlvdQ0Kc2hvdWxkIGtub3cgaXQgZ2V0cyBwcm9tb3RlZCB0byAnaW50JyAoYW5kIHRoZW4g
dG8gdW5zaWduZWQgaW50KS4NCldoYXQgbWlnaHQgZG8gd2hhdCB5b3UgaW50ZW5kZWQgaXMgKHU4
KX5jZWlsICUgY2VpbC4NCkJ1dCB0aGF0IGlzIHRoZSBzYW1lIGFzICgweGZmIC0gY2VpbCkgJSBj
ZWlsLg0KV2hpY2ggaXMgdGhlIHNhbWUgYXMgMHhmZiAlIGNlaWwuDQoNCkEgcXVpY2sgY2hlY2sg
d2l0aCBjZWlsID09IDUgZ2l2ZXMgdGhlIHdyb25nIGFuc3dlcg0KYXMgYWxsIHZhbHVlcyBnZXQg
YWNjZXB0ZWQgLSBhbmQgb25lIG5lZWQgdG8gYmUgZXhjbHVkZWQuDQpTbyB5b3UgZWl0aGVyIG5l
ZWQgKG11bHQgJiAweGZmKSA+IDB4ZmYgJSBjZWlsDQpvciAobXVsdCAmIDB4ZmYpID49IDB4MTAw
ICUgY2VpbC4NClRoZSBsYXR0ZXIgdmVyc2lvbiBpcyBhbHNvIHJpZ2h0IGZvciBwb3dlcnMgb2Yg
Mg0KZXhjZXB0IHRoYXQgdGhlIGNvbXBpbGVyIHdvbid0IGxpa2UgdGhlIHh4eCA+IDB1IHRlc3QN
CmJlY2F1c2UgaXQgaXMgYWx3YXlzIHRydWUuDQoNCglEYXZpZA0KDQo+IA0KPiA+DQo+ID4gPiB2
aW0gKzY0IGluY2x1ZGUvbGludXgvcmFuZG9tLmgNCj4gPiA+DQo+ID4gPiAgICAgNTMNCj4gPiA+
ICAgICA1NAl1MzIgX19nZXRfcmFuZG9tX3UzMl9iZWxvdyh1MzIgY2VpbCk7DQo+ID4gPiAgICAg
NTUJLyogUmV0dXJucyBhIHJhbmRvbSBpbnRlZ2VyIGluIHRoZSBpbnRlcnZhbCBbMCwgY2VpbCks
IHdpdGggdW5pZm9ybSBkaXN0cmlidXRpb24uICovDQo+ID4gPiAgICAgNTYJc3RhdGljIGlubGlu
ZSB1MzIgZ2V0X3JhbmRvbV91MzJfYmVsb3codTMyIGNlaWwpDQo+ID4gPiAgICAgNTcJew0KPiA+
ID4gICAgIDU4CQlpZiAoIV9fYnVpbHRpbl9jb25zdGFudF9wKGNlaWwpKQ0KPiA+ID4gICAgIDU5
CQkJcmV0dXJuIF9fZ2V0X3JhbmRvbV91MzJfYmVsb3coY2VpbCk7DQo+ID4gPiAgICAgNjANCj4g
PiA+ICAgICA2MQkJZm9yICg7Oykgew0KPiA+ID4gICAgIDYyCQkJaWYgKGNlaWwgPD0gMVUgPDwg
OCkgew0KPiA+ID4gICAgIDYzCQkJCXUzMiBtdWx0ID0gY2VpbCAqIGdldF9yYW5kb21fdTgoKTsN
Cj4gPiA+ICAgPiA2NAkJCQlpZiAoaXNfcG93ZXJfb2ZfMihjZWlsKSB8fCAodTgpbXVsdCA+PSAt
KHU4KWNlaWwgJSBjZWlsKQ0KPiA+ID4gICAgIDY1CQkJCQlyZXR1cm4gbXVsdCA+PiA4Ow0KPiA+
DQo+ID4gSWYgeW91IGFyZSBnb2luZyB0byBjaGVjayBpc19wb3dlcl9vZl8yKCkgdGhlbiB5b3Ug
bWlnaHQgYXMgd2VsbCBkbzoNCj4gPiAJCXUzMiB2YWwgPSBnZXRfcmFuZG9tX3U4KCk7DQo+ID4g
CQlpZiAoaXNfcG93ZXJfb2ZfMihjZWlsKSkNCj4gPiAJCQlyZXR1cm4gY2VpbCA9PSAweDEwMCA/
IHZhbCA6IHZhbCAmIChjZWlsIC0gMSk7DQo+ID4gRXhjZXB0IHRoYXQgeW91IGRvbid0IHdhbnQg
dG8gbG9vcCBvbiB6ZXJvIC0gc28gIShjZWlsICYgKGNlaWwgLSAxKSkNCj4gDQo+IEkgdGhvdWdo
dCBJIG9wdGVkIG91dCBvZiB0aGUgTGFpZ2h0IGRyaXZlLWJ5cz8NCj4gDQo+IEVpdGhlciB3YXks
IEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnRzIG9yIGhvdyB0aGV5IHBlcnRhaW4gdG8g
dGhlDQo+IGN1cnJlbnQgY29kZSBpbiB0aGF0IHVuZmluaXNoZWQgZGV2ZWxvcG1lbnQgYnJhbmNo
LiBQbGVhc2UganVzdCBzZW5kDQo+IHJlYWwgcGF0Y2hlcy4NCj4gDQo+IEphc29uDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

