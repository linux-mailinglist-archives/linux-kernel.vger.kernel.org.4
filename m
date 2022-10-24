Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E060BE21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJXXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiJXXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:04:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C782D8732
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:25:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-QO35gdfgOYKQaXrkZ7Sh9w-1; Mon, 24 Oct 2022 22:24:19 +0100
X-MC-Unique: QO35gdfgOYKQaXrkZ7Sh9w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Oct
 2022 22:24:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 24 Oct 2022 22:24:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Topic: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Index: AQHY59EzH4qdMwC1Yk+S6+0KOnujn64eCxPg
Date:   Mon, 24 Oct 2022 21:24:18 +0000
Message-ID: <4218173bd72b4f1899d4c41a8e251f0d@AcuMS.aculab.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com> <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com> <202210241035.1487F523@keescook>
 <CAJZ5v0jczp8J89EdywFDbzPmmeKmoQ3wNFUmKxH_1xS7LPNzkA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jczp8J89EdywFDbzPmmeKmoQ3wNFUmKxH_1xS7LPNzkA@mail.gmail.com>
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

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogMjQgT2N0b2JlciAyMDIyIDE4OjUxDQou
Li4NCj4gPiBJdCBsb29rcyBsaWtlIGl0IHdhcyBkZXNpZ25lZCB0byBoYW5kbGUgdGhlIGNhc2Vz
IHdoZXJlIHRoZSBwb2ludGVyIHdhcw0KPiA+IEVSUl9PUl9OVUxMOg0KPiA+DQo+ID4gICAgICAg
IElTX0VSUl9PUl9OVUxMKF9fbXB0cikgPyBFUlJfQ0FTVChfX21wdHIpIDogXA0KPiA+ICAgICAg
ICAgICAgICAgICgodHlwZSAqKShfX21wdHIgLSBvZmZzZXRvZih0eXBlLCBtZW1iZXIpKSk7IH0p
DQo+ID4NCj4gPiBpLmUuIGp1c3QgcGFzcyB0aHJvdWdoIHRoZSBOVUxML0VSUiBpbnN0ZWFkIG9m
IGF0dGVtcHRpbmcgdGhlIGNhc3QsDQo+ID4gd2hpY2ggd291bGQgZmFpbCBzcGVjdGFjdWxhcmx5
LiA6KQ0KPiA+DQo+ID4gSXQgc2VlbXMgbGlrZSB0aGlzIHZlcnNpb24gc2hvdWxkIGFjdHVhbGx5
IGJlIHVzZWQgZXZlcnl3aGVyZSBpbnN0ZWFkIG9mDQo+ID4gbm93aGVyZS4uLiAoaS5lLiBqdXN0
IGRyb3AgY29udGFpbmVyX29mKCkgYW5kIHJlbmFtZSBjb250YWluZXJfb2Zfc2FmZSgpDQo+ID4g
dG8gY29udGFpbmVyX29mKCkpDQo+IA0KPiBBcyBhIHJ1bGUsIHRob3VnaCwgdXNlcnMgb2YgY29u
dGFpbmVyX29mKCkgZG9uJ3QgY2hlY2sgdGhlIHBvaW50ZXINCj4gcmV0dXJuZWQgYnkgaXQgYWdh
aW5zdCBOVUxMLCBzbyBJJ20gbm90IHN1cmUgaG93IG11Y2ggb2YgYW4NCj4gaW1wcm92ZW1lbnQg
dGhhdCB3b3VsZCBiZS4NCj4gDQo+IElmIE5VTEwgaXMgcGFzc2VkIHRvIGNvbnRhaW5lcl9vZigp
LCB0aGVyZSB3aWxsIGJlIGEgc3BlY3RhY3VsYXINCj4gZmFpbHVyZSwgc29vbmVyIG9yIGxhdGVy
IC4uLg0KDQpDZXJ0YWlubHkgdGhlcmUgaXNuJ3QgbXVjaCBkaWZmZXJlbmNlIGJldHdlZW4gZGVy
ZWZlcmVuY2luZw0KYSAtRXh4eHggdmFsdWUgYW5kIC1FeHh4eCAtIG9mZnNldG9mKCkuDQpCb3Ro
IGFyZSBpbiB0aGUgc2FtZSBwYWdlIC0gaG9wZWZ1bGx5IG5vdCBtYXBwZWQ/DQoNCk1pc3Npbmcg
RVJSL05VTEwgY2hlY2tzIGFyZSBhIHByb2JsZW0gYnV0IGFkZGluZyBvbmUgaW5zaWRlDQpjb250
YWluZXJfb2YoKSBkb2Vzbid0IHJlYWxseSBoZWxwLg0KDQpZb3UgbWlnaHQgYXMgd2VsbCBhZGQg
YW4gZXhwbGljaXQgdGVzdCBiZWZvcmUgdXNpbmcgY29udGFpbmVyX29mKCkNCnJhdGhlciB0aGFu
IGFkZGluZyBvbmUgaW5zaWRlIGl0IEFORCByZXF1aXJpbmcgYSB0ZXN0IGFmdGVyd2FyZHMuDQpJ
IGRvbid0IHRoaW5rIHRoZSBjb21waWxlciBjYW4gYXNzdW1lIHRoZSBzdWJ0cmFjdGlvbiBkb2Vz
bid0DQpnZW5lcmF0ZSBOVUxMIC0gc28gbXVzdCBjaGVjayB0d2ljZS4NCg0KSSd2ZSBub3QgZXZl
biBzdXJlIGhvdyBtYW55IG9mIHRoZSBmdW5jdGlvbnMgdGhhdCBjYW4gY2hlY2sgY2FuDQpldmVy
IGFjdHVhbGx5IGJlIHBhc3NlZCBhbiBpbnZhbGlkIHBvaW50ZXIuDQpOb3JtYWxseSB0aGUgY2Fs
bGVyIGJhaWxzIG91dCBhbmQgcmV0dXJucyB0aGUgZXJyb3IgYmVmb3JlDQpwYXNzaW5nIGl0IG9u
Lg0KVGhlIGtlcm5lbCByZWFsbHkgZG9lc24ndCBjaGVjayBldmVyeSBmdW5jdGlvbiBwYXJhbWV0
ZXIgZm9yDQp2YWxpZGl0eSAtIGl0IGhhcyB0byBhc3N1bWUgdGhlIGNhbGxlciBpcyBkb2luZyBz
b21ldGhpbmcgc2Vuc2libGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

