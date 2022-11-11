Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1162B625DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiKKPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiKKPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:01:30 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDA729BB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1668178834;
  x=1699714834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fON7pObanRF1Uh/P00Mehvr/bi1ufQEx4XCvxOtF19o=;
  b=W5IGUlVxAixecHeNIGOLKFiUmvIrYcA2G3L7J6BdIVgkQ56AV1X3Veg4
   9d9sgJyjgSQK+iXWzsHMMyON/Yobcitec/gd6kMvpT0AUl0yKNlFPcoaW
   qVTnFgLyZZKclauLZhcQxOtVfYPiDuGcXHe2J2FofwYlqJAn6dZigOHJL
   Xa9wCyO9qopWaa2Ll+yVtLfhr8H4u5YT7ebPiwhgDMnzJdc1j8S1i2sl5
   ojNcrIOuEgsqJZo2ryemlNfdefR/FExMIhIYwWEpVHwuBrg8YhW0VtJiK
   4wLPoIUOBcRUrTIUHI/cMDAF8Y8iJhx/x6Uz3e7bcYfnm+phhjsagGvgw
   g==;
From:   =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
To:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>,
        "etienne.carriere@linaro.org" <etienne.carriere@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Thread-Topic: [PATCH] firmware: arm_scmi: Resolve dependency with TEE
 subsystem
Thread-Index: AQHY9bNyMyeFeP3G1keVYelAsguUwK45ujoAgAAGSIA=
Date:   Fri, 11 Nov 2022 15:00:29 +0000
Message-ID: <7a32a3694ffd6790e4e2a7c5896931cf8f1a7243.camel@axis.com>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
         <20221111143800.k7xje6g23ujefnye@bogus>
