Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696BE743AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF3LVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3LVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:21:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469F1999
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:21:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-212-9cH8WDJ2PzetEzsNny-iPQ-1; Fri, 30 Jun 2023 12:21:45 +0100
X-MC-Unique: 9cH8WDJ2PzetEzsNny-iPQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 12:21:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 30 Jun 2023 12:21:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] pid: use flex array
Thread-Topic: [GIT PULL] pid: use flex array
Thread-Index: AQHZqymBmTCNURBJjUywJ1CSP6kH3a+jMNSw
Date:   Fri, 30 Jun 2023 11:21:44 +0000
Message-ID: <8b73a39a359b4523a053efd614cd7dd7@AcuMS.aculab.com>
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
 <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner>
 <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
 <20230630-stiefel-rotor-7f2d13fc084f@brauner>
In-Reply-To: <20230630-stiefel-rotor-7f2d13fc084f@brauner>
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

RnJvbTogQ2hyaXN0aWFuIEJyYXVuZXINCj4gU2VudDogMzAgSnVuZSAyMDIzIDA5OjA0DQouLi4N
Cj4gPiBBbmQgc29tZSBvZiB0aGVtIGFyZSBldmVuIG9rLiBJIGRvbid0IHRoaW5rIGl0J3MgYWx3
YXlzIHdyb25nLA0KPiA+IHBhcnRpY3VsYXJseSBpZiB5b3UgdGhlbiBhYnN0cmFjdCBpdCBvdXQu
DQo+ID4NCj4gPiBTbyBkb2luZyBzb21ldGhpbmcgbGlrZSB0aGF0DQo+ID4NCj4gPiAgICAjZGVm
aW5lIFBDSV9JT0JBU0UgKCh2b2lkIF9faW9tZW0gKikwKQ0KPiA+DQo+ID4gbWFrZXMgcGVyZmVj
dCBzZW5zZS4gSXQncyBsaXRlcmFsbHkgYWJzdHJhY3Rpbmcgb3V0IHNvbWV0aGluZyByZWFsIChp
bg0KPiA+IHRoaXMgY2FzZSB5ZXMsIGl0IGxvb2tzIGxpa2UgYSBOVUxMIHBvaW50ZXIsIGJ1dCBp
dCdzIGFjdHVhbGx5IGENCj4gPiBwb2ludGVyIHdpdGggYSBzdHJpY3QgdHlwZSB0aGF0IGp1c3Qg
aGFwcGVucyB0byBoYXZlIHRoZSB2YWx1ZSB6ZXJvLg0KDQpZb3UgY2FuJ3QgZG8gdGhhdCwgaXQg
ZG9lc24ndCB3b3JrLg0KQSBOVUxMIHBvaW50ZXIgaXMgYW55IGNvbnN0YW50IGludGVnZXIgZXhw
cmVzc2lvbiB0aGF0IGV2YWx1YXRlcw0KdG8gemVybyBpbXBsaWNpdGx5IG9yIGV4cGxpY2l0bHkg
Y29udmVydGVkIHRvIGEgcG9pbnRlciB0eXBlLg0KDQpUaGUgYml0IHBhdHRlcm4gdXNlZCBmb3Ig
YSBOVUxMIHBvaW50ZXIgaXMgaW1wbGVtZW50YXRpb24gZGVmaW5lZC4NCkl0IGlzIGFsbW9zdCBh
bHdheXMgMCwgYnV0IHRoZSBDIGxhbmd1YWdlIGFsbG93cyBhbnkgaW52YWxpZA0KdmFsdWUgdG8g
YmUgdXNlZCAtIGVnIHRoZSAnYWxsIG9uZXMnIHBhdHRlcm4uDQoNCmNsYW5nIHdhcm5zIGZvciAn
UENJX0lPQkFTRSArIDQnLg0KUHJvYmFibHkgYmVjYXVzZSBpdCBvbmx5IGhhcyB0aGUgZXhwZWN0
ZWQgdmFsdWUgaWYgTlVMTCBpcyB0aGUNCnplcm8gYml0IHBhdHRlcm4gLSBzbyBpdCBpc24ndCBw
b3J0YWJsZS4NCg0KSWYgaGFzIHRvIGJlIHNhaWQgdGhhdCBJIGRvdWJ0IGdjYyBvciBjbGFuZyBz
dXBwb3J0IE5VTEwgYmVpbmcNCm90aGVyIHRoYW4gdGhlIHplcm8gYml0IHBhdHRlcm4uDQpBbnkg
QyBjb2RlIHRoYXQgdXNlcyBtZW1zZXQoKSB0byBzZXQgYSBwb2ludGVyIHRvIE5VTEwgaXMgbWFr
aW5nDQp0aGF0IGFzc3VtcHRpb24uDQoNCkkgaGF2ZSB1c2VkIGEgc3lzdGVtIHdoZXJlIHRoZSBu
YXRpdmUgJ2ludmFsaWQgcG9pbnRlcicgd2FzIH4wDQpidXQgdGhlIEMgcG9ydCB1c2VkIHplcm8u
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

