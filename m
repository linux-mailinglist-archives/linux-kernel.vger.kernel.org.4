Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3A718E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEaWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:36:33 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA189F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:36:31 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F134C2C0274;
        Thu,  1 Jun 2023 10:36:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685572587;
        bh=K6Qn8QeOKSoZHZZ0pj4vqr+48A5yvnzbjMWWua+foqI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JNSd5zz7GjQWD6N8teZuZB0wWvPzDRoabXUWRQe7nUTyXgUR/nwSTl7dpBY+hdsRi
         IWrzERyZ5M/OAhTD/Fav1RvCIbH3Df6smoQGexvYDVzxnM0vJoaG4z0hHmnKy6TYcn
         O2tXpTO0HxbDEGmF9FA6PxdDuKAn34gd9SlyAxc9Vph78sGKJFCyRAniOrmH6OfcPt
         S/vmmXUjeS0A+VlXg91YeNzLfHQ6rKFilXiVxyT1izglrw2eq+QoTkzFMBdj2xroIi
         IGgnwW3rq5sjf4S+F25loBb3CS7ogMylCjnLgXLTFvnsWRmz/VLD5NwaVj7UZ3EQsf
         2TOenYHyhMb0g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477cbeb0001>; Thu, 01 Jun 2023 10:36:27 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 10:36:27 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 1 Jun 2023 10:36:27 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>
Subject: Re: [PATCH v7 4/4] dt-bindings: mtd: marvell-nand: Remove deprecated
 compatibles
Thread-Topic: [PATCH v7 4/4] dt-bindings: mtd: marvell-nand: Remove deprecated
 compatibles
Thread-Index: AQHZk1Io0TYCpzAakEW/VeOAcipdYq9zNJAAgAD8TYA=
Date:   Wed, 31 May 2023 22:36:27 +0000
Message-ID: <a84403a0-334e-c0e8-4a1b-bedac69e816d@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
 <20230530235456.1009082-5-chris.packham@alliedtelesis.co.nz>
 <20230531093326.26b6ced7@xps-13>
In-Reply-To: <20230531093326.26b6ced7@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E40439F4111574EB437CE288F8410B1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Score: -1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMS8wNS8yMyAxOTozMywgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gSGkgQ2hyaXMsDQo+
DQo+IGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5ueiB3cm90ZSBvbiBXZWQsIDMxIE1h
eSAyMDIzIDExOjU0OjU2DQo+ICsxMjAwOg0KPg0KPj4gUmVtb3ZlIGNvbXBhdGlibGUgdmFsdWVz
IHRoYXQgd2VyZSBtYXJrZWQgYXMgZGVwcmVjYXRlZCBpbiB0aGUgb2xkIHRleHQNCj4+IGJpbmRp
bmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBh
bGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L210ZC9tYXJ2ZWxsLG5hbmQtY29udHJvbGxlci55YW1sICAgICAgIHwgMyAtLS0NCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNvbnRyb2xsZXIueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNv
bnRyb2xsZXIueWFtbA0KPj4gaW5kZXggN2NkNGEyZTk5MzQzLi44MGNlODU0MjkxY2IgMTAwNjQ0
DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGws
bmFuZC1jb250cm9sbGVyLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gQEAgLTE4LDkgKzE4
LDYgQEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgLSBlbnVtOg0KPj4gICAgICAgICAgICAgLSBt
YXJ2ZWxsLGFybWFkYTM3MC1uYW5kLWNvbnRyb2xsZXINCj4+ICAgICAgICAgICAgIC0gbWFydmVs
bCxweGEzeHgtbmFuZC1jb250cm9sbGVyDQo+PiAtICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEt
OGstbmFuZA0KPj4gLSAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQNCj4+IC0gICAg
ICAgICAgLSBtYXJ2ZWxsLHB4YTN4eC1uYW5kDQo+IE5vdCBzdXJlIHdoYXQgeW91J3JlIGRvaW5n
IGhlcmU/DQpUaGF0J3MgbWUgYmVpbmcgaW4gYW4gYXdrd2FyZCB0aW1lem9uZSBhbmQgZ3Vlc3Np
bmcgKGJhZGx5KS4gSSB0aGluayANCkkndmUgZ290IHRoZSBkZXByZWNhdGVkIGNvbXBhdGlibGVz
IHNvcnRlZCBub3cgc28gSSdsbCBkcm9wIHRoaXMgZnJvbSB2OC4NCj4gICBJIHdvdWxkIGFjdHVh
bGx5IGV4cGVjdCB0aGVzZSB0aHJlZQ0KPiBsaW5lcyB0byBoYXZlIHNvbWV0aGluZyBhbG9uZzoN
Cj4NCj4gICAgICAgICAgICAgICAgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPg0KPiBhbmQgdGhpcyBz
aG91bGQgYmUgcGFydCBvZiB0aGUgY29udmVyc2lvbiB0byB5YW1sLiBPciBwZXJoYXBzIEkgYW0N
Cj4gbWlzc2luZyBzb21ldGhpbmc/DQo+DQo+IFRoZSByZXN0IG9mIHRoZSBzZXJpZXMgbG9va3Mg
Z29vZCB0byBtZS4NCj4NCj4+ICAgDQo+PiAgICAgcmVnOg0KPj4gICAgICAgbWF4SXRlbXM6IDEN
Cj4NCj4gVGhhbmtzLA0KPiBNaXF1w6hs
