Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9A5EBE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiI0JTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiI0JTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:19:16 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F8E9CDD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:18:08 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WKU00000;
        Tue, 27 Sep 2022 17:18:00 +0800
Received: from jtjnmail201606.home.langchao.com (10.100.2.6) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 17:18:01 +0800
Received: from jtjnmail201606.home.langchao.com ([fe80::8583:33f:807a:3430])
 by jtjnmail201606.home.langchao.com ([fe80::8583:33f:807a:3430%10]) with mapi
 id 15.01.2507.012; Tue, 27 Sep 2022 17:18:01 +0800
From:   =?utf-8?B?Um9jayBMaSjmnY7lro/kvJ8p?= <lihongweizz@inspur.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: fix crash issue if access released lockres in
 debugfs
Thread-Topic: [PATCH] ocfs2: fix crash issue if access released lockres in
 debugfs
Thread-Index: AdjSTgjzs68j6v4ZSxestKMYGpn8kQ==
Date:   Tue, 27 Sep 2022 09:18:01 +0000
Message-ID: <33c7f114b4ee498fbb5d233bb354e396@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.180.204.84]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
tUid:   20229271718004bb7c0e07da3a80c9c3a277ef3517944
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zZXBoLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuIA0KSW4gb3VyIHVzZSBjYXNlLCBh
IHVzZXJzcGFjZSBkYWVtb24gdG9vbCB3aWxsIHBlcmlvZGljYWxseSByZWFkIC9zeXMva2VybmVs
L2RlYnVnL28yZGxtLzx1dWlkPi9sb2NraW5nX3N0YXRlIHRvIGNoZWNrIHRoZSBsb2NrIHJlcXVl
c3Qgc3RhdGUuIFN5c3RlbSBjcmFzaGVzIGNhc3VhbGx5IGFmdGVyIGEgbG9uZyB0aW1lIHJ1bm5p
bmcuIEFmdGVyIGFuYWx5emVkIHRoZSB2bWNvcmUgZmlsZSwgSSBmb3VuZCB0aGUgZGFlbW9uIHRv
b2wgcHJvY2VzcyBpcyBhY2Nlc3NpbmcgYW4gaW52YWxpZCBwb2ludGVyIGluc2lkZSB0aGUgc2Vx
ZmlsZSBpdGVyYXRpb24gd2hlbiByZWFkaW5nIGxvY2tpbmdfc3RhdGUuIA0KDQpJIG5lZWQgdG8g
Y29ycmVjdCBteSBwYXRjaCBjb21tZW50IHNsaWdodGx5IHRoYXQgYWRkaW5nIGxvY2tyZXNBIGFu
ZCByZW1vdmluZyBsb2NrcmVzQiBkbyBub3QgaGF2ZSB0byBiZSB0aGUgc2FtZSBwcm9jZXNzLCB0
aGUga2V5IHBvaW50IGlzIHRoYXQgdGhlIGxvY2sgdHJhY2tpbmcgbGlzdCBpcyBjaGFuZ2VkIGR1
cmluZyBzZXFmaWxlIGl0ZXJhdGlvbi4NCg0KQnIsDQpSb2NrDQoNCj4gUmU6IFtQQVRDSF0gb2Nm
czI6IGZpeCBjcmFzaCBpc3N1ZSBpZiBhY2Nlc3MgcmVsZWFzZWQgbG9ja3JlcyBpbiBkZWJ1Z2Zz
DQo+IA0KPiBIaSwNCj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KPiBJdCBzZWVtcyBpdCBp
cyBpbmRlZWQgYW4gaXNzdWUgYW5kIEknbGwgZ2V0IGludG8gaXQgbW9yZSBkZWVwbHkuDQo+IEkn
bSBjdXJpb3VzIGFib3V0IGhvdyB5b3UgZmlndXJlIG91dCB0aGlzPyBJcyBpdCBhIHJlYWwgaXNz
dWUgeW91J3ZlIGVuY291bnRlcmVkPw0KPiANCj4gVGhhbmtzLA0KPiBKb3NlcGgNCj4gDQo+IE9u
IDkvMjAvMjIgMzozNiBQTSwgUm9jayBMaSB3cm90ZToNCj4gPiBBY2Nlc3MgbG9ja2luZ19zdGF0
ZSBvZiBkbG0gZGVidWdmcyBtYXkgY2F1c2UgY3Jhc2ggYXMgc2NlbmUgYmVsb3c6DQo+ID4NCj4g
PiBQcm9jIEE6ICAgICAgICAgICAgICAgICAgUHJvYyB0aGF0IGFjY2VzcyBkZWJ1Z2luZm86DQo+
ID4gYWRkX2xvY2tyZXNfdHJhY2tpbmcobG9ja3Jlc0EpDQo+ID4gLi4uDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgIG9jZnMyX2RsbV9zZXFfbmV4dCgpOg0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8vcHJpdi0+cF9pdGVyX3JlcyBwb2ludHMgdG8gbmV4dA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC8vbG9ja3JlcyBlLmcuIEIuIHByaXYtPnBfdG1wX3JlcyBo
b2xkDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgLy9jb3B5IG9mIGxvY2tyZXMgQSBi
ZWZvcmUgbGVhdmUNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgb2NmczJfZGxtX3NlcV9z
aG93KCkgLi4uDQo+ID4gcmVtb3ZlX2xvY2tyZXNfdHJhY2tpbmcobG9ja3JlcyBCKToNCj4gPiAg
IC8vZnJlZSBsb2NrcmVzIEIsIGxfZGVidWdfbGlzdCBpbg0KPiA+ICAgLy9wcml2LT5wX3Rlcl9y
ZXMgaXMgdXBkYXRlZCBidXQgbm90DQo+ID4gICAvL3ByaXYtPnBfdG1wX3Jlcw0KPiA+IC4uLg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBvY2ZzMl9kbG1fc2VxX25leHQoKToNCj4gPiAJ
CQkgICAgICAgICAgICAgICAgICAvL3ByaXYtPnBfdG1wX3JlcyB3aGljaCBob2xkcyBhIG9sZCBj
b3B5IG9mDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgLy9sb2NrcmVzIEEsIHRoZSBs
X2RlYnVnX2xpc3QgaG9sZHMgYQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vb3V0
LW9mLWRhdGUgc3VjY2VlZCBwb2ludGVyLCB3aGljaCB3aWxsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLy9jYXVzZSBjcmFzaCBhcyAvL2FjY2VzcyBpbnZhbGlkIG1lbW9yeQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGl0ZXIgPSB2OyAvL3ByaXYtPnBfdG1wX3Jlcw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGl0ZXIgPSBvY2ZzMl9kbG1fbmV4dF9yZXMo
aXRlciwgcHJpdikNCj4gPg0KPiA+IFRoZSByb290IGNhdXNlIG9mIHRoaXMgaXNzdWUgaXMgdGhh
dCBwcml2YXRlLT5wX2l0ZXJfcmVzIGFjdHMgYXMgdGhlDQo+ID4gYWdlbnQgb2YgYWNjZXNzaW5n
IGxvY2tyZXMgYW5kIGlzIHByb3RlY3RlZCBieSBvY2ZzMl9kbG1fdHJhY2tpbmdfbG9jaw0KPiA+
IHdoaWxlIHBfdG1wX3JlcyBpcyBvbmx5IGEgY29weSBvZiB0aGUgbG9ja3JlcyBhbmQgd2lsbCBi
ZSBvdXQtb2YtZGF0ZWQNCj4gPiBhZnRlciBsZWF2ZSBjcml0aWFsIHJlZ2lvbiBvZiBvY2ZzMl9k
bG1fdHJhY2tpbmdfbG9jay4gV2Ugc2hvdWxkIHVzZQ0KPiA+IHByaXYtPnBfdGVyX3JlcyBhcyB0
aGUgZm9yd2FyZCBpdGVyYXRlciBpbnN0ZWFkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9j
ayBMaSA8bGlob25nd2VpenpAaW5zcHVyLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvb2NmczIvZGxt
Z2x1ZS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9vY2ZzMi9kbG1nbHVlLmMgYi9mcy9v
Y2ZzMi9kbG1nbHVlLmMgaW5kZXgNCj4gPiBjMjhiYzk4Li41ZDg0MzUwIDEwMDY0NA0KPiA+IC0t
LSBhL2ZzL29jZnMyL2RsbWdsdWUuYw0KPiA+ICsrKyBiL2ZzL29jZnMyL2RsbWdsdWUuYw0KPiA+
IEBAIC0zMTA5LDcgKzMxMDksNyBAQCBzdGF0aWMgdm9pZCAqb2NmczJfZGxtX3NlcV9uZXh0KHN0
cnVjdCBzZXFfZmlsZQ0KPiAqbSwgdm9pZCAqdiwgbG9mZl90ICpwb3MpDQo+ID4gIAlzdHJ1Y3Qg
b2NmczJfbG9ja19yZXMgKmR1bW15ID0gJnByaXYtPnBfaXRlcl9yZXM7DQo+ID4NCj4gPiAgCXNw
aW5fbG9jaygmb2NmczJfZGxtX3RyYWNraW5nX2xvY2spOw0KPiA+IC0JaXRlciA9IG9jZnMyX2Rs
bV9uZXh0X3JlcyhpdGVyLCBwcml2KTsNCj4gPiArCWl0ZXIgPSBvY2ZzMl9kbG1fbmV4dF9yZXMo
ZHVtbXksIHByaXYpOw0KPiA+ICAJbGlzdF9kZWxfaW5pdCgmZHVtbXktPmxfZGVidWdfbGlzdCk7
DQo+ID4gIAlpZiAoaXRlcikgew0KPiA+ICAJCWxpc3RfYWRkKCZkdW1teS0+bF9kZWJ1Z19saXN0
LCAmaXRlci0+bF9kZWJ1Z19saXN0KTsNCg==
