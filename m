Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCECB6EBE44
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDWJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDWJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 05:24:34 -0400
Received: from gfmail1.glenfly.com (gfmail1.glenfly.com [113.31.180.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0D211736
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 02:24:32 -0700 (PDT)
X-ASG-Debug-ID: 1682241870-196b4b1510128830001-xx1T2L
Received: from GFSHEXCH03.glenfly.com (GFSHEXCH03.glenfly.com [10.5.250.53]) by gfmail1.glenfly.com with ESMTP id q6eotvfgetRQy7sM; Sun, 23 Apr 2023 17:24:30 +0800 (CST)
X-Barracuda-Envelope-From: ReaperLiOC@glenfly.com
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
Received: from GFSHEXCH03.glenfly.com (10.5.250.53) by GFSHEXCH03.glenfly.com
 (10.5.250.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 17:24:53 +0800
Received: from GFSHEXCH03.glenfly.com ([fe80::1cb2:fbd4:8e34:2eb5]) by
 GFSHEXCH03.glenfly.com ([fe80::1cb2:fbd4:8e34:2eb5%4]) with mapi id
 15.01.2507.023; Sun, 23 Apr 2023 17:24:53 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
From:   Reaper Li_OC <ReaperLiOC@glenfly.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jason Tao(SH-RD)" <JasonTao@glenfly.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: =?gb2312?B?tPC4tDogW7/JxNzKx8Csu/jTyrz+XSAgUmU6IFtQQVRDSF0gQUxTQTogaGRh?=
 =?gb2312?B?OiBHbGVuZmx5OiBhZGQgSEQgQXVkaW8gUENJIElEcyBhbmQgSERNSSBDb2Rl?=
 =?gb2312?Q?c_Vendor_IDs.?=
Thread-Topic: =?gb2312?B?W7/JxNzKx8Csu/jTyrz+XSAgUmU6IFtQQVRDSF0gQUxTQTogaGRhOiBHbGVu?=
 =?gb2312?B?Zmx5OiBhZGQgSEQgQXVkaW8gUENJIElEcyBhbmQgSERNSSBDb2RlYyBWZW5k?=
 =?gb2312?Q?or_IDs.?=
X-ASG-Orig-Subj: =?gb2312?B?tPC4tDogW7/JxNzKx8Csu/jTyrz+XSAgUmU6IFtQQVRDSF0gQUxTQTogaGRh?=
 =?gb2312?B?OiBHbGVuZmx5OiBhZGQgSEQgQXVkaW8gUENJIElEcyBhbmQgSERNSSBDb2Rl?=
 =?gb2312?Q?c_Vendor_IDs.?=
Thread-Index: AQHZcc/EOyC6wNUtXUCwz+S5QTu9D68wSx6AgAhbiBw=
Date:   Sun, 23 Apr 2023 09:24:53 +0000
Message-ID: <a711bc855b7a4e95a78343f0347bad59@glenfly.com>
References: <20230418083312.5208-1-reaperlioc@glenfly.com>,<87leip4j8q.wl-tiwai@suse.de>
In-Reply-To: <87leip4j8q.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.30.24.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: GFSHEXCH03.glenfly.com[10.5.250.53]
X-Barracuda-Start-Time: 1682241870
X-Barracuda-URL: https://10.5.252.51:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at glenfly.com
X-Barracuda-Scan-Msg-Size: 3828
X-Barracuda-Bayes: SPAM GLOBAL 0.9944 1.0000 4.2773
X-Barracuda-Spam-Score: 4.28
X-Barracuda-Spam-Status: No, SCORE=4.28 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107811
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KVGhhbmtzLCBJIHdpbGwgYWxzbyBzdWJtaXQgdG8gYWxzYS1kZXZlbCBNTCBhdCB0aGUg
bmV4dCB0aW1lLiANCg0KRm9yIHRoZSBsaXN0ZWQgcXVlc3Rpb25zOg0KDQo+IEBAIC0xNzQzLDYg
KzE3NDUsOCBAQCBzdGF0aWMgaW50IGRlZmF1bHRfYmRsX3Bvc19hZGooc3RydWN0IGF6eCAqY2hp
cCkNCj4gICAgICAgIH0NCj4gDQo+ICAgICAgICBzd2l0Y2ggKGNoaXAtPmRyaXZlcl90eXBlKSB7
DQo+ICsgICAgIGNhc2UgQVpYX0RSSVZFUl9HRkhETUk6DQo+ICsgICAgICAgICAgICAgcmV0dXJu
IDEyODsNCg0KIG91ciBjaGlwIG5lZWQgaW5jcmVhc2UgdGhlIGJkbCBhcyB0aGVyZSBpcyBsaW1p
dGF0aW9uIG9uIGhhcmR3YXJlLCBvbmNlIGhkYWMgaW50ZXJydXB0IGludGVydmFsIGlzIHRvbyBz
aG9ydCwgdGhlIGF1ZGlvIGRhdGEgbWF5IGdldCBsb3N0Lg0KDQo+IEBAIC0xODU5LDYgKzE4NjMs
OSBAQCBzdGF0aWMgaW50IGF6eF9maXJzdF9pbml0KHN0cnVjdCBhenggKmNoaXApDQo+ICAgICAg
ICB9DQo+ICAjZW5kaWYNCj4gDQo+ICsgICAgIGlmIChjaGlwLT5kcml2ZXJfdHlwZSA9PSBBWlhf
RFJJVkVSX0dGSERNSSkNCj4gKyAgICAgICAgICAgICBidXMtPnBvbGxpbmdfbW9kZSA9IDE7DQog
DQpPdXIgY2hpcCBoYXMgaW50ZXJydXB0IHVwb24gdGhlIENPUkIvUklSQiByZXNwb25zZSwgd2hl
biB0aGUgY29kZWMgY29tcGxldGUgdGhlIGNvbW1hbmQsIEl0IHNlbmRzIGludGVycnVwdCBhbmQg
d3JpdGVzIHJlc3BvbnNlIGVudHJpZXMgdG8gbWVtb3J5LCBIb3dldmVyIG9uIG91ciBoYXJkd2Fy
ZSwgdGhlIHJlc3BvbnNlIGVudHJpZXMgc29tZXRpbWVzIGFyZSBub3QgYWN0dWFsbHkgc3luY2hy
b25pemVkIHRvIG1lbW9yeSB3aGVuIGRyaXZlciBoYW5kbGUgdGhlIGhkYWMgaW50ZXJydXB0LiBJ
ZiB0aGUgUklSQiBzdGF0dXMgaXMgbm90IHVwZGF0ZWQgaW4gdGhlIGhkYWMgaW50ZXJydXB0IGhh
bmRsZXIsIGF6eF9yaXJiX2dldF9yZXNwb25zZSBrZWVwcyB0cnlpbmcgdG8gcmVjZWl2ZSBhIHJl
c3BvbnNlICBmcm9tIHJpcmIgdW50aWwgMXMgdGltb3V0IGJlZm9yZSBlbmFibGluZyBwb2xsaW5n
X21vZGUsIHNvbWUgYXBwcyB0cmVhdCBpdCBhcyBhbiBlcnJvci4gU28gZm9yIG91ciBoYXJkd2Fy
ZSwgbmVlZCB0byBlbmFibGUgcG9sbGluZ19tb2RlIHRvIGZpeCBpdC4NCg0KPiAtLS0gYS9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX2hkbWkuYw0KPiArKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWku
Yw0KPiBAQCAtNDQ4OSw2ICs0NDg5LDE4IEBAIHN0YXRpYyBpbnQgcGF0Y2hfdmlhX2hkbWkoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMpDQo+ICAgICAgICByZXR1cm4gcGF0Y2hfc2ltcGxlX2hkbWko
Y29kZWMsIFZJQUhETUlfQ1ZUX05JRCwgVklBSERNSV9QSU5fTklEKTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgaW50IHBhdGNoX2dmX2hkbWkoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpDQo+ICt7DQo+
ICsgICAgIGludCBlcnI7DQo+ICsNCj4gKyAgICAgZXJyID0gcGF0Y2hfZ2VuZXJpY19oZG1pKGNv
ZGVjKTsNCj4gKyAgICAgaWYgKGVycikNCj4gKyAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiAr
DQo+ICsgICAgIGNvZGVjLT5ub19zdGlja3lfc3RyZWFtID0gMTsNCg0KT24gb3VyIGNoaXAsIHRo
ZXJlIGFyZSB0d28gY29kZWNzLiB3aGVuIHN0cmVhbSBzd2l0Y2ggZnJvbSBvbmUgY29kZWMgdG8g
YW5vdGhlciBjb2RlYywgb3VyIGhhcmR3YXJlIG5lZWQgZHJpdmVyIHRvIGRvIGFjdHVhbCBjbGVh
bi11cHMgaW4gY29kZWNfY2xlYW51cF9zdHJlYW0gZm9yIHRoZSBsaW5rZWQgY29kZWMsIG90aGVy
d2lzZSBpdCBjYW4ndCBjb21wbGV0ZSBzd2l0Y2ggc3VjY2Vzc2Z1bGx5Lg0KDQpCZXN0IFJlZ2Fy
ZHMsDQoNClJlYXBlckxpDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQq3orz+yMs6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4NCreiy83KsbzkOiAyMDIzxOo0
1MIxOMjVIDE3OjQ0DQrK1bz+yMs6IFJlYXBlciBMaV9PQw0Ks63LzTogcGVyZXhAcGVyZXguY3o7
IHRpd2FpQHN1c2UuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKYXNvbiBUYW8o
U0gtUkQpOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCtb3zOI6IFu/ycTcysfArLv408q8
/l0gIFJlOiBbUEFUQ0hdIEFMU0E6IGhkYTogR2xlbmZseTogYWRkIEhEIEF1ZGlvIFBDSSBJRHMg
YW5kIEhETUkgQ29kZWMgVmVuZG9yIElEcy4NCg0KT24gVHVlLCAxOCBBcHIgMjAyMyAxMDozMzox
MiArMDIwMCwNCnJlYXBlcmxpIHdyb3RlOg0KPg0KPiBGcm9tOiBqYXNvbnRhbyA8amFzb250YW9A
Z2xlbmZseS5jb20+DQo+DQo+IEFkZCBhIHNldCBvZiBIRCBBdWRpbyBQQ0kgSURTLCBhbmQgdGhl
IEhETUkgY29kZWMgdmVuZG9yIElEcyBmb3INCj4gR2xlbmZseSBBcmlzZS4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogamFzb250YW8gPGphc29udGFvQGdsZW5mbHkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiByZWFwZXJsaSA8cmVhcGVybGlvY0BnbGVuZmx5LmNvbT4NCg0KVGhlIHBhdGNoIGxvb2tzIE9L
IG5vdywgYnV0IGNvdWxkIHlvdSBzdWJtaXQgdG8gYWxzYS1kZXZlbCBNTCBhdCB0aGUNCm5leHQg
dGltZT8NCg0KQWJvdXQgZGV0YWlscyBpbiB0aGUgcGF0Y2g6DQoNCj4gQEAgLTE3NDMsNiArMTc0
NSw4IEBAIHN0YXRpYyBpbnQgZGVmYXVsdF9iZGxfcG9zX2FkaihzdHJ1Y3QgYXp4ICpjaGlwKQ0K
PiAgICAgICB9DQo+DQo+ICAgICAgIHN3aXRjaCAoY2hpcC0+ZHJpdmVyX3R5cGUpIHsNCj4gKyAg
ICAgY2FzZSBBWlhfRFJJVkVSX0dGSERNSToNCj4gKyAgICAgICAgICAgICByZXR1cm4gMTI4Ow0K
DQpTbyB0aGlzIGxvb2tzIHByZXR0eSBoaWdoIGluIGNvbXBhcmlzb24gd2l0aCBvdGhlciBjaGlw
cy4NCkl0IG1lYW5zIHRoYXQgdGhlIGFjdHVhbCBwb3NpdGlvbiBpcyBtdWNoIGJlaGluZCB0aGUg
cmVwb3J0ZWQNCnBvc2l0aW9uLiAgRHVlIHRvIGEgbGFyZ2UgRklGTz8gIE9yIHdoYXQgcmVhc29u
Pw0KDQo+IEBAIC0xODU5LDYgKzE4NjMsOSBAQCBzdGF0aWMgaW50IGF6eF9maXJzdF9pbml0KHN0
cnVjdCBhenggKmNoaXApDQo+ICAgICAgIH0NCj4gICNlbmRpZg0KPg0KPiArICAgICBpZiAoY2hp
cC0+ZHJpdmVyX3R5cGUgPT0gQVpYX0RSSVZFUl9HRkhETUkpDQo+ICsgICAgICAgICAgICAgYnVz
LT5wb2xsaW5nX21vZGUgPSAxOw0KDQpUaGlzIGxvb2tzIG9kZCwgdG9vLiAgRG9lc24ndCB0aGUg
aGFyZHdhcmUgZ2l2ZSBhbnkgaW50ZXJydXB0IGJhY2sNCnVwb24gdGhlIENPUkIvUklSQiByZXNw
b25zZT8NCg0KPiAtLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYw0KPiArKysgYi9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX2hkbWkuYw0KPiBAQCAtNDQ4OSw2ICs0NDg5LDE4IEBAIHN0YXRpYyBp
bnQgcGF0Y2hfdmlhX2hkbWkoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpDQo+ICAgICAgIHJldHVy
biBwYXRjaF9zaW1wbGVfaGRtaShjb2RlYywgVklBSERNSV9DVlRfTklELCBWSUFIRE1JX1BJTl9O
SUQpOw0KPiAgfQ0KPg0KPiArc3RhdGljIGludCBwYXRjaF9nZl9oZG1pKHN0cnVjdCBoZGFfY29k
ZWMgKmNvZGVjKQ0KPiArew0KPiArICAgICBpbnQgZXJyOw0KPiArDQo+ICsgICAgIGVyciA9IHBh
dGNoX2dlbmVyaWNfaGRtaShjb2RlYyk7DQo+ICsgICAgIGlmIChlcnIpDQo+ICsgICAgICAgICAg
ICAgcmV0dXJuIGVycjsNCj4gKw0KPiArICAgICBjb2RlYy0+bm9fc3RpY2t5X3N0cmVhbSA9IDE7
DQoNClRoaXMgaGFjayBpcyBuZWVkZWQgZm9yIHdoYXQgcmVhc29uPw0KDQoNCnRoYW5rcywNCg0K
VGFrYXNoaQ0K
