Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9016ACD47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCFS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCFSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:55:54 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1538039;
        Mon,  6 Mar 2023 10:54:15 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 67EBA5FD0A;
        Mon,  6 Mar 2023 21:53:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678128834;
        bh=DBAxHW4F3m3jlrgYwBiCU5dDtVa0huLSFWaR9cqGTRs=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=lfAPjKXwtBgFoS4HZh2/2mc2A2jy4eQRXk93RoqpihXA0iCEC1Y0tpfZauzFzBpS5
         yak3/vd5y4PIMROJz/27NsAI6ef8lydzbI8vY8VA5utcJDX6LkZ9edaRGZoooxT6Uq
         MMRzfD42KDHwXrA2J7aPVB4X0CpOQ5gp9W9C/3VQaN/3/rlCAsNfypBtdhJnn3HsPP
         9p0i1oFyFkhLXJ4xIf+UT7Gv9dCsHjnx0ROICcbMCHeMEh7euIf2PaKdlk24s60jzf
         P9mxssoVa298PruybjgUgc0ATMhAYakHY5zRULTfTAeIV1jxqxAmATv+NTyJANte1d
         gn7p2gq84C3EA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  6 Mar 2023 21:53:52 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Topic: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Index: AQHZNxDMFNGdYZWqIECM18Y2pLjN2K7E0tUAgClGs4A=
Date:   Mon, 6 Mar 2023 18:53:52 +0000
Message-ID: <20230306185324.2n65uw3uqgtnc5vx@cab-wsm-0029881.sigma.sbrf.ru>
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
 <3a06d80c-7f52-2c5c-840e-09a0a08400f4@linaro.org>
In-Reply-To: <3a06d80c-7f52-2c5c-840e-09a0a08400f4@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.25]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D18ECF9035574649BCC96986028AD074@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/06 16:19:00 #20919562
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIE5laWwhDQoNCk9uIFdlZCwgRmViIDA4LCAyMDIzIGF0IDAxOjM0OjA0UE0gKzAxMDAs
IE5laWwgQXJtc3Ryb25nIHdyb3RlOg0KPiBMZSAwMi8wMi8yMDIzIMOgIDE1OjE1LCBBbGV4ZXkg
Um9tYW5vdiBhIMOpY3JpdMKgOg0KPiA+IEFkZCBncGlvIGludGVycnVwdCBjb250cm9sbGVyIG5v
ZGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGV5IFJvbWFub3YgPGF2cm9tYW5vdkBz
YmVyZGV2aWNlcy5ydT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvYW1sb2dp
Yy9tZXNvbi1hMS5kdHNpIHwgMTAgKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9hbWxvZ2ljL21lc29uLWExLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FtbG9naWMvbWVz
b24tYTEuZHRzaQ0KPiA+IGluZGV4IDYyNjhjMzIzYTgxMC4uYTA0ZGRmMGY0Y2QzIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYW1sb2dpYy9tZXNvbi1hMS5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbWxvZ2ljL21lc29uLWExLmR0c2kNCj4gPiBAQCAt
MTU4LDYgKzE1OCwxNiBAQCBjbGtjX3BsbDogcGxsLWNsb2NrLWNvbnRyb2xsZXJAN2M4MCB7DQo+
ID4gICAJCQkJCSA8JmNsa2NfcGVyaXBocyBDTEtJRF9YVEFMX0hJRklQTEw+Ow0KPiA+ICAgCQkJ
CWNsb2NrLW5hbWVzID0gInh0YWxfZml4cGxsIiwgInh0YWxfaGlmaXBsbCI7DQo+ID4gICAJCQl9
Ow0KPiA+ICsNCj4gPiArCQkJZ3Bpb19pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlckAwNDQwIHsN
Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNvbi1hMS1ncGlvLWludGMiLA0KPiA+
ICsJCQkJCSAgICAgImFtbG9naWMsbWVzb24tZ3Bpby1pbnRjIjsNCj4gPiArCQkJCXJlZyA9IDww
eDAgMHgwNDQwIDB4MCAweDE0PjsNCj4gPiArCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+
ICsJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCj4gPiArCQkJCWFtbG9naWMsY2hhbm5lbC1p
bnRlcnJ1cHRzID0NCj4gPiArCQkJCQk8NDkgNTAgNTEgNTIgNTMgNTQgNTUgNTY+Ow0KPiA+ICsJ
CQl9Ow0KPiA+ICAgCQl9Ow0KPiA+ICAgCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQGZmOTAx
MDAwIHsNCj4gDQo+IFJldmlld2VkLWJ5OiBOZWlsIEFybXN0cm9uZyA8bmVpbC5hcm1zdHJvbmdA
bGluYXJvLm9yZz4NCj4gDQo+IA0KPiBJJ2xsIHRha2UgaXQgb25jZSB2Ni4zLXJjMSBpcyB0YWdn
ZWQuDQo+IA0KPiANCj4gVGhhbmtzLA0KPiANCj4gTmVpbA0KDQp2Ni4zIGlzIHRhZ2dlZCwgYnV0
IHdlIGRpZG4ndCBmaW5kIG15IHBhdGNoIGluIEFtbG9naWMgYnJhbmNoLg0KDQpEaWQgeW91IGhh
cHBlbiB0byBmb3JnZXQgYWJvdXQgaGltPw0KDQotLSANClRoYW5rIHlvdSwNCkFsZXhleQ==
