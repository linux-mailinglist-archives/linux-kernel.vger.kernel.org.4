Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757F4742300
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjF2JNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjF2JNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:13:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0A2681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:13:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-mpnZrVpkOXCdW5IIr55IVQ-1; Thu, 29 Jun 2023 10:12:55 +0100
X-MC-Unique: mpnZrVpkOXCdW5IIr55IVQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 10:10:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 10:10:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Richard Weinberger <richard@nod.at>
CC:     Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Bug report] __arch_hweight32/64 x86
Thread-Topic: [Bug report] __arch_hweight32/64 x86
Thread-Index: AQHZqK+xK5+vhLZdqUGGYpmfRwoI1q+hgTlw
Date:   Thu, 29 Jun 2023 09:10:11 +0000
Message-ID: <fc6f668458fc4cad8ed009f0a796f5f9@AcuMS.aculab.com>
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
 <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
 <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
 <02b36386-a18c-8bfb-2c70-c398f6fc964b@intel.com>
 <20230627042538.GAZJpkwldpkqTKeeDL@fat_crate.local>
In-Reply-To: <20230627042538.GAZJpkwldpkqTKeeDL@fat_crate.local>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI3IEp1bmUgMjAyMyAwNToyNg0KPiANCj4g
T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMDM6NDE6MjdQTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3Jv
dGU6DQo+ID4gSSdtIG5vdCBldmVuIHN1cmUgdGhhdCBVTUwgbmVlZHMgR0VORVJJQ19IV0VJR0hU
LiAgRnJvbSBhIHF1aWNrIGdsYW5jZSwNCj4gPiBpdCBsb29rcyBsaWtlIHg4NiB1c2VkIHRvIHVz
ZSBHRU5FUklDX0hXRUlHSFQsIGJ1dCBnb3QgYXJjaC1zcGVjaWZpYw0KPiA+IHZlcnNpb25zIGxh
dGVyLiAgVU1MIGp1c3QgbmV2ZXIgbW92ZWQgb3ZlciB0byB0aGUgYXJjaC1zcGVjaWZpYyB2ZXJz
aW9ucy4NCj4gDQo+IFRoYW5rcyAtIHRoYXQgY291bGQgdmVyeSB3ZWxsIGJlIHRoZSBleHBsYW5h
dGlvbi4NCj4gDQo+IFRoYXQgYnVnIHJlcG9ydCBtYWRlIG1lIGJsaW5rIGEgY291cGxlIG9mIHRp
bWVzIHNpbmNlIEkgZGlkIHRha2UgZXh0cmENCj4gcHJlY2F1dGlvbiB0byBub3QgY2xvYmJlciBy
ZWdzIGluIGFyY2gveDg2L2xpYi9od2VpZ2h0LlMgYXMgdGhpcyB3YXMNCj4gcGFydCBvZiB0aGUg
d2hvbGUgcGFpbiBiYWNrIHRoZW4gd2l0aCBjYWxsaW5nIGEgZnVuY3Rpb24gZnJvbSBhc20gd2hl
cmUNCj4gZ2NjIGRvZXNuJ3QgZXZlbiBrbm93IHdlJ3JlIGNhbGxpbmcgYSBmdW5jdGlvbiwgc2Vl
Og0KDQpQZXJoYXBzIHRoZSBhc20gY2FsbGVkIGZ1bmN0aW9uIHNob3VsZCB1c2UgYSBkaWZmZXJl
bnQgZ2xvYmFsDQpsYWJlbCB0aGFuIHRoZSBvbmUgaW4gdGhlIEMgZmlsZS4NCg0KVGhlbiBpdCB3
b3VsZG4ndCBiZSBhcyBmcmFnaWxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

