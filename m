Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9996642AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjAJOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjAJOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:02:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8F7D1CD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:02:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-SsGC0zidN_CRdpuXUGw0TA-1; Tue, 10 Jan 2023 14:01:54 +0000
X-MC-Unique: SsGC0zidN_CRdpuXUGw0TA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 14:01:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 10 Jan 2023 14:01:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Thread-Topic: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Thread-Index: AQHZJOfS2VU/2mkm2kadStyL0HeH366XrYtA
Date:   Tue, 10 Jan 2023 14:01:50 +0000
Message-ID: <23d1f8db268d43afa332517779b0ef95@AcuMS.aculab.com>
References: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
 <Y71NwKcbVZIZyP8p@zn.tnic>
In-Reply-To: <Y71NwKcbVZIZyP8p@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDEwIEphbnVhcnkgMjAyMyAxMTozNw0KPiAN
Cj4gT24gVHVlLCBKYW4gMTAsIDIwMjMgYXQgMTI6MTU6NDBQTSArMDEwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQo+ID4NCj4gPiBXaXRoICdHTlUgYXNzZW1ibGVyIChHTlUgQmludXRpbHMgZm9y
IERlYmlhbikgMi4zOS45MC4yMDIyMTIzMScgdGhlDQo+ID4gYnVpbGQgbm93IHJlcG9ydHM6DQo+
ID4NCj4gPiAgIGFyY2gveDg2L3JlYWxtb2RlL3JtLy4uLy4uL2Jvb3QvYmlvc2NhbGwuUzogQXNz
ZW1ibGVyIG1lc3NhZ2VzOg0KPiA+ICAgYXJjaC94ODYvcmVhbG1vZGUvcm0vLi4vLi4vYm9vdC9i
aW9zY2FsbC5TOjM1OiBXYXJuaW5nOiBmb3VuZCBgbW92c2QnOyBhc3N1bWluZyBgbW92c2wnIHdh
cyBtZWFudA0KPiA+ICAgYXJjaC94ODYvcmVhbG1vZGUvcm0vLi4vLi4vYm9vdC9iaW9zY2FsbC5T
OjcwOiBXYXJuaW5nOiBmb3VuZCBgbW92c2QnOyBhc3N1bWluZyBgbW92c2wnIHdhcyBtZWFudA0K
PiA+DQo+ID4gICBhcmNoL3g4Ni9ib290L2Jpb3NjYWxsLlM6IEFzc2VtYmxlciBtZXNzYWdlczoN
Cj4gPiAgIGFyY2gveDg2L2Jvb3QvYmlvc2NhbGwuUzozNTogV2FybmluZzogZm91bmQgYG1vdnNk
JzsgYXNzdW1pbmcgYG1vdnNsJyB3YXMgbWVhbnQNCj4gPiAgIGFyY2gveDg2L2Jvb3QvYmlvc2Nh
bGwuUzo3MDogV2FybmluZzogZm91bmQgYG1vdnNkJzsgYXNzdW1pbmcgYG1vdnNsJyB3YXMgbWVh
bnQNCj4gPg0KPiA+IFdoaWNoIGlzIGR1ZSB0bzoNCj4gPg0KPiA+ICAgUFIgZ2FzLzI5NTI1DQo+
ID4NCj4gPiAgIE5vdGUgdGhhdCB3aXRoIHRoZSBkcm9wcGVkIENNUFNEIGFuZCBNT1ZTRCBJbnRl
bCBTeW50YXggc3RyaW5nIGluc24NCj4gPiAgIHRlbXBsYXRlcyB0YWtpbmcgb3BlcmFuZHMsIG1p
eGVkIElzU3RyaW5nL25vbi1Jc1N0cmluZyB0ZW1wbGF0ZSBncm91cHMNCj4gPiAgICh3aXRoIG1l
bW9yeSBvcGVyYW5kcykgY2Fubm90IG9jY3VyIGFueW1vcmUuIFdpdGggdGhhdA0KPiA+ICAgbWF5
YmVfYWRqdXN0X3RlbXBsYXRlcygpIGJlY29tZXMgdW5uZWNlc3NhcnkgKGFuZCBpcyBoZW5jZSBi
ZWluZw0KPiA+ICAgcmVtb3ZlZCkuDQo+ID4NCj4gPiBNb3JlIGRldGFpbHM6IGh0dHBzOi8vc291
cmNld2FyZS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTI5NTI1DQo+IA0KPiBSaWdodCwg
SSdtIGJlaW5nIHRvbGQgdGhlIHBhcnRpY3VsYXIgcHJvYmxlbSBoZXJlIGlzIGlzIHRoYXQgdGhl
ICdkJyBzdWZmaXggaXMNCj4gImNvbmZsaWN0aW5nIiBpbiB0aGUgc2Vuc2UgdGhhdCB5b3UgY2Fu
IGhhdmUgU1NFIG1uZW1vbmljcyBsaWtlIG1vdnNEICV4bW0uLi4NCj4gYW5kIHRoZSBzYW1lIHRo
aW5nIGFsc28gZm9yIHN0cmluZyBvcHMgKHdoaWNoIGlzIHRoZSBjYXNlIGhlcmUpIHNvIGFwcGFy
ZW50bHkNCj4gdGhlIGFncmVlbWVudCBpbiBiaW51dGlscyBsYW5kIGlzIHRvIHVzZSB0aGUgYWx3
YXlzIGFjY2VwdGVkIHN1ZmZpeGVzICdsJyBvciAncScNCj4gYW5kIHBoYXNlIG91dCAnZCcgc2xv
d2x5Li4uDQo+IA0KPiBXaGljaCBpcyBiYXNpY2FsbHkgd2hhdCB0aGUgUFIgdGV4dCBzYXlzIGFi
b3ZlIGJ1dCBtb3JlIHVuZGVyc3RhbmFibGUuIDotKQ0KPiANCj4gTWlnaHQgd2FubmEgYWRkIHRo
YXQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpDYW4gdGhleSBiZSBjaGFuZ2VkIHRvIG1vdnNx
ID8NCm1vdnNsIGhhcyBhbiBpbXBsaWVkIDMyYml0bmVzcyBhYm91dCBpdC4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

