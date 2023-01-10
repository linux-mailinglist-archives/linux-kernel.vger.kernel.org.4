Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029F6637DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjAJDeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAJDes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:34:48 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099E1DDFD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:34:46 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 36B4D2C04E4;
        Tue, 10 Jan 2023 16:34:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1673321683;
        bh=JXK9XcuU5BtTAG6zrZjes9Fz+CEerOh/HuxsN544Y3g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=qKd8w3gLakPOod4mevoFnSmDLtoVk/yC5opyZE/Kh2iNpVccHfNVUeg7o0Rqx/Z2m
         lPkBFRDO2DOUgMme3kaRoPpCeJ4iVMV4zhojBjF05134M/dH7QbLw0zlVOl4ImV65S
         BwCvWklC4A0DUfXKwqVcb2Y1ur7Wzks+LHhGHCPoU3euI+1X6w/ANymF7eUO1KFIA1
         pv7lkJH7vEktoFzgn2w9EQZLkMW5290pLEhZs5+nHOKqEkZoNznrScC92TIhrAf8W8
         LJ0XChQSKVPcboa45K8SBDodAaLkeYkw528GBhu4heae23nNHeruRTtCfDR26bG6NQ
         a1THDI7I++kJw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63bcdcd30001>; Tue, 10 Jan 2023 16:34:43 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan 2023 16:34:42 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 16:34:42 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: AC5/AC5X: Fix address for UART1
Thread-Topic: [PATCH] arm64: dts: marvell: AC5/AC5X: Fix address for UART1
Thread-Index: AQHZEDB9qsL6lsHyh06bePZmPJfPRK6WTqQA
Date:   Tue, 10 Jan 2023 03:34:42 +0000
Message-ID: <70fb6048-848e-e558-a1b9-3d74aca8ec01@alliedtelesis.co.nz>
References: <20221215025402.1733132-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20221215025402.1733132-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C83D4EE8769D514F99C9FE9176FDAE15@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=X/cs11be c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10 a=D_AEATpMilPvRHeLKy4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAxNS8xMi8yMiAxNTo1NCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gVGhl
IGNvcnJlY3QgYWRkcmVzcyBvZmZzZXQgaXMgMHgxMjEwMC4NCj4NCj4gRml4ZXM6IDMxYmU3OTFl
MjZjZiAoImFybTY0OiBkdHM6IG1hcnZlbGw6IEFkZCBVQVJUMS0zIGZvciBBQzUvQUM1WCIpDQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4gLS0tDQo+IE5vdCBzdXJlIGhvdyB0aGlzIGhhcHBlbmVkLiBJIG9ubHkgbm90
aWNlZCB3aGVuIEkgaGFkIGEgY29uZmxpY3QgaW4gc29tZQ0KPiBsb2NhbCBwYXRjaGVzIEkgd2Fz
IHJlYmFzaW5nIGFnYWluc3QgdXBzdHJlYW0uIFNvIEkgb2J2aW91c2x5IGhhZCBpdA0KPiByaWdo
dCBhdCBvbmUgcG9pbnQgYnV0IHRoZW4gbWFuYWdlZCB0byBicmVhayBpdCBpbiB0aGUgcHJvY2Vz
cyBvZg0KPiBjbGVhbmluZyB0aGluZ3MgdXAgZm9yIHN1Ym1pc3Npb24uDQoNCkkga25vdyBwZW9w
bGUgaGF2ZSBwcm9iYWJseSBiZWVuIGF3YXkgd2l0aCB2YXJpb3VzIGhvbGlkYXlzIGJ1dCBJIHRo
aW5rIA0KaXQncyBiZWVuIGxvbmcgZW5vdWdoIHNvLi4uLg0KDQpwaW5nPw0KDQo+DQo+ICAgYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpIHwgMiArLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpDQo+IGluZGV4IDczMDhm
N2I2YjIyYy4uOGJjZTY0MDY5MTM4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpDQo+IEBAIC05OCw3ICs5OCw3IEBAIHVhcnQwOiBzZXJp
YWxAMTIwMDAgew0KPiAgIA0KPiAgIAkJCXVhcnQxOiBzZXJpYWxAMTIxMDAgew0KPiAgIAkJCQlj
b21wYXRpYmxlID0gInNucHMsZHctYXBiLXVhcnQiOw0KPiAtCQkJCXJlZyA9IDwweDExMDAwIDB4
MTAwPjsNCj4gKwkJCQlyZWcgPSA8MHgxMjEwMCAweDEwMD47DQo+ICAgCQkJCXJlZy1zaGlmdCA9
IDwyPjsNCj4gICAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg0IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiAgIAkJCQlyZWctaW8td2lkdGggPSA8MT47
