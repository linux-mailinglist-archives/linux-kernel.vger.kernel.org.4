Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D5716F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjE3U71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjE3U7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:59:25 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00C106
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:59:22 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 052302C04E1;
        Wed, 31 May 2023 08:59:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685480360;
        bh=PBjB3x4Da7R7TpfstPuHs+sIxaQk8nENaOGkEpE5qtQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=pOzNHpaz1NG0hXZBt0V94hy2P9aj14wKaqHp509UwOd1nNBzemAHrK6pHcoWGh218
         p+05TD5BLxtu3Z2/QVK7Uhv56ROPJ4yusOEUTKdDz/UCKGczdS1kEMs86ZA0Hu+FUN
         wu/jujAmHbTvFn15P5Z7bymwu6n3ICf5ky3L+IWDllkqVjQaELhWt6uOSMjnZevWAg
         CGn/k1fhhYqVx1PBKKP5d4gwK62nbyJoLfBm4sAsLTbRgsVb6ckp4HmBpibFK7PLqO
         Mq3FZ9QhxiI9ZRLj19YYC7FWJgMyv1Gy4Dvt+3dn19AuJcyQQ24s5exW+LSSGA8WiS
         gbxXT6EBSZfWw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647663a70001>; Wed, 31 May 2023 08:59:19 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 08:59:19 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 31 May 2023 08:59:19 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZkpEvY3k2XQch4kKrVAHkTx0+pa9x9ZmAgACPToA=
Date:   Tue, 30 May 2023 20:59:19 +0000
Message-ID: <c030b2c5-2f44-72c7-f06f-9fa7b9247992@alliedtelesis.co.nz>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
 <20230530122625.7zu3ey5dnn6izeli@krzk-bin>
