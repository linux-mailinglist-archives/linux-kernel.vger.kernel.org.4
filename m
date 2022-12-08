Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23476466A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLHBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHBt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:49:57 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875866A748;
        Wed,  7 Dec 2022 17:49:55 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with
 arch_cpu_idle
Thread-Topic: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with
 arch_cpu_idle
Thread-Index: AQHZCkl35vAH2p6SAUK3SxvI0ANPyq5jOG4A
Date:   Thu, 8 Dec 2022 01:46:35 +0000
Message-ID: <9e19c594bcf144fbb433fb4cfee54e08@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
In-Reply-To: <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.204.59]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2022-12-08 09:46:35:454
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDcsIDIw
MjIgMTA6MzggUE0NCj4gVG86IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4g
Q2M6IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOw0K
PiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyByYWZhZWxAa2Vy
bmVsLm9yZzsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5v
cmc7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHRvbnkubHVja0BpbnRlbC5jb207IGpw
b2ltYm9lQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl1bdjJdIGNwdWlk
bGUtaGFsdHBvbGw6IFJlcGxhY2UgZGVmYXVsdF9pZGxlIHdpdGgNCj4gYXJjaF9jcHVfaWRsZQ0K
PiANCj4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxOjQyIFBNIDxsaXJvbmdxaW5nQGJhaWR1LmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5j
b20+DQo+ID4NCj4gPiBXaGVuIEtWTSBndWVzdCBoYXMgTVdBSVQgYW5kIG13YWl0X2lkbGUgaXMg
dXNlZCBhcyBkZWZhdWx0IGlkbGUNCj4gPiBmdW5jdGlvbiwgYnV0IG9uY2UgY3B1aWRsZS1oYWx0
cG9sbCBpcyBsb2FkZWQsIGRlZmF1bHRfaWRsZSBpbg0KPiA+IGRlZmF1bHRfZW50ZXJfaWRsZSBp
cyB1c2VkLCB3aGljaCBpcyB1c2luZyBITFQsIGFuZCBjYXVzZSBhDQo+ID4gcGVyZm9ybWFuY2Ug
cmVncmVzc2lvbi4gQXMgdGhlIGNvbW1pdCBhZWJlZjYzY2Y3ZmYgKCJ4ODY6IFJlbW92ZQ0KPiA+
IHZlbmRvciBjaGVja3MgZnJvbSBwcmVmZXJfbXdhaXRfYzFfb3Zlcl9oYWx0IikgZXhwbGFpbnMg
dGhhdCBtd2FpdCBpcw0KPiA+IHByZWZlcnJlZA0KPiA+DQo+ID4gc28gcmVwbGFjZSBkZWZhdWx0
X2lkbGUgd2l0aCBhcmNoX2NwdV9pZGxlIHdoaWNoIGNhbiB1c2luZyBNV0FJVA0KPiA+IG9wdGlt
aXphdGlvbi4NCj4gPg0KPiA+IGxhdGVuY3kgb2Ygc29ja3BlcmYgcGluZy1wb25nIGxvY2FsaG9z
dCB0ZXN0IGlzIHJlZHVjZWQgYnkgbW9yZSAyMCUNCj4gPiB1bml4YmVuY2ggaGFzIDUlIHBlcmZv
cm1hbmNlIGltcHJvdmVtZW50cyBmb3Igc2luZ2xlIGNvcmUNCj4gPg0KPiA+IFN1Z2dlc3RlZC1i
eTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gU3VnZ2VzdGVkLWJ5
OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0K
PiA+ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jICAgICAgICAgIHwgMSArDQo+ID4gIGRyaXZl
cnMvY3B1aWRsZS9jcHVpZGxlLWhhbHRwb2xsLmMgfCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4g
PiBpbmRleCBjMjFiNzM0Li4zMDNhZmFkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9wcm9jZXNzLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+ID4gQEAg
LTcyMSw2ICs3MjEsNyBAQCB2b2lkIGFyY2hfY3B1X2lkbGUodm9pZCkgIHsNCj4gPiAgICAgICAg
IHg4Nl9pZGxlKCk7DQo+ID4gIH0NCj4gPiArRVhQT1JUX1NZTUJPTChhcmNoX2NwdV9pZGxlKTsN
Cj4gDQo+IFdoeSBkbyB5b3UgbmVlZCB0aGlzIGV4cG9ydCBhdCBhbGw/DQo+IA0KDQpXaGVuIGNw
dWlkbGUtaGFsdHBvbGwgaXMgYnVpbHQgYXMgbW9kdWxlLCBpZiBhcmNoX2NwdV9pZGxlIGlzIG5v
dCBleHBvcnQsIGNwdWlkbGUtaGFsdHBvbGwgd2lsbCBjb21wbGFpbiAiYXJjaF9jcHVfaWRsZSIg
dW5kZWZpbmVkDQoNCkxpa2UNCg0KRVJST1I6IG1vZHBvc3Q6ICJhcmNoX2NwdV9pZGxlIiBbZHJp
dmVycy9jcHVpZGxlL2NwdWlkbGUtaGFsdHBvbGwua29dIHVuZGVmaW5lZCENCm1ha2VbMV06ICoq
KiBbc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0OjEyNjogTW9kdWxlLnN5bXZlcnNdIEVycm9yIDEN
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6MTk0NDogbW9kcG9zdF0gRXJyb3IgMg0KRXJyb3I6IE1ha2Ug
ZmFpbGVkIQ0KDQpJIHdpbGwgYWRkIHRoZSByZWFzb24gdG8gdjMgDQpUaGFua3MNCg0KLUxpDQoN
Cg0K
