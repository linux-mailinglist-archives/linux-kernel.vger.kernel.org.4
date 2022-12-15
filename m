Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9A64DD51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLOPJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:09:10 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5983E303E3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1671116945; x=1673708945;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kFOqwniGjxa3Q6hZgzgttYJdF6JENtUv0c65sBnKk3I=;
        b=coa57Vg3nuOHXUEYmD4RgQwmNrcwqXzD2nQeDl/7aCu7LLKdbYikRrTjPQLLjGW/
        4Vnv9V6+te+N1kSjK72P1ur1E7AGe5jlZet/Dal5F7TvLDweBkYcd7yrNAwbbePx
        L8AkEslsHJjCYVtyvSFFzHU0or6+kueDaiTPBHmO+rk=;
X-AuditID: ac14000a-83bf370000003940-38-639b38917ae4
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 93.7C.14656.1983B936; Thu, 15 Dec 2022 16:09:05 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 15 Dec
 2022 16:09:05 +0100
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Thu, 15 Dec 2022 16:09:05 +0100
From:   Wadim Egorov <W.Egorov@phytec.de>
To:     Jerome Neanne <jneanne@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>
CC:     "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Thread-Topic: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Thread-Index: AQHY8GHP4sH8k9jEvEicIzv1bzoxDa5vPM8A
Date:   Thu, 15 Dec 2022 15:09:04 +0000
Message-ID: <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
In-Reply-To: <20221104152311.1098603-2-jneanne@baylibre.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <80A18248D03D574989598CCF0D03CBAD@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGPd/dweJzLjwaJQ0qupglGm8Z0gXqwwj8Iwi6qEM/dGkm0yIj
        tMyumrlVQputrKGkZrrCW5a1rLScSppZLdvUZEai3VZZZm4r8r/n/J7nOe974HCk7DkdwKlS
        0kV1ijJZwUioCn8vaZAG9HHLSvLkMPpEw8KE9hELhjonAeftgwyMluQhuNTcToOm4wcDD644
        EFzUaxE8qc0moO11MQGFtiEEP47fIqD0s56FfIedhLpjxRQ4u08QYBrooeHlJycNXQ1FDOiN
        Zyg4PFBGQI62nwFz/nb48N1CwNE7zSw4bvlBU3ckTFrGWKi3tpCQYw1bEyhUGCqQ8HNciwTn
        Vy0ljPYeZYVrDj0raCxBQr3uDSuYyk4yQun9QkKw9jQywk1jlvC4t5YQTO8F4bNpTtSMbZLV
        8WKyap+oDo6IlSRm943Rqf1h+zsnDdQhVBV6CnlzmA/FV0bayVNIwsn4qwTub7UxLkPG2xDW
        j0d5jGqEnV19tMtg+AVYM9FCuww5/4rFjzuHWdeB5C9T+HTTmDvly+/C2dXlhEvL+ST862M5
        6dEhuL3b6OYUPw/fvl7g1lJ+Ne6xT1Ce0bvxpSM17rz3FDc3G5BLI342rqrqcHOS98OmoW+0
        5w08NjZ6OOZn4uGB3395IG55VTh1PzeVX4hvNAR7qoAr7z2jPHouPpdrZz0r+ODWC4NUAfLT
        TZug+9/WTWvrprV109qXEV2GZLtVcUmiWpW0NDUxI12MWxovmpDr68m9JHUov0gwI4JDZoQ5
        UiGXRr3Txcmk8cqMA6J6T4x6b7KYZkazOErhJ32bRyhlfIIyXUwSxVRR/c8lOO+AQ2jbZMLN
        aH9L7fjPD++fXn2a5WN2WIc2rYyMiN0Aw74HG1aMbMkc3boubUdde3b4yzvGTrtBFVzulRnU
        ZO0zJliyFhT6V76IiLGFBBRtjj9Yqdg4Nv+sP+Njw1s+vlmvUy3ZWf+tiL5fk7nW9MV7VUZK
        bnhrm6QtOmRxX5bz7sPYrkwFlZaoXL6IVKcp/wBqH42PaAMAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVyb21lLA0KDQppcyB0aGlzIHNldHVwIHdvcmtpbmcgZm9yIHlvdSBvbiB0aGUgQU02NDIg
