Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233B61475F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiKAKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKAKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:02:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E714087
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:02:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-IO7oJJsdPEWfrci-nPnQRA-1; Tue, 01 Nov 2022 10:02:38 +0000
X-MC-Unique: IO7oJJsdPEWfrci-nPnQRA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Nov
 2022 10:02:26 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 1 Nov 2022 10:02:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Szabolcs Nagy' <szabolcs.nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: linux interprets an fcntl int arg as long
Thread-Topic: linux interprets an fcntl int arg as long
Thread-Index: AQHY7dH4b5GlkmHz9EyVI+/nub6Ts64p0qEQ
Date:   Tue, 1 Nov 2022 10:02:26 +0000
Message-ID: <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
References: <Y1/DS6uoWP7OSkmd@arm.com> <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
In-Reply-To: <Y2DisyknbKxeCik4@arm.com>
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

RnJvbTogU3phYm9sY3MgTmFneQ0KPiBTZW50OiAwMSBOb3ZlbWJlciAyMDIyIDA5OjExDQo+IA0K
PiBUaGUgMTAvMzEvMjAyMiAyMTo0NiwgVGhlb2RvcmUgVHMnbyB3cm90ZToNCj4gPiBPbiBNb24s
IE9jdCAzMSwgMjAyMiBhdCAxMjo0NDo1OVBNICswMDAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0K
PiA+ID4gYW5kIHN1Y2ggZmNudGwgY2FsbCBjYW4gaGFwcGVuIHdpdGggYyBjb2RlIHRoYXQganVz
dCBwYXNzZXMNCj4gPiA+IEZfU0VBTF9XUklURSBzaW5jZSBpdCBpcyBhbiBpbnQgYW5kIGUuZy4g
d2l0aCBhYXJjaDY0IHBjcyBydWxlcw0KPiA+ID4gaXQgaXMgcGFzc2VkIGluIGEgcmVnaXN0ZXIg
d2hlcmUgdG9wIGJpdHMgY2FuIGJlIG5vbi16ZXJvDQo+ID4gPiAodW5saWtlbHkgaW4gcHJhY3Rp
Y2UgYnV0IHZhbGlkKS4NCj4gPg0KPiA+IEluIExpbnV4J3MgYWFyY2g2NCBBQkksIGFuIGludCBp
cyBhIDQtYnl0ZSB2YWx1ZS4gIEl0IGlzICpub3QqIGFuDQo+ID4gOC1ieXRlIHZhbHVlLiAgU28g
cGFzc2luZyBpbiAiRl9TRUFMX1dSSVRFIHwgMHhGMDAwMDAwMDAiIGFzIGFuIGludA0KPiA+IChh
cyBpbiB5b3VyIGV4YW1wbGUpIGlzIHNpbXBseSBub3QgdmFsaWQgdGhpbmcgZm9yIHRoZSB1c2Vy
c3BhY2UNCj4gPiBwcm9ncmFtIHRvIGRvLg0KPiA+DQo+ID4gTm93LCBpZiB0aGVyZSBpcyBhIEMg
cHJvZ3JhbSB3aGljaCBoYXMgImludCBjID0gRl9TRUFMX1dSSVRFIiwgaWYgdGhlDQo+ID4gUENT
IGFsbG93cyB0aGUgY29tcGlsZXIgdG8gcGFzcyBhIGZ1bmN0aW9uIHBhcmFtdGVyIGMgLS0tIGZv
ciBleGFtcGxlDQo+ID4gZihhLCBiLCBjKSAtLS0gd2hlcmUgdGhlIDQtYnl0ZSBwYXJhbXRlciAn
YycgaXMgcGxhY2VkIGluIGEgNjQtYml0DQo+ID4gcmVnaXN0ZXIgd2hlcmUgdGhlIGhpZ2ggYml0
cyBvZiB0aGUgNjQtYml0IHJlZ2lzdGVyIGNvbnRhaW5zIG5vbi16ZXJvDQo+ID4gZ2FyYmFnZSB2
YWx1ZXMsIEkgd291bGQgYXJndWUgdGhhdCB0aGlzIGlzIGEgYnVnIGluIHRoZSBQQ1MgYW5kL29y
IHRoZQ0KPiA+IGNvbXBpbGVyLg0KPiANCj4gdGhlIGNhbGxlZSB1c2VzIHZhX2FyZyhhcCwgdHlw
ZSkgdG8gZ2V0IHRoZSBhcmd1bWVudCwNCj4gYW5kIGlmIHRoZSB0eXBlIGlzIHdpZGVyIHRoYW4g
d2hhdCB3YXMgYWN0dWFsbHkgcGFzc2VkDQo+IHRoZW4gYW55dGhpbmcgY2FuIGhhcHBlbi4gaW4g
cHJhY3RpY2Ugd2hhdCBoYXBwZW5zIGlzDQo+IHRoYXQgdGhlIHRvcCBiaXRzIGNhbiBiZSBub24t
emVyby4NCj4gDQo+IG1hbnkgcGNzIGFyZSBhZmZlY3RlZCAoYWFyY2g2NCBpcyB0aGUgb25lIGkg
a25vdyB3ZWxsLA0KPiBidXQgYXQgbGVhc3QgeDg2XzY0LCBhcm0gYXJlIGFmZmVjdGVkIHRvbyku
IGFuZCBldmVuIGlmDQo+IGl0IHdhcyBhYXJjaDY0IHBjcyBvbmx5LCBpdCBpcyBpbmNvbXBldGVu
dCB0byBzYXkgdGhhdA0KPiB0aGUgcGNzIGlzIHdyb25nOiB0aGF0J3MgYSBjb25zdHJhaW50IHdl
IGFyZSB3b3JraW5nIHdpdGguDQo+IA0KPiB0aGUga2VybmVsIG11c3Qgbm90IHJlYWQgYSB3aWRl
ciB0eXBlIHRoYW4gd2hhdCBpdA0KPiBkb2N1bWVudHMgYXMgYXJndW1lbnQgdG8gdmFyaWFkaWMg
ZnVuY3Rpb25zIGluIHRoZSBjIGFwaS4NCj4gKGl0IGRvZXMgbm90IG1ha2UgbXVjaCBzZW5zZSB0
byBleHBlY3QgYW55dGhpbmcgdGhlcmUNCj4gYW55d2F5LCBidXQgaXQgY2FuIGJyZWFrIHVzZXJz
cGFjZSkNCg0KVGhlIExpbnV4IGtlcm5lbCBqdXN0IGFzc3VtZXMgdGhhdCB0aGUgdmFyYXJncyBj
YWxsIGxvb2tzIGxpa2UNCmEgbm9uLXZhcmFncyBjYWxsIHdpdGggdGhlIHNhbWUgcGFyYW1ldGVy
cy4NCihJdCBkb2Vzbid0IHVzZSB2YV9hcmcoKSkNCkFsbCBzeXNjYWxsIGFyZ3VtZW50cyBhcmUg
cGFzc2VkIGluIHJlZ2lzdGVycyAodW5saWtlIEJTRHMNCndoZXJlIHRoZXkgY2FuIGFsc28gYmUg
b24gdGhlIHVzZXIgc3RhY2spLg0KT24gNjRiaXQgc3lzdGVtcyB0aGUgc2FtZSByZWdpc3RlcnMg
YXJlIGV4cGVjdGVkIHRvIGJlIHVzZWQNCmZvciA2NGJpdCBhbmQgMzJiaXQgaW50ZWdlcnMgYW5k
IGZvciBwb2ludGVycy4NCjMyYml0IHZhbHVlcyB1c3VhbGx5IGdldCBtYXNrZWQgYmVjYXVzZSB0
aGV5IGdldCBwYXNzZWQgdG8NCmEgZnVuY3Rpb24gd2l0aCBhbiAnaW50JyBhcmd1bWVudC4NCg0K
SWYgYW55IGZjbnRsKCkgY2FsbHMgcmVxdWlyZSBhIDY0Yml0IHZhbHVlIGFuZCB0aGUgQyBBQkkN
Cm1pZ2h0IGxlYXZlIG5vbi16ZXJvIGhpZ2ggYml0cyBpbiBhbiByZWdpc3RlciBjb250YWluaW5n
DQphIDMyYml0IHZhbHVlIChlc3AuIHRvIGEgdmFyYXJncyBmdW5jdGlvbikgdGhlbiB0aGUgY2Fs
bGluZw0KY29kZSB3aWxsIG5lZWQgdG8gY2FzdCBzdWNoIGFyZ3VtZW50cyB0byA2NCBiaXRzLg0K
DQpPVE9IIEkgc3VzcGVjdCB0aGUgYXJndW1lbnQgaXMgZWl0aGVyIGFic2VudCwgaW50IG9yIHBv
aW50ZXIuDQpTbyBpdCBzaG91bGQgbWFzayB0aGUgdmFsdWUgdG8gMzIgYml0cy4NCg0KTm90ZSB0
aGF0IHRoZXJlIGFyZSBBQkkgd2hlcmUgJ2ludCcgYW5kICdwb2ludGVyJyBnZXQgcGFzc2VkDQpp
biBkaWZmZXJlbnQgcmVnaXN0ZXJzLg0KRm9ydHVuYXRlbHkgbm9uZSB3aWxsIHN1cHBvcnQgTGlu
dXghDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

