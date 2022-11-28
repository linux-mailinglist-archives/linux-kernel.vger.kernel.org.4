Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FED63A47D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiK1JOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK1JN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:13:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80318B10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:13:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-245-C23Bty6yN0-1Dpk6yyalUQ-1; Mon, 28 Nov 2022 09:13:53 +0000
X-MC-Unique: C23Bty6yN0-1Dpk6yyalUQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 09:13:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 28 Nov 2022 09:13:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
Thread-Topic: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
Thread-Index: AdkA3jB+9p3HVKOjROWboToCz6X2bgCKx+jg
Date:   Mon, 28 Nov 2022 09:13:50 +0000
Message-ID: <6fc56385a90742c7ad21a68403dc27df@AcuMS.aculab.com>
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
In-Reply-To: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI1IE5vdmVtYmVyIDIwMjIgMTU6MDENCj4gDQo+
IFNsaWdodGx5IHJlbGF4IHRoZSB0eXBlIGNoZWNraW5nIGRvbmUgYnkgbWluKCkgYW5kIG1heCgp
Lg0KPiAtIFByb21vdGUgc2lnbmVkL3Vuc2lnZWQgY2hhci9zaG9ydCB0byBpbnQgcHJpb3IgdG8g
dGhlIHR5cGUgdGVzdC4NCj4gICBUaGlzIG1hdGNoZXMgd2hhdCB0aGUgY29tcGlsZXIgZG9lcyBi
ZWZvcmUgZG9pbmcgdGhlIGNvbXBhcmlzb24uDQo+IC0gU2tpcCB0aGUgdHlwZSB0ZXN0IGlmIGVp
dGhlciBhcmd1bWVudCBpcyBhIHBvc2l0aXZlICdpbnQnIGNvbnN0YW50Lg0KPiAgIEluc3RlYWQg
Y2FzdCB0aGUgY29uc3RhbnQgdG8gJ2ludCcsIHRoZSBjb21waWxlciBtYXkgcHJvbW90ZSBpdA0K
PiAgIGJhY2sgdG8gJ3Vuc2lnbmVkIGludCcgd2hlbiBkb2luZyB0aGUgdGVzdC4NCj4gDQo+IFJl
ZHVjZXMgdGhlIG5lZWQgdG8gdXNlIG1pbl90L21heF90KCkgYW5kIHRoZSBwb3NzaWJseSB1bndh
bnRlZA0KPiAgIHNpZGUgZWZmZWN0cyBpZiBhIHR5cGUgdGhhdCBpcyB0b28gc21hbGwgaXMgc3Bl
Y2lmaWVkLg0KPiANCi4uLg0KPiArI2RlZmluZSBfX2NtcCh4LCB5LCBvcCkJX19jbXBfbWF5YmVf
aW50KF9fbWF5YmVfaW50X2Nhc3QoeCksIF9fbWF5YmVfaW50X2Nhc3QoeSksIG9wKQ0KPiANCj4g
ICNkZWZpbmUgX19jbXBfb25jZSh4LCB5LCB1bmlxdWVfeCwgdW5pcXVlX3ksIG9wKSAoewlcDQo+
ICAJCXR5cGVvZih4KSB1bmlxdWVfeCA9ICh4KTsJCVwNCg0Kc2VsZiBuYWsuDQpUaGF0IGhhcyB0
byBiZSBkb25lIGFzOg0KCXR5cGVvZihfX21heWJlX2ludF9jYXN0KHgpKSB1bmlxdWVfeCA9ICh4
KTsNCg0KSSB3aWxsIHNlbmQgYSBWMi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

