Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E771FB0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjFBHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjFBHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:35:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8909C0;
        Fri,  2 Jun 2023 00:34:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3527XgK72027076, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3527XgK72027076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 15:33:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 15:33:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Jun 2023 15:33:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 2 Jun 2023 15:33:56 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Thread-Index: AQHZjrBYcJlLsVj/HkuHUZRifSysgq90OEaAgAGJYxD//9d+gIABRKMg///BZQCAAIkxgA==
Date:   Fri, 2 Jun 2023 07:33:55 +0000
Message-ID: <9cf3f726120846fabfcca269155d948c@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
 <ee65a9d6d40d4099987db5ff1ad1753f@realtek.com>
 <c49f5619-286c-fbb7-0f18-5869527081c8@linaro.org>
 <f53b5c21247c49db8be7071de36c773b@realtek.com>
 <1231d116-ca4b-fb73-d000-d531297343e7@linaro.org>
In-Reply-To: <1231d116-ca4b-fb73-d000-d531297343e7@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+ID4+IElmIHRoZXNlIGNhbiBiZSBpbiB0aGUgZHJpdmVyLCB3aHkg
d291bGQgZXZlciB0aGV5IGJlIGluIERUUyBpbiB0aGUgZmlyc3QNCj4gcGxhY2U/DQo+ID4+DQo+
ID4gT3VyIHBsYXRmb3JtcyBoYXZlIDMgeGhjaSBjb250cm9sbGVycyB3aGljaCBtYXAgdG8gMyBk
aWZmZXJlbnQgcGh5IHBvcnRzLg0KPiANCj4gWW91IG1lYW4gb24gdGhlIHNhbWUgU29DPw0KDQpZ
ZXMsIG9uZSBTb0MgaGFzIHRocmVlIHhoY2kgY29udHJvbGxlcnMuDQoNCj4gPiBBbmQgdGhlIHRo
cmVlIHBoeSBwb3J0cyB1c2UgdGhlIHNhbWUgZHJpdmVyLCBidXQgdGhlIHBhcmFtZXRlcnMgYXJl
DQo+IGRpZmZlcmVudC4NCj4gPiBTbyBJIHB1dCB0aGUgcGFyYW1ldGVyIHNldHRpbmdzIGluIERU
Uywgd2UgaGF2ZSAzIHVzYi1waHkgbm9kZXMgcmVwcmVzZW50aW5nDQo+IDMgcGh5IHBvcnRzLg0K
PiA+IEFsc28sIHNvbWUgcGFyYW1ldGVycyBoYXZlIHRvIGJlIGFkanVzdGVkIGZvciBkaWZmZXJl
bnQgYm9hcmRzLg0KPiA+IFRoZXJlZm9yZSwgaXQgaXMgbW9yZSBhcHBsaWNhYmxlIGluIERUUyB0
aGFuIGluIGRyaXZlci4NCj4gDQo+IFRoZW4gaXQgbG9va3MganVzdGlmaWVkIGluIERULCBzbyBw
bGVhc2Ugd3JpdGUgcHJvcGVyIGRlc2NyaXB0aW9ucyBmb3IgcHJvcGVyDQo+IHByb3BlcnRpZXMu
IFVuZGVyc2NvcmVzIGFyZSBub3QgYWxsb3dlZCBpbiBub2RlIG5hbWVzLiBObyBmYWtlIG5vZGVz
Lg0KPiBQcm9wZXJ0aWVzIHNob3VsZCB1c3VhbGx5IGRlc2NyaWJlIHBoeXNpY2FsL2hhcmR3YXJl
IGVmZmVjdCBub3QgdGhlIHJlZ2lzdGVyDQo+IHZhbHVlLg0KDQpJIHdpbGwgd3JpdGUgbW9yZSBk
ZXRhaWwgZm9yIHByb3BlcnRpZXMuIA0KDQo+IHFjb20sdXNiLXNucHMtZmVtdG8tdjIueWFtbCBp
cyBuaWNlIGV4YW1wbGUuIEZldyBNZWRpYXRlayBiaW5kaW5ncyBhbHNvDQo+IHdvdWxkIHdvcmsu
DQo+ICcNCg0KVGhhbmtzLA0KU3RhbmxleQ0K
