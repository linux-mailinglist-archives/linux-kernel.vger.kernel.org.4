Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DB72C308
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjFLLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjFLLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:37:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5C7D9C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:22:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-261-YAv902QKNE-1ixxPiO8tQA-1; Mon, 12 Jun 2023 12:22:27 +0100
X-MC-Unique: YAv902QKNE-1ixxPiO8tQA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Jun
 2023 12:22:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 12 Jun 2023 12:22:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Breno Leitao <leitao@debian.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "leit@meta.com" <leit@meta.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Thread-Topic: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Thread-Index: AQHZmviQI/r0/Sv4xEqYGehxHbaKRa+HB92A
Date:   Mon, 12 Jun 2023 11:22:15 +0000
Message-ID: <543116e1a8cf4b7a8b086c850374f99e@AcuMS.aculab.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
In-Reply-To: <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDA5IEp1bmUgMjAyMyAxODozNA0KPiANCj4g
T24gRnJpLCBGZWIgMDMsIDIwMjMgYXQgMDQ6MDY6MTVBTSAtMDgwMCwgQnJlbm8gTGVpdGFvIHdy
b3RlOg0KPiA+IFJpZ2h0IG5vdyBpdCBpcyBub3QgcG9zc2libGUgdG8gZGlzYWJsZSBDUFUgdnVs
bmVyYWJpbGl0aWVzIG1pdGlnYXRpb25zDQo+ID4gYXQgYnVpbGQgdGltZS4gTWl0aWdhdGlvbiBu
ZWVkcyB0byBiZSBkaXNhYmxlZCBwYXNzaW5nIGtlcm5lbA0KPiA+IHBhcmFtZXRlcnMsIHN1Y2gg
YXMgJ21pdGlnYXRpb25zPW9mZicuDQo+ID4NCj4gPiBDcmVhdGUgYSBuZXcgY29uZmlnIG9wdGlv
biAoQ09ORklHX0NQVV9NSVRJR0FUSU9OU19ERUZBVUxUX09GRikgdGhhdA0KPiA+IHNldHMgdGhl
IGdsb2JhbCB2YXJpYWJsZSBgY3B1X21pdGlnYXRpb25zYCB0byBPRkYsIGluc3RlYWQgb2YgQVVU
Ty4gVGhpcw0KPiA+IGFsbG93cyB0aGUgY3JlYXRpb24gb2Yga2VybmVsIGJpbmFyaWVzIHRoYXQg
Ym9vdHMgd2l0aCB0aGUgQ1BVDQo+ID4gbWl0aWdhdGlvbnMgdHVybmVkIG9mZiBieSBkZWZhdWx0
LCBhbmQgZG9lcyBub3QgcmVxdWlyZSBkZWFsaW5nIGtlcm5lbA0KPiA+IHBhcmFtZXRlcnMuDQo+
IA0KPiBXaGF0J3MgdGhlIHJlYWwtbGlmZSB1c2UgY2FzZSBmb3IgdGhpcz8NCg0KSSBjYW4gZGVm
aW5pdGVseSBqdXN0aWZ5IGNvbXBpbGluZyB0aGVtIGFsbCBvdXQuDQpGb3IgaW5zdGFuY2UgZW1i
ZWRkZWQgc3lzdGVtcyB3aXRoIGxpbWl0ZWQgdXNlcnNwYWNlIGFuZA0KKHByZXR0eSBtdWNoKSBl
dmVyeXRoaW5nIHJ1bm5pbmcgYXMgcm9vdC4NCg0KQ29tcGlsaW5nIHRoZW0gb3V0IGdpdmVzIGJl
dHRlciBjb2RlIHRoYW4gcGF0Y2hpbmcgdGhlbSBvdXQNCmR1cmluZyBib290Lg0KSSd2ZSBzdG9w
cGVkIHVwZGF0aW5nIGFuIExUUyBrZXJuZWwgYmVjYXVzZSBJIHJlYWxseSBkb24ndA0Kd2FudC9u
ZWVkIGFueSBvZiB0aGUgbWl0aWdhdGlvbnMgLSBlc3BlY2lhbGx5IHRoZSBvbmVzDQphc3NvY2lh
dGVkIHdpdGggJ3JldCcgaW5zdHJ1Y3Rpb25zLg0KVGhleSBhcmUgZmFyIG1vcmUgcGVydmFzaXZl
IHRoYW4gdGhlIG9uZXMgZm9yIGluZGlyZWN0IGp1bXBzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

