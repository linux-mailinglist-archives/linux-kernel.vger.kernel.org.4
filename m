Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38BF7279DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjFHIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjFHIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:22:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1FE43;
        Thu,  8 Jun 2023 01:22:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3588KpOO2008876, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3588KpOO2008876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 16:20:51 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 16:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 16:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 16:21:07 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Thread-Index: AQHZmQjdazkCXQ0o50uX71FuvNBNuK9+uDoAgAGs3VD//54bgIAAiZyw
Date:   Thu, 8 Jun 2023 08:21:07 +0000
Message-ID: <7d503e3028a7487a9a087cfa061fff9d@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
 <8a88cbee5c6245f2941c700b2bb30697@realtek.com>
 <7df8ffb6-a544-d10e-5273-fd6c4b368b20@linaro.org>
In-Reply-To: <7df8ffb6-a544-d10e-5273-fd6c4b368b20@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gTWF5YmUgSSB1c2UgdGhlIHdvcmQgImNvbnRyb2wgcG93ZXIgZG9tYWluIiBpcyBub3Qg
d2VsbCwgSSBqdXN0IHdhbnQgdG8NCj4gY29udHJvbCB0aGUgbGRvIG9mIHVzYiBwaHkuDQo+ID4g
UmV2aXNlZDoNCj4gPiBUaGUgcGhhbmRsZSBvZiBzeXNjb24gdXNlZCB0byBjb250cm9sIHRoZSBs
ZG8gb2YgVVNCIFBIWS4NCj4gDQo+IElzbid0IHRoaXMgc3RpbGwgYSBwb3dlciBkb21haW4/DQoN
Ckkgb25seSBjb250cm9sIGEgcmVnaXN0ZXIsIGl0IGlzIG5vdCBuZWVkZWQgYSBkcml2ZXIgb2Yg
cG93ZXIgZG9tYWluLg0KDQoNCj4gPg0KPiA+Pj4gKw0KPiA+Pj4gK3BhdHRlcm5Qcm9wZXJ0aWVz
Og0KPiA+Pj4gKyAgIl5waHlAWzAtM10rJCI6DQo+ID4+PiArICAgIHR5cGU6IG9iamVjdA0KPiA+
Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBFYWNoIHN1Yi1ub2RlIGlzIGEgUEhZ
IGRldmljZSBmb3Igb25lIFhIQ0kgY29udHJvbGxlci4NCj4gPj4NCj4gPj4gSSBkb24ndCB0aGlu
ayBpdCBpcyB0cnVlLiBZb3UgY2xhaW0gYWJvdmUgdGhhdCB5b3UgaGF2ZSAwIGFzDQo+ID4+IHBo
eS1jZWxscywgbWVhbnMgeW91IGhhdmUgb25lIHBoeS4gSGVyZSB5b3Ugc2F5IHlvdSBjYW4gaGF2
ZSB1cCB0byA0IHBoeXMuDQo+ID4NCj4gPiBJIG1lYW4gdGhlIGRyaXZlciBjYW4gc3VwcG9ydCB1
cCB0byA0IHBoeXMuDQo+IA0KPiBXaGF0IGRyaXZlciBjYW4gb3IgY2Fubm90IGRvLCBkb2VzIG5v
dCBtYXR0ZXIuIFRoaXMgaXMgYWJvdXQgaGFyZHdhcmUuDQo+IA0KPiA+IEZvciBSVEQxMjk1IGhh
cyBvbmx5IG9uZSBwaHkuDQo+ID4gRm9yIFJURDEzOTUgaGFzIHR3byBwaHlzLg0KPiANCj4gVHdv
IHBoeXM/IFNvIGhvdyBkbyB5b3UgcmVmZXJlbmNlIHRoZW0gd2hlbiBjZWxscz0wPw0KDQoNCkFi
b3V0IFJURDEzOTUgU29DcyBVU0INCiAgWEhDSSBjb250cm9sbGVyIzEgLS0gdXNiMnBoeSAtLSBw
aHkjMA0KICAgICAgICAgICAgICAgICAgICAgICAgICB8LSBwaHkjMQ0KT25lIHhoY2kgY29udHJv
bGxlciBtYXAgdG8gb25lIHBoeSBkcml2ZXIuDQpBbmQgb25lIHBoeSBkcml2ZXIgaGF2ZSB0d28g
cGh5cyAocGh5QDAgYW5kIHBoeUAxKS4NCg0KTWF5YmUgdGhlICJwaHkiIG5hbWUgaXMgY29uZnVz
aW5nLg0KVGhpcyAicGh5IiBub3QgbWVhbiBhIHBoeSBkcml2ZXIuDQpXb3VsZCAicG9ydCIgYmUg
bW9yZSBhcHByb3ByaWF0ZT8gDQoNCkZvciBleGFtcGxlLA0KVXNpbmcgcGh5QDAgYW5kIHBoeUAx
Og0KICAgIHVzYl9wb3J0MV91c2IycGh5OiB1c2ItcGh5QDEzYzE0IHsNCiAgICAgICAgY29tcGF0
aWJsZSA9ICJyZWFsdGVrLHJ0ZDEzOTUtdXNiMnBoeSIsICJyZWFsdGVrLHVzYjJwaHkiOw0KICAg
ICAgICByZWcgPSA8MHgxMzJjNCAweDQ+LCA8MHgzMTI4MCAweDg+Ow0KICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCiAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQogICAgICAgICNwaHkt
Y2VsbHMgPSA8MD47DQogICAgICAgIHJlYWx0ZWssdXNiLWN0cmwgPSA8JnVzYl9jdHJsPjsNCg0K
ICAgICAgICBwaHlAMCB7DQogICAgICAgICAgICByZWcgPSA8MD47DQogICAgICAgIH07DQogICAg
ICAgIHBoeUAxIHsNCiAgICAgICAgICAgIHJlZyA9IDwxPjsNCiAgICAgICAgfTsNCiAgICB9Ow0K
DQpDaGFuZ2U6IHBvcnRAMCBhbmQgcG9ydEAxDQogICAgdXNiX3BvcnQxX3VzYjJwaHk6IHVzYi1w
aHlAMTNjMTQgew0KICAgICAgICBjb21wYXRpYmxlID0gInJlYWx0ZWsscnRkMTM5NS11c2IycGh5
IiwgInJlYWx0ZWssdXNiMnBoeSI7DQogICAgICAgIHJlZyA9IDwweDEzMmM0IDB4ND4sIDwweDMx
MjgwIDB4OD47DQogICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCiAgICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCiAgICAgICAgcmVhbHRlayx1
c2ItY3RybCA9IDwmdXNiX2N0cmw+Ow0KDQogICAgICAgIHByb3RAMCB7DQogICAgICAgICAgICBy
ZWcgPSA8MD47DQogICAgICAgIH07DQogICAgICAgIHBvcnRAMSB7DQogICAgICAgICAgICByZWcg
PSA8MT47DQogICAgICAgIH07DQogICAgfTsNCg0KDQo=
