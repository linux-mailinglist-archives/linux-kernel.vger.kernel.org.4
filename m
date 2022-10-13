Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB55FD923
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJMMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:22:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B176118747
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:22:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-221-fYkKU98OO8mGbD5J_5kNzA-1; Thu, 13 Oct 2022 13:22:38 +0100
X-MC-Unique: fYkKU98OO8mGbD5J_5kNzA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 13 Oct
 2022 13:22:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Thu, 13 Oct 2022 13:22:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "Linux Kbuild mailing list" <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: gcc 5 & 6 & others already out of date?
Thread-Topic: gcc 5 & 6 & others already out of date?
Thread-Index: AQHY3qRO7iEL7dtsYEaMGjvDqAFL8a4MPngQ
Date:   Thu, 13 Oct 2022 12:22:37 +0000
Message-ID: <8e31925d92e9496dad35290bad1c3dd3@AcuMS.aculab.com>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
In-Reply-To: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDEzIE9jdG9iZXIgMjAyMiAwMjozNw0K
Li4uDQo+IEFuZCB0aGVuIHRoZXJlJ3Mgb2xkIHRydXN0eSBnY2MuIEdjYyBhbHNvIGltcHJvdmVz
IGFjY29yZGluZyB0byBhIG5pY2UNCj4gY2FkZW5jZSwgYW5kIHdlIGtub3cgcGVvcGxlIGFyZSB1
c2luZyBsYXRlciBnY2NzIGJlY2F1c2Ugbm9ib2R5IGlzDQo+IGNhdGNoaW5nIHRoZSBidWlsZCBl
cnJvcnMgZnJvbSBvbGQgZ2Njcy4gU28gbGV0J3Mgc3RvcCBwcmV0ZW5kaW5nIHdlDQo+IHN1cHBv
cnQgb2xkIGNvbXBpbGVycy4gV2UgY2xlYXJseSBkb24ndC4gTWF5YmUgc29tZSBzdWJzZXQgb2Yg
Y29kZQ0KPiBkb2VzLCBidXQgYnkgYW5kIGxhcmdlLCBJIGRvdWJ0IG1hbnkgZGV2ZWxvcGVycyBh
cmUgYWN0dWFsbHkgZGFpbHkNCj4gZHJpdmluZyBnY2MgNS4xIGFuZCBkb2luZyBhbGx5ZXNjb25m
aWcgYnVpbGRzIHdpdGggaXQuIFllcywgbWFueSBhcmUNCj4gcmlnaHRmdWxseSBjYXV0aW91cyBv
ZiBnY2MgMTIgYW5kIHN0aWNrIHdpdGggZ2NjIDExIHN0aWxsLCBhbmQgdGhhdCdzDQo+IHJlYXNv
bmFibGUsIGJ1dCAxMSBvciBldmVuIDEwIGlzIHN0aWxsIHdheSBsYXJnZXIgdGhhbiA1LjEuDQo+
IA0KPiBUaGUgdHJ1dGggaXMsIHBlb3BsZSB0ZW5kIHRvIHVzZSBtb3JlIHJlY2VudCB0b29sY2hh
aW5zLiBBbmQgaWYgQ2xhbmcNCj4gaGFzbid0IGJyb2tlbiB0aGUgd2lsbCBvZiB0aGUgc3RyYW5n
bGVycywgdGhlbiBzdXJlbHkgUnVzdCB3aWxsLg0KDQpEZXZlbG9wZXJzIG1pZ2h0IHVzZSByZWNl
bnQgdG9vbGNoYWlucywgYnV0IHVzZXJzIGFyZSBtdWNoDQptb3JlIGxpa2VseSB0byB1c2UgdGhl
IG9uZSBpbiB0aGUgZGlzdHJpYnV0aW9uIHRoZXkgaGF2ZSBpbnN0YWxsZWQuDQoNCldvcmtpbmcg
b3V0IGhvdyB0byBidWlsZCBhIGtlcm5lbCBpcyBoYXJkIGVub3VnaC4NClJlcXVpcmluZyBub24t
c3RhbmRhcmQgdmVyc2lvbnMgb2YgZ2NjIGlzIGEgUElUQS4NClJlbWVtYmVyIHRoYXQgeW91IGNh
biBsb2FkIGEgY3VycmVudCBrZXJuZWwgb24gcXVpdGUNCm9sZCB1c2Vyc3BhY2UuDQpUaGVyZSBj
YW4gYmUgYWxsIHNvcnRzIG9mIHJlYXNvbnMgZm9yIHdhbnRpbmcgdG8ga2VlcCBidWlsZGluZw0K
bm9uLWtlcm5lbCAnc3R1ZmYnIHdpdGggdGhlIGRlZmF1bHQgdG9vbGNoYWluLg0KDQpBbnlvbmUg
dXNpbmcgY2xhbmcgYWxtb3N0IGNlcnRhaW5seSBoYXMgdG8gZG93bmxvYWQgYSByZWNlbnQNCnZl
cnNpb24gLSBidXQgdGhpcyBpcyBub3QgdHJ1ZSBvZiBnY2MuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