In-Reply-To: <20230530122625.7zu3ey5dnn6izeli@krzk-bin>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E9CA2666FDA994A94BC77746B7458E3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=g8kJ_gb0AAAA:8 a=62ntRvTiAAAA:8 a=voM4FWlXAAAA:8 a=bzQKzZmY9NnqJuOzxnoA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22 a=pToNdpNmrtiFLRE6bQ9Z:22 a=IC2XNlieTeVoXbcui8wp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMS8wNS8yMyAwMDoyNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gVHVl
LCAzMCBNYXkgMjAyMyAxMjo1MzozNiArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEZy
b206IFZhZHltIEtvY2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4NCj4+IFN3aXRj
aCB0aGUgRFQgYmluZGluZyB0byBhIFlBTUwgc2NoZW1hIHRvIGVuYWJsZSB0aGUgRFQgdmFsaWRh
dGlvbi4NCj4+DQo+PiBEcm9wcGVkIGRlcHJlY2F0ZWQgY29tcGF0aWJsZXMgYW5kIHByb3BlcnRp
ZXMgZGVzY3JpYmVkIGluIHR4dCBmaWxlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZhZHltIEtv
Y2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMg
UGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+Pg0K
Pj4gTm90ZXM6DQo+PiAgICAgIENoYW5nZXMgaW4gdjY6DQo+PiAgICAgIC0gcmVtb3ZlIHByb3Bl
cnRpZXMgY292ZXJlZCBieSBuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gICAgICAtIGFkZCBleGFt
cGxlIHVzaW5nIGFybWFkYS04ayBjb21wYXRpYmxlDQo+Pg0KPj4gICAgICBlYXJsaWVyIGNoYW5n
ZXM6DQo+Pg0KPj4gICAgICB2NToNCj4+ICAgICAgICAgMSkgR2V0IGJhY2sgImxhYmVsIiBhbmQg
InBhcnRpdGlvbnMiIHByb3BlcnRpZXMgYnV0IHdpdGhvdXQNCj4+ICAgICAgICAgICAgcmVmIHRv
IHRoZSAicGFydGl0aW9uLnlhbWwiIHdoaWNoIHdhcyB3cm9uZ2x5IHVzZWQuDQo+Pg0KPj4gICAg
ICAgICAyKSBBZGQgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSIgZm9yIG5hbmRAIGJlY2F1
c2UgYWxsIHBvc3NpYmxlDQo+PiAgICAgICAgICAgIHByb3BlcnRpZXMgYXJlIGRlc2NyaWJlZC4N
Cj4+DQo+PiAgICAgIHY0Og0KPj4gICAgICAgICAxKSBSZW1vdmUgImxhYmVsIiBhbmQgInBhcnRp
dGlvbnMiIHByb3BlcnRpZXMNCj4+DQo+PiAgICAgICAgIDIpIFVzZSAyIGNsb2NrcyBmb3IgQTdL
LzhLIHBsYXRmb3JtIHdoaWNoIGlzIGEgcmVxdWlyZW1lbnQNCj4+DQo+PiAgICAgIHYzOg0KPj4g
ICAgICAgIDEpIFJlbW92ZSB0eHQgdmVyc2lvbiBmcm9tIHRoZSBNQUlOVEFJTkVSUyBsaXN0DQo+
Pg0KPj4gICAgICAgIDIpIFVzZSBlbnVtIGZvciBzb21lIG9mIGNvbXBhdGlibGUgc3RyaW5ncw0K
Pj4NCj4+ICAgICAgICAzKSBEcm9wOg0KPj4gICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzDQo+
PiAgICAgICAgICAgICAgI3NpemUtY2VsbHM6DQo+Pg0KPj4gICAgICAgICAgIGFzIHRoZXkgYXJl
IGluaGVyaXRlZCBmcm9tIHRoZSBuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4NCj4+ICAgICAgICA0
KSBBZGQgcmVzdHJpY3Rpb24gdG8gdXNlIDIgY2xvY2tzIGZvciBBOEsgU29DDQo+Pg0KPj4gICAg
ICAgIDUpIERyb3BwZWQgZGVzY3JpcHRpb24gZm9yIGNsb2NrLW5hbWVzIGFuZCBleHRlbmQgaXQg
d2l0aA0KPj4gICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+Pg0KPj4gICAgICAgIDYpIERyb3AgZGVz
Y3JpcHRpb24gZm9yICJkbWFzIg0KPj4NCj4+ICAgICAgICA3KSBVc2UgInVuZXZhbGF1dGVkUHJv
cGVydGllczogZmFsc2UiDQo+Pg0KPj4gICAgICAgIDgpIERyb3AgcXVpdGVzIGZyb20geWFtbCBy
ZWZzLg0KPj4NCj4+ICAgICAgICA5KSBVc2UgNC1zcGFjZSBpbmRlbnRhdGlvbiBmb3IgdGhlIGV4
YW1wbGUgc2VjdGlvbg0KPj4NCj4+ICAgICAgdjI6DQo+PiAgICAgICAgMSkgRml4ZWQgd2Fybmlu
ZyBieSB5YW1sbGludCB3aXRoIGluY29ycmVjdCBpbmRlbnRhdGlvbiBmb3IgY29tcGF0aWJsZSBs
aXN0DQo+Pg0KPj4gICAuLi4vYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlh
bWwgfCAxOTAgKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L210ZC9tYXJ2ZWxsLW5hbmQudHh0ICB8IDEyNiAtLS0tLS0tLS0tLS0NCj4+ICAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxOTAgaW5zZXJ0aW9ucygrKSwgMTI3IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2
ZWxsLG5hbmQtY29udHJvbGxlci55YW1sDQo+PiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGwtbmFuZC50eHQNCj4+DQo+IFJ1
bm5pbmcgJ21ha2UgZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1hIGluIHRoaXMgcGF0Y2ggZ2l2
ZXMgdGhlDQo+IGZvbGxvd2luZyB3YXJuaW5ncy4gQ29uc2lkZXIgaWYgdGhleSBhcmUgZXhwZWN0
ZWQgb3IgdGhlIHNjaGVtYSBpcw0KPiBpbmNvcnJlY3QuIFRoZXNlIG1heSBub3QgYmUgbmV3IHdh
cm5pbmdzLg0KPg0KPiBOb3RlIHRoYXQgaXQgaXMgbm90IHlldCBhIHJlcXVpcmVtZW50IHRvIGhh
dmUgMCB3YXJuaW5ncyBmb3IgZHRic19jaGVjay4NCj4gVGhpcyB3aWxsIGNoYW5nZSBpbiB0aGUg
ZnV0dXJlLg0KPg0KPiBGdWxsIGxvZyBpcyBhdmFpbGFibGUgaGVyZTogaHR0cHM6Ly9zY2FubWFp
bC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9LXV2MTVEUTR5TjFxT3VaTGNvMWpXcVk3bzhjQmsx
RVF1VHB3UGNqNGxBJnU9aHR0cHMlM2ElMmYlMmZwYXRjaHdvcmslMmVvemxhYnMlMmVvcmclMmZw
YXRjaCUyZjE3ODcyNDgNCl5eXiBhcG9sb2dpZXMgZm9yIHRoaXMsIGl0J3MgaXJvbmljIHRoYXQg
YSBzZWN1cml0eSBmZWF0dXJlIG9uIG91ciBlbWFpbCANCmdhdGV3YXkgbWFrZXMgbGlua3MgbG9v
ayBfbW9yZV8gbGlrZSBtYWxpY2lvdXMgVVJMcy4NCj4gbmFuZEA3MjAwMDA6ICRub2RlbmFtZTow
OiAnbmFuZEA3MjAwMDAnIGRvZXMgbm90IG1hdGNoICdebmFuZC1jb250cm9sbGVyKEAuKik/Jw0K
PiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS03MDQwLWRiLmR0Yg0KPiAJYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS03MDQwLW1vY2hhYmluLmR0Yg0KPiAJYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0Yg0K
PiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThr
LmR0Yg0KPiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWRiLmR0Yg0K
PiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWRiLmR0Yg0KPiAJYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0Yg0KPiAJYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0Yg0KPiAJYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLXNpbmdsZXNob3QuZHRiDQo+IAlh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtbWNiaW4tc2luZ2xlc2hvdC5k
dGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1wdXp6bGUtbTgw
MS5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1wdXp6bGUt
bTgwMS5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY3JiLUEuZHRi
DQo+IAlhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMwLWNyYi1CLmR0Yg0KPiAJYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1kYi1CLmR0Yg0KPiAJYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1kYi5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9jbjkxMzEtZGItQi5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkx
MzEtZGItQi5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzEtZGIuZHRi
DQo+IAlhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMxLWRiLmR0Yg0KPiAJYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMi1kYi1CLmR0Yg0KPiAJYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2NuOTEzMi1kYi1CLmR0Yg0KPiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2NuOTEzMi1kYi1CLmR0Yg0KPiAJYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEz
Mi1kYi5kdGINCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzItZGIuZHRiDQo+
IAlhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMyLWRiLmR0Yg0KVGhpcyBpcyByZXNv
bHZlZCBpbiBwYXRjaCAyLzIuIEkgY2FuIHN3YXAgdGhlIG9yZGVyIGluIHRoZSBzZXJpZXMgaWYg
aXQgDQpoZWxwcy4NCj4gbmFuZEA3MjAwMDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5v
dCBhbGxvd2VkICgnI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIHdlcmUgdW5leHBlY3Rl
ZCkNCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtZGItQi5kdGINCj4gCWFy
Y2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzEtZGItQi5kdGINCj4gCWFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWFydmVsbC9jbjkxMzItZGItQi5kdGINCkkgZG9uJ3Qgc2VlIHRoZXNlIHdoZW4g
SSBydW4gZHRic19jaGVjaw0KPiBuYW5kLWNvbnRyb2xsZXJANDMxMDAwMDA6IGNsb2NrLW5hbWVz
OiBbJ2NvcmUnXSBpcyB0b28gc2hvcnQNCj4gCWFyY2gvYXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVt
ZmVsZC1jb25uZWN0b3IuZHRiDQo+IAlhcmNoL2FybS9ib290L2R0cy9weGEzMDAtcmF1bWZlbGQt
Y29udHJvbGxlci5kdGINCj4gCWFyY2gvYXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVtZmVsZC1zcGVh
a2VyLWwuZHRiDQo+IAlhcmNoL2FybS9ib290L2R0cy9weGEzMDAtcmF1bWZlbGQtc3BlYWtlci1t
LmR0Yg0KPiAJYXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLXNwZWFrZXItb25lLmR0
Yg0KPiAJYXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLXNwZWFrZXItcy5kdGINCj4N
Cj4gbmFuZC1jb250cm9sbGVyQDQzMTAwMDAwOiBkbWEtbmFtZXM6MDogJ3J4dHgnIHdhcyBleHBl
Y3RlZA0KPiAJYXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLWNvbm5lY3Rvci5kdGIN
Cj4gCWFyY2gvYXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVtZmVsZC1jb250cm9sbGVyLmR0Yg0KPiAJ
YXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLXNwZWFrZXItbC5kdGINCj4gCWFyY2gv
YXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVtZmVsZC1zcGVha2VyLW0uZHRiDQo+IAlhcmNoL2FybS9i
b290L2R0cy9weGEzMDAtcmF1bWZlbGQtc3BlYWtlci1vbmUuZHRiDQo+IAlhcmNoL2FybS9ib290
L2R0cy9weGEzMDAtcmF1bWZlbGQtc3BlYWtlci1zLmR0Yg0KPg0KPiBuYW5kLWNvbnRyb2xsZXJA
NDMxMDAwMDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnZG1hLW5h
bWVzJyB3YXMgdW5leHBlY3RlZCkNCj4gCWFyY2gvYXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVtZmVs
ZC1jb25uZWN0b3IuZHRiDQo+IAlhcmNoL2FybS9ib290L2R0cy9weGEzMDAtcmF1bWZlbGQtY29u
dHJvbGxlci5kdGINCj4gCWFyY2gvYXJtL2Jvb3QvZHRzL3B4YTMwMC1yYXVtZmVsZC1zcGVha2Vy
LWwuZHRiDQo+IAlhcmNoL2FybS9ib290L2R0cy9weGEzMDAtcmF1bWZlbGQtc3BlYWtlci1tLmR0
Yg0KPiAJYXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLXNwZWFrZXItb25lLmR0Yg0K
PiAJYXJjaC9hcm0vYm9vdC9kdHMvcHhhMzAwLXJhdW1mZWxkLXNwZWFrZXItcy5kdGINCg0KSSd2
ZSBiZWVuIHJ1bm5pbmcgYG1ha2UgQVJDSD1hcm02NCBkdGJzX2NoZWNrIA0KRFRfU0NIRU1BX0ZJ
TEVTPW1hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlhbWxgIChhbmQgc2ltaWxhciBmb3IgYXJtKSBi
dXQgDQpkaWRuJ3Qgc2VlIHRoZXNlIGFtIEkgZG9pbmcgc29tZXRoaW5nIHdyb25nIG9yIGRpZCBJ
IGp1c3QgZmFpbCB0byBsb29rIA0KcHJvcGVybHkuDQoNCj4gbmFuZC1jb250cm9sbGVyQGQwMDAw
OiBuYW5kQDA6cGFydGl0aW9uczogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93
ZWQgKCdwYXJ0aXRpb25AZXJybG9nJywgJ3BhcnRpdGlvbkBuYW5kLWJidCcsICdwYXJ0aXRpb25A
dXNlcicgd2VyZSB1bmV4cGVjdGVkKQ0KPiAJYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4NS1h
dGwteDUzMC5kdGINCj4NCj4gbmFuZC1jb250cm9sbGVyQGQwMDAwOiBVbmV2YWx1YXRlZCBwcm9w
ZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJyNhZGRyZXNzLWNlbGxzJywgJyNzaXplLWNlbGxzJyB3
ZXJlIHVuZXhwZWN0ZWQpDQo+IAlhcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzg1LWF0bC14NTMw
LmR0Yg==