In-Reply-To: <20221111143800.k7xje6g23ujefnye@bogus>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8924B4C78786645BA9E21081AD15CAB@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDE0OjM4ICswMDAwLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+
IE9uIEZyaSwgTm92IDExLCAyMDIyIGF0IDAzOjIzOjEzUE0gKzA1MzAsIFN1bWl0IEdhcmcgd3Jv
dGU6DQo+ID4gVGhlIE9QLVRFRSBTQ01JIHRyYW5zcG9ydCBjaGFubmVsIGlzIGRlcGVuZGVudCBv
biBURUUgc3Vic3lzdGVtIHRvDQo+ID4gYmUNCj4gPiBpbml0aWFsaXplZCBmaXJzdC4gQnV0IGN1
cnJlbnRseSB0aGUgQXJtIFNDTUkgc3Vic3lzdGVtIGFuZCBURUUNCj4gPiBzdWJzeXN0ZW0gYXJl
IGludm9rZWQgb24gdGhlIHNhbWUgaW5pdGNhbGwgbGV2ZWwgYXMNCj4gPiBzdWJzeXN0ZW1faW5p
dCgpLg0KPiA+IA0KPiA+IEl0IGlzIG9ic2VydmVkIHRoYXQgdGhlIFNDTUkgc3Vic3lzdGVtIGlu
aXRjYWxsIGlzIGludm9rZWQgcHJpb3IgdG8NCj4gPiBURUUNCj4gPiBzdWJzeXN0ZW0gaW5pdGNh
bGwuIFRoaXMgbGVhZHMgdG8gdW53YW50ZWQgZXJyb3IgbWVzc2FnZXMgcmVnYXJkaW5nDQo+ID4g
VEVFDQo+ID4gYnVzIGlzIG5vdCBwcmVzZW50IHlldC4gQWx0aG91Z2gsIC1FUFJPQkVfREVGRVIg
dHJpZXMgdG8gd29ya2Fyb3VuZA0KPiA+IHRoYXQNCj4gPiBwcm9ibGVtLg0KPiA+IA0KPiA+IExl
dHMgdHJ5IHRvIHJlc29sdmUgaW50ZXIgc3Vic3lzdGVtIGRlcGVuZGVuY3kgcHJvYmxlbSB2aWEg
c2hpZnRpbmcNCj4gPiBBcm0NCj4gPiBTQ01JIHN1YnN5c3RlbSB0byBzdWJzeXN0ZW1faW5pdF9z
eW5jKCkgaW5pdGNhbGwgbGV2ZWwuDQo+ID4gDQo+IA0KPiBJIHdvdWxkIGF2b2lkIGRvaW5nIHRo
YXQuIFdlIGFscmVhZHkgaGF2ZSBzb21lIGltcGxpY2l0IGRlcGVuZGVuY3kNCj4gd2l0aA0KPiBz
dWJzeXNfaW5pdGNhbGwgYmVjYXVzZSB0aGlzIGRyaXZlciBjcmVhdGVzL3JlZ2lzdGVycyBidXMg
YW5kIG5lZWQgdG8NCj4gYmUNCj4gZG9uZSBlYXJseS4gTm93IGluIG9yZGVyIHRvIHNvbHZlIHRo
ZSBkZXBlbmRlbmN5IGJldHdlZW4gU0NNSSBhbmQNCj4gVEVFLA0KPiBib3RoIG9mIHdoaWNoIGNy
ZWF0ZXMvcmVnaXN0ZXJzIGJ1cyBhbmQgYXJlIGF0IHNhbWUgc3Vic3lzX2luaXRjYWxsLA0KPiB3
ZSBhcmUgcmVseWluZyBvbiBzdWJzeXNfaW5pdGNhbGxfc3luYy4NCj4gDQo+IE1lIGFuZCBMdWR2
aWcgZGlzY3Vzc2VkIHRoaXMgaW4gcHJpdmF0ZSBhbmQgSSBzdWdnZXN0ZWQgaGltIHRvIGRvDQo+
IHNvbWV0aGluZw0KPiBsaWtlIGJlbG93IHBhdGNoIHNuaXBwZXQuIEhlIG1lbnRpb25lZCBoZSBk
aWQgcG9zdCBhIHBhdGNoIG9uIHRoZQ0KPiBsaXN0IGJ1dA0KPiBJIGNvdWxkbid0IGZpbmQgaXQu
IEZvciB0aGlzIHRoZSBzY21pIG5vZGUgbXVzdCBiZSBjaGlsZCBub2RlIG9mDQo+IE9QVEVFIGFz
DQo+IGl0IGlzIHByb3ZpZGluZyB0aGUgdHJhbnNwb3J0Lg0KPiANCj4gQEx1ZHZpZywgPw0KPiAN
Cj4gUmVnYXJkcywNCj4gU3VkZWVwDQo+IA0KPiAtLQ0KPiBkaWZmIC0tZ2l0IGkvZHJpdmVycy90
ZWUvb3B0ZWUvc21jX2FiaS5jDQo+IHcvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+IGlu
ZGV4IGExYzFmYTFhOWMyOC4uODM5ZmVjYTBkZWY0IDEwMDY0NA0KPiAtLS0gaS9kcml2ZXJzL3Rl
ZS9vcHRlZS9zbWNfYWJpLmMNCj4gKysrIHcvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+
IEBAIC0xNTM0LDcgKzE1MzQsOSBAQCBzdGF0aWMgaW50IG9wdGVlX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIGVycl9kaXNhYmxlX3NobV9jYWNoZTsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIHByX2luZm8o
ImluaXRpYWxpemVkIGRyaXZlclxuIik7DQo+IC3CoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ICsN
Cj4gK8KgwqDCoMKgwqDCoCAvKiBQb3B1bGF0ZSBhbnkgZGVwZW5kZW50IGNoaWxkIG5vZGUoaWYg
YW55KSAqLw0KPiArwqDCoMKgwqDCoMKgIHJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRl
KCZwZGV2LT5kZXYpOw0KPiANCj4gwqBlcnJfZGlzYWJsZV9zaG1fY2FjaGU6DQo+IMKgwqDCoMKg
wqDCoMKgIGlmICghb3B0ZWUtPnJwY19wYXJhbV9jb3VudCkNCj4gDQpJIGhhdmUgYW5zd2VyZWQg
c29tZXRoaW5nIHNpbWlsYXIgaW4gbXkgc3VibWl0IFsxXS4gTWF5YmUgSSBzaG91bGQgaGF2ZQ0K
Q0NlZCB5b3UsIG9yIGF0bGVhc3Qgc2VudCB5b3UgdGhpcyBsaW5rIHdoZW4gSSB0b2xkIHlvdSBJ
IG1hZGUgdGhlDQpzdWJtaXNzaW9uLg0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjIv
MTEvOS84MDMNCg0KQlIsDQpMdWR2aWcNCg==
