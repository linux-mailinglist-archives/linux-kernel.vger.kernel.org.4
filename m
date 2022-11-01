Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020D4614A86
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKAMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKAMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:19:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947FE167CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:19:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-cgaiRFvXNJ2qCkCMR_nIOQ-1; Tue, 01 Nov 2022 12:19:53 +0000
X-MC-Unique: cgaiRFvXNJ2qCkCMR_nIOQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Nov
 2022 12:19:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 1 Nov 2022 12:19:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Szabolcs Nagy' <szabolcs.nagy@arm.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: linux interprets an fcntl int arg as long
Thread-Topic: linux interprets an fcntl int arg as long
Thread-Index: AQHY7dH4b5GlkmHz9EyVI+/nub6Ts64p0qEQgAAgcACAAAds0A==
Date:   Tue, 1 Nov 2022 12:19:51 +0000
Message-ID: <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
References: <Y1/DS6uoWP7OSkmd@arm.com> <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
 <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
 <Y2EGtE05hcVn3B3a@arm.com>
In-Reply-To: <Y2EGtE05hcVn3B3a@arm.com>
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

RnJvbTogJ1N6YWJvbGNzIE5hZ3knIDxzemFib2xjcy5uYWd5QGFybS5jb20+DQo+IFNlbnQ6IDAx
IE5vdmVtYmVyIDIwMjIgMTE6NDUNCj4gDQo+IFRoZSAxMS8wMS8yMDIyIDEwOjAyLCBEYXZpZCBM
YWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogU3phYm9sY3MgTmFneQ0KPiA+ID4gU2VudDogMDEgTm92
ZW1iZXIgMjAyMiAwOToxMQ0KPiA+ID4NCj4gPiA+IFRoZSAxMC8zMS8yMDIyIDIxOjQ2LCBUaGVv
ZG9yZSBUcydvIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIE9jdCAzMSwgMjAyMiBhdCAxMjo0NDo1
OVBNICswMDAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0KPiA+ID4gPiA+IGFuZCBzdWNoIGZjbnRs
IGNhbGwgY2FuIGhhcHBlbiB3aXRoIGMgY29kZSB0aGF0IGp1c3QgcGFzc2VzDQo+ID4gPiA+ID4g
Rl9TRUFMX1dSSVRFIHNpbmNlIGl0IGlzIGFuIGludCBhbmQgZS5nLiB3aXRoIGFhcmNoNjQgcGNz
IHJ1bGVzDQo+ID4gPiA+ID4gaXQgaXMgcGFzc2VkIGluIGEgcmVnaXN0ZXIgd2hlcmUgdG9wIGJp
dHMgY2FuIGJlIG5vbi16ZXJvDQo+ID4gPiA+ID4gKHVubGlrZWx5IGluIHByYWN0aWNlIGJ1dCB2
YWxpZCkuDQo+ID4gPiA+DQo+ID4gPiA+IEluIExpbnV4J3MgYWFyY2g2NCBBQkksIGFuIGludCBp
cyBhIDQtYnl0ZSB2YWx1ZS4gIEl0IGlzICpub3QqIGFuDQo+ID4gPiA+IDgtYnl0ZSB2YWx1ZS4g
IFNvIHBhc3NpbmcgaW4gIkZfU0VBTF9XUklURSB8IDB4RjAwMDAwMDAwIiBhcyBhbiBpbnQNCj4g
PiA+ID4gKGFzIGluIHlvdXIgZXhhbXBsZSkgaXMgc2ltcGx5IG5vdCB2YWxpZCB0aGluZyBmb3Ig
dGhlIHVzZXJzcGFjZQ0KPiA+ID4gPiBwcm9ncmFtIHRvIGRvLg0KPiA+ID4gPg0KPiA+ID4gPiBO
b3csIGlmIHRoZXJlIGlzIGEgQyBwcm9ncmFtIHdoaWNoIGhhcyAiaW50IGMgPSBGX1NFQUxfV1JJ
VEUiLCBpZiB0aGUNCj4gPiA+ID4gUENTIGFsbG93cyB0aGUgY29tcGlsZXIgdG8gcGFzcyBhIGZ1
bmN0aW9uIHBhcmFtdGVyIGMgLS0tIGZvciBleGFtcGxlDQo+ID4gPiA+IGYoYSwgYiwgYykgLS0t
IHdoZXJlIHRoZSA0LWJ5dGUgcGFyYW10ZXIgJ2MnIGlzIHBsYWNlZCBpbiBhIDY0LWJpdA0KPiA+
ID4gPiByZWdpc3RlciB3aGVyZSB0aGUgaGlnaCBiaXRzIG9mIHRoZSA2NC1iaXQgcmVnaXN0ZXIg
Y29udGFpbnMgbm9uLXplcm8NCj4gPiA+ID4gZ2FyYmFnZSB2YWx1ZXMsIEkgd291bGQgYXJndWUg
dGhhdCB0aGlzIGlzIGEgYnVnIGluIHRoZSBQQ1MgYW5kL29yIHRoZQ0KPiA+ID4gPiBjb21waWxl
ci4NCj4gPiA+DQo+ID4gPiB0aGUgY2FsbGVlIHVzZXMgdmFfYXJnKGFwLCB0eXBlKSB0byBnZXQg
dGhlIGFyZ3VtZW50LA0KPiA+ID4gYW5kIGlmIHRoZSB0eXBlIGlzIHdpZGVyIHRoYW4gd2hhdCB3
YXMgYWN0dWFsbHkgcGFzc2VkDQo+ID4gPiB0aGVuIGFueXRoaW5nIGNhbiBoYXBwZW4uIGluIHBy
YWN0aWNlIHdoYXQgaGFwcGVucyBpcw0KPiA+ID4gdGhhdCB0aGUgdG9wIGJpdHMgY2FuIGJlIG5v
bi16ZXJvLg0KPiA+ID4NCj4gPiA+IG1hbnkgcGNzIGFyZSBhZmZlY3RlZCAoYWFyY2g2NCBpcyB0
aGUgb25lIGkga25vdyB3ZWxsLA0KPiA+ID4gYnV0IGF0IGxlYXN0IHg4Nl82NCwgYXJtIGFyZSBh
ZmZlY3RlZCB0b28pLiBhbmQgZXZlbiBpZg0KPiA+ID4gaXQgd2FzIGFhcmNoNjQgcGNzIG9ubHks
IGl0IGlzIGluY29tcGV0ZW50IHRvIHNheSB0aGF0DQo+ID4gPiB0aGUgcGNzIGlzIHdyb25nOiB0
aGF0J3MgYSBjb25zdHJhaW50IHdlIGFyZSB3b3JraW5nIHdpdGguDQo+ID4gPg0KPiA+ID4gdGhl
IGtlcm5lbCBtdXN0IG5vdCByZWFkIGEgd2lkZXIgdHlwZSB0aGFuIHdoYXQgaXQNCj4gPiA+IGRv
Y3VtZW50cyBhcyBhcmd1bWVudCB0byB2YXJpYWRpYyBmdW5jdGlvbnMgaW4gdGhlIGMgYXBpLg0K
PiA+ID4gKGl0IGRvZXMgbm90IG1ha2UgbXVjaCBzZW5zZSB0byBleHBlY3QgYW55dGhpbmcgdGhl
cmUNCj4gPiA+IGFueXdheSwgYnV0IGl0IGNhbiBicmVhayB1c2Vyc3BhY2UpDQo+ID4NCj4gPiBU
aGUgTGludXgga2VybmVsIGp1c3QgYXNzdW1lcyB0aGF0IHRoZSB2YXJhcmdzIGNhbGwgbG9va3Mg
bGlrZQ0KPiA+IGEgbm9uLXZhcmFncyBjYWxsIHdpdGggdGhlIHNhbWUgcGFyYW1ldGVycy4NCj4g
PiAoSXQgZG9lc24ndCB1c2UgdmFfYXJnKCkpDQo+ID4gQWxsIHN5c2NhbGwgYXJndW1lbnRzIGFy
ZSBwYXNzZWQgaW4gcmVnaXN0ZXJzICh1bmxpa2UgQlNEcw0KPiA+IHdoZXJlIHRoZXkgY2FuIGFs
c28gYmUgb24gdGhlIHVzZXIgc3RhY2spLg0KPiA+IE9uIDY0Yml0IHN5c3RlbXMgdGhlIHNhbWUg
cmVnaXN0ZXJzIGFyZSBleHBlY3RlZCB0byBiZSB1c2VkDQo+ID4gZm9yIDY0Yml0IGFuZCAzMmJp
dCBpbnRlZ2VycyBhbmQgZm9yIHBvaW50ZXJzLg0KPiA+IDMyYml0IHZhbHVlcyB1c3VhbGx5IGdl
dCBtYXNrZWQgYmVjYXVzZSB0aGV5IGdldCBwYXNzZWQgdG8NCj4gPiBhIGZ1bmN0aW9uIHdpdGgg
YW4gJ2ludCcgYXJndW1lbnQuDQo+ID4NCj4gPiBJZiBhbnkgZmNudGwoKSBjYWxscyByZXF1aXJl
IGEgNjRiaXQgdmFsdWUgYW5kIHRoZSBDIEFCSQ0KPiA+IG1pZ2h0IGxlYXZlIG5vbi16ZXJvIGhp
Z2ggYml0cyBpbiBhbiByZWdpc3RlciBjb250YWluaW5nDQo+ID4gYSAzMmJpdCB2YWx1ZSAoZXNw
LiB0byBhIHZhcmFyZ3MgZnVuY3Rpb24pIHRoZW4gdGhlIGNhbGxpbmcNCj4gPiBjb2RlIHdpbGwg
bmVlZCB0byBjYXN0IHN1Y2ggYXJndW1lbnRzIHRvIDY0IGJpdHMuDQo+IA0KPiB0aGUgZW50aXJl
IHBvaW50IG9mIG15IG1haWwgaXMgdGhhdCBpdCBpcyBub3QgcG9zc2libGUNCj4gdG8gdGVsbCBp
biB0aGUgbGliYyBpZiB0aGUgdmFyYXJnIGlzIHBvaW50ZXIgb3IgaW50Lg0KPiANCj4gc28gaW4g
Y2FzZSBhIHVzZXIgcGFzc2VkIGFuIGludCwgdGhlIGxpYmMgY2Fubm90IGZpeA0KPiB0aGF0IHVw
LCBsaWtlIGl0IHVzdWFsbHkgZG9lcyBmb3Igb3RoZXIgY2FzZXMgd2hlcmUNCj4gbGludXggc3lz
Y2FsbCBhYmkgaXMgaW5jb21wYXRpYmxlIHdpdGggdGhlIGMgYXBpLg0KPiANCj4gbGV0IG1lIGdv
IHRocm91Z2ggc3RlcCBieSBzdGVwIHdoYXQgaXMgZ29pbmcgb246DQouLi4NCj4gbG9uZyBpbnRl
cm5hbF9zeXNjYWxsKGludCwgbG9uZywgbG9uZywgbG9uZywgbG9uZywgbG9uZywgbG9uZyk7DQo+
IGludCBmY250bChpbnQgZmQsIGludCBjbWQsIC4uLikNCj4gew0KPiAJdmFfbGlzdCBhcDsNCj4g
CXZhX3N0YXJ0KGFwLCBjbWQpOw0KPiAJLyogdGhpcyBpcyBub24tY29uZm9ybWluZyBDOiB3cm9u
ZyB0eXBlIGluIHZhX2FyZywNCj4gCSAgIGJ1dCB0aGF0J3Mgbm90IHJlbGV2YW50IHNpbmNlIGxp
YmMgY2FuIGltcGxlbWVudA0KPiAJICAgdGhpcyBhcyB0YXJnZXQgc3BlY2lmaWMgYXNtLCB0aGUg
aW1wb3J0YW50IGJpdCBpcw0KPiAJICAgdGhhdCB0aGUgY29ycmVjdCB0eXBlIGlzIG5vdCBrbm93
bjogbGliYyBjYW5ub3QNCj4gCSAgIHJlcGxpY2F0ZSB0aGUga2VybmVsIHNpZGUgZGlzcGF0Y2gg
bG9naWMgYmVjYXVzZQ0KPiAJICAgbmV3IGNtZCBjYW4gYmUgaW50cm9kdWNlZCBpbiB0aGUgZnV0
dXJlIHdpdGgNCj4gCSAgIGFyYml0cmFyeSB0eXBlIGFyZy4NCj4gDQo+IAkgICB0b3AgMzJiaXRz
IG9mIGFyZyBhcmUgbm9uLXplcm8sIGxpYmMgY2Fubm90DQo+IAkgICB6ZXJvIHRoZW0gaGVyZSBh
cyBhcmcgbWF5IGJlIGxvbmcgb3IgcG9pbnRlci4gICovDQo+IAlsb25nIGFyZyA9IHZhX2FyZyhh
cCwgbG9uZyk7DQoNCkhlcmUgbGliYyBoYXMgdG8gYXNzdW1lIHRoYXQgaW50LCBsb25nIGFuZCBw
b2ludGVyIGFyZSBwYXNzZWQNCnRoZSBzYW1lIHdheS4NClRoaXMgaXMgdHJ1ZSBmb3IgZXZlcnl0
aGluZyBMaW51eCBhY3R1YWxseSBydW5zIG9uLg0KQnV0IHdvdWxkbid0IGJlIGlmLCBmb3IgZXhh
bXBsZSwgYSA2NGJpdCBhcmNoIGp1c3QgcHVzaGVkDQozMmJpdCBhcmd1bWVudHMgb24gc3RhY2su
DQpPciBpZiBhIDMyIGJpdCBvbmUgcGFzc2VkIGludGVnZXIgYW5kIHBvaW50ZXIgYXJncyBpbiBk
aWZmZXJlbnQNCnR5cGVzIG9mIHJlZ2lzdGVycy4NCkJ1dCBhbGwgNjRiaXQgb25lcyB1c2UgdGhl
IHNhbWUgR1AgcmVnaXN0ZXJzIGZvciBpbnQvbG9uZy9wb2ludGVyLg0KDQo+IGtlcm5lbCBjb2Rl
Og0KPiAtLS0tLS0tLS0tLS0NCj4gU1lTQ0FMTF9ERUZJTkUzKGZjbnRsLCB1bnNpZ25lZCBpbnQs
IGZkLCB1bnNpZ25lZCBpbnQsIGNtZCwgdW5zaWduZWQgbG9uZywgYXJnKQ0KPiB7DQoNClRoYXQg
aXMganVzdCBhIHdyYXBwZXIgYW5kIGNhbGxzIGRvX2ZjbnRsKCkuDQp3aGljaCBuZWVkcyBjaGFu
Z2luZyB0byBiZSBhZGQ6DQoJYXJnICY9IH4wVTsNCmJlZm9yZSB0aGUgc3dpdGNoKGNtZCkgew0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

