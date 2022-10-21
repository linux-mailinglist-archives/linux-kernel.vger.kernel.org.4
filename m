Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4563B60814B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUWCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:02:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950BD2A58DE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:02:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-242-ge_Nv5x8MGqVulAXveaOKA-1; Fri, 21 Oct 2022 23:02:36 +0100
X-MC-Unique: ge_Nv5x8MGqVulAXveaOKA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Oct
 2022 23:02:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Fri, 21 Oct 2022 23:02:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Thread-Topic: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Thread-Index: AQHY5XLlQAer2MD960S23xxh/U1Nz64ZZOog
Date:   Fri, 21 Oct 2022 22:02:35 +0000
Message-ID: <8ca8b04cf5ef4e0099a04637df8293ac@AcuMS.aculab.com>
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
 <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
In-Reply-To: <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgT2N0b2JlciAyMDIyIDE4OjMxDQouLi4N
Cj4gSSB0aGluayB5b3UgbWlnaHQgYXMgd2VsbCBhbHNvIHJlbW92ZSB0aGUgY2FzdCB0aGF0IHdh
cyBhbHdheXMgYSBiaXQgb2RkOg0KPiANCj4gICAgICAgICAgICAgICAgIGJ1ZlswXSA9ICh1OClk
dW0tPmRldnN0YXR1czsNCi4uLg0KPiBJIHN1c3BlY3QgYSBjb21tZW50IHdvdWxkIGJlIG1vcmUg
cmVhZGFibGUgdGhhbiBhbiBvZGQgY2FzdCB0aGF0DQo+IGRvZXNuJ3QgYWN0dWFsbHkgY2hhbmdl
IGFueXRoaW5nIChzaW5jZSB0aGUgYXNzaWdubWVudCBkb2VzIGl0DQo+IGFueXdheSkuDQoNCkkn
dmUgc2VlbiBhIGNvbXBpbGVyIGdlbmVyYXRlIGFuICcmIDB4ZmYnIGZvciB0aGUgY2FzdCBiZWZv
cmUNCnN0b3JpbmcgdGhlIGxvdyBieXRlLg0KRG9uJ3QgZXZlbiB0aGluayBhYm91dCB3aGF0IHRo
YXQgY29tcGlsZXIgd291bGQgZ2VuZXJhdGVkIGZvcjoNCgkJYnVmWzBdID0gKHU4KShkdW0tPmRl
dnN0YXR1cyAmIDB4ZmYpOw0KDQpUaGUgY29kZSBpcyBtdWNoIGVhc2llciB0byByZWFkIGFzIGp1
c3QgYW4gYXNzaWdubWVudCA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

