Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE95F3AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJDBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDBNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:13:10 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3E3687A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 18:13:07 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1C2D02C04D1;
        Tue,  4 Oct 2022 01:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664845984;
        bh=x29jml33rjTDIC1AW0KfLG/mVZ1osUI+ufY8iDO3EpM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aBXyNnpP22g2MXdkhVL8XJgxNq9LuAQZJ6vRb6pxZBRwGjtxH2qIjmMNzBadg8FAv
         Y7qFX+EF5Ao+hy5YXgVUUyE2IVzMqBJiKvRL0RFBmUyXjwJNCE6vUeqQp06Pkd2d0s
         DcjOz1kOElAe5HKptRjb5Ue+MPkBtlNngA51QQipb4O8RXYwP1SzHC4/XxU6up4QRv
         Fr71NudIpSw9MFtlX44D4hc4/kqyw3tjqqtvpjl3Mdc0kgN6NFk3B534fWbo7XpQI9
         3G0Z2d3ptOLCChmn+Sa8Aw47XuyRzDbxWWLG2vR1yZGsF9Tob8PhQGvBSQIEL7bWYg
         OhX5vOEmostKg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633b88a00000>; Tue, 04 Oct 2022 14:13:04 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.38; Tue, 4 Oct 2022 14:13:03 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Tue, 4 Oct 2022 14:13:03 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: armada-xp-98dx3236: add interrupts for watchdog
Thread-Topic: [PATCH] ARM: dts: armada-xp-98dx3236: add interrupts for
 watchdog
Thread-Index: AQHY126F968+A44LO0SkiKQWyPP7Ta38lBuA
Date:   Tue, 4 Oct 2022 01:13:03 +0000
Message-ID: <c99ca249-7135-1313-8cc4-e6d3c3f85d2a@alliedtelesis.co.nz>
References: <20221003212419.1280860-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20221003212419.1280860-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DD004912570C44D866D32A2F84D5CEC@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=VwQbUJbxAAAA:8 a=PKtBWZOgI90uNcnaf6AA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiA0LzEwLzIyIDEwOjI0LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBUaGUg
Zmlyc3QgaW50ZXJydXB0IGlzIGZvciB0aGUgcmVndWxhciB3YXRjaGRvZyB0aW1lb3V0LiBOb3Jt
YWxseSB0aGUNCj4gUlNUT1VUIGxpbmUgd2lsbCB0cmlnZ2VyIGEgcmVzZXQgYmVmb3JlIHRoaXMg
aW50ZXJydXB0IGZpcmVzIGJ1dCBvbg0KPiBzeXN0ZW1zIHdpdGggYSBub24tc3RhbmRhcmQgcmVz
ZXQgaXQgbWF5IHN0aWxsIHRyaWdnZXIuDQo+DQo+IFRoZSBzZWNvbmQgaW50ZXJydXB0IGlzIGZv
ciBhIHRpbWVyMSB3aGljaCBpcyB1c2VkIGFzIGEgcHJlLXRpbWVvdXQgZm9yDQo+IHRoZSB3YXRj
aGRvZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBh
bGxpZWR0ZWxlc2lzLmNvLm56Pg0KDQpJIGp1c3QgcmVhbGl6ZWQgdGhpcyBpcyBhIGR1cGxpY2F0
ZSBvZiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdhdGNoZG9nLzIwMjIwMjExMDAz
MjU3LjIwMzczMzItMi1jaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubnovIA0KKEkgZGlk
IGhhdmUgYSBzdHJhbmdlIHNlbnNlIG9mIGRlamEgdnUgd2hlbiB3cml0aW5nIGl0KS4NCg0KTG9v
a3MgbGlrZSB0aGF0IHBhdGNoIHdhcyByZXZpZXdlZCBhbmQgYWNrZWQgYnV0IG5ldmVyIGRlbGl2
ZXJlZC4gDQpHcmVnb3J5IHdvdWxkIHlvdSBiZSBhYmxlIHRvIHBpY2sgaXQgdXAgbm93PyBUaGUg
ZHJpdmVyIGNoYW5nZSBoYXMgYmVlbiANCmluIGZvciBhIHdoaWxlLg0KDQo+IC0tLQ0KPiAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL2FybWFkYS14cC05OGR4MzIzNi5kdHNpIHwgMSArDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9hcm1hZGEteHAtOThkeDMyMzYuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS14
cC05OGR4MzIzNi5kdHNpDQo+IGluZGV4IDM4YTA1MmEwMzEyZC4uMGU1NjFkZmMwY2E5IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAtOThkeDMyMzYuZHRzaQ0KPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEteHAtOThkeDMyMzYuZHRzaQ0KPiBAQCAtMjg2
LDYgKzI4Niw3IEBAICZ3YXRjaGRvZyB7DQo+ICAgCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1h
ZGEteHAtd2R0IjsNCj4gICAJY2xvY2tzID0gPCZjb3JlY2xrIDI+LCA8JnJlZmNsaz47DQo+ICAg
CWNsb2NrLW5hbWVzID0gIm5iY2xrIiwgImZpeGVkIjsNCj4gKwlpbnRlcnJ1cHRzID0gPDkzPiwg
PDM4PjsNCj4gICB9Ow0KPiAgIA0KPiAgICZjcHVyc3Qgew==
