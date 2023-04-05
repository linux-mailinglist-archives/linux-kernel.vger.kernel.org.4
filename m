Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F286D85EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjDESYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDESYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:24:49 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B23A9F;
        Wed,  5 Apr 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680719050;
        bh=7Nl52tGHqcsiPw/xmAb/LjUgiMWKfLo4pbV1xDkMOBY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AV+chS/zAW+VTX6tSwISxGEgwZPAokvLWTKacRk0NwyvRYGSqPV/Ani6gHC0BZXLF
         qw9VeqKHFVZY/v8uT2CRqS9nQC4WW3wg7zN8G6MPKBLYyEs4g8QQzZtMbekwMswN2B
         3fr6BE1p/zwZJMU9RtSQiDR3QdptV6wl8gSDVAymnC03hUQaEY5YvHcWaSMiw0ezcR
         RS8omk7RJKoLiMd4ZJt8h/XeVVA0//aPPUY72msTVgtzj9T1GSmGoqjmTCCIWmQ2Cw
         SeYZEI7tzUzMwe91L+3gAa71pIwwGotFWEC9OPQhRJxzbCJWdzqcgOdZauYZUi8pSE
         BR5rcYqgMIs+g==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Topic: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Index: AQHZZ9hJaqalrClMnUSWr1zaggJvEq8cxTeAgAA/z6A=
Date:   Wed, 5 Apr 2023 18:24:01 +0000
Message-ID: <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
 <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
In-Reply-To: <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogV2VkbmVzZGF5
LCBBcHJpbCA1LCAyMDIzIDY6MjUgUE0NCj4gT24gNC81LzIzIDE4OjAyLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsvIHsNCj4+ICsgICAgIG1vZGVs
ID0gIkRIIGVsZWN0cm9uaWNzIGkuTVg2VUxMIERIQ09SIG9uIG1hdmVvIGJveCI7DQo+PiArICAg
ICBjb21wYXRpYmxlID0gImRoLGlteDZ1bGwtZGhjb3ItbWF2ZW8tYm94IiwgImRoLGlteDZ1bGwt
ZGhjb3Itc29tIiwNCj4+ICsgICAgICAgICAgICAgICAgICAiZnNsLGlteDZ1bGwiOw0KPj4gKw0K
Pj4gKyAgICAgYWxpYXNlcyB7DQo+PiArICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIG1t
YzA7IC8qIEF2b2lkIGRvdWJsZSBkZWZpbml0aW9ucyAqLw0KPj4gKyAgICAgICAgICAgICAvZGVs
ZXRlLXByb3BlcnR5LyBtbWMxOw0KPj4gKyAgICAgICAgICAgICBtbWMyID0gJnVzZGhjMjsgLyog
ZU1NQyBzaG91bGQgYmUgbW1jMiAqLw0KPiANCj4gV2h5IG5vdCBtbWMwID8NCj4gDQo+IFVzZSBy
b290PVBBUlRVVUlEPSB3aGVuIGJvb3RpbmcgdG8gYXZvaWQgYW55IGRlcGVuZGVuY3kgb24NCj4g
cm9vdD0vZGV2L21tY2JsazJwTiBlbnVtZXJhdGlvbi4NCg0KVGhpcyBpcyBkdWUgdG8gc29mdHdh
cmUgaW50ZXJjaGFuZ2VhYmlsaXR5IHdpdGggdGhlIERIQ09NDQppLk1YNlVMTCwgd2hlcmUgdGhl
IGVNTUMgaXMgYWx3YXlzIG1tYzIuDQoNCj4gDQo+PiArICAgICAgICAgICAgIHNwaTAgPSAmZWNz
cGk0Ow0KPj4gKyAgICAgICAgICAgICBzcGkzID0gJmVjc3BpMTsNCj4+ICsgICAgIH07DQo+IA0K
PiBbLi4uXQ0KPiANCj4+ICsmaW9tdXhjIHsNCj4+ICsgICAgIHBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9ob2dfbWF2ZW9fYm94PjsNCj4+ICsgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
PiArDQo+PiArICAgICBwaW5jdHJsX2hvZ19tYXZlb19ib3g6IGhvZy1tYXZlby1ib3gtZ3JwIHsN
Cj4+ICsgICAgICAgICAgICAgZnNsLHBpbnMgPSA8DQo+PiArICAgICAgICAgICAgICAgICAgICAg
TVg2VUxfUEFEX0dQSU8xX0lPMDVfX0dQSU8xX0lPMDUgICAgICAgIDB4NDAwMTIwYjAgLyogQlVU
VE9OX1VTRVIgKi8NCj4+ICsgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfR1BJTzFfSU8w
OF9fR1BJTzFfSU8wOCAgICAgICAgMHg0MDAxMjBiMCAvKiBCVVRUT05fUkVTRVQgKi8NCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfQ1NJX1BJWENMS19fR1BJTzRfSU8xOCAgICAg
ICAgMHg0MDAxMjBiMCAvKiBMRURfRyAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIE1YNlVM
X1BBRF9DU0lfREFUQTAyX19HUElPNF9JTzIzICAgICAgICAweDQwMDEyMGIwIC8qIExFRF9CICov
DQo+IA0KPiBTaG91bGQgdGhlICJTSU9OKDEgPDwgMzApOiBTb2Z0d2FyZSBJbnB1dCBPbiBGaWVs
ZC4iIGJpdCByZWFsbHkgYmUgc2V0DQo+IG9uIEdQSU9zIHdoaWNoIGFyZSBPVVRQVVQgKGxpa2Ug
TEVEcykgPw0KDQpJIHRoaW5rIGZvciBJTlBVVCBpdCBkb2Vzbid0IG1hdHRlciwgYnV0IGZvciBP
VVRQVVQgSSB0aGVuIGhhdmUgYSBmZWVkYmFjay4NCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
