Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1261228E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ2Lri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2Lrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:47:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF76178B7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:47:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-tgQyLKm6N-GCBI1-CWKo5w-1; Sat, 29 Oct 2022 12:47:31 +0100
X-MC-Unique: tgQyLKm6N-GCBI1-CWKo5w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 29 Oct
 2022 12:47:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Sat, 29 Oct 2022 12:47:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Subject: RE: [PATCH] kbuild: drop -Wdeclaration-after-statement
Thread-Topic: [PATCH] kbuild: drop -Wdeclaration-after-statement
Thread-Index: AQHY6w+lqC88uwzGKUa42ZlWxBqczq4lQRfg
Date:   Sat, 29 Oct 2022 11:47:31 +0000
Message-ID: <45b92f4e5794439fb8057611ef0096d3@AcuMS.aculab.com>
References: <Y1w031iI6Ld29IVT@p183>
 <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
 <Y1xBwRCHoQtMyPf8@p183>
In-Reply-To: <Y1xBwRCHoQtMyPf8@p183>
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

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDI4IE9jdG9iZXIgMjAyMiAyMTo1NQ0KPiAN
Cj4gT24gRnJpLCBPY3QgMjgsIDIwMjIgYXQgMDE6Mjk6MDhQTSAtMDcwMCwgTGludXMgVG9ydmFs
ZHMgd3JvdGU6DQo+ID4gT24gRnJpLCBPY3QgMjgsIDIwMjIgYXQgMTowMCBQTSBBbGV4ZXkgRG9i
cml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFB1dHRpbmcg
ZGVjbGFyYXRpb25zIGluIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGJsb2NrIGlzIGFuIGFmdGVyZmFj
dCBmcm9tDQo+ID4gPiBzaW5nbGUgcGFzcyBjb21waWxlciBlcmEuIENvbXBpbGVyIHdvdWxkIHBh
cnNlIGFsbCBkZWNsYXJhdGlvbnMsIGxheW91dA0KPiA+ID4gc3RhY2sgZnJhbWUgYW5kIHByb2Nl
ZWQgdG8gZ2VuZXJhdGUgY29kZS4NCj4gPg0KPiA+IE5vLCBwdXR0aW5nIGRlY2xhcmF0aW9ucyBh
dCB0aGUgYmVnaW5uaW5nIGlzIHN0aWxsIGtlcm5lbCBzeW50YXguDQo+ID4NCj4gPiBEb24ndCBk
ZWNsYXJlIHZhcmlhYmxlcyBpbiBtdWx0aXBsZSBwbGFjZXMuIEl0IGdldHMgcmVhbGx5IGNvbmZ1
c2luZy4NCj4gDQo+IEl0IGlzIG5vdC4gU29tZWhvdyBtaWxsaW9ucyBvZiBwcm9ncmFtbWVycyBt
YW5hZ2UgdG8gZmluZCB0aGVpcg0KPiB2YXJpYWJsZXMganVzdCBmaW5lIGluIEMgYW5kIG90aGVy
IHByb2dyYW1taW5nIGxhbmd1YWdlcy4NCg0KSGF2ZSB5b3UgZXZlciB0cmllZCBpdCB3aGVuIC1X
c2hhZG93IGlzbid0IGVuYWJsZWQgYW5kIHZhcmlhYmxlcw0Kd2l0aCB0aGUgc2FtZSBuYW1lIGFy
ZSByZWRlZmluZWQgaW4gdGhlIG1pZGRsZSBvZiBibG9ja3M/DQoNCkMrKyBoYXMgdG8gYWxsb3cg
aXQgKGFuZCBpdCBpcyBhbm5veWluZyB0byBmaW5kIGRlZmluaXRpb25zKQ0KYmVjYXVzZSB0aGUg
aW5pdGlhbGlzZXIgaGFzIHRvIGJlIGNhbGxlZC4NCkJ1dCB5b3UgY2FuJ3QgdXNlIGEgJ2dvdG8n
IHRvIGp1bXAgcGFzdCBhIGRlY2xhcmF0aW9uLg0KDQo+ID4gUHV0IGFsbCBkZWNsYXJhdGlvbnMg
YXQgdGhlIHRvcCBvZiB0aGUgYmxvY2sgdGhleSBhcmUgY29udGFpbmVkIGluLg0KDQpPciBiZXR0
ZXIsIGVpdGhlciBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbiBvciBpbiBhIHNtYWxsIGJsb2Nr
DQood2hlcmUgdGhlIGxpbWl0ZWQgc2NvcGUgaXMgYWJzb2x1dGVseSBvYnZpb3VzKS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

