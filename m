Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A32719083
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFACZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFACZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:25:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7382B3;
        Wed, 31 May 2023 19:25:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3512OFzD4014400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3512OFzD4014400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 10:24:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 1 Jun 2023 10:24:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 10:24:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 10:24:29 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Douglas Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Ray Chi" <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Thread-Index: AQHZjrBYcJlLsVj/HkuHUZRifSysgq9xG94AgAEOUJD//7ougIADWznA
Date:   Thu, 1 Jun 2023 02:24:28 +0000
Message-ID: <96a7905208c148debe3791636034a038@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <20230529-impurity-dismount-bca5c9100c9b@spud>
 <44015844858c42a79e0e7f9207d01496@realtek.com>
 <202305310146.34V1kevI7026106@rtits1.realtek.com.tw>
In-Reply-To: <202305310146.34V1kevI7026106@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNCj4gPiA+IFlvdSBoYXZlIGRldmljZS1zcGVjaWZpYyBjb21wYXRpYmxlcywg
d2hpY2ggaXMgZ3JlYXQsIGJ1dCB5b3UgYWxzbyBhbGxvdw0KPiA+ID4gb25seSB0aG9zZSB0d28g
Z2VuZXJpYyBvbmVzLiBJIGhhZCBhIF9icmllZl8gbG9vayBhdCB0aGUgZHJpdmVyLCBhbmQgaXQN
Cj4gPiA+IHNlZW1zIGxpa2UgdGhlcmUgaXMgbm8gZGVjaXNpb24gbWFraW5nIGRvbmUgYmFzZWQg
b24gdGhlIGNvbXBhdGlibGVzLA0KPiA+ID4gb25seSBvbiB0aGUgcHJvcGVydGllcy4gSXMgdGhh
dCBjb3JyZWN0Pw0KPiA+ID4gSWYgaXQgaXMsIEkgd291bGQgdW5kZXJzdGFuZCBoYXZpbmcgInJl
YWx0ZWssdXNiM3BoeSIgYXMgYSBmYWxsYmFjaw0KPiA+ID4gY29tcGF0aWJsZSBmb3IgInJlYWx0
ZWsscnRkMTYxOS11c2IzcGh5IiwgYnV0IEkgZG8gbm90IGdldCB0aGUgY3VycmVudA0KPiA+ID4g
c2V0dXAuDQo+ID4NCj4gPiBUaGlzIGRyaXZlciBpcyBjb21wYXRpYmxlIHdpdGggYWxsIFJlYWx0
ZWsgUlREIFNvQ3Mgd2l0aG91dCBzcGVjaWZ5aW5nIGRpZmZlcmVudCBzZXR0aW5ncy4NCj4gPiBT
byB1c2UgInJlYWx0ZWssdXNiM3BoeSIgYXMgZmFsbGJhY2sgY29tcGF0aWJsZSBmb3IgYWxsIFNv
Q3MuDQo+ID4gVGhpcyBpcyB0aGUgY29tcGF0aWJsZSBuYW1lIHdlIHVzZS4NCj4gPiBPdGhlciBj
b21wYXRpYmxlIG5hbWVzIHNpbXBseSBpbmRpY2F0ZSB0aGF0IHRoZSBkcml2ZXIgc3VwcG9ydHMg
dGhlIFNvQ3MuDQo+IA0KPiBUaGVuIHlvdSBzaG91bGQgd3JpdGUgdGhlIGJpbmRpbmcgc3VjaCB0
aGF0IGhhdmluZyBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiBpcyBwZXJtaXR0ZWQuIFRyeSBwbHVn
Z2luZw0KPiBjb21wYXRpYmxlID0gInJlYWx0ZWsscnRkMTI5NS11c2IycGh5IiwgInJlYWx0ZWss
cnRkLXVzYjJwaHkiLCAicmVhbHRlayx1c2IycGh5IjsNCj4gaW50byB5b3VyIGV4YW1wbGUgYmVs
b3cgYW5kIHNlZSB3aGF0IGhhcHBlbnMuDQo+IA0KPiA+IFRoZSBuYW1lICJ1c2JOcGh5IiBhbmQg
InJ0ZC11c2JOcGh5IiBzZWVtIHRvIGJlIG1vcmUgZ2VuZXJpYyBmb3IgYWxsIFJURCBTb0NzLA0K
PiA+IGJ1dCB0aGV5IGFyZSBub3QgZGV2aWNlLXNwZWNpZmljIGNvbXBhdGlibGUuDQo+ID4gRG8g
eW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbj8NCj4gDQo+IFdyaXRlIHRoZSBiaW5kaW5nIHNv
IHRoYXQgaGF2aW5nIGZhbGxiYWNrIGNvbXBhdGlibGVzIGluIHRoZSBEVCBhY3R1YWxseQ0KPiB3
b3JrcywgZG9uJ3QgYWRkIHRoZSBTb0Mtc3BlY2lmaWMgb25lcyBtZXJlbHkgYXMgaW5kaWNhdG9y
cyB0aGF0IHRob3NlDQo+IFNvQ3MgYXJlIHN1cHBvcnRlZCBhbmQgZG9uJ3QgcGVybWl0ICJyZWFs
dGVrLHVzYk5waHkiIG9yDQo+ICJyZWFsdGVrLHJ0ZC11c2JOcGh5IiBpbiBpc29sYXRpb24gOykN
Cj4NCg0KQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0KSSBzaG91bGQgZm9s
bG93IG90aGVyIGRvY3MgdG8gZGVmaW5lIGNvbXBhdGlibGUuDQpSZWZlcmVuY2U6DQogIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWsseHNwaHkueWFtbA0KICBk
cml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXhzcGh5LmMNCg0KRm9yIGV4YW1wbGU6DQoNCiAg
Y29tcGF0aWJsZToNCiAgICBpdGVtczoNCiAgICAgIC0gZW51bToNCiAgICAgICAgICAtIHJlYWx0
ZWsscnRkMTI5NS11c2IycGh5DQogICAgICAgICAgLSByZWFsdGVrLHJ0ZDEzOTUtdXNiMnBoeQ0K
ICAgICAgICAgIC0gcmVhbHRlayxydGQxNjE5LXVzYjJwaHkNCiAgICAgICAgICAtIHJlYWx0ZWss
cnRkMTMxOS11c2IycGh5DQogICAgICAgICAgLSByZWFsdGVrLHJ0ZDE2MTliLXVzYjJwaHkNCiAg
ICAgICAgICAtIHJlYWx0ZWsscnRkMTMxMmMtdXNiMnBoeQ0KICAgICAgICAgIC0gcmVhbHRlayxy
dGQxMzE5ZC11c2IycGh5DQogICAgICAgICAgLSByZWFsdGVrLHJ0ZDEzMTVlLXVzYjJwaHkNCiAg
ICAgIC0gY29uc3Q6IHJlYWx0ZWssdXNiMnBoeQ0KDQpleGFtcGxlczoNCiAgLQ0KICAgIGR3YzNf
dTNkcmRfdXNiMnBoeTogZHdjM191M2RyZF91c2IycGh5QDk4MDEzZTE0IHsNCiAgICAgICAgY29t
cGF0aWJsZSA9ICJyZWFsdGVrLHJ0ZDEzMTktdXNiMnBoeSIsICJyZWFsdGVrLHVzYjJwaHkiOw0K
ICANCkFuZCB1c2Ugb25seSAiUmVhbHRlaywgdXNiMnBoeSIgaW4gdGhlIGRyaXZlci4NCnN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHVzYnBoeV9ydGtfZHRfbWF0Y2hbXSA9IHsNCiAg
ICAgICAgeyAuY29tcGF0aWJsZSA9ICJyZWFsdGVrLHVzYjJwaHkiLCB9LA0KICAgICAgICB7fSwN
Cn07DQoNCg==