U0sgYm9hcmQ/DQoNCkkgYW0gdGVzdGluZyB5b3VyIFBNSUMgcGF0Y2hlcyBvbiBhIEFNNjIgYmFz
ZWQgYm9hcmQgd2l0aCBhIHNpbWlsYXIgc2V0dXAgYW5kDQpydW5uaW5nIGludG8gdGhlIGZvbGxv
d2luZyBlcnJvcg0KDQogwqDCoCBWRERTSFY1X1NESU86IGJ5cGFzc2VkIHJlZ3VsYXRvciBoYXMg
bm8gc3VwcGx5IQ0KIMKgwqAgVkREU0hWNV9TRElPOiB3aWxsIHJlc29sdmUgc3VwcGx5IGVhcmx5
OiBsZG8xDQogwqDCoCBWRERTSFY1X1NESU86IHN1cHBsaWVkIGJ5IHJlZ3VsYXRvci1kdW1teQ0K
IMKgwqAgVkREU0hWNV9TRElPOiBmYWlsZWQgdG8gZ2V0IHRoZSBjdXJyZW50IHZvbHRhZ2U6IC1F
SU5WQUwNCg0KSGF2ZSB5b3Ugbm90aWNlZCBwcm9ibGVtcyB3aXRoIExETzEgYW5kIGJ5cGFzcyBt
b2RlPw0KDQpSZWdhcmRzLA0KV2FkaW0NCg0KQW0gMDQuMTEuMjIgdW0gMTY6MjMgc2NocmllYiBK
ZXJvbWUgTmVhbm5lOg0KPiBGcm9tOiBKZXJvbWUgTkVBTk5FIDxqbmVhbm5lQGJheWxpYnJlLmNv
bT4NCj4NCj4gQWRkIHN1cHBvcnQgZm90IHRoZSBUSSBQb3dlciBNYW5hZ2VtZW50IElDIFRQUzY1
MjE5DQo+IG9uIHRoZSBBTTY0MiBTS0VWTSBib2FyZC4NCj4NCj4gTmVlZGVkIGZvciBkcml2ZXIg
dGVzdGluZyBidXQgb2ZmaWNpYWwgYm9hcmQgc3VwcG9ydCBwZW5kaW5nLg0KPiBUSSBjb21taXRt
ZW50IGlzIHJlcXVpcmVkIGJlZm9yZSBib2FyZCB1cHN0cmVhbSBraWNrLW9mZi4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSmVyb21lIE5FQU5ORSA8am5lYW5uZUBiYXlsaWJyZS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gPG1zcEBiYXlsaWJyZS5jb20+DQo+
IC0tLQ0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItc2suZHRzIHwgMTA0ICsr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTA0IGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDIt
c2suZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zay5kdHMNCj4gaW5kZXgg
NzM4ZDBjZjZjNDBhLi5kMDEyMTk3NjQ5MWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvazMtYW02NDItc2suZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkv
azMtYW02NDItc2suZHRzDQo+IEBAIC0yMTksNiArMjE5LDIwIEBAIGxlZC03IHsNCj4gICAJCQln
cGlvcyA9IDwmZXhwMiA3IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAgIAkJfTsNCj4gICAJfTsNCj4g
Kw0KPiArCXZzZWxfc2RfbmRkcjogZ3Bpby1yZWd1bGF0b3Igew0KPiArCQljb21wYXRpYmxlID0g
InJlZ3VsYXRvci1ncGlvIjsNCj4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwkJ
cGluY3RybC0wID0gPCZ2c2VsX3NkX25kZHJfcGluc19kZWZhdWx0PjsNCj4gKwkJcmVndWxhdG9y
LW5hbWUgPSAidHBzNjUyMTktTERPMS1TRUwtU0QiOw0KPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwxODAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAw
MD47DQo+ICsJCXJlZ3VsYXRvci1ib290LW9uOw0KPiArCQl2aW4tc3VwcGx5ID0gPCZsZG8xX3Jl
Zz47DQo+ICsJCWdwaW9zID0gPCZtYWluX2dwaW8wIDQ1IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAr
CQlzdGF0ZXMgPSA8MTgwMDAwMCAweDA+LA0KPiArCQkJIDwzMzAwMDAwIDB4MT47DQo+ICsJfTsN
Cj4gICB9Ow0KPiAgIA0KPiAgICZtYWluX3BteDAgew0KPiBAQCAtMjUwLDYgKzI2NCwxMyBAQCBB
TTY0WF9JT1BBRCgweDAyYTgsIFBJTl9PVVRQVVQsIDApIC8qIChFMTkpIFVTQjBfRFJWVkJVUyAq
Lw0KPiAgIAkJPjsNCj4gICAJfTsNCj4gICANCj4gKwltYWluX2kyYzBfcGluc19kZWZhdWx0OiBt
YWluLWkyYzAtcGlucy1kZWZhdWx0IHsNCj4gKwkJcGluY3RybC1zaW5nbGUscGlucyA9IDwNCj4g
KwkJCUFNNjRYX0lPUEFEKDB4MDI2MCwgUElOX0lOUFVUX1BVTExVUCwgMCkgLyogKEExOCkgSTJD
MF9TQ0wgKi8NCj4gKwkJCUFNNjRYX0lPUEFEKDB4MDI2NCwgUElOX0lOUFVUX1BVTExVUCwgMCkg
LyogKEIxOCkgSTJDMF9TREEgKi8NCj4gKwkJPjsNCj4gKwl9Ow0KPiArDQo+ICAgCW1haW5faTJj
MV9waW5zX2RlZmF1bHQ6IG1haW4taTJjMS1waW5zLWRlZmF1bHQgew0KPiAgIAkJcGluY3RybC1z
aW5nbGUscGlucyA9IDwNCj4gICAJCQlBTTY0WF9JT1BBRCgweDAyNjgsIFBJTl9JTlBVVF9QVUxM
VVAsIDApIC8qIChDMTgpIEkyQzFfU0NMICovDQo+IEBAIC0zMzYsNiArMzU3LDEyIEBAIG1haW5f
d2xhbl9waW5zX2RlZmF1bHQ6IG1haW4td2xhbi1waW5zLWRlZmF1bHQgew0KPiAgIAkJCUFNNjRY
X0lPUEFEKDB4MDBiYywgUElOX0lOUFVULCA3KSAvKiAoVTgpIEdQSU8wXzQ2ICovDQo+ICAgCQk+
Ow0KPiAgIAl9Ow0KPiArDQo+ICsJdnNlbF9zZF9uZGRyX3BpbnNfZGVmYXVsdDogdnNlbC1zZC1u
ZGRyLXBpbnMtZGVmYXVsdCB7DQo+ICsJCXBpbmN0cmwtc2luZ2xlLHBpbnMgPSA8DQo+ICsJCQlB
TTY0WF9JT1BBRCgweDAwYjgsIFBJTl9JTlBVVCwgNykgLyogKFk3KSBQUkcxX1BSVTBfR1BPMC5H
UElPMF80NSAqLw0KPiArCQk+Ow0KPiArCX07DQo+ICAgfTsNCj4gICANCj4gICAmbWN1X3VhcnQw
IHsNCj4gQEAgLTM4NCw2ICs0MTEsODMgQEAgJm1jdV9pMmMxIHsNCj4gICAJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4gICB9Ow0KPiAgIA0KPiArJm1haW5faTJjMCB7DQo+ICsJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8Jm1haW5faTJjMF9waW5zX2RlZmF1bHQ+
Ow0KPiArCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsN
Cj4gKw0KPiArCXRwczY1MjE5OiBwbWljQDMwIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJ0aSx0cHM2
NTIxOSI7DQo+ICsJCXJlZyA9IDwweDMwPjsNCj4gKwkJc3lzdGVtLXBvd2VyLWNvbnRyb2xsZXI7
DQo+ICsNCj4gKwkJYnVjazEtc3VwcGx5ID0gPCZ2Y2NfM3YzX3N5cz47DQo+ICsJCWJ1Y2syLXN1
cHBseSA9IDwmdmNjXzN2M19zeXM+Ow0KPiArCQlidWNrMy1zdXBwbHkgPSA8JnZjY18zdjNfc3lz
PjsNCj4gKwkJbGRvMS1zdXBwbHkgPSA8JnZjY18zdjNfc3lzPjsNCj4gKwkJbGRvMi1zdXBwbHkg
PSA8JmJ1Y2syX3JlZz47DQo+ICsJCWxkbzMtc3VwcGx5ID0gPCZ2Y2NfM3YzX3N5cz47DQo+ICsJ
CWxkbzQtc3VwcGx5ID0gPCZ2Y2NfM3YzX3N5cz47DQo+ICsNCj4gKwkJcmVndWxhdG9ycyB7DQo+
ICsJCQlidWNrMV9yZWc6IGJ1Y2sxIHsNCj4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJWRERfQ09S
RSI7DQo+ICsJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NzUwMDAwPjsNCj4gKwkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCj4gKwkJCQlyZWd1bGF0b3ItYm9v
dC1vbjsNCj4gKwkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiArCQkJfTsNCj4gKw0KPiArCQkJ
YnVjazJfcmVnOiBidWNrMiB7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiVkNDMVY4IjsNCj4g
KwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gKwkJCQlyZWd1bGF0
b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gKwkJCQlyZWd1bGF0b3ItYm9vdC1vbjsN
Cj4gKwkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiArCQkJfTsNCj4gKw0KPiArCQkJYnVjazNf
cmVnOiBidWNrMyB7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiVkREX0xQRERSNCI7DQo+ICsJ
CQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTEwMDAwMD47DQo+ICsJCQkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MTEwMDAwMD47DQo+ICsJCQkJcmVndWxhdG9yLWJvb3Qtb247DQo+
ICsJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gKwkJCX07DQo+ICsNCj4gKwkJCWxkbzFfcmVn
OiBsZG8xIHsNCj4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJWRERTSFZfU0RfSU9fUE1JQyI7DQo+
ICsJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTAwMDAwMD47DQo+ICsJCQkJcmVndWxh
dG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ICsJCQkJcmVndWxhdG9yLWFsbG93LWJ5
cGFzczsNCj4gKwkJCX07DQo+ICsNCj4gKwkJCWxkbzJfcmVnOiBsZG8yIHsNCj4gKwkJCQlyZWd1
bGF0b3ItbmFtZSA9ICJWRERBUl9DT1JFIjsNCj4gKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDw4NTAwMDA+Ow0KPiArCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDg1MDAwMD47
DQo+ICsJCQkJcmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsN
Cj4gKwkJCX07DQo+ICsNCj4gKwkJCWxkbzNfcmVnOiBsZG8zIHsNCj4gKwkJCQlyZWd1bGF0b3It
bmFtZSA9ICJWRERBXzFWOCI7DQo+ICsJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgw
MDAwMD47DQo+ICsJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQo+ICsJ
CQkJcmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gKwkJ
CX07DQo+ICsNCj4gKwkJCWxkbzRfcmVnOiBsZG80IHsNCj4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9
ICJWRERfUEhZXzJWNSI7DQo+ICsJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MjUwMDAw
MD47DQo+ICsJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MjUwMDAwMD47DQo+ICsJCQkJ
cmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gKwkJCX07
DQo+ICsJCX07DQo+ICsJfTsNCj4gK307DQo+ICAgJm1haW5faTJjMSB7DQo+ICAgCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgCXBpbmN0cmwtMCA9IDwmbWFpbl9pMmMxX3BpbnNfZGVm
YXVsdD47DQoNCg0K
