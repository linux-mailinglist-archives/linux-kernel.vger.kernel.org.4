Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768DC66AC21
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjANPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjANPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:36:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E444B5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 07:36:00 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-70-8-cgC713N-WSCbvTwzlehQ-1; Sat, 14 Jan 2023 15:35:56 +0000
X-MC-Unique: 8-cgC713N-WSCbvTwzlehQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 14 Jan
 2023 15:35:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sat, 14 Jan 2023 15:35:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Yujie Liu" <yujie.liu@intel.com>
Subject: RE: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Thread-Topic: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Thread-Index: AQHZJqG7RbFqgn/bok2CRgJfJGfeWa6eC/hg
Date:   Sat, 14 Jan 2023 15:35:55 +0000
Message-ID: <54dabf8bd3374543b2c72631db4f9c11@AcuMS.aculab.com>
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
 <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com>
 <Y7i1h3lCMKfxB532@zn.tnic>
 <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
 <Y8Ax/I5qOcVDZljG@zn.tnic>
In-Reply-To: <Y8Ax/I5qOcVDZljG@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDEyIEphbnVhcnkgMjAyMyAxNjoxNQ0KLi4u
DQo+ID4gSW4gdGhpcyBjYXNlLCBpdCBnaXZlczoNCj4gPg0KPiA+ICAgICBBIHR5cGUgd2l0aCBg
cGFja2VkYCByZXByZXNlbnRhdGlvbiBoaW50IGhhcyBhIGZpZWxkIHdpdGggYGFsaWduYA0KPiA+
ICAgICByZXByZXNlbnRhdGlvbiBoaW50Lg0KPiA+IC4uLg0KPiANCj4gc28gdGhlIHN0cnVjdCBp
czoNCj4gDQo+IHN0cnVjdCBhbHRfaW5zdHIgew0KPiAgICAgICAgIHMzMiBpbnN0cl9vZmZzZXQ7
ICAgICAgIC8qIG9yaWdpbmFsIGluc3RydWN0aW9uICovDQo+ICAgICAgICAgczMyIHJlcGxfb2Zm
c2V0OyAgICAgICAgLyogb2Zmc2V0IHRvIHJlcGxhY2VtZW50IGluc3RydWN0aW9uICovDQo+IA0K
PiAgICAgICAgIHVuaW9uIHsNCj4gICAgICAgICAgICAgICAgIHN0cnVjdCB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHUzMiBjcHVpZDogMTY7ICAvKiBDUFVJRCBiaXQgc2V0IGZvciByZXBs
YWNlbWVudCAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgZmxhZ3M6IDE2OyAgLyog
cGF0Y2hpbmcgY29udHJvbCBmbGFncyAqLw0KPiAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAg
ICAgICAgICAgIHUzMiBmdF9mbGFnczsNCj4gICAgICAgICB9Ow0KPiANCj4gICAgICAgICB1OCAg
aW5zdHJsZW47ICAgICAgICAgICAvKiBsZW5ndGggb2Ygb3JpZ2luYWwgaW5zdHJ1Y3Rpb24gKi8N
Cj4gICAgICAgICB1OCAgcmVwbGFjZW1lbnRsZW47ICAgICAvKiBsZW5ndGggb2YgbmV3IGluc3Ry
dWN0aW9uICovDQo+IH0gX19wYWNrZWQ7DQo+IA0KPiBhbmQgZXZlcnl0aGluZyBpcyBuYXR1cmFs
bHkgYWxpZ25lZC4NCg0KV2hpbGUgdGhlcmUgd291bGQgYmUgbm8gcGFkZGluZyBiZXR3ZWVuIGFu
eSBvZiB0aGUgc3RyaWN0dXJlIG1lbWJlcnMNCnRoYXQgaXMgbGFyZ2VseSBpcnJlbGV2YW50Lg0K
VGhlIF9fcGFja2VkIHJlbW92ZXMgdGhlIHR3byBwYWQgYnl0ZXMgZnJvbSB0aGUgZW5kIG9mIHRo
ZSBzdHJ1Y3R1cmUNCmFuZCBhbHNvIHRlbGxzIHRoZSBjb21waWxlciB0aGF0IHRoZSBzdHJ1Y3R1
cmUgaXRzZWxmIG1heSBub3QgYmUNCmFsaWduZWQgaW4gbWVtb3J5Lg0KDQpTbyB0aGUgYml0Zmll
bGRzIGNhbiBiZSBtaXNhbGlnbmVkIGluIG1lbW9yeS4NClF1aXRlIHdoeSB0aGV5IGFyZSBiaXRm
aWVsZHMgaXMgYW55Ym9kaWVzIGd1ZXNzLCB1MTYgd291bGQgc3VmZmljZS4NClVzaW5nIHUxNiB3
b3VsZCBhbHNvIGdlbmVyYXRlIGEga25vd24gbWVtb3J5IGxheW91dCAoYml0ZmllbGRzIGFyZQ0K
YmVzdCBwYXJ0IG9mIGNvbXBpbGVyIGRlZmluZWQgLSBjZXJ0YWlubHkgbm90IGVuZGlhbm5lc3Mg
ZGVmaW5lZC4pDQoNCklmIHRoZSBpbnRlbnQgb2YgdGhlIF9fcGFja2VkIGlzIHRvIHNhdmUgMiBi
eXRlcyBvbiBldmVyeSBjb3B5DQpvZiB0aGUgc3RydWN0dXJlIHRoZW4gX19wYWNrZWQgX19hbGln
bmVkKDIpIHdpbGwgaGF2ZSB0aGUgc2FtZQ0KZWZmZWN0IHdoaWxlIGFsbG93aW5nIHRoZSBjb21w
aWxlciB0byB1c2UgMTYtYml0IGFjY2Vzc2VzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

