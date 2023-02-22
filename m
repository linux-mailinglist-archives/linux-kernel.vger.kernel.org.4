Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D2369FEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjBVWmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBVWml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:42:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF1135247
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:42:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-123-Ghao7OUBPH-Y2K61j5y3OQ-1; Wed, 22 Feb 2023 22:42:37 +0000
X-MC-Unique: Ghao7OUBPH-Y2K61j5y3OQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Wed, 22 Feb
 2023 22:42:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Wed, 22 Feb 2023 22:42:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mina Almasry' <almasrymina@google.com>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] arch: Enable function alignment for arm64
Thread-Topic: [PATCH v1] arch: Enable function alignment for arm64
Thread-Index: AQHZL+y0RRcMkmENukGyDrKLrCNKda6u+djAgCy80ACAAARF8A==
Date:   Wed, 22 Feb 2023 22:42:35 +0000
Message-ID: <533d55ba7b774eb494c653260d9768b7@AcuMS.aculab.com>
References: <20221208053649.540891-1-almasrymina@google.com>
 <20230124120913.GA26449@willie-the-truck>
 <c663ba9da2c14c69a126f01774cf5973@AcuMS.aculab.com>
 <CAHS8izNbZ=8on1qx+DmVwVX_oqQ4NwPULjxyy00dSUoJDfyskw@mail.gmail.com>
In-Reply-To: <CAHS8izNbZ=8on1qx+DmVwVX_oqQ4NwPULjxyy00dSUoJDfyskw@mail.gmail.com>
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

