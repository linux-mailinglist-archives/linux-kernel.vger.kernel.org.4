Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B864E5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLPBgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLPBgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:36:32 -0500
Received: from mail5.msi.com (mail5.msi.com [114.30.40.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15482EF42;
        Thu, 15 Dec 2022 17:36:27 -0800 (PST)
Received: from mail2.msi.com (mail2.msi.com [220.130.147.42])
        by mail5.msi.com (Postfix) with ESMTPS id 7AC55540659;
        Fri, 16 Dec 2022 09:36:25 +0800 (CST)
Received: from mail2.msi.com (localhost [127.0.0.1])
        by postfix.imss91 (Postfix) with ESMTP id D0495CC07F2;
        Fri, 16 Dec 2022 09:36:25 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 postfix.imss91 D0495CC07F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msi.com; s=20220711;
        t=1671154585; bh=CgWxA2UFYmU8ajRWDJy7zd3Ws4qZPKtlN9XJ+PlMXKI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NAAGv0WJfhZEUSXuy2xKQ3xlEuYbtV6SeBlw5HMYZmDkO/+b2NrP5AsEw+QIxMCmy
         j1E1ZG8UzxEBkxL/kNfJuhBZtlTvbe6n79p3uTSLadJXfkBnJJuLLTN7F0mVJkTNv0
         BaeFBUzPJne9EoqEdkuM3jKpQ3p2D2oG7ifKKG+4dObpV0NZuDO5fs1ErYR8ZFHJCM
         j7E2KnhdKMX9RAt01xycF/02WiU0rCtc0EwRFN2HuFkJ0voy/cUFOWWXjQESRVmpM3
         mWeDIDOPf2ULqhMXa8kvvjPd6+5nk83Opai7sMGuW8rmFl7W5TyWfnHmc0VR6npSa3
         52d2ABhxmEN0w==
Received: from EX2016A.msi.com.tw (unknown [172.16.0.54])
        by mail2.msi.com (Postfix) with ESMTPS id C1A4CCC07AF;
        Fri, 16 Dec 2022 09:36:25 +0800 (CST)
Received: from EX2016A.msi.com.tw (172.16.0.54) by EX2016A.msi.com.tw
 (172.16.0.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Fri, 16 Dec
 2022 09:36:24 +0800
Received: from EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011]) by
 EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011%10]) with mapi id
 15.01.2507.016; Fri, 16 Dec 2022 09:36:24 +0800
From:   =?big5?B?am9ld3Uop2Sl8q62KQ==?= <joewu@msi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Joe Wu <joewu@msi.corp-partner.google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Derek Huang <derekhuang@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Douglas Anderson <dianders@chromium.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: RE: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Topic: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Index: AQHZEEy2MF2RiyAUZk2itU6kR3IX965u+taAgAC9IyA=
Date:   Fri, 16 Dec 2022 01:36:24 +0000
Message-ID: <5f36a68518ca44aa9566a5df801bccaa@msi.com>
References: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
 <Y5uZNVzEgsKzlPD0@google.com>
