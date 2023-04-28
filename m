Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974366F12D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjD1Hva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbjD1HvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:51:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C706190
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:50:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-RO6yIwq1NPCn28Piz-Aq2A-1; Fri, 28 Apr 2023 08:46:15 +0100
X-MC-Unique: RO6yIwq1NPCn28Piz-Aq2A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Apr
 2023 08:46:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Apr 2023 08:46:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        =?utf-8?B?S29ucmFkIEdyw6RmZQ==?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Thread-Topic: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Thread-Index: AQHZeZ6mT7/jda5LSEivIvi7ndHGNq9AV0+Q
Date:   Fri, 28 Apr 2023 07:46:14 +0000
Message-ID: <954a3b8d5be0487e8ead23bef450fabe@AcuMS.aculab.com>
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
In-Reply-To: <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAyOCBBcHJpbCAyMDIzIDA3OjU3DQo+IA0K
PiBPbiAyNy8wNC8yMDIzIDEzLjUxLCBLb25yYWQgR3LDpGZlIHdyb3RlOg0KPiA+IFRoZSBDREMt
RUNNIHNwZWNpZmljYXRpb24gcmVxdWlyZXMgYW4gVVNCIGdhZGdldCB0byBzZW5kIHRoZSBob3N0
IE1BQw0KPiA+IGFkZHJlc3MgYXMgdXBwZXJjYXNlIGhleCBzdHJpbmcuIFRoaXMgY2hhbmdlIGFk
ZHMgdGhlIGFwcHJvcHJpYXRlDQo+ID4gbW9kaWZpZXIuDQo+IA0KPiBUaGlua2luZyBtb3JlIGFi
b3V0IGl0LCBJJ20gbm90IHN1cmUgdGhpcyBpcyBhcHByb3ByaWF0ZSwgbm90IGZvciBhDQo+IHNp
bmdsZSB1c2VyIGxpa2UgdGhpcy4gdnNwcmludGYoKSBzaG91bGQgbm90IGFuZCBjYW5ub3Qgc2F0
aXNmeSBhbGwNCj4gcG9zc2libGUgc3RyaW5nIGZvcm1hdHRpbmcgcmVxdWlyZW1lbnRzIGZvciB0
aGUgd2hvbGUga2VybmVsLiBUaGUgJXBYDQo+IGV4dGVuc2lvbnMgYXJlIGNvbnZlbmllbnQgZm9y
IHVzZSB3aXRoIHByaW50aygpIGFuZCBmcmllbmRzIHdoZXJlIG9uZQ0KPiBuZWVkcyB3aGF0IGlu
IG90aGVyIGxhbmd1YWdlcyB3b3VsZCBiZSAic3RyaW5nIGludGVycG9sYXRpb24iIChiZWNhdXNl
DQo+IHRoZW4gdGhlIGNhbGxlciBkb2Vzbid0IG5lZWQgdG8gZGVhbCB3aXRoIHRlbXBvcmFyeSBz
dGFjayBidWZmZXJzIGFuZA0KPiBwYXNzIHRoZW0gYXMgJXMgYXJndW1lbnRzKSwgYnV0IGZvciBz
aW5nbGUgaXRlbXMgbGlrZSB0aGlzLCBzbnByaW50ZigpDQo+IGlzIG5vdCBuZWNlc3NhcmlseSB0
aGUgcmlnaHQgdG9vbCBmb3IgdGhlIGpvYi4NCj4gDQo+IEluIHRoaXMgY2FzZSwgdGhlIGNhbGxl
ciBjYW4ganVzdCBhcyB3ZWxsIGNhbGwgc3RyaW5nX3VwcGVyKCkgb24gdGhlDQo+IHJlc3VsdCwg
b3Igbm90IHVzZSBzcHJpbnRmKCkgYXQgYWxsIGFuZCBkbyBhIHRpbnkgbG9vcCB3aXRoDQo+IGhl
eF9ieXRlX3BhY2tfdXBwZXIoKS4NCg0KT3Igc25wcmludGYgd2l0aCAiJTAyWDolMDJYOiUwMlg6
JTAyWDolMDJYOiUwMlgiLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

