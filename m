Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF0715421
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjE3DJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3DJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:09:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28916B0;
        Mon, 29 May 2023 20:09:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U38HzB4006839, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U38HzB4006839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 11:08:17 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 30 May 2023 11:08:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 May 2023 11:08:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 30 May 2023 11:08:29 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
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
Thread-Index: AQHZjrBYcJlLsVj/HkuHUZRifSysgq9xG94AgAEOUJA=
Date:   Tue, 30 May 2023 03:08:29 +0000
Message-ID: <44015844858c42a79e0e7f9207d01496@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <20230529-impurity-dismount-bca5c9100c9b@spud>
In-Reply-To: <20230529-impurity-dismount-bca5c9100c9b@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

SGkgQ29ub3IsDQoNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsg
ICAgZW51bToNCj4gPiArICAgICAgLSByZWFsdGVrLHVzYjJwaHkNCj4gPiArICAgICAgLSByZWFs
dGVrLHJ0ZC11c2IycGh5DQo+ID4gKyAgICAgIC0gcmVhbHRlayxydGQxMjk1LXVzYjJwaHkNCj4g
PiArICAgICAgLSByZWFsdGVrLHJ0ZDEzOTUtdXNiMnBoeQ0KPiA+ICsgICAgICAtIHJlYWx0ZWss
cnRkMTYxOS11c2IycGh5DQo+ID4gKyAgICAgIC0gcmVhbHRlayxydGQxMzE5LXVzYjJwaHkNCj4g
PiArICAgICAgLSByZWFsdGVrLHJ0ZDE2MTliLXVzYjJwaHkNCj4gPiArICAgICAgLSByZWFsdGVr
LHJ0ZDEzMTJjLXVzYjJwaHkNCj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTlkLXVzYjJwaHkN
Cj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTVlLXVzYjJwaHkNCg0KPiA+ICtwcm9wZXJ0aWVz
Og0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIHJlYWx0
ZWssdXNiM3BoeQ0KPiA+ICsgICAgICAtIHJlYWx0ZWsscnRkLXVzYjNwaHkNCj4gPiArICAgICAg
LSByZWFsdGVrLHJ0ZDEyOTUtdXNiM3BoeQ0KPiA+ICsgICAgICAtIHJlYWx0ZWsscnRkMTYxOS11
c2IzcGh5DQo+ID4gKyAgICAgIC0gcmVhbHRlayxydGQxMzE5LXVzYjNwaHkNCj4gPiArICAgICAg
LSByZWFsdGVrLHJ0ZDE2MTliLXVzYjNwaHkNCj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDEzMTlk
LXVzYjNwaHkNCg0KPiBJZ25vcmluZyBldmVyeXRoaW5nIGVsc2UsIGJlY2F1c2UgSSByZWFsbHkg
d2FudCBLcnp5c3p0b2Ygb3IgUm9iIHRvDQo+IHJldmlldyB0aGlzIHJhdGhlciB0aGFuIG1lLCBi
dXQgd2hhdCdzIGdvaW5nIG9uIGhlcmUgd2l0aCB0aGUNCj4gY29tcGF0aWJsZXM/DQo+IFdoYXQg
aGFyZHdhcmUgZG8gInVzYk5waHkiIGFuZCAicnRkLXVzYk5waHkiIHJlcHJlc2VudD8NCj4gDQo+
IFlvdSBoYXZlIGRldmljZS1zcGVjaWZpYyBjb21wYXRpYmxlcywgd2hpY2ggaXMgZ3JlYXQsIGJ1
dCB5b3UgYWxzbyBhbGxvdw0KPiBvbmx5IHRob3NlIHR3byBnZW5lcmljIG9uZXMuIEkgaGFkIGEg
X2JyaWVmXyBsb29rIGF0IHRoZSBkcml2ZXIsIGFuZCBpdA0KPiBzZWVtcyBsaWtlIHRoZXJlIGlz
IG5vIGRlY2lzaW9uIG1ha2luZyBkb25lIGJhc2VkIG9uIHRoZSBjb21wYXRpYmxlcywNCj4gb25s
eSBvbiB0aGUgcHJvcGVydGllcy4gSXMgdGhhdCBjb3JyZWN0Pw0KPiBJZiBpdCBpcywgSSB3b3Vs
ZCB1bmRlcnN0YW5kIGhhdmluZyAicmVhbHRlayx1c2IzcGh5IiBhcyBhIGZhbGxiYWNrDQo+IGNv
bXBhdGlibGUgZm9yICJyZWFsdGVrLHJ0ZDE2MTktdXNiM3BoeSIsIGJ1dCBJIGRvIG5vdCBnZXQg
dGhlIGN1cnJlbnQNCj4gc2V0dXAuDQoNClRoaXMgZHJpdmVyIGlzIGNvbXBhdGlibGUgd2l0aCBh
bGwgUmVhbHRlayBSVEQgU29DcyB3aXRob3V0IHNwZWNpZnlpbmcgZGlmZmVyZW50IHNldHRpbmdz
Lg0KU28gdXNlICJyZWFsdGVrLHVzYjNwaHkiIGFzIGZhbGxiYWNrIGNvbXBhdGlibGUgZm9yIGFs
bCBTb0NzLg0KVGhpcyBpcyB0aGUgY29tcGF0aWJsZSBuYW1lIHdlIHVzZS4NCk90aGVyIGNvbXBh
dGlibGUgbmFtZXMgc2ltcGx5IGluZGljYXRlIHRoYXQgdGhlIGRyaXZlciBzdXBwb3J0cyB0aGUg
U29Dcy4NCg0KVGhlIG5hbWUgInVzYk5waHkiIGFuZCAicnRkLXVzYk5waHkiIHNlZW0gdG8gYmUg
bW9yZSBnZW5lcmljIGZvciBhbGwgUlREIFNvQ3MsDQpidXQgdGhleSBhcmUgbm90IGRldmljZS1z
cGVjaWZpYyBjb21wYXRpYmxlLg0KRG8geW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbj8NCg0K
PiANCj4gQWxzbywgSSByZWFsbHkgdGhpbmsgdGhpcyBzaG91bGQgYmUgYnJva2VuIGRvd24gaW50
byB0d28gcGF0Y2hlcywgb25lDQo+IGZvciBlYWNoIG9mIFVTQiAyICYgMy4NCg0KT2theSwgSSB3
aWxsIHNwbGl0IHRvIHR3byBwYXRjaGVzLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
