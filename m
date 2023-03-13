Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD76B6D61
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCMCPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:15:32 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21B2E0D2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:15:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 83C922C04A0;
        Mon, 13 Mar 2023 15:15:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1678673727;
        bh=QzXzTbqI6gPJAzPqvcn9hCrEDAGQZEo5CMEesFh4BEo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=P+8LIkwlnWzZwtC1CiOa/WIO5+GTSOUuENduePFmSVmgBOFPNRpg6I5vYwiQM3e/l
         pbklEy/e2twc6RKxdTAsYjC6ZorqVSgWCdcHFjCkyC6IoGKaoOu7/nthrxGg2xwFJZ
         4GQWDyiU2XsuI4zHbGAoZ0GJjdw57EnjVbuis8QlcEORRAmU8pAYAhjD/CrwroDLb/
         2EarPDf3Q76iyG6KiPBWV8HA2H2+/ONZc2q+scMu3VRdCtzsWoy9CFaQ/8u4p70Dc/
         ABYtLBxDECjC70OQtGO8UaDp0I/YUb9fmk7fR5sUx5o3YNfe1DI4DZ2xgC+JGI5fgA
         WizkrGhBKku2g==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B640e873f0002>; Mon, 13 Mar 2023 15:15:27 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 13 Mar 2023 15:15:27 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.047; Mon, 13 Mar 2023 15:15:27 +1300
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
Thread-Index: AQHZQLLY3ijYBbo43E6McZa87qvtIa7Sap6AgCTdZwA=
Date:   Mon, 13 Mar 2023 02:15:26 +0000
Message-ID: <52382400-5abd-b473-6cf7-333e7deab2d4@alliedtelesis.co.nz>
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
Content-ID: <697B16603D201848B6F70AC0786352B3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=gAnH3GRIAAAA:8 a=fNrnSkCQ5hO86qIVmZYA:9 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWJyYWhpbSwNCg0KT24gMTgvMDIvMjMgMDQ6MTcsIFRpbGtpLCBJYnJhaGltIHdyb3RlOg0K
Pj4gSGkgSWJyYWhpbSwNCj4+DQo+PiBPbiA5LzExLzIyIDAxOjIyLCBJYnJhaGltIFRpbGtpIHdy
b3RlOg0KPj4+IEFkZGluZyBzdXBwb3J0IGZvciBBbmFsb2cgRGV2aWNlcyBNQVgzMTNYWCBzZXJp
ZXMgUlRDcy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IElicmFoaW0gVGlsa2kgPElicmFoaW0u
VGlsa2lAYW5hbG9nLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaZXluZXAgQXJzbGFuYmVuemVy
IDxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxvZy5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVy
cy9ydGMvS2NvbmZpZyAgICAgICAgfCAgIDExICsNCj4+PiAgICBkcml2ZXJzL3J0Yy9NYWtlZmls
ZSAgICAgICB8ICAgIDEgKw0KPj4+ICAgIGRyaXZlcnMvcnRjL3J0Yy1tYXgzMTN4eC5jIHwgMTA3
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAzIGZpbGVzIGNo
YW5nZWQsIDEwODIgaW5zZXJ0aW9ucygrKQ0KPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3J0Yy9ydGMtbWF4MzEzeHguYw0KPj4gV2hhdCBpcyB0aGUgY3VycmVudCBzdGF0ZSBvZiB0
aGlzIHdvcms/IEkgc2VlIHRoZXJlIGFyZSBzb21lIGNvbW1lbnRzIG9uDQo+PiB0aGlzIHYzIGl0
ZXJhdGlvbiBmcm9tIGxhdGUgbGFzdCB5ZWFyIGFuZCBJIGNvdWxkbid0IGZpbmQgYW55IG5ld2Vy
DQo+PiBpdGVyYXRpb24gb24gYW55IG1haWxpbmcgbGlzdC4gV2UndmUgZ290IHNvbWUgbmV3IGhh
cmR3YXJlIGFycml2aW5nIHNvb24NCj4+IHRoYXQgd2lsbCBoYXZlIHRoZSBNQVgzMTMzMSBSVEMg
YW5kIEknbSBrZWVuIHRvIHNlZSB0aGlzIHBhdGNoIHNlcmllcw0KPj4gbGFuZC4gSXMgdGhlcmUg
YW55dGhpbmcgSSBjYW4gZG8gdG8gaGVscCBpdCBhbG9uZz8gSSBjYW4ndCBiZSB2ZXJ5DQo+PiBz
cGVjaWZpYyBhYm91dCB3aGVuIEknbGwgc2VlIHRoZSBuZXcgaGFyZHdhcmUgKHdobyBjYW4gdGhl
c2UgZGF5cyksIHRoZQ0KPj4gbGFzdCB1cGRhdGUgd2FzICJib2FyZHMgYXJlIGR1ZSBpbiBNYXJj
aCIuDQo+Pg0KPj4gRm9yIHRoZSBtYWludGFpbmVycyBvbiB0aGUgQ2MgbGlzdCBvbmNlIHRoZSBk
dXN0IHNldHRsZXMgaG93IHdvdWxkIEkgZ2V0DQo+PiB0aGlzIHN1cHBvcnRlZCBpbiBhIExUUyBr
ZXJuZWwgKHdlJ3JlIGN1cnJlbnRseSB1c2luZyB0aGUgNS4xNSBzZXJpZXMpPw0KPj4gT3IgaXMg
dG90YWxseSBvdXQgb2YgdGhlIHF1ZXN0aW9uIGJlY2F1c2UgaXQncyBub3QganVzdCBhIG5ldyBk
ZXZpY2UgaWQ/DQo+IEhpIENocmlzLA0KPg0KPiBQYXRjaCB2NCBpcyBvbiB0aGUgd2F5LCBJIHdp
bGwgYmUgc2VuZGluZyBpdCBpbiBhIGZldyB3ZWVrcy4NCj4gSXQgaXMgaGFyZCB0byB0ZWxsIHdo
ZW4gaXQgaXMgZ29pbmcgdG8gbGFuZCBidXQgSSBleHBlY3QgdG8gYmUgbW9yZSByZXNwb25zaXZl
DQo+IHRvIHJldmlld3MgYWZ0ZXIgcGF0Y2ggdjQuDQoNCkZZSSBJJ3ZlIG5vdyBnb3Qgc29tZSBi
b2FyZHMgd2l0aCBhIE1BWDMxMzMxLiBJJ3ZlIGdpdmVuIHYzIGEgcXVpY2sgdGVzdCANCmFuZCBp
dCB3b3JrcyBmb3IgbWUuDQoNCkFyZSB5b3UgYWxzbyBsb29raW5nIGF0IGEgdS1ib290IGRyaXZl
cj8gSWYgbm90IEkgY2FuIHBvcnQgeW91ciBkcml2ZXIgDQphY3Jvc3MgcmVhc29uYWJseSBlYXNp
bHkuDQoNCg==
