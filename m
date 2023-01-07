Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036C660D22
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjAGJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjAGJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:10:31 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F66B585
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:10:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8922224E004;
        Sat,  7 Jan 2023 17:10:24 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 7 Jan
 2023 17:10:24 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Sat, 7 Jan 2023 17:10:24 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH 0/3] RISC-V Hibernation Support
Thread-Topic: [PATCH 0/3] RISC-V Hibernation Support
Thread-Index: AQHZIZTqwYypoX0My0ChYWYlFtUmh66Qm80AgAG96pA=
Date:   Sat, 7 Jan 2023 09:10:24 +0000
Message-ID: <31b303a394f24b04b3aa81c64be6855f@EXMBX066.cuchost.com>
References: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
 <E0CEA20A-7D53-4766-AB5D-48A06D7E3991@kernel.org>
In-Reply-To: <E0CEA20A-7D53-4766-AB5D-48A06D7E3991@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.6.8]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIDYgSmFudWFyeSwgMjAyMyA1OjM4IFBN
DQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IHBhdWwu
d2FsbXNsZXlAc2lmaXZlLmNvbTsNCj4gcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHUNCj4gQ2M6IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEplZUhlbmcgU2lhDQo+IDxqZWVoZW5nLnNpYUBzdGFyZml2
ZXRlY2guY29tPjsgTGV5Zm9vbiBUYW4NCj4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+
OyBNYXNvbiBIdW8NCj4gPG1hc29uLmh1b0BzdGFyZml2ZXRlY2guY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAvM10gUklTQy1WIEhpYmVybmF0aW9uIFN1cHBvcnQNCj4gDQo+IEhleSBmb2xr
cywNCj4gSnVzdCBwYXNzaW5nIG9uIHNvbWUgaXNzdWVzIHRoYXQgYXV0b21hdGlvbiBwaWNrZWQg
dXAuDQpUaGFua3MuIFdpbGwgc3VibWl0IGEgbmV3IHBhdGNoZXMgc2VyaWVzIHRvIGFkZHJlc3Mg
dGhlIGlzc3Vlcy4NCj4gDQo+IA0KPiBPbiA2IEphbnVhcnkgMjAyMyAwNjowNTozMiBHTVQsIFNp
YSBKZWUgSGVuZw0KPiA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4gd3JvdGU6DQo+ID5U
aGlzIHNlcmllcyBhZGRzIFJJU0MtViBIaWJlcm5hdGlvbi9zdXNwZW5kIHRvIGRpc2sgc3VwcG9y
dC4NCj4gPkxvdyBsZXZlbCBBcmNoIGZ1bmN0aW9ucyB3ZXJlIGNyZWF0ZWQgdG8gc3VwcG9ydCBo
aWJlcm5hdGlvbi4NCj4gPnN3c3VzcF9hcmNoX3N1c3BlbmQoKSByZWxpZXMgY29kZSBmcm9tIF9f
Y3B1X3N1c3BlbmRfZW50ZXIoKSB0byB3cml0ZQ0KPiA+Y3B1IHN0YXRlIG9udG8gdGhlIHN0YWNr
LCB0aGVuIGNhbGxpbmcgc3dzdXNwX3NhdmUoKSB0byBzYXZlIHRoZSBtZW1vcnkNCj4gPmltYWdl
Lg0KPiA+DQo+ID5hcmNoX2hpYmVybmF0aW9uX2hlYWRlcl9yZXN0b3JlKCkgYW5kIGFyY2hfaGli
ZXJuYXRpb25faGVhZGVyX3NhdmUoKQ0KPiA+ZnVuY3Rpb25zIGFyZSBpbXBsZW1lbnRlZCB0byBw
cmV2ZW50IGtlcm5lbCBjcmFzaCB3aGVuIHJlc3VtZSwNCj4gPnRoZSBrZXJuZWwgYnVpbHQgdmVy
c2lvbiBpcyBzYXZlZCBpbnRvIHRoZSBoaWJlcm5hdGlvbiBpbWFnZSBoZWFkZXINCj4gPnRvIG1h
a2luZyBzdXJlIG9ubHkgdGhlIHNhbWUga2VybmVsIGlzIHJlc3RvcmUgd2hlbiByZXN1bWUuDQo+
ID4NCj4gPnN3c3VzcF9hcmNoX3Jlc3VtZSgpIGNyZWF0ZXMgYSB0ZW1wb3JhcnkgcGFnZSB0YWJs
ZSB0aGF0IGNvdmVyaW5nIG9ubHkNCj4gPnRoZSBsaW5lYXIgbWFwLCBjb3BpZXMgdGhlIHJlc3Rv
cmUgY29kZSB0byBhICdzYWZlJyBwYWdlLCB0aGVuIHN0YXJ0IHRvDQo+ID5yZXN0b3JlIHRoZSBt
ZW1vcnkgaW1hZ2UuIE9uY2UgY29tcGxldGVkLCBpdCByZXN0b3JlcyB0aGUgb3JpZ2luYWwNCj4g
Pmtlcm5lbCdzIHBhZ2UgdGFibGUuIEl0IHRoZW4gY2FsbHMgaW50byBfX2hpYmVybmF0ZV9jcHVf
cmVzdW1lKCkNCj4gPnRvIHJlc3RvcmUgdGhlIENQVSBjb250ZXh0LiBGaW5hbGx5LCBpdCBmb2xs
b3dzIHRoZSBub3JtYWwgaGliZXJuYXRpb24NCj4gPnBhdGggYmFjayB0byB0aGUgaGliZXJuYXRp
b24gY29yZS4NCj4gPg0KPiA+VG8gZW5hYmxlIGhpYmVybmF0aW9uL3N1c3BlbmQgdG8gZGlzayBp
bnRvIFJJU0NWLCB0aGUgYmVsb3cgY29uZmlnDQo+ID5uZWVkIHRvIGJlIGVuYWJsZWQ6DQo+ID4t
IENPTkZJR19BUkNIX0hJQkVSTkFUSU9OX0hFQURFUg0KPiA+LSBDT05GSUdfQVJDSF9ISUJFUk5B
VElPTl9QT1NTSUJMRQ0KPiA+DQo+ID4NCj4gPkF0IGhpZ2gtbGV2ZWwsIHRoaXMgc2VyaWVzIGlu
Y2x1ZGVzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4gPjEpIENoYW5nZSBzdXNwZW5kX3NhdmVf
Y3NycygpIGFuZCBzdXNwZW5kX3Jlc3RvcmVfY3NycygpDQo+ID4gICB0byBwdWJsaWMgZnVuY3Rp
b24gYXMgdGhlc2UgZnVuY3Rpb25zIGFyZSBjb21tb24gdG8NCj4gPiAgIHN1c3BlbmQvaGliZXJu
YXRpb24uIChwYXRjaCAxKQ0KPiA+MikgRW5oYW5jZSBrZXJuZWxfcGFnZV9wcmVzZW50KCkgZnVu
Y3Rpb24gdG8gc3VwcG9ydCBodWdlIHBhZ2UuIChwYXRjaCAyKQ0KPiA+MykgQWRkIGFyY2gvcmlz
Y3YgbG93IGxldmVsIGZ1bmN0aW9ucyB0byBzdXBwb3J0DQo+ID4gICBoaWJlcm5hdGlvbi9zdXNw
ZW5kIHRvIGRpc2suIChwYXRjaCAzKQ0KPiA+DQo+ID5UaGUgYWJvdmUgcGF0Y2hlcyBhcmUgYmFz
ZWQgb24ga2VybmVsIHY2LjItcmMyIGFuZCBhcmUgdGVzdGVkIG9uDQo+ID5TdGFyZml2ZSBWRjIg
U0JDIGJvYXJkLg0KPiA+DQo+ID5TaWEgSmVlIEhlbmcgKDMpOg0KPiA+ICBSSVNDLVY6IENoYW5n
ZSBzdXNwZW5kX3NhdmVfY3NycyBhbmQgc3VzcGVuZF9yZXN0b3JlX2NzcnMgdG8gcHVibGljDQo+
ID4gICAgZnVuY3Rpb24NCj4gPiAgUklTQy1WOiBtbTogRW5hYmxlIGh1Z2UgcGFnZSBzdXBwb3J0
IHRvIGtlcm5lbF9wYWdlX3ByZXNlbnQoKSBmdW5jdGlvbg0KPiANCj4gVW5mb3J0dW5hdGVseSB0
aGlzIGJyZWFrcyBydjMyX2RlZmNvbmZpZw0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbGludXgtDQo+IHJpc2N2L3BhdGNoLzIwMjMwMTA2MDYwNTM1LjEwNDMyMS0zLWpl
ZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20vDQo+IA0KPiA+ICBSSVNDLVY6IEFkZCBhcmNoIGZ1
bmN0aW9ucyB0byBzdXBwb3J0IGhpYmVybmF0aW9uL3N1c3BlbmQtdG8tZGlzaw0KPiANCj4gVGhp
cyBvbmUgdGhlbiBicmVha3MgcnY2NCBhbGxtb2Rjb25maWcgdG9vIDovDQo+IA0KPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+IHJpc2N2L3BhdGNoLzIwMjMw
MTA2MDYwNTM1LjEwNDMyMS00LWplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20vDQo+IA0KPiBU
aGFua3MsDQo+IENvbm9yLg0KPiANCj4gPg0KPiA+IGFyY2gvcmlzY3YvS2NvbmZpZyAgICAgICAg
ICAgICAgICB8ICAgNyArDQo+ID4gYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zdXNwZW5kLmggIHwg
IDIzICsrDQo+ID4gYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgICAgICAgIHwgICAyICstDQo+
ID4gYXJjaC9yaXNjdi9rZXJuZWwvYXNtLW9mZnNldHMuYyAgIHwgICA1ICsNCj4gPiBhcmNoL3Jp
c2N2L2tlcm5lbC9oaWJlcm5hdGUtYXNtLlMgfCAxMjMgKysrKysrKysrKysNCj4gPiBhcmNoL3Jp
c2N2L2tlcm5lbC9oaWJlcm5hdGUuYyAgICAgfCAzNTMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gYXJjaC9yaXNjdi9rZXJuZWwvc3VzcGVuZC5jICAgICAgIHwgICA0ICstDQo+
ID4gYXJjaC9yaXNjdi9tbS9wYWdlYXR0ci5jICAgICAgICAgIHwgICA2ICsNCj4gPiA4IGZpbGVz
IGNoYW5nZWQsIDUyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9oaWJlcm5hdGUtYXNtLlMNCj4gPiBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvaGliZXJuYXRlLmMNCj4gPg0KPiA+DQo+ID5i
YXNlLWNvbW1pdDogMWY1YWJiZDc3ZTJjMTc4N2U3NGI3YzJjYWZmYWM5N2RlZjc4YmE1Mg0K
