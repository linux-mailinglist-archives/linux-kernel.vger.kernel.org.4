Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B769C238
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 21:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBSUUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 15:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjBSUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:20:05 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4C17177
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 12:20:02 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2D2CE2C0616;
        Mon, 20 Feb 2023 09:19:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1676837999;
        bh=JUH1WHvmSPZEoOp3VE0zisnHxspGu5Hm0zgeJH9zu1I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fvcmT/Pyx2t6LBiMUImOlkCKblUMIMSBzAiCx1rExGeLTvy2hsnufwplzw48jSa52
         6fA41FHWQUdHTIj1rcr14rWMntJRBp5tVx5wpe3AsvNB4hS8g8CX4Sb9U0md4dO7Fc
         CBXl0i4DKdPq3w+fzs6Cx9c7MCW2FS+nqMhtxF9czoIoSKCNMbYFcIsgfcEx8Gq9RU
         mJRL135DKohVZi5408IfwNwLHKFJiUgcMjw3K1vDCLNo0OQ5M6c5kZWzwRSDynS1is
         RSN3GilcC2ZwGdLphd02zGM5+6c4MPt4qvGrivyvB7DP2pFwcseBevhDIqP1jmn2Cv
         n8BupNoqvp/Pg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f2846f0001>; Mon, 20 Feb 2023 09:19:59 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 20 Feb 2023 09:19:59 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.047; Mon, 20 Feb 2023 09:19:59 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHZQLLY3ijYBbo43E6McZa87qvtIa7Sap6AgAN5H4A=
Date:   Sun, 19 Feb 2023 20:19:58 +0000
Message-ID: <ee7c6fc7-c4d7-ae85-6da9-ec4e1a14bac4@alliedtelesis.co.nz>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
 <CY4PR03MB2488B54E722831F0375430CA96A19@CY4PR03MB2488.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB2488B54E722831F0375430CA96A19@CY4PR03MB2488.namprd03.prod.outlook.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C7E09A091FB6346873D0D56147F9888@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10 a=gAnH3GRIAAAA:8 a=fNrnSkCQ5hO86qIVmZYA:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOC8wMi8yMyAwNDoxNywgVGlsa2ksIElicmFoaW0gd3JvdGU6DQo+PiBIaSBJYnJhaGlt
LA0KPj4NCj4+IE9uIDkvMTEvMjIgMDE6MjIsIElicmFoaW0gVGlsa2kgd3JvdGU6DQo+Pj4gQWRk
aW5nIHN1cHBvcnQgZm9yIEFuYWxvZyBEZXZpY2VzIE1BWDMxM1hYIHNlcmllcyBSVENzLg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogSWJyYWhpbSBUaWxraSA8SWJyYWhpbS5UaWxraUBhbmFsb2cu
Y29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNs
YW5iZW56ZXJAYW5hbG9nLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJzL3J0Yy9LY29uZmln
ICAgICAgICB8ICAgMTEgKw0KPj4+ICAgIGRyaXZlcnMvcnRjL01ha2VmaWxlICAgICAgIHwgICAg
MSArDQo+Pj4gICAgZHJpdmVycy9ydGMvcnRjLW1heDMxM3h4LmMgfCAxMDcwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMTA4MiBp
bnNlcnRpb25zKCspDQo+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRjL3J0Yy1t
YXgzMTN4eC5jDQo+PiBXaGF0IGlzIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoaXMgd29yaz8gSSBz
ZWUgdGhlcmUgYXJlIHNvbWUgY29tbWVudHMgb24NCj4+IHRoaXMgdjMgaXRlcmF0aW9uIGZyb20g
bGF0ZSBsYXN0IHllYXIgYW5kIEkgY291bGRuJ3QgZmluZCBhbnkgbmV3ZXINCj4+IGl0ZXJhdGlv
biBvbiBhbnkgbWFpbGluZyBsaXN0LiBXZSd2ZSBnb3Qgc29tZSBuZXcgaGFyZHdhcmUgYXJyaXZp
bmcgc29vbg0KPj4gdGhhdCB3aWxsIGhhdmUgdGhlIE1BWDMxMzMxIFJUQyBhbmQgSSdtIGtlZW4g
dG8gc2VlIHRoaXMgcGF0Y2ggc2VyaWVzDQo+PiBsYW5kLiBJcyB0aGVyZSBhbnl0aGluZyBJIGNh
biBkbyB0byBoZWxwIGl0IGFsb25nPyBJIGNhbid0IGJlIHZlcnkNCj4+IHNwZWNpZmljIGFib3V0
IHdoZW4gSSdsbCBzZWUgdGhlIG5ldyBoYXJkd2FyZSAod2hvIGNhbiB0aGVzZSBkYXlzKSwgdGhl
DQo+PiBsYXN0IHVwZGF0ZSB3YXMgImJvYXJkcyBhcmUgZHVlIGluIE1hcmNoIi4NCj4+DQo+PiBG
b3IgdGhlIG1haW50YWluZXJzIG9uIHRoZSBDYyBsaXN0IG9uY2UgdGhlIGR1c3Qgc2V0dGxlcyBo
b3cgd291bGQgSSBnZXQNCj4+IHRoaXMgc3VwcG9ydGVkIGluIGEgTFRTIGtlcm5lbCAod2UncmUg
Y3VycmVudGx5IHVzaW5nIHRoZSA1LjE1IHNlcmllcyk/DQo+PiBPciBpcyB0b3RhbGx5IG91dCBv
ZiB0aGUgcXVlc3Rpb24gYmVjYXVzZSBpdCdzIG5vdCBqdXN0IGEgbmV3IGRldmljZSBpZD8NCj4g
SGkgQ2hyaXMsDQo+DQo+IFBhdGNoIHY0IGlzIG9uIHRoZSB3YXksIEkgd2lsbCBiZSBzZW5kaW5n
IGl0IGluIGEgZmV3IHdlZWtzLg0KPiBJdCBpcyBoYXJkIHRvIHRlbGwgd2hlbiBpdCBpcyBnb2lu
ZyB0byBsYW5kIGJ1dCBJIGV4cGVjdCB0byBiZSBtb3JlIHJlc3BvbnNpdmUNCj4gdG8gcmV2aWV3
cyBhZnRlciBwYXRjaCB2NC4NCkdyZWF0IHRoYW5rcy4gSSdsbCBrZWVwIGFuIGV5ZSBvdXQgZm9y
IGl0Lg==
