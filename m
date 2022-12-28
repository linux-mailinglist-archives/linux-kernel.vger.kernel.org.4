Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA2657539
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiL1KQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiL1KQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:16:33 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1D120
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1672222588; x=1674814588;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oVJnYDbF2ktfkp8XSbH6Wj64VWVTuGh5A3DbFRH21Xg=;
        b=kBfry2KtVaplH9pn2UX9jrd6GM5n5b7LKjPeOksZ5cUdjOrtW1k8lWcgIBfNcl7C
        gAL7WFuk2RpXZq2uTBSFYKR7suZEx8jtJKfjofq1QDUrQSyG9f8Jufjg6xY0T4yN
        +RK8CFBoEWcl92jAJC4ZSVDvrCcYMljge+dzwlekntA=;
X-AuditID: ac14000a-917fe70000007ecb-bf-63ac177cd8dc
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 87.C4.32459.C771CA36; Wed, 28 Dec 2022 11:16:28 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 28 Dec
 2022 11:16:27 +0100
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Wed, 28 Dec 2022 11:16:27 +0100
From:   Wadim Egorov <W.Egorov@phytec.de>
To:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     jerome Neanne <jneanne@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "jeff@labundy.com" <jeff@labundy.com>, "afd@ti.com" <afd@ti.com>,
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
Thread-Index: AQHY8GHP4sH8k9jEvEicIzv1bzoxDa5vPM8AgAAL5wCAAAUUAIAAHSeAgAAH4YCAADe5gIABDDwAgBKiloA=
Date:   Wed, 28 Dec 2022 10:16:27 +0000
Message-ID: <c2a0f9fb-3b54-0a3f-2bfa-9575a9ae937f@phytec.de>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk> <20221215175411.znxy3d6ussq2iq5h@grieving>
 <Y5tl3+2pJispcXy6@sirena.org.uk> <20221215214149.whcjdphxxvvedrih@affront>
 <Y5x1oAzezZGqyZSx@sirena.org.uk>
In-Reply-To: <Y5x1oAzezZGqyZSx@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5CFE471CAD70F4EABAD6E65C4662516@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH+/4e7ve7I/t24r7VMG2mTHkY22fWPP31G/8UY4ZNp35zp6Rd
        MVkbUtGVuJPMXUW0os5DP1kPDnVSuenBJCEqNaJyPaxS5OE6pv9e3/fn/dr3892+PK1sZr15
        bVSsqItSR/rKFIzFy21mQLzKErY8p0YODruBg0ljDQc5ZaMUXOjsloEjPw3B5eoGFgyN4zJ4
        fLUHQbbZiMBemkDBs7e5FGR2fEQwfqqEgoJhMwfpPZ00lCXnMjDafJoCqauFhddDoyy8qMiS
        gTnvLAMnugopSDR+kIEtfRf0faunIOlBNQc9JSp41LwJftUPcFDeVkdDYtvq9QsES44FCd8n
        jEgYHTEygqM1iRNu9Jg5wVAfIJSb3nGCVJgiEwqqMimhrcUqE+7mHRNqW0spQfoiCMPS/OBZ
        OxVB4WKk9rCoW7Y2VKGpSXGg6A6PI4a6J+xxlOehR3Ke4FVkUn+e0yMFr8TXKNLXYWRdhw5E
        bvZLfyfFiAwMtSGnIsOLiWGy7k+L5z3xOpKQsNXZobE0g+TarJSzMxvvJwnFRVPsiSPIj8Ei
        2sV7yaeqJNbJDF5E7MWvp3J3HEReFORP5UqcQZMzt5Y7WY4DiKOpkXEywvPInTuNU30aq4j0
        cYx1PQGTPKsrJ3gO+dz182++gNS9yaSce9LYn9yuWOZSgaT1JiMXLyQZqZ2cawUP8vRSN3MO
        qUzTbjD9t03TbNM02zTNvoLYQqQ8oA2LEHXaiMBoTVysGBYYLkrI+fM83RRlKD1LsCGKRzZE
        eNrX092vvihM6R6ujjsq6g7u0R2KFGNsyIdnfFXu7WmUWon3qWPFCFGMFnX/phQv9z6Obl+P
        yu9Xh+zZt/LLIXvL9onu3qw1GyuH9Dfv+41sKasMDt14Sb/Ei7d/XfN88YaZ2UE+yR+kDEtT
        ZshJ78HU4Nr8vTtfLpXvvhcCrRuYdrV//JFN3Y+8aGvQq/crcpB/qH9D6Y648hOM/OGiZw+t
        Upxmzti2lxd/kRSzZm7J+OZsrS8To1GvWELrYtS/AfgfHpFnAwAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTYuMTIuMjIgdW0gMTQ6NDEgc2NocmllYiBNYXJrIEJyb3duOg0KPiBPbiBUaHUsIERlYyAx
