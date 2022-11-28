Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B063A348
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK1Ilq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiK1Ilo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:41:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832D17061
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:41:43 -0800 (PST)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NLJlJ1ytPzJp31;
        Mon, 28 Nov 2022 16:38:20 +0800 (CST)
Received: from kwepemi500013.china.huawei.com (7.221.188.120) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 16:41:41 +0800
Received: from kwepemi500013.china.huawei.com ([7.221.188.120]) by
 kwepemi500013.china.huawei.com ([7.221.188.120]) with mapi id 15.01.2375.031;
 Mon, 28 Nov 2022 16:41:41 +0800
From:   zhengyongjun <zhengyongjun3@huawei.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHNvYzogaW14OG06IEZpeCByZXR1cm4gdmFsdWUg?=
 =?utf-8?B?Y2hlY2sgaW4gaW14OG1xX3NvY19yZXZpc2lvbigp?=
Thread-Topic: [PATCH] soc: imx8m: Fix return value check in
 imx8mq_soc_revision()
Thread-Index: AQHZAXlwATmrP6JmYUKzP9C0acy6Ua5TdKeAgACSnXA=
Date:   Mon, 28 Nov 2022 08:41:41 +0000
Message-ID: <0c9958a539384a3a92677427fd152322@huawei.com>
References: <20221126092433.91150-1-zhengyongjun3@huawei.com>
 <489b24e6-fe75-caa7-1a97-2f1921b0c242@pengutronix.de>
In-Reply-To: <489b24e6-fe75-caa7-1a97-2f1921b0c242@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGFkaXZpY2UgOikNCiAgICAgICANCiAgICAgICAgICAgICAgIFpoZW5n
DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQWhtYWQgRmF0b3VtIFttYWls
dG86YS5mYXRvdW1AcGVuZ3V0cm9uaXguZGVdIA0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0MTHmnIgy
OOaXpSAxNTo1Ng0K5pS25Lu25Lq6OiB6aGVuZ3lvbmdqdW4gPHpoZW5neW9uZ2p1bjNAaHVhd2Vp
LmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0K5oqE6YCBOiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LWlteEBueHAuY29tOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGUNCuS4u+mimDogUmU6IFtQQVRDSF0gc29jOiBpbXg4bTogRml4IHJl
dHVybiB2YWx1ZSBjaGVjayBpbiBpbXg4bXFfc29jX3JldmlzaW9uKCkNCg0KSGkgWmhlbmcsDQoN
Ck9uIDI2LjExLjIyIDEwOjI0LCBaaGVuZyBZb25nanVuIHdyb3RlOg0KPiBJbiBjYXNlIG9mIGVy
cm9yLCB0aGUgZnVuY3Rpb24gb2ZfY2xrX2dldF9ieV9uYW1lKCkgcmV0dXJucyBFUlJfUFRSKCkg
DQo+IGFuZCBuZXZlciByZXR1cm5zIE5VTEwuIFRoZSBOVUxMIHRlc3QgaW4gdGhlIHJldHVybiB2
YWx1ZSBjaGVjayBzaG91bGQgDQo+IGJlIHJlcGxhY2VkIHdpdGggSVNfRVJSKCkuDQo+IA0KPiBG
aXhlczogODM2ZmIzMDk0OWQ5ICgic29jOiBpbXg4bTogRW5hYmxlIE9DT1RQIGNsb2NrIGJlZm9y
ZSByZWFkaW5nIA0KPiB0aGUgcmVnaXN0ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBZb25n
anVuIDx6aGVuZ3lvbmdqdW4zQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvaW14
L3NvYy1pbXg4bS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9zb2Mt
aW14OG0uYyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OG0uYyANCj4gaW5kZXggMjgxNDRjNjk5
YjBjLi4zMmVkOWRjODhlNDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14
OG0uYw0KPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDhtLmMNCj4gQEAgLTY2LDggKzY2
LDggQEAgc3RhdGljIHUzMiBfX2luaXQgaW14OG1xX3NvY19yZXZpc2lvbih2b2lkKQ0KPiAgCW9j
b3RwX2Jhc2UgPSBvZl9pb21hcChucCwgMCk7DQo+ICAJV0FSTl9PTighb2NvdHBfYmFzZSk7DQo+
ICAJY2xrID0gb2ZfY2xrX2dldF9ieV9uYW1lKG5wLCBOVUxMKTsNCj4gLQlpZiAoIWNsaykgew0K
PiAtCQlXQVJOX09OKCFjbGspOw0KPiArCWlmIChJU19FUlIoY2xrKSkgew0KPiArCQlXQVJOX09O
KElTX0VSUihjbGspKTsNCj4gIAkJcmV0dXJuIDA7DQoNCllvdSBjb3VsZCBhbHNvIHJld3JpdGUg
YXMNCg0KaWYgKFdBUk5fT04oSVNfRVJSKGNsaykpDQoJcmV0dXJuIDA7DQoNClRvIG1ha2UgaXQg
bW9yZSBjb25jaXNlLiBDaGFuZ2UgbG9va3MgZ29vZCB0aG91Z2g6DQoNClJldmlld2VkLWJ5OiBB
aG1hZCBGYXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KDQpDaGVlcnMsDQpBaG1hZA0K
DQo+ICAJfQ0KPiANCj4gLS0NCj4gMi4xNy4xDQo+IA0KPiANCj4gDQoNCi0tIA0KUGVuZ3V0cm9u
aXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNClN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8DQozMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAg
ICAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KQW10c2dlcmlj
aHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkx
Ny01NTU1IHwNCg0KDQo=