In-Reply-To: <Y5uZNVzEgsKzlPD0@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.252.125]
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-RCPT: <dmitry.torokhov@gmail.com>, <joewu@msi.corp-partner.google.com>, <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>, <wangxiang@cdjrlc.com>, <linux-input@vger.kernel.org>, <derekhuang@google.com>, <gregkh@linuxfoundation.org>, <bleung@chromium.org>, <dnojiri@chromium.org>, <pmalani@chromium.org>, <furquan@chromium.org>, <tzungbi@kernel.org>, <chrome-platform@lists.linux.dev>, <dianders@chromium.org>, <dustin@howett.net>, <groeck@chromium.org>, <gustavoars@kernel.org>, <sebastian.reichel@collabora.com>
X-TM-AS-GCONF: 00
X-RCPT: <wangxiang@cdjrlc.com>, <bleung@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <groeck@chromium.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <sebastian.reichel@collabora.com>, <dmitry.torokhov@gmail.com>, <derekhuang@google.com>, <dustin@howett.net>, <gustavoars@kernel.org>, <tzungbi@kernel.org>, <gregkh@linuxfoundation.org>, <chrome-platform@lists.linux.dev>, <internal@maedb.msi.com>, <joewu@msi.corp-partner.google.com>, <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpUaGFuayB5b3UgZm9yIGNvbW1lbnRzLiBJIHdpbGwgdHJ5IHRvIGdpdmUg
YSBjbGVhciBkZXNjcmlwdGlvbiBhbmQgc2VudCB0aGUgcGF0Y2ggYWdhaW4uDQpBY3R1YWxseSwg
dGhlIGZ1bmN0aW9uIG9mICJsZWF2ZSBQQyhjcm9zKSBtb2RlIiBidXR0b24gaXMgdG8gaW1wbGVt
ZW50ICdsb2NrIHRoZSBzY3JlZW4nIGluIGNocm9tZU9TLg0KR29vZ2xlIHN1Z2dlc3RzIHVzIHRv
IHNlbnQgJ0YxMycga2V5IHRvIGxvY2sgdGhlIHNjcmVlbiwgY291bGQgd2UgZG8gaXQgb3IgZG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/IA0KDQpCUnMsDQpKb2UNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWls
LmNvbT4gDQpTZW50OiBGcmlkYXksIERlY2VtYmVyIDE2LCAyMDIyIDY6MDEgQU0NClRvOiBKb2Ug
V3UgPGpvZXd1QG1zaS5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCkNjOiBMS01MIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21pdW0ub3Jn
PjsgWGlhbmcgd2FuZ3ggPHdhbmd4aWFuZ0BjZGpybGMuY29tPjsgbGludXgtaW5wdXRAdmdlci5r
ZXJuZWwub3JnOyBEZXJlayBIdWFuZyA8ZGVyZWtodWFuZ0Bnb29nbGUuY29tPjsgR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEJlbnNvbiBMZXVuZyA8Ymxl
dW5nQGNocm9taXVtLm9yZz47IERhaXN1a2UgTm9qaXJpIDxkbm9qaXJpQGNocm9taXVtLm9yZz47
IFByYXNoYW50IE1hbGFuaSA8cG1hbGFuaUBjaHJvbWl1bS5vcmc+OyBGdXJxdWFuIFNoYWlraCA8
ZnVycXVhbkBjaHJvbWl1bS5vcmc+OyBUenVuZy1CaSBTaGloIDx0enVuZ2JpQGtlcm5lbC5vcmc+
OyBjaHJvbWUtcGxhdGZvcm1AbGlzdHMubGludXguZGV2OyBEb3VnbGFzIEFuZGVyc29uIDxkaWFu
ZGVyc0BjaHJvbWl1bS5vcmc+OyBEdXN0aW4gTCAuIEhvd2V0dCA8ZHVzdGluQGhvd2V0dC5uZXQ+
OyBHdWVudGVyIFJvZWNrIDxncm9lY2tAY2hyb21pdW0ub3JnPjsgR3VzdGF2byBBIC4gUiAuIFNp
bHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+OyBTZWJhc3RpYW4gUmVpY2hlbCA8c2ViYXN0aWFu
LnJlaWNoZWxAY29sbGFib3JhLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNyb3NfZWNfa2V5
YjogQWRkIDMgYnV0dG9ucyBmb3IgbW9uaXRvciBmdW5jdGlvbg0KDQpIaSBKb2UsDQoNCk9uIFRo
dSwgRGVjIDE1LCAyMDIyIGF0IDAyOjE1OjUwUE0gKzA4MDAsIEpvZSBXdSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBpcyB0byBhZGQgZXh0cmEgMyBidXR0b25zOiAnYnJpZ2h0bmVzcyB1cCcsICdicmln
aHRuZXNzIA0KPiBkb3duJyBhbmQgJ2xlYXZlIFBDKGNyb3MpIG1vZGUnIHRvIHN1cHBvcnQgbW9u
aXRvciBuYXZpZ2F0aW9uIA0KPiBmdW5jdGlvbi4NCg0KSSB1bmRlcnN0YW5kICJicmlnaHRuZXNz
IHVwIiBhbmQgImJyaWdodG5lc3MgZG93biIgYnV0IEkgaGF2ZSBubyBpZGVhIHdoYXQgImxlYXZl
IFBDKGNyb3MpIG1vZGUiIG1lYW5zLiBJIGFsc28gZG8gbm90IHRoaW5rIHdlIHNob3VsZCBiZSBh
YnVzaW5nIEYxMyBmb3IgdGhpcy4NCg0KVGhhbmtzLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
b2UgV3UgPGpvZXd1QG1zaS5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gDQo+IC0tLQ0KPiAN
Cj4gIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvY3Jvc19lY19rZXliLmMgICAgICAgICAgfCAxNSAr
KysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jcm9zX2VjX2Nv
bW1hbmRzLmggfCAgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvY3Jvc19lY19rZXliLmMg
DQo+IGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9jcm9zX2VjX2tleWIuYw0KPiBpbmRleCBjMTQx
MzZiNzMzYTkuLmJmMWNmMGI3ODJkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbnB1dC9rZXli
b2FyZC9jcm9zX2VjX2tleWIuYw0KPiArKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2Nyb3Nf
ZWNfa2V5Yi5jDQo+IEBAIC0xMDAsNiArMTAwLDIxIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3Jv
c19lY19ic19tYXAgY3Jvc19lY19rZXliX2JzW10gPSB7DQo+ICAJCS5jb2RlCQk9IEtFWV9WT0xV
TUVET1dOLA0KPiAgCQkuYml0CQk9IEVDX01LQlBfVk9MX0RPV04sDQo+ICAJfSwNCj4gKwl7DQo+
ICsJCS5ldl90eXBlICAgICAgICA9IEVWX0tFWSwNCj4gKwkJLmNvZGUgICAgICAgICAgID0gS0VZ
X0JSSUdIVE5FU1NVUCwNCj4gKwkJLmJpdCAgICAgICAgICAgID0gRUNfTUtCUF9CUklfVVAsDQo+
ICsJfSwNCj4gKwl7DQo+ICsJCS5ldl90eXBlICAgICAgICA9IEVWX0tFWSwNCj4gKwkJLmNvZGUg
ICAgICAgICAgID0gS0VZX0JSSUdIVE5FU1NET1dOLA0KPiArCQkuYml0ICAgICAgICAgICAgPSBF
Q19NS0JQX0JSSV9ET1dOLA0KPiArCX0sDQo+ICsJew0KPiArCQkuZXZfdHlwZSAgICAgICAgPSBF
Vl9LRVksDQo+ICsJCS5jb2RlICAgICAgICAgICA9IEtFWV9GMTMsDQo+ICsJCS5iaXQgICAgICAg
ICAgICA9IEVDX01LQlBfQ1JPU19MRUFWRSwNCj4gKwl9LA0KPiAgDQo+ICAJLyogU3dpdGNoZXMg
Ki8NCj4gIAl7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY3Jv
c19lY19jb21tYW5kcy5oIA0KPiBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jcm9zX2Vj
X2NvbW1hbmRzLmgNCj4gaW5kZXggNTc0NGEyZDc0NmFhLi43OTIxOGRhOGE4Y2IgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jcm9zX2VjX2NvbW1hbmRzLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KPiBA
QCAtMzQ3MSw2ICszNDcxLDkgQEAgc3RydWN0IGVjX3Jlc3BvbnNlX2dldF9uZXh0X2V2ZW50X3Yx
IHsNCj4gICNkZWZpbmUgRUNfTUtCUF9WT0xfVVAJCTENCj4gICNkZWZpbmUgRUNfTUtCUF9WT0xf
RE9XTgkyDQo+ICAjZGVmaW5lIEVDX01LQlBfUkVDT1ZFUlkJMw0KPiArI2RlZmluZSBFQ19NS0JQ
X0JSSV9VUCAgICAgICAgICA0DQo+ICsjZGVmaW5lIEVDX01LQlBfQlJJX0RPV04gICAgICAgIDUN
Cj4gKyNkZWZpbmUgRUNfTUtCUF9DUk9TX0xFQVZFICAgICAgNg0KPiAgDQo+ICAvKiBTd2l0Y2hl
cyAqLw0KPiAgI2RlZmluZSBFQ19NS0JQX0xJRF9PUEVOCTANCj4gLS0NCj4gMi4xNy4xDQo+IA0K
DQotLSANCkRtaXRyeQ0KDQoqKioqKkNPTkZJREVOVElBTCBJTkZPUk1BVElPTioqKioqDQoNClRo
aXMgZW1haWwgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHVzZSBvZiB0aGUgcGVyc29uIG9yIGVu
dGl0eSB0byB3aG9tIGl0IGlzDQphZGRyZXNzZWQgYW5kIGNvbnRhaW5zIGluZm9ybWF0aW9uIHRo
YXQgbWF5IGJlIHN1YmplY3QgdG8gYW5kL29yIG1heSBiZQ0KcmVzdHJpY3RlZCBmcm9tIGRpc2Ns
b3N1cmUgYnkgY29udHJhY3Qgb3IgYXBwbGljYWJsZSBsYXcuIElmIHlvdSBhcmUgbm90IHRoZSAN
CmludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVtYWlsLCBiZSBhZHZpc2VkIHRoYXQgYW55IGRp
c2Nsb3N1cmUsIGNvcHksIA0KZGlzdHJpYnV0aW9uIG9yIHVzZSBvZiB0aGUgY29udGVudHMgb2Yg
dGhpcyBtZXNzYWdlIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIA0KSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVtYWlsLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgDQp0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IgYnkgcmVwbHlpbmcgdG8g
dGhpcyBtZXNzYWdlLiBUaGVuLCANCnBsZWFzZSBkZWxldGUgaXQgZnJvbSB5b3VyIHN5c3RlbS4g
T3VyIFByaXZhY3kgUG9saWN5IGlzIGF2YWlsYWJsZSBoZXJlIA0KaHR0cHM6Ly93d3cubXNpLmNv
bS9wYWdlL3ByaXZhY3ktcG9saWN5LiBUaGFuayB5b3Uu

