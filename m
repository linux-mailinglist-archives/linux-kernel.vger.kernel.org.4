Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DF727B45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjFHJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFHJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:28:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF89213C;
        Thu,  8 Jun 2023 02:28:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3589R9aZ4011935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3589R9aZ4011935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 17:27:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 17:27:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 17:27:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 17:27:25 +0800
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
Thread-Index: AQHZmQjdazkCXQ0o50uX71FuvNBNuK9+uDoAgAGs3VD//54bgIAAiZyw//+BfQCAAI4H4A==
Date:   Thu, 8 Jun 2023 09:27:25 +0000
Message-ID: <d515bfed030d4499b16050d492e1ec23@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
 <8a88cbee5c6245f2941c700b2bb30697@realtek.com>
 <7df8ffb6-a544-d10e-5273-fd6c4b368b20@linaro.org>
 <7d503e3028a7487a9a087cfa061fff9d@realtek.com>
 <b941c06f-7f7d-1364-a7f5-be5905112cac@linaro.org>
In-Reply-To: <b941c06f-7f7d-1364-a7f5-be5905112cac@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

PiA+IEkgb25seSBjb250cm9sIGEgcmVnaXN0ZXIsIGl0IGlzIG5vdCBuZWVkZWQgYSBkcml2ZXIg
b2YgcG93ZXIgZG9tYWluLg0KPiANCj4gQXJlbid0IG1hbnkgcG93ZXIgZG9tYWlucyBqdXN0IGEg
cmVnaXN0ZXJzPyBXaGF0IGFib3V0IG90aGVyIGRyaXZlcnM/DQo+IERvbid0IHlvdSB3YW50IGlu
IG90aGVyIGRyaXZlciBjb250cm9sIExETyBvZiBzb21ldGhpbmcgZWxzZT8gQW5kIGluIG90aGVy
DQo+IHNvbWV0aGluZyBlbHNlPw0KDQpJIHdpbGwgdXNlIHBvd2VyIGRvbWFpbiB0byBpbnN0ZWFk
IHRoaXMuDQoNCj4gPiBXb3VsZCAicG9ydCIgYmUgbW9yZSBhcHByb3ByaWF0ZT8NCj4gPg0KPiA+
IEZvciBleGFtcGxlLA0KPiA+IFVzaW5nIHBoeUAwIGFuZCBwaHlAMToNCj4gPiAgICAgdXNiX3Bv
cnQxX3VzYjJwaHk6IHVzYi1waHlAMTNjMTQgew0KPiA+ICAgICAgICAgY29tcGF0aWJsZSA9ICJy
ZWFsdGVrLHJ0ZDEzOTUtdXNiMnBoeSIsICJyZWFsdGVrLHVzYjJwaHkiOw0KPiA+ICAgICAgICAg
cmVnID0gPDB4MTMyYzQgMHg0PiwgPDB4MzEyODAgMHg4PjsNCj4gPiAgICAgICAgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gICAgICAg
ICAjcGh5LWNlbGxzID0gPDA+Ow0KPiA+ICAgICAgICAgcmVhbHRlayx1c2ItY3RybCA9IDwmdXNi
X2N0cmw+Ow0KPiA+DQo+ID4gICAgICAgICBwaHlAMCB7DQo+ID4gICAgICAgICAgICAgcmVnID0g
PDA+Ow0KPiANCj4gU28gc3VjaCBjaGlsZCBpcyBhIE5BSy4uLiB5b3UgaGF2ZSBub3RoaW5nIGhl
cmUuIEJ1dCBpdCdzIHVucmVsYXRlZCB0b3BpYy4NCkhlcmUgaXMgZm9yIHNpbXBsZSwgc28gc29t
ZSBpdGVtcyBpZ25vcmUuDQoNCj4gPiAgICAgICAgIH07DQo+ID4gICAgICAgICBwaHlAMSB7DQo+
ID4gICAgICAgICAgICAgcmVnID0gPDE+Ow0KPiA+ICAgICAgICAgfTsNCj4gPiAgICAgfTsNCj4g
Pg0KPiA+IENoYW5nZTogcG9ydEAwIGFuZCBwb3J0QDENCj4gPiAgICAgdXNiX3BvcnQxX3VzYjJw
aHk6IHVzYi1waHlAMTNjMTQgew0KPiA+ICAgICAgICAgY29tcGF0aWJsZSA9ICJyZWFsdGVrLHJ0
ZDEzOTUtdXNiMnBoeSIsICJyZWFsdGVrLHVzYjJwaHkiOw0KPiA+ICAgICAgICAgcmVnID0gPDB4
MTMyYzQgMHg0PiwgPDB4MzEyODAgMHg4PjsNCj4gPiAgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiA+ICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gICAgICAgICAjcGh5LWNl
bGxzID0gPDA+Ow0KPiA+ICAgICAgICAgcmVhbHRlayx1c2ItY3RybCA9IDwmdXNiX2N0cmw+Ow0K
PiA+DQo+ID4gICAgICAgICBwcm90QDAgew0KPiA+ICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4g
PiAgICAgICAgIH07DQo+ID4gICAgICAgICBwb3J0QDEgew0KPiA+ICAgICAgICAgICAgIHJlZyA9
IDwxPjsNCj4gPiAgICAgICAgIH07DQo+ID4gICAgIH07DQo+IA0KPiBUaGlzIGlzIG5vdCB0aGUg
YW5zd2VyLiBUaGlzIGlzIHRoZSBwcm92aWRlci4gSG93IGRvIHlvdSByZWZlcmVuY2UgaXQgZnJv
bSB0aGUNCj4gY29uc3VtZXIuDQoNCg0KPiBVcHN0cmVhbSB5b3VyIGVudGlyZSBEVFMuIEl0J3Mg
ZnJ1c3RyYXRpbmcgdG8gdHJ5IHRvIHVuZGVyc3RhbmQgeW91ciBEVFMgZnJvbQ0KPiBwaWVjZXMg
b2YgaW5mb3JtYXRpb24geW91IGFyZSBzaGFyaW5nLiBBbHNvIHZlcnkgdGltZSBjb25zdW1pbmcg
YW5kIHlvdSBhcmUNCj4gbm90IHRoZSBvbmx5IG9uZSBzZW5kaW5nIHBhdGNoZXMgZm9yIHJldmll
dy4uLg0KDQpTb3JyeSB0byB0YWtlIHVwIGEgbG90IG9mIHlvdXIgdGltZS4NCkFwcGFyZW50bHkg
SSBkb24ndCBrbm93IGVub3VnaCBhYm91dCBkdHMuDQpJIHdpbGwgcmVmZXJlbmNlIG1vcmUgZGV2
aWNlIHRyZWUgZG9jdW1lbnQgdG8gdW5kZXJzdGFuZCB0aGUgcmVsYXRpbmcgYmV0d2VlbiBEVFMg
YW5kIGhhcmR3YXJlLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
