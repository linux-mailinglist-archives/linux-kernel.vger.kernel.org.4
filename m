Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2936BFA11
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:40:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8494429426
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 05:40:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-lYTWO18YOr6zRMPC2d8q3w-1; Sat, 18 Mar 2023 12:40:03 +0000
X-MC-Unique: lYTWO18YOr6zRMPC2d8q3w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Sat, 18 Mar
 2023 12:40:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Sat, 18 Mar 2023 12:40:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'richard clark' <richard.xnu.clark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Question about select and poll system call
Thread-Topic: Question about select and poll system call
Thread-Index: AQHZWKoj15NaHXL3bku7XbgbJ/Iq0a8AePAA
Date:   Sat, 18 Mar 2023 12:40:01 +0000
Message-ID: <7a0033e7db3f4acb9d70b173d063b4d2@AcuMS.aculab.com>
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
 <CAHk-=wh0foAi-kPgNOq6qSHPgsfekT8N9_--usjiTynpQbqvRA@mail.gmail.com>
 <CAJNi4rO+gdRH4Hsx3gOOBS3m=wiH=uroPh7iJ5QgP1iqvNEd_Q@mail.gmail.com>
In-Reply-To: <CAJNi4rO+gdRH4Hsx3gOOBS3m=wiH=uroPh7iJ5QgP1iqvNEd_Q@mail.gmail.com>
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

PiBPbiBGcmksIE1hciAxNywgMjAyMyBhdCAyOjE14oCvQU0gTGludXMgVG9ydmFsZHMNCj4gPHRv
cnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KLi4uDQo+ID4gQW5kIGJh
Y2sgdGhlbiwgd2UgaGFkIHRoaXM6DQo+ID4NCj4gPiAgIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBm
ZF9zZXQ7DQo+ID4NCj4gPiB3aGljaCBtYXkgc2VlbSBhIGJpdCBsaW1pdGluZyB0b2RheSAoIk9u
bHkgMzIgYml0cz8/IT8iKSwgYnV0IHRvIHB1dA0KPiA+IHRoYXQgaW4gcGVyc3BlY3RpdmUsIGJh
Y2sgdGhlbiB3ZSBhbHNvIGhhZCB0aGlzOg0KPiA+DQo+ID4gICAjZGVmaW5lIE5SX09QRU4gMjAN
Cg0KVGhhdCBpcyB0aGUgaGlzdG9yaWMgbGltaXQgZm9yIFNZU1YgKGFuZCBwcm9iYWJseSBCU0Qp
Lg0KSSBzdXNwZWN0IHlvdSBqdXN0IGNvcGllZCBpdC4NClF1aXRlIHdoeSBpdCB3YXMgMjAgYW5k
IG5vdCAxNiBvciAzMiBJIGRvbid0IGtub3cuDQpCdXQgMjAgb3BlbiBmaWxlcyB3YXMgYXNzdW1l
ZCB0byBiZSAncGxlbnR5JyENCg0KVGhlIGZpcnN0IFNZU1Yga2VybmVsIHRoYXQgc3VwcG9ydGVk
IGZkID49IDIwIGFjdHVhbGx5IHVzZWQNCmEgbGlua2VkIGxpc3QgdG8gaG9sZCB0aGUgaW50ZXJu
YWwgZGF0YSAobW9zdGx5IGEgcG9pbnRlcikuDQoNClNvIGFjY2Vzc2luZyBhIGJpZyBmZCBudW1i
ZXIgd2FzIE8oZmQpLg0KQ2FsbGluZyBwb2xsKCkgTyhudW1mZCoqMikgYW5kIGdldHRpbmcgdGhh
dCBtYW55IG9wZW4gc29ja2V0cw0KaW4gYSBuZXR3b3JrIHNlcnZlciBwcm9jZXNzIE8obioqMyku
DQoNCkRvbid0IGV2ZW4gdGhpbmsgYWJvdXQgaG93IHNsb3dseSBhIHByb2Nlc3MgdHJ5aW5nIHRv
DQp1c2UgMjAwMCBzb2NrZXRzIHdhcyENCg0KVGhlIDIwIGZkIGxpbWl0IGFsc28gbWFkZSB0aGVt
IGEgbGltaXRlZCByZXNvdXJjZS4NCkRlbW9ucyBjb3VsZG4ndCByZWFsbHkgYWZmb3JkIHRvIGR1
cCgpIC9kZXYvbnVsbCBvbnRvIDAsIDEgYW5kIDIsDQppbnN0ZWFkIHRoZXknZCBqdXN0IGNsb3Nl
IHRoZSBmZC4NCkFuIGFjY2lkZW50YWwgcHJpbnRmKCkgdGhhdCBzaG91bGQgaGF2ZSBiZWVuIHNw
cmludGYoKSB0aGVuDQpzbG93bHkgZmlsbHMgdGhlIHN0ZG91dCBidWZmZXIsIHdoZW4gdGhhdCBl
dmVudHVhbGx5IGZpbGxzDQp0aGUgd3JpdGUgdG8gZmQgMSBoYXMgc2lkZSBlZmZlY3RzIHRoYXQg
YXJlIHJhdGhlciBkaWZmaWN1bHQNCnRvIGRlYnVnLg0KKFNvbWVvbmUgc2hvdWxkIGhhdmUgbm90
aWNlZCB0aGF0IHRoZSB0cmFjaW5nIHdhcyBpbmNvcnJlY3QpDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

