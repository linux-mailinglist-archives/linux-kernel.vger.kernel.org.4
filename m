Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64A73F78B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjF0Ij2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjF0IjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:39:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE5702129;
        Tue, 27 Jun 2023 01:38:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35R8bbQJ3020365, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35R8bbQJ3020365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Jun 2023 16:37:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 27 Jun 2023 16:37:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 Jun 2023 16:37:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 27 Jun 2023 16:37:37 +0800
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
        Douglas Anderson <dianders@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v5 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v5 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Thread-Index: AQHZqNBPqRelKVx0kUO74xPTqy/mgq+dyu4AgACG3DA=
Date:   Tue, 27 Jun 2023 08:37:37 +0000
Message-ID: <90549ea704c645278fc502118642fa40@realtek.com>
References: <20230627082022.22902-1-stanley_chang@realtek.com>
 <20230627082022.22902-4-stanley_chang@realtek.com>
 <5c384322-5321-f3c5-f0c5-0558c344eef5@linaro.org>
In-Reply-To: <5c384322-5321-f3c5-f0c5-0558c344eef5@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+IE9uIDI3LzA2LzIwMjMgMTA6MjAsIFN0YW5sZXkgQ2hhbmcgd3Jv
dGU6DQo+ID4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGV4cGxhaW4gdGhlIHByb3BlcnR5IGFib3V0
IFJlYWx0ZWsgVVNCIFBIWSBkcml2ZXIuDQo+ID4NCj4gPiBSZWFsdGVrIERIQyAoZGlnaXRhbCBo
b21lIGNlbnRlcikgUlREIFNvQ3Mgc3VwcG9ydCBEV0MzIFhIQ0kgVVNCDQo+ID4gY29udHJvbGxl
ci4gQWRkZWQgdGhlIGRyaXZlciB0byBkcml2ZSB0aGUgVVNCIDIuMCBQSFkgdHJhbnNjZWl2ZXJz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0By
ZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2NCB0byB2NSBjaGFuZ2U6DQo+ID4gICAgIDEuIEFk
ZCBtb3JlIGV4YW1wbGVzLg0KPiANCj4gTm90IG1vcmUgZXhhbXBsZXMuIEp1c3QgZ2l2ZSBvbmUg
b3IgdHdvIHJlbGV2YW50IGV4YW1wbGVzLg0KDQpPa2F5LiBJIHdpbGwga2VlcCBqdXN0IG9uZSBl
eGFtcGxlLg0KDQo+IA0KPiANCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSAiI3BoeS1jZWxscyINCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAg
LSB8DQo+ID4gKyAgICB1c2JfcG9ydDBfdXNiMnBoeTogdXNiLXBoeUAxMzIxNCB7DQo+IA0KPiBE
cm9wIGFsc28gdGhlIGxhYmVscy4NCg0KT2theQ0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
cmVhbHRlayxydGQxMzE5ZC11c2IycGh5IjsNCj4gPiArICAgICAgICByZWcgPSA8MHgxMzIxNCAw
eDQ+LCA8MHgyODI4MCAweDQ+Ow0KPiA+ICsgICAgICAgICNwaHktY2VsbHMgPSA8MD47DQo+ID4g
KyAgICAgICAgbnZtZW0tY2VsbHMgPSA8Jm90cF91c2JfcG9ydDBfZGNfY2FsPiwNCj4gPCZvdHBf
dXNiX3BvcnQwX2RjX2Rpcz47DQo+ID4gKyAgICAgICAgbnZtZW0tY2VsbC1uYW1lcyA9ICJ1c2It
ZGMtY2FsIiwgInVzYi1kYy1kaXMiOw0KPiA+ICsNCj4gPiArICAgICAgICByZWFsdGVrLGRyaXZp
bmctbGV2ZWwgPSA8MHhlPjsNCj4gDQo+IFdoeSBrZWVwaW5nIHRoaXMgZXhhbXBsZT8gSSBhc2tl
ZCB0byBncm93IGl0IGFuZCBpbnN0ZWFkIHRoZXJlIGFyZSB0d28gbW9yZS4NCj4gSnVzdCBrZWVw
IG9uZSBkZXNjcmliaW5nIGFzIG11Y2ggYXMgcG9zc2libGUuIFNlY29uZCBpcyB1c2VmdWwgaWYg
eW91IGhhdmUgdGhlcmUNCj4gZGlmZmVyZW50IHByb3BlcnRpZXMuDQo+IA0KPiBZb3VyIHRoaXJk
IGlzIGFsbW9zdCB0aGUgc2FtZSBhcyBzZWNvbmQsIHNvIG5vIG5lZWQgZm9yIGl0IGF0IGFsbC4N
Cg0KVGhleSBhcmUgcmVhbCBleGFtcGxlcyBmb3IgZGlmZmVyZW50IHBsYXRmb3JtLg0KU28gSSBk
b24ndCBhZGQgb3RoZXIgcHJvcGVydGllcyB0byBleGFtcGxlIDEuDQpJIHdpbGwgcmVtb3ZlIGV4
YW1wbGUgMSBhbmQgZXhhbXBsZSAzLg0KDQpUaGFua3MsDQpTdGFubGV5DQoNCg0K
