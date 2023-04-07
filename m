Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD26DACA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDGM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjDGM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:26:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C9B47A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:25:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-21-ab4gE1LeNP2VPUmRwH7ghQ-1; Fri, 07 Apr 2023 13:25:15 +0100
X-MC-Unique: ab4gE1LeNP2VPUmRwH7ghQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 7 Apr
 2023 13:25:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 7 Apr 2023 13:25:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
Thread-Topic: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
Thread-Index: AdlodgFkFYa3Wd45RlGJwWEgKJXFDwAQJm4AACPxQkA=
Date:   Fri, 7 Apr 2023 12:25:11 +0000
Message-ID: <dd933c50df674dd69f6e630a53cfee77@AcuMS.aculab.com>
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDYgQXByaWwgMjAyMyAyMDozNg0KPiANCj4g
T24gVGh1LCBBcHIgNiwgMjAyMyBhdCA0OjA14oCvQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTbyBjb2RlIGxpa2U6DQo+ID4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykNCj4gPiAgICAgICAgICAgICAgICAgbXNpeF90Ymxb
aV0uZW50cnkgPSBpOw0KPiA+ICAgICAgICAgbnZlYyA9IHBjaV9lbmFibGVfbXNpeF9yYW5nZShk
ZXYsIG1zaXhfdGJsLCAxLCAxNik7DQo+ID4gTm93IHJldHVybnMgLTIyIGlmIHRoZSBoYXJkd2Fy
ZSBvbmx5IHN1cHBvcnRzIDggaW50ZXJydXB0cy4NCj4gPg0KPiA+IFByZXZpb3VzbHkgaXQgcmV0
dXJuZWQgOC4NCj4gDQo+IERvZXMganVzdCBtb3ZpbmcgdGhlIHBjaV9tc2l4X3ZhbGlkYXRlX2Vu
dHJpZXMoKSBkb3duIHRvIGJlbG93IHRoZQ0KPiBod3NpemUgdXBkYXRlIGNvZGUgZml4IGl0Pw0K
DQpJIHRoaW5rIGl0IGRlcGVuZHMgb24gd2h5IHRoZSBkcml2ZXIgaXMgYXNraW5nIGZvciBtb3Jl
DQppbnRlcnJ1cHRzIHRoYW4gdGhlIGhhcmR3YXJlIHN1cHBvcnRzLg0KUG90ZW50aWFsbHkgdGhl
IGRyaXZlciBjb3VsZCBkbzoNCglmb3IgKGkgPSAwOyBpIDwgODsgaSsrKQ0KCQltc2l4X3RibFtp
XS5lbnRyeSA9IDIgKiBpOw0KaWYgdGhlIGhhcmR3YXJlIHN1cHBvcnRzIDggaW50ZXJydXB0cyBw
ZXJoYXBzIGl0DQpzaG91bGQgcmV0dXJuIDQ/DQoNCkluIG15IGNhc2UgYm90aCB0aGUgTVNJLVgg
bG9naWMgb24gdGhlIGZwZ2EgYW5kIHRoZSBkcml2ZXINCnN1cHBvcnQgMTYgaW50ZXJydXB0cywg
YnV0IFBDSWUgY29uZmlnIHNwYWNlIHJlcG9ydHMgOC4NClRoZSBoaWdoIG51bWJlcmVkIGludGVy
cnVwdHMgYXJlbid0IHVzZWQgdmVyeSBvZnRlbiBhbmQgZ2V0DQptdWx0aXBsZXhlZCBvbnRvIHRo
ZSBoaWdoZXN0ICdyZWFsJyBpbnRlcnJ1cHQuDQooVGhlIGZwZ2EgYnVpbGQgbWFrZXMgaXQgcHJl
dHR5IG11Y2ggaW1wb3NzaWJsZSB0byB0aWUNCnRvZ2V0aGVyIHRoZSBjb25maWcgc3BhY2UgdmFs
dWUgYW5kIHRoZSBzaXplIG9mIHRoZSBNU0ktWA0KdGFibGUuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

