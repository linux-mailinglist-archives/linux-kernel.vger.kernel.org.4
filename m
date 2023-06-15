Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97A7311BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjFOIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjFOIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:06:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB761A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:06:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-PRuVYsO4PPG9Khf-CB4twQ-1; Thu, 15 Jun 2023 09:06:48 +0100
X-MC-Unique: PRuVYsO4PPG9Khf-CB4twQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Jun
 2023 09:06:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 15 Jun 2023 09:06:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: RE: [PATCH v3 0/4] Make sscanf() stricter
Thread-Topic: [PATCH v3 0/4] Make sscanf() stricter
Thread-Index: AQHZnXRzYKsBWmeEwU2LY4YQ5TFW+a+Is3nggAAaG4CAASnjAIAAtO+AgADXzkA=
Date:   Thu, 15 Jun 2023 08:06:46 +0000
Message-ID: <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email> <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
In-Reply-To: <ZIoeVjC6offUywop@itl-email>
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

RnJvbTogRGVtaSBNYXJpZSBPYmVub3VyDQo+IFNlbnQ6IDE0IEp1bmUgMjAyMyAyMTowOQ0KLi4u
Lg0KPiA+IFdoYXQgc29ydCBvZiBmb3JtYXRzIGFuZCBkYXRhIGFyZSBiZWluZyB1c2VkPw0KPiAN
Cj4gQmFzZS0xMCBvciBiYXNlLTE2IGludGVnZXJzLCB3aXRoIHdoaXRlc3BhY2UgbmV2ZXIgYmVp
bmcgdmFsaWQuDQoNCkluIHdoaWNoIGNhc2Ugc3NjYW5mKCkgcmVhbGx5IGlzbid0IHdoYXQgeW91
IGFyZSBsb29raW5nIGZvci4NCg0KPiA+IFRoZSAiJXMiIGZvcm1hdCB0ZXJtaW5hdGVzIG9uIHdo
aXRlc3BhY2UuDQo+ID4gRXZlbiBzdHJvdWwoKSAoYW5kIGZyaWVuZHMpIHdpbGwgc2tpcCBsZWFk
aW5nIHdoaXRlc3BhY2UuDQo+IA0KPiBZZXMsIHdoaWNoIGlzIGEgcmVhc29uIHRoYXQgc3RydG8q
bCgpIGFyZSBqdXN0IGJyb2tlbiBJTU8uDQoNClRoZXkgYXJlIG5vdCAnYnJva2VuJywgdGhhdCBp
cyB3aGF0IGlzIHVzZWZ1bCBtb3N0IG9mIHRoZSB0aW1lLg0KVGhlIHVzdWFsIHByb2JsZW0gaXMg
dGhhdCAiMDIwIiBpcyB0cmVhdGVkIGFzIG9jdGFsLg0KDQo+IEnigJltIHRyeWluZyB0byByZXBs
YWNlIHRoZWlyIHVzZXMgaW4gWGVuIHdpdGggY3VzdG9tIHBhcnNpbmcgY29kZS4NCg0KVGhlbiB3
cml0ZSBhIGN1c3RvbSBwYXJzZXIgOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

