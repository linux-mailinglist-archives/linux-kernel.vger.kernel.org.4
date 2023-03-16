Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F716BCAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCPJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCPJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:34:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7044B861A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:34:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-268-_Kt5I6A8OTyr-IwvmH3DbQ-1; Thu, 16 Mar 2023 09:34:05 +0000
X-MC-Unique: _Kt5I6A8OTyr-IwvmH3DbQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Thu, 16 Mar
 2023 09:34:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Thu, 16 Mar 2023 09:34:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'richard clark' <richard.xnu.clark@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: Question about select and poll system call
Thread-Topic: Question about select and poll system call
Thread-Index: AQHZVhzW15NaHXL3bku7XbgbJ/Iq0a77izHggAEM7ICAAJBhcA==
Date:   Thu, 16 Mar 2023 09:34:02 +0000
Message-ID: <bc2ce748111d4699a765132a17a14522@AcuMS.aculab.com>
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
 <c708bced26624078842ff7d83e8597d7@AcuMS.aculab.com>
 <CAJNi4rMB46z2hejoPCHyy+qDwE5U2D7H1OUwZ3+_pFAT9-cN3A@mail.gmail.com>
In-Reply-To: <CAJNi4rMB46z2hejoPCHyy+qDwE5U2D7H1OUwZ3+_pFAT9-cN3A@mail.gmail.com>
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

RnJvbTogcmljaGFyZCBjbGFyaw0KPiBTZW50OiAxNiBNYXJjaCAyMDIzIDAwOjU3DQo+IA0KPiBP
biBXZWQsIE1hciAxNSwgMjAyMyBhdCA0OjU54oCvUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IDIuIENhbiB3ZSB1bmlmeSB0aGUgdHdv
IGRpZmZlcmVudCBzeXN0ZW0gY2FsbHM/IEZvciBleGFtcGxlLCB1c2luZw0KPiA+ID4gcG9sbCgu
Li4pIHRvIGltcGxlbWVudCB0aGUgZnJvbnRlbmQgc2VsZWN0IGNhbGwoLi4uKSwgaXMgdGhlcmUN
Cj4gPiA+IHNvbWV0aGluZyBJJ20gbWlzc2luZyBmb3IgY3VycmVudCBpbXBsZW1lbnRhdGlvbj8g
VGhlIENvbnMgYW5kIFByb3MsDQo+ID4gPiBldGMNCj4gPg0KPiA+IFRoZSB1bmRlcmx5aW5nIGNv
ZGUgdGhhdCBpbXBsZW1lbnRzIHRoZW0gaXMgY29tbW9uLg0KPiA+DQo+ID4gQmV3YXJlIHRoYXQg
dGhlIGdsaWJjIHNlbGVjdCgpIHdyYXBwZXJzIGhhdmUgdGhlaXIgb3duIGxpbWl0DQo+ID4gb24g
dGhlIGhpZ2hlc3QgZmQuDQo+ID4gRXhjZWVkaW5nIHRoYXQgbGltaXQgKHByb2JhYmx5IDEwMjQp
IHdpbGwgY2F1c2UgYnVmZmVyIG92ZXJydW5zDQo+ID4gaW4gdGhlIGFwcGxpY2F0aW9uIChPbmUg
b2YgdGhlIEFuZHJvaWQgYXBwcyBJIHVzZXMgY3Jhc2hlcyB0aGF0IHdheSkuDQo+IA0KPiBBaCwg
aW50ZXJlc3RpbmcuIFNlZW1zIGdsaWJjIGRvZXNuJ3QgbWFrZSB0aGF0IGxpbWl0IGZyb20gbXkg
dGVzdGluZw0KPiBjb2RlIHNuaXBwZXQgaW4gbGFzdCBlbWFpbC4uLg0KDQpMb29rIGF0IHRoZSBG
RF9TRVQoKSBtYWNyb3MuLi4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