RnJvbTogTWluYSBBbG1hc3J5DQo+IFNlbnQ6IDIyIEZlYnJ1YXJ5IDIwMjMgMjI6MTYNCj4gDQo+
IE9uIFdlZCwgSmFuIDI1LCAyMDIzIGF0IDM6MTYgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBXaWxsIERlYWNvbiA8d2lsbEBr
ZXJuZWwub3JnPg0KPiA+ID4gU2VudDogMjQgSmFudWFyeSAyMDIzIDEyOjA5DQo+ID4gPg0KPiA+
ID4gT24gV2VkLCBEZWMgMDcsIDIwMjIgYXQgMDk6MzY6NDhQTSAtMDgwMCwgTWluYSBBbG1hc3J5
IHdyb3RlOg0KPiA+ID4gPiBXZSByZWNlbnRseSByYW4gaW50byBhIGRvdWJsZS1kaWdpdCBwZXJj
ZW50YWdlIGhhY2tiZW5jaCByZWdyZXNzaW9uDQo+ID4gPiA+IHdoZW4gYmFja3BvcnRpbmcgY29t
bWl0IDEyZGYxNDBmMGJkZiAoIm1tLGh1Z2V0bGI6IHRha2UgaHVnZXRsYl9sb2NrDQo+ID4gPiA+
IGJlZm9yZSBkZWNyZW1lbnRpbmcgaC0+cmVzdl9odWdlX3BhZ2VzIikgdG8gYW4gb2xkZXIga2Vy
bmVsLiBUaGlzIHdhcw0KPiA+ID4gPiBzdXJwcmlzaW5nIHNpbmNlIGhhY2tiZW5jaCBkb2VzIHVz
ZSBodWdldGxiIHBhZ2VzIGF0IGFsbCBhbmQgdGhlDQo+ID4gPiA+IG1vZGlmaWVkIGNvZGUgaXMg
bm90IGludm9rZWQuIEFmdGVyIHNvbWUgZGVidWdnaW5nIHdlIGZvdW5kIHRoYXQgdGhlDQo+ID4g
PiA+IHJlZ3Jlc3Npb24gY2FuIGJlIGZpeGVkIGJ5IGJhY2stcG9ydGluZyBjb21taXQgZDQ5YTA2
MjYyMTZiICgiYXJjaDoNCj4gPiA+ID4gSW50cm9kdWNlIENPTkZJR19GVU5DVElPTl9BTElHTk1F
TlQiKSBhbmQgZW5hYmxpbmcgZnVuY3Rpb24gYWxpZ25tZW50DQo+ID4gPiA+IGZvciBhcm02NC4g
SSBzdWdnZXN0IGVuYWJsaW5nIGl0IGJ5IGRlZmF1bHQgZm9yIGFybTY0IGlmIHBvc3NpYmxlLg0K
PiA+ID4gPg0KPiA+IC4uLg0KPiA+ID4NCj4gPiA+IFRoaXMgaW5jcmVhc2VzIHRoZSBzaXplIG9m
IC50ZXh0IGZvciBhIGRlZmNvbmZpZyBidWlsZCBieSB+MiUsIHNvIEkgdGhpbmsgaXQNCj4gPiA+
IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBzb21lIHJlYWwgbnVtYmVycyBmb3IgdGhlIHBlcmZvcm1h
bmNlIHVwbGlmdC4gQXJlIHlvdQ0KPiA+ID4gYWJsZSB0byBlbGFib3JhdGUgYmV5b25kICJkb3Vi
bGUtZGlnaXQgcGVyY2VudGFnZSBoYWNrYmVuY2ggcmVncmVzc2lvbiI/DQo+ID4gPg0KPiA+ID4g
SW4gZ2VuZXJhbCwgaG93ZXZlciwgSSdtIHN1cHBvcnRpdmUgb2YgdGhlIHBhdGNoIChhbmQgaXQg
c2VlbXMgdGhhdCB4ODYNCj4gPiA+IGRvZXMgdGhlIHNhbWUgdGhpbmcpIHNvOg0KPiA+DQo+ID4g
SSBiZXQgaXQganVzdCBjaGFuZ2VzIHRoZSBhbGlnbm1lbnQgb2YgdGhlIGNvZGUgc28gdGhhdCBt
b3JlDQo+ID4gZnVuY3Rpb25zIGFyZSB1c2luZyBkaWZmZXJlbnQgY2FjaGUgbGluZXMuDQo+ID4N
Cj4gPiBBbGwgc29ydHMgb2Ygb3RoZXIgcmFuZG9tIGNoYW5nZXMgYXJlIGxpa2VseSB0byBoYXZl
IGEgc2ltaWxhciBlZmZlY3QuDQo+ID4NCj4gPiBDYWNoZS1saW5lIGFsaWduaW5nIHRoZSBzdGFy
dCBvZiBhIGZ1bmN0aW9uIHByb2JhYmx5IHJlZHVjZXMgdGhlDQo+ID4gbnVtYmVyIG9mIGNhY2hl
IGxpbmVzIHRoZSBmdW5jdGlvbnMgbmVlZHMgLSBidXQgdGhhdCBpc24ndCBndWFyYW50ZWVkLg0K
PiA+IEl0IGFsc28gc2xpZ2h0bHkgcmVkdWNlcyB0aGUgZGVsYXkgb24gYSBjYWNoZSBtaXNzIC0g
YnV0IHRoZXkgYXJlIHNvDQo+ID4gc2xvdyBpdCBwcm9iYWJseSBtYWtlcyBhbG1vc3Qgbm8gZGlm
ZmVyZW5jZS4NCj4gPg0KPiANCj4gRGF2aWQsIG15IHVuZGVyc3RhbmRpbmcgaXMgc2ltaWxhciB0
byB5b3Vycy4gSS5lLiB3aXRob3V0IGV4cGxpY2l0IGFsaWdubWVudDoNCj4gDQo+IDEuIFJhbmRv
bSBjaGFuZ2VzIHRvIHRoZSBjb2RlIGNhbiBjYXVzZSBjcml0aWNhbCBwYXRoIGZ1bmN0aW9ucyB0
bw0KPiBiZWNvbWUgYWxpZ25lZCBvciB1bmFsaWduZWQgd2hpY2ggd2lsbCBjYXVzZSBwZXJmDQo+
IHJlZ3Jlc3Npb25zL2ltcHJvdmVtZW50cy4NCj4gMi4gUmFuZG9tIGNoYW5nZXMgdG8gdGhlIGNv
ZGUgY2FuIGNhdXNlIGNyaXRpY2FsIHBhdGggZnVuY3Rpb25zIHRvIGJlDQo+IHBsYWNlZCBuZWFy
IGEgY2FjaGUgbGluZSBib3VuZGFyeSwgY2F1c2luZyBvbmUgbW9yZSBjYWNoZSBsaW5lIHRvIGJl
DQo+IGxvYWRlZCB3aGVuIHRoZXkgYXJlIHJ1biwgd2hpY2ggd2lsbCBjYXVzZSBwZXJmIHJlZ3Jl
c3Npb25zLg0KPiANCj4gU28gZm9yIHRoZXNlIHZlcnkgcmVhc29ucyBmdW5jdGlvbiBhbGlnbm1l
bnQgaXMgYSBnb29kIHRoaW5nLg0KDQpFeGNlcHQgdGhhdCBhbGlnbmluZyBmdW5jdGlvbnMgZG9l
c24ndCBuZWNlc3NhcmlseSBpbXByb3ZlIHRoaW5ncy4NCg0KRXZlbiB3aXRoaW4gYSBmdW5jdGlv
biB0aGUgYWxpZ25tZW50IG9mIHRoZSB0b3Agb2YgYSBsb29wICh0aGF0DQppcyBleGVjdXRlZCBh
IGxvdCkgbWlnaHQgbWF0dGVyIG1vcmUgdGhhbiB0aGUgYWxpZ25tZW50IG9mIHRoZQ0KZnVuY3Rp
b24gaXRzZWxmLg0KDQpBbnkgY2hhbmdlIHdpbGwgYWZmZWN0IHdoaWNoIGNvZGUgJ3NoYXJlJyBj
YWNoZSBsaW5lcyBzbyBjYW4NCnN0b3AgdGhlIHdvcmtpbmcgc2V0IG9mIHNvbWUgdGVzdCAob3Ig
Y29kZSBsb29wIHdpdGggZGVlcA0KZnVuY3Rpb24gY2FsbHMpIGZyb20gZml0dGluZyBpbiB0aGUg
SS1jYWNoZSBzbyBtYWtpbmcgaXQNCm11Y2ggc2xvd2VyLg0KDQpDaGFuZ2luZyB0aGUgc2l6ZSBh
bHNvIGFmZmVjdHMgd2hlcmUgdGhlIFRMQiBib3VuZGFyaWVzIGFyZQ0KKGVzcGVjaWFsbHkgaWYg
bm90IHVzaW5nIHZlcnkgbGFyZ2UgcGFnZXMpLg0KSWYgdGhlIG51bWJlciBvZiBwYWdlcyBleGNl
ZWRzIHRoZSBudW1iZXIgb2YgVExCIHRoaW5ncw0Kd2lsbCBzbG93IGRvd24uDQoNCkkgdGhpbmsg
b25lIHZlcnNpb24gb2YgZ2NjIHVzZWQgdG8gYWxpZ24gbW9zdCBsYWJlbHMuDQpXaGlsZSB0aGUg
Y29kZSBtaWdodCBiZSBzbGlnaHRseSBmYXN0ZXIsIHRoZSBibG9hdCBhY3R1YWxseQ0KbWFkZSBp
dCBhIG5ldCBsb3NzLg0KDQpTbyBhbGlnbmluZyBmdW5jdGlvbnMgbWlnaHQgaGVscCwgYnV0IGl0
IG1pZ2h0IGp1c3QNCm1ha2UgdGhpbmdzIHdvcnNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

