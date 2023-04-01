Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FF6D347D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDAWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDAWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:04:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DF27839
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 15:04:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-p39s4WFePrSsQjihVNUmug-1; Sat, 01 Apr 2023 23:04:29 +0100
X-MC-Unique: p39s4WFePrSsQjihVNUmug-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 1 Apr
 2023 23:04:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 1 Apr 2023 23:04:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] mm: remove all the slab allocators
Thread-Topic: [PATCH] mm: remove all the slab allocators
Thread-Index: AQHZZH7yC1nc5Yxd6ES5VUUdsjQvja8WxpGg///z5QCAAEfSoA==
Date:   Sat, 1 Apr 2023 22:04:26 +0000
Message-ID: <45a4b0ac2bac40a691b55ae9de5c6617@AcuMS.aculab.com>
References: <20230401094658.11146-1-vbabka@suse.cz>
 <eea7e17ab4264b7ca7ccea0ab725120f@AcuMS.aculab.com>
 <a84e8534-ef49-c33f-711c-fa5b9ee88269@csgroup.eu>
In-Reply-To: <a84e8534-ef49-c33f-711c-fa5b9ee88269@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwMSBBcHJpbCAyMDIzIDE5OjQ1DQo+IA0K
PiBMZSAwMS8wNC8yMDIzIMOgIDIwOjMzLCBEYXZpZCBMYWlnaHQgYSDDqWNyaXTCoDoNCj4gPiBG
cm9tOiBWbGFzdGltaWwgQmFia2ENCj4gPj4gU2VudDogMzIgTWFyY2ggMjAyMyAxMDo0Nw0KPiA+
Pg0KPiA+PiBBcyB0aGUgU0xPQiByZW1vdmFsIGlzIG9uIHRyYWNrIGFuZCB0aGUgU0xBQiByZW1v
dmFsIGlzIHBsYW5uZWQsIEkgaGF2ZQ0KPiA+PiByZWFsaXplZCAtIHdoeSBzaG91bGQgd2Ugc3Rv
cCB0aGVyZSBhbmQgbm90IHJlbW92ZSBhbHNvIFNMVUI/IFdoYXQncyBhDQo+ID4+IHNsYWIgYWxs
b2NhdG9yIGdvb2QgZm9yIGluIDIwMjM/IFRoZSBSQU0gc2l6ZXMgYXJlIGdldHRpbmcgbGFyZ2Vy
IGFuZA0KPiA+PiB0aGUgbW9kdWxlcyBjaGVhcGVyIFsxXS4gVGhlIG9iamVjdCBjb25zdHJ1Y3Rv
ciB0cmljayB3YXMgcGVyaGFwcw0KPiA+PiBpbnRlcmVzdGluZyBpbiAxOTk0LCBidXQgbm90IHdp
dGggY29udGVtcG9yYXJ5IENQVXMuIFNvIGFsbCB0aGUgc2xhYg0KPiA+PiBhbGxvY2F0b3IgZG9l
cyB0b2RheSBpcyBqdXN0IGFkZGluZyBhbiB1bm5lY2Vzc2FyeSBsYXllciBvZiBjb21wbGV4aXR5
DQo+ID4+IG92ZXIgdGhlIHBhZ2UgYWxsb2NhdG9yLg0KPiA+DQo+ID4gV2h5IHN0b3AgdGhlcmU/
DQo+ID4gUmVtb3ZlIGttYWxsb2MoKSBjb21wbGV0ZWx5Lg0KPiA+IFdpdGggY2hlYXAgbWVtb3J5
IGlzbid0IHVucmVhc29uYWJsZSB0byBnbyBiYWNrIHRvIGNvbXBpbGUtdGltZQ0KPiA+IHNldHRh
YmxlIGZpeGVkIHNpemUgYXJyYXlzIGZvciBhbGwgaXRlbXMuDQo+ID4gU2hvdWxkIG1ha2UgJ3Vz
ZSBhZnRlciBmcmVlJyBtdWNoIGVhc2llciB0byB0cmFjayBkb3duLg0KPiA+DQo+IA0KPiBXaGls
ZSBhdCBpdCwgd2h5IG5vdCBhbHNvIGluY3JlYXNlIHRoZSBwYWdlIHNpemUgdG8gaHVnZXBhZ2Ug
c2l6ZSwgdGhhdA0KPiB3b3VsZCBhbGxvdyB1cyB0byByZW1vdmUgYWxsIHRoZSBjb21wbGV4IFRI
UCBsb2dpYywgYW5kIHdvdWxkIHJlbW92ZSBvbmUNCj4gbGV2ZWwgb2YgcGFnZSB0YWJsZXMuIEkg
d291bGQgYWxzbyByZWR1Y2UgVExCIHByZXNzdXJlLg0KDQpHb29kIGlkZWEsIDRrIHBhZ2VzIHdl
cmUgdXNlZCBvbiBzeXN0ZW1zIHdoZXJlIHRoZSB0b3RhbCBzeXN0ZW0NCm1lbW9yeSB3YXMgYSBm
ZXcgTUIuDQpNZW1vcnkgc3lzdGVtIGFyZSBub3cgZWFzaWx5IDEwMDB4IHRpbWVzIGxhcmdlciAt
IHNvIHdoeSBub3QgNE1CDQpwYWdlcyAuLi4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

