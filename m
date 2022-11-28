Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6241A63B302
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiK1UYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiK1UYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:24:45 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417052A431
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:24:43 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E64B32C049B;
        Tue, 29 Nov 2022 09:24:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1669667080;
        bh=5wZqT5umrzdhHJ1OH604ML9RIdQn8n/Sd4CkmccXXPs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=neMm7dsDdMWO392CxSiirKC43zAXdZydoYNMv4eyviNc+noQCFillShmbEEomC9Hz
         3x0MfJe2krn6LSsBoxHvEmoCz4OgZX/B+t+eJOiRmEdmSLqYjMf2G44hwpq/YXsvqa
         nmXc/OP+883MP6NSO19ps1dQuAOrc0hkPY8+afJL/XF9sC5z4ArwJ9amrHLufoqVCz
         kvhpMrbP+pPfrmpequzPPa8gGNzmIj3q4jtm+KGgFoQ39zPhnm1dydkkfJLbpOTKd5
         OWAzS7tIL1Fmg8b+lEh6EMyDILFnDh2SdpzM1wGl7J4JWaM35virwTuzOtCfyGvDTz
         q3lGd41+hpnBA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B638519080001>; Tue, 29 Nov 2022 09:24:40 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 29 Nov 2022 09:24:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.044; Tue, 29 Nov 2022 09:24:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Thread-Topic: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Thread-Index: AQHZA2dxCY+RGJJEdEqB1PvkL3CYsw==
