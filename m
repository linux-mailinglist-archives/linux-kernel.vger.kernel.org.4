Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC07069E0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjBUMtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBUMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:49:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26F3C27
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:48:57 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-AR28esPlM1CGtjOtoVTXdw-1; Tue, 21 Feb 2023 12:48:55 +0000
X-MC-Unique: AR28esPlM1CGtjOtoVTXdw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Tue, 21 Feb
 2023 12:48:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Tue, 21 Feb 2023 12:48:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>,
        Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "Johan Hovold" <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: jsm: Use min_t instead of min
Thread-Topic: [PATCH] serial: jsm: Use min_t instead of min
Thread-Index: AQHZRSHLK/dRdoMFwUmEmVJXtnmGSq7ZWrxg
Date:   Tue, 21 Feb 2023 12:48:54 +0000
Message-ID: <f292a8314e334587979d1dc7edbf8085@AcuMS.aculab.com>
References: <20230219205316.3499-1-mohammadmahfoozpersonal@gmail.com>
 <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
In-Reply-To: <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiAyMCBGZWJydWFyeSAyMDIzIDExOjUyDQo+IA0KPiBP
biAxOS4gMDIuIDIzLCAyMTo1MywgTW9oYW1tYWQgTWFoZm9veiB3cm90ZToNCj4gPiBVc2UgbWlu
X3QgaW5zdGVhZCBvZiBtaW4gdG8gY3V0IGRvd24gbiBmdXJ0aGVyIGlmIG5lZWRlZC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE1vaGFtbWFkIE1haGZvb3ogPG1vaGFtbWFkbWFoZm9venBlcnNv
bmFsQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9qc20vanNt
X25lby5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2pzbS9q
c21fbmVvLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvanNtL2pzbV9uZW8uYw0KPiA+IGluZGV4IDBj
NzhmNjYyNzZjZC4uNGNjZTFlNDIzYjA2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9qc20vanNtX25lby5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2pzbS9qc21f
bmVvLmMNCj4gPiBAQCAtMzUwLDcgKzM1MCw3IEBAIHN0YXRpYyB2b2lkIG5lb19jb3B5X2RhdGFf
ZnJvbV91YXJ0X3RvX3F1ZXVlKHN0cnVjdCBqc21fY2hhbm5lbCAqY2gpDQo+ID4gICAJCSAqIElC
TSBwU2VyaWVzIHBsYXRmb3JtLg0KPiA+ICAgCQkgKiAxNSBieXRlcyBtYXggYXBwZWFycyB0byBi
ZSB0aGUgbWFnaWMgbnVtYmVyLg0KPiA+ICAgCQkgKi8NCj4gPiAtCQluID0gbWluKCh1MzIpIG4s
ICh1MzIpIDEyKTsNCj4gPiArCQluID0gbWluX3QodTMyLCBuLCAxMik7DQo+IA0KPiBOYWgsIHdo
eSBpcyAibiIgc2lnbmVkIGluIHRoZSBmaXJzdCBwbGFjZT8gQ291bGQgeW91IGZpeCB0aGF0IGFu
ZCBhbGwNCj4gYWxsIHRob3NlIGNhc3RzIGluIG1pbigpcyBhcm91bmQgaW5zdGVhZD8NCg0KVGhl
cmUgaXMgYWxzbyBhIChJSVJDKSAnZmlmb19zcGFjZSAtPSAzOycgaW4gdGhlcmUgdGhhdCBjb3Vs
ZA0KYWxzbyBnZW5lcmF0ZSBuZWdhdGl2ZXMuDQoNCkkgdG9vayBvbmUgbG9vayBhdCB0aGF0IGZ1
bmN0aW9uIGFuZCByYW4gYXdheS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