NSwgMjAyMiBhdCAwMzo0MTo0OVBNIC0wNjAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToNCj4NCj4+
IFllYWggLSB0aGlzIGhhcHBlbnMgdG8gYmUgU0RjYXJkIHN1cHBseSAoYXQgbGVhc3QgaW4gbXkg
Y2FzZSkuLiBJJ2QNCj4+IHJhdGhlciBub3QgY2hhbmdlIHRoZSBtbWMgaG9zdCBvciBjb3JlIGxh
eWVyIHRvIGhhbmRsZSBhIGNhc2Ugd2hlcmUNCj4+IExETyBoYXBwZW5lZCB0byBiZSBpbiBieXBh
c3MuIGl0IGlzIGEgcmVndWxhdG9yIGRyaXZlcidzIHByb2JsZW0sIElNSE8NCj4+IGhvdyB0byBw
cm92aWRlIHRoZSBzdGF0ZWQgdm9sdGFnZSBPUiBmYWlsIHRvIHRyYW5zaXRpb24gdGhlIHZvbHRh
Z2UuDQo+IFdlbGwsIGlmIHRoZSByZWd1bGF0b3IgaXMgaW4gYnlwYXNzIG1vZGUgdGhlbiBpdCBp
cyBieSBkZWZpbml0aW9uIG5vdA0KPiByZWd1bGF0aW5nIGFuZCBzbyBpdCdzIGxpa2UgcHJvZ3Jh
bW1pbmcgdGhlIHZvbHRhZ2Ugd2hpbGUgc3dpdGNoZWQgb2ZmLA0KPiBzZXR0aW5nIHRoZSB0YXJn
ZXQgZm9yIHdoZW4gaXQgc3RhcnRzIHJlZ3VsYXRpbmcgYWdhaW4uICBJdCdzIGEgd2VpcmRlcg0K
PiB1c2UgY2FzZSBidXQgaXQgZG9lcyBmZWVsIGxpa2UgdGhlIGNvbnNpc3RlbnQgdGhpbmcgdG8g
ZG8gYXQgbGVhc3QuDQo+IFRoZSBkcml2ZXIgc2hvdWxkbid0IGVudGVyL2xlYXZlIGJ5cGFzcyB3
aXRob3V0IGJlaW5nIGV4cGxpY2l0bHkgdG9sZCB0bw0KPiBzbyBzaW5jZSB0aGVyZSdsbCBiZSBh
IHBlcmZvcm1hbmNlIGltcGFjdC4NCj4NCj4+IGIpIElmIEkgd2FudGVkIHRoZSBMRE8gdG8gcG93
ZXJvZmYgdGhlIGJ5cGFzcyBiaXQgYXQgc3RhcnQgKGRlZmluZSB0aGUNCj4+ICAgICBzdGFydHVw
IGhhcmR3YXJlIGNvbmRpdGlvbiksIEkgZG9udCBzZWVtIHRvIGhhdmUgYSBkZXNjcmlwdGlvbiBm
b3INCj4+ICAgICB0aGF0IGVpdGhlci4NCj4gVGhhdCdzIHNvbWV0aGluZyB3ZSBjb3VsZCBhZGQg
aW4gY29uc3RyYWludHMsIHRob3VnaCB0aGUgYWN0dWFsIHByb2Nlc3MNCj4gb2YgaW1wbGVtZW50
aW5nIGl0IG1pZ2h0IGdldCBtZXNzeSBpZiB0aGVyZSdzIHJlc3RyaWN0aW9ucyBsaWtlIGhhdmlu
Zw0KPiB0byBwb3dlciBvZmYgKHRob3VnaCBmcm9tIGZ1cnRoZXIgZG93biB0aGUgdGhyZWFkIEkg
c2VlIHRoYXQgbWlnaHQgbm90DQo+IGFwcGx5IHRvIHRoaXMgZGV2aWNlKS4NCg0KSnVzdCBmb3Ig
dGhlIHJlY29yZDoNCg0KTXkgcmVwb3J0ZWQgcHJvYmxlbSB3YXMgYWN0dWFsbHkgbm90IHRoZSBM
RE8xL2J5cGFzcyBzaXR1YXRpb24sIGJ1dCBhbiBpc3N1ZSBpbiANCnRoZSBwcm9jZXNzIG9mIHJl
c29sdmluZyB0aGUgcmVndWxhdG9yIHN1cHBsaWVzLg0KDQpJdCB3YXMgcmVzb2x2ZWQgYnkNCiDC
oCBjb21taXQgMGRlYmVkNWIxMTdkICgicmVndWxhdG9yOiBjb3JlOiBGaXggcmVzb2x2ZSBzdXBw
bHkgbG9va3VwIGlzc3VlIikNCg0KTm93IGV2ZXJ5dGhpbmcgc2VlbXMgdG8gd29yayB3aXRoIG15
IHNldHVwIHdpdGggTERPMSBzdXBwbGllZCBieSBhIGZpeGVkIA0KcmVndWxhdG9yIGFuZCBMRE8x
IGFjdGluZyBpbiBieXBhc3MgbW9kZSBvbiBvdXIgaGFyZHdhcmUuDQoNClJlZ2FyZHMsDQpXYWRp
bQ0KDQo=