Date:   Mon, 28 Nov 2022 20:24:40 +0000
Message-ID: <417a6fb6-6ae7-a2bf-c549-fdba6e5765f6@alliedtelesis.co.nz>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
In-Reply-To: <20220714183328.4137-3-pali@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <649E928CB0C86B44965A882F94612FB3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=PqrtkDE3 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=VwQbUJbxAAAA:8 a=vEA0kl4FgOUJEhR6YuwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFsaSwNCg0KT24gMTUvMDcvMjIgMDY6MzMsIFBhbGkgUm9ow6FyIHdyb3RlOg0KPiBBcm1h
ZGEgMzh4IHN1cHBvcnRzIHBlciBDUFUgaW50ZXJydXB0cyBmb3IgZ3Bpb3MsIGxpa2UgQXJtYWRh
IFhQLiBQcmUtWFANCj4gdmFyaWFudHMgbGlrZSBBcm1hZGEgMzcwIGRvIG5vdCBzdXBwb3J0IHBl
ciBDUFUgaW50ZXJydXB0cyBmb3IgZ3Bpb3MuDQo+DQo+IFNvIGNoYW5nZSBjb21wYXRpYmxlIHN0
cmluZyBmb3IgQXJtYWRhIDM4eCBmcm9tICJtYXJ2ZWxsLGFybWFkYS0zNzAtZ3BpbyINCj4gd2hp
Y2ggaW5kaWNhdGVzIHByZS1YUCB2YXJpYW50IHRvICJtYXJ2ZWxsLGFybWFkYXhwLWdwaW8iIHdo
aWNoIGluZGljYXRlcw0KPiBYUCB2YXJpYW50IG9yIG5ldy4NCj4NCj4gRHJpdmVyIGdwaW8tbXZl
YnUuYyB3aGljaCBoYW5kbGVzIGJvdGggcHJlLVhQIGFuZCBYUCB2YXJpYW50cyBhbHJlYWR5DQo+
IHByb3ZpZGVzIHN1cHBvcnQgZm9yIHBlciBDUFUgaW50ZXJydXB0cyBvbiBYUCBhbmQgbmV3ZXIg
dmFyaWFudHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5v
cmc+DQo+IEZpeGVzOiA3Y2IyYWNiM2ZiYWUgKCJBUk06IGR0czogbXZlYnU6IEFkZCBQV00gcHJv
cGVydGllcyBmb3IgYXJtYWRhLTM4eCIpDQo+IC0tLQ0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2Fy
bWFkYS0zOHguZHRzaSB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
cm1hZGEtMzh4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kNCj4gaW5k
ZXggZGYzYzhkMWQ4ZjY0Li45MzQzZGU2OTQ3YjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2FybWFkYS0zOHguZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEt
Mzh4LmR0c2kNCj4gQEAgLTI5Miw3ICsyOTIsNyBAQA0KPiAgIAkJCX07DQo+ICAgDQo+ICAgCQkJ
Z3BpbzA6IGdwaW9AMTgxMDAgew0KPiAtCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGEt
MzcwLWdwaW8iLA0KPiArCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGF4cC1ncGlvIiwN
Cj4gICAJCQkJCSAgICAgIm1hcnZlbGwsb3Jpb24tZ3BpbyI7DQo+ICAgCQkJCXJlZyA9IDwweDE4
MTAwIDB4NDA+LCA8MHgxODFjMCAweDA4PjsNCj4gICAJCQkJcmVnLW5hbWVzID0gImdwaW8iLCAi
cHdtIjsNCg0KQ3VycmVudGx5IHdoZW4geW91IHNwZWNpZnkgdGhlICJtYXJ2ZWxsLGFybWFkYXhw
LWdwaW8iIGNvbXBhdGlibGUgdGhpcyANCmNhdXNlcyB0aGUgZHJpdmVyIHRvIGV4cGVjdCB0aGUg
Mm5kIHJlZyBwcm9wZXJ0eSB0byBiZSB0aGUgcGVyLUNQVSANCmludGVycnVwdCByZWdpc3RlcnMu
IFRoZSBjb2RlIGluIHF1ZXN0aW9uIGlzDQoNCiDCoMKgwqDCoMKgwqDCoCAvKg0KIMKgwqDCoMKg
wqDCoMKgwqAgKiBUaGUgQXJtYWRhIFhQIGhhcyBhIHNlY29uZCByYW5nZSBvZiByZWdpc3RlcnMg
Zm9yIHRoZQ0KIMKgwqDCoMKgwqDCoMKgwqAgKiBwZXItQ1BVIHJlZ2lzdGVycw0KIMKgwqDCoMKg
wqDCoMKgwqAgKi8NCiDCoMKgwqDCoMKgwqDCoCBpZiAobXZjaGlwLT5zb2NfdmFyaWFudCA9PSBN
VkVCVV9HUElPX1NPQ19WQVJJQU5UX0FSTUFEQVhQKSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSk7
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoYmFzZSkpDQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VS
UihiYXNlKTsNCg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdmNoaXAtPnBlcmNw
dV9yZWdzID0NCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRldm1fcmVnbWFwX2luaXRfbW1pbygmcGRldi0+ZGV2LCBiYXNlLA0KJm12ZWJ1X2dwaW9fcmVn
bWFwX2NvbmZpZyk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIo
bXZjaGlwLT5wZXJjcHVfcmVncykpDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihtdmNoaXAtPnBlcmNwdV9yZWdzKTsNCiDCoMKg
wqDCoMKgwqDCoCB9DQoNCkJ1dCB3aXRoIHlvdXIgY29kZSBjaGFuZ2UgcmVzb3VyY2VbMV0gaXMg
cG9pbnRpbmcgYXQgdGhlIGJsaW5rIGVuYWJsZSANCnJlZ2lzdGVyIG5vdCBhdCB0aGUgcGVyLUNQ
VSBpbnRlcnJ1cHQgcmVnaXN0ZXIgKG9mZnNldCAxODgwMC8xODg0MCkuDQoNCg0KPiBAQCAtMzEw
LDcgKzMxMCw3IEBADQo+ICAgCQkJfTsNCj4gICANCj4gICAJCQlncGlvMTogZ3Bpb0AxODE0MCB7
DQo+IC0JCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zNzAtZ3BpbyIsDQo+ICsJCQkJ
Y29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYXhwLWdwaW8iLA0KPiAgIAkJCQkJICAgICAibWFy
dmVsbCxvcmlvbi1ncGlvIjsNCj4gICAJCQkJcmVnID0gPDB4MTgxNDAgMHg0MD4sIDwweDE4MWM4
IDB4MDg+Ow0KPiAgIAkJCQlyZWctbmFtZXMgPSAiZ3BpbyIsICJwd20iOw==
