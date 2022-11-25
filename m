Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E931638CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKYPEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKYPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:04:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041161A23D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:04:46 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-149-pJJNRtCWOniSHKEqYW45oQ-1; Fri, 25 Nov 2022 15:04:43 +0000
X-MC-Unique: pJJNRtCWOniSHKEqYW45oQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 15:04:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 15:04:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sandy Harris' <sandyinchina@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH] random: add 8-bit and 16-bit batches
Thread-Topic: [PATCH] random: add 8-bit and 16-bit batches
Thread-Index: AQHZAIP4o7HbqUXjoUGVncfvVGWCWq5PvPcw
Date:   Fri, 25 Nov 2022 15:04:41 +0000
Message-ID: <a171166422a545a99ac815541018d44f@AcuMS.aculab.com>
References: <20220928165018.73496-1-Jason@zx2c4.com>
 <CACXcFmkyoNu5fU=pAxPNY-bwGyJ5bd2LkmVkxHGOubZmbbzT_Q@mail.gmail.com>
In-Reply-To: <CACXcFmkyoNu5fU=pAxPNY-bwGyJ5bd2LkmVkxHGOubZmbbzT_Q@mail.gmail.com>
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

RnJvbTogU2FuZHkgSGFycmlzDQo+IFNlbnQ6IDI1IE5vdmVtYmVyIDIwMjIgMDQ6MTENCj4gDQo+
IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDE6MzMgQU0gSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNv
bkB6eDJjNC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlcmUgYXJlIG51bWVyb3VzIHBsYWNlcyBp
biB0aGUga2VybmVsIHRoYXQgd291bGQgYmUgc3BlZCB1cCBieSBoYXZpbmcNCj4gPiBzbWFsbGVy
IGJhdGNoZXMuIC4uLg0KPiANCj4gPiAgdm9pZCBnZXRfcmFuZG9tX2J5dGVzKHZvaWQgKmJ1Ziwg
c2l6ZV90IGxlbik7DQo+ID4gK3U4IGdldF9yYW5kb21fdTgodm9pZCk7DQo+ID4gK3UxNiBnZXRf
cmFuZG9tX3UxNih2b2lkKTsNCj4gPiAgdTMyIGdldF9yYW5kb21fdTMyKHZvaWQpOw0KPiA+ICB1
NjQgZ2V0X3JhbmRvbV91NjQodm9pZCk7DQo+ID4gIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50
IGdldF9yYW5kb21faW50KHZvaWQpDQo+IA0KPiBUbyBtZSwgdGhlIDMyLWJpdCAmIDY0LWJpdCBm
dW5jdGlvbnMgbG9vayBsaWtlIGFuDQo+IG9idmlvdXNseSBnb29kIGlkZWEuIEhvd2V2ZXIsIEkg
Y2Fubm90IHNlZQ0KPiB0aGF0IHRoZSA4LWJpdCBvciAxNi1iaXQgZnVuY3Rpb25zIGFyZSBuZWVk
ZWQuDQo+IA0KPiBFdmVuIGxpYnJhcnkgZnVuY3Rpb25zIGxpa2UgZ2V0Y2hhcigpIHJldHVybiBh
bg0KPiBpbnQgJiB3aGF0ZXZlciB5b3UgcmV0dXJuLCBpdCBpcyBnb2luZyB0byBiZQ0KPiBoYW5k
bGVkIGFzIGFuIGludC1zaXplZCBpdGVtIGlmIGl0IGdvZXMgaW4gYQ0KPiByZWdpc3Rlciwgc28g
d2hhdCdzIHRoZSBwb2ludD8NCg0KVGhleSBhdm9pZCAndXNpbmcgdXAnIHJhbmRvbSB2YWx1ZXMg
dGhlIGNhbGxlcnMgd29udCB1c2UuDQpUaGlzIGNhbiBzYXZlIGV4cGVuc2l2ZSByZS1oYXNoaW5n
IChldGMpLg0KDQpPVE9IIHRoZSByZXR1cm4gdHlwZXMgc2hvdWxkIHByb2JhYmx5IGJlIHUzMiBl
dmVuIHRob3VnaCB0aGUNCmRvbWFpbiBpcyBzbWFsbGVyLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

