Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B57435DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3HgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjF3HfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:35:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 686312694;
        Fri, 30 Jun 2023 00:35:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35U7XiBD2019875, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35U7XiBD2019875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 30 Jun 2023 15:33:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 30 Jun 2023 15:33:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Jun 2023 15:33:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 30 Jun 2023 15:33:45 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Douglas Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v6 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Thread-Index: AQHZqkz4ea6k1ChKgUmQ1oGFAHMAzq+hdqEAgAFUL4A=
Date:   Fri, 30 Jun 2023 07:33:45 +0000
Message-ID: <f17378f003144f4ba50ec08e0ad38c0b@realtek.com>
References: <20230629054523.7519-1-stanley_chang@realtek.com>
 <20230629054523.7519-4-stanley_chang@realtek.com>
 <20230629164220.GA3146341-robh@kernel.org>
In-Reply-To: <20230629164220.GA3146341-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IE9uIFRodSwgSnVuIDI5LCAyMDIzIGF0IDAxOjQ1OjEyUE0gKzA4MDAsIFN0
YW5sZXkgQ2hhbmcgd3JvdGU6DQo+ID4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGV4cGxhaW4gdGhl
IHByb3BlcnR5IGFib3V0IFJlYWx0ZWsgVVNCIFBIWSBkcml2ZXIuDQo+IA0KPiBJbiB0aGUgc3Vi
amVjdCwgZHJvcCAidGhlIGRvYyBhYm91dCB0aGUiLiBJdCdzIHJlZHVuZGFudC4gQW5kIHBlcmhh
cHMgYWRkICdESEMNCj4gUlREIFNvQycgaWYgdGhpcyBpc24ndCBmb3IgKmFsbCogUmVhbHRlayBT
b0NzLg0KPiANCj4gPiBSZWFsdGVrIERIQyAoZGlnaXRhbCBob21lIGNlbnRlcikgUlREIFNvQ3Mg
c3VwcG9ydCBEV0MzIFhIQ0kgVVNCDQo+ID4gY29udHJvbGxlci4gQWRkZWQgdGhlIGRyaXZlciB0
byBkcml2ZSB0aGUgVVNCIDIuMCBQSFkgdHJhbnNjZWl2ZXJzLg0KPiANCj4gZHJpdmVyPyBUaGlz
IGlzIGEgYmluZGluZyBmb3IgdGhlIGgvdy4NCg0KSSBtZWFuLCB0aGUgZHJpdmVyIGlzIGRyaXZl
cnMvcGh5L3JlYWx0ZWsvcGh5LXJ0ay11c2IyLmMNCkkgd2lsbCByZXZpc2UgYXMNCiAgICBkdC1i
aW5kaW5nczogcGh5OiByZWFsdGVrOiBBZGQgdGhlIFJlYWx0ZWsgREhDIFJURCBTb0MgVVNCIDIu
MCBQSFkNCg0KICAgIEFkZCB0aGUgZG9jdW1lbnRhdGlvbiBleHBsYWluIHRoZSBwcm9wZXJ0eSBh
Ym91dCBSZWFsdGVrIFVTQiBQSFkgZHJpdmVyLg0KDQogICAgUmVhbHRlayBESEMgKGRpZ2l0YWwg
aG9tZSBjZW50ZXIpIFJURCBTb0NzIHN1cHBvcnQgRFdDMyBYSENJIFVTQg0KICAgIGNvbnRyb2xs
ZXIgYW5kIHVzZXMgcGh5LXJ0ay11c2IyIGFzIGRyaXZlciBmb3IgVVNCIDIuMCBQSFkgdHJhbnNj
ZWl2ZXIuLg0KDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGh5L3Jl
YWx0ZWssdXNiMnBoeS55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBSZWFsdGVrIERIQyBT
b0NzIFVTQiAyLjAgUEhZDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFN0YW5s
ZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlw
dGlvbjoNCj4gDQo+IFlvdSBuZWVkICd8JyBpZiBmb3JtYXR0aW5nIChsaW5lIGJyZWFrcykgYXJl
IGltcG9ydGFudC4NCg0KSSB0aGluayBJIG5lZWQgaXQuIEkgd2lsbCBhZGQgaXQuDQoNCj4gPiAr
ICByZWFsdGVrLGludmVyc2UtaHN0eC1zeW5jLWNsb2NrOg0KPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gKyAgICAgIEZvciBvbmUgb2YgdGhlIHBoeXMgb2YgUlREMTYxOWIgU29DLCB0aGUgc3lu
Y2hyb25vdXMgY2xvY2sgb2YgdGhlDQo+ID4gKyAgICAgIGhpZ2gtc3BlZWQgdHggbXVzdCBiZSBp
bnZlcnRlZC4NCj4gDQo+ICJpbnZlcnQiIGFzc3VtZXMgSSBrbm93IHdoYXQgbm9uLWludmVydGVk
IG1lYW5zLiBJIGRvIG5vdC4gQmV0dGVyIHRvIHN0YXRlIGluDQo+IHRlcm1zIG9mIGFjdGl2ZSBo
aWdoLCBsb3csIGZhbGxpbmcgZWRnZSwgcmlzaW5nIGVkZ2UsIGV0Yy4NCg0KTWVhbmluZywgdGhl
IGNsb2NrIG11c3QgYmUgcmV2ZXJzZWQuDQo+IA0KPiA+ICsgICAgdHlwZTogYm9vbGVhbg0KPiA+
ICsNCj4gPiArICByZWFsdGVrLGRyaXZpbmctbGV2ZWw6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gPiArICAgICAgQ29udHJvbCB0aGUgbWFnbml0dWRlIG9mIEhpZ2ggc3BlZWQgRHAvRG0gb3V0
cHV0IHN3aW5nLg0KPiA+ICsgICAgICBGb3IgYSBkaWZmZXJlbnQgYm9hcmQgb3IgcG9ydCwgdGhl
IG9yaWdpbmFsIG1hZ25pdHVkZSBtYXliZSBub3QNCj4gbWVldA0KPiA+ICsgICAgICB0aGUgc3Bl
Y2lmaWNhdGlvbi4gSW4gdGhpcyBzaXR1YXRpb24gd2UgY2FuIGFkanVzdCB0aGUgdmFsdWUgdG8g
bWVldA0KPiA+ICsgICAgICB0aGUgc3BlY2lmaWNhdGlvbi4NCj4gDQo+IFdoYXQgYXJlIHRoZSB1
bml0cz8NCg0KVGhlcmUgaXMgbm8gdW5pdC4gSXQgaXMgb25seSBhIGdhaW4gZm9yIGFkanVzdGlu
ZyB0aGUgbWFnbml0dWRlLiANCg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZWZhdWx0OiA4DQo+ID4gKyAgICBtaW5pbXVt
OiAwDQo+ID4gKyAgICBtYXhpbXVtOiAzMQ0KPiA+ICsNCj4gPiArICByZWFsdGVrLGRyaXZpbmct
Y29tcGVuc2F0ZToNCj4gDQo+IGNvbXBlbnNhdGUgd2hhdD8NCg0KSXQgaXMgdG8gY29tcGVuc2F0
ZSB0aGUgZHJpdmluZyBsZXZlbC4gSW4gb3RoZXIgd29yZCwgdG8gYWRqdXN0IHRoZSBkcml2aW5n
IGxldmVsLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
