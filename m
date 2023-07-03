Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8C745679
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGCHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGCHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:53:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26AC8E49;
        Mon,  3 Jul 2023 00:53:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3637qGlmD004278, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3637qGlmD004278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Jul 2023 15:52:16 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 3 Jul 2023 15:52:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 15:52:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 3 Jul 2023 15:52:18 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
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
Thread-Index: AQHZqkz4ea6k1ChKgUmQ1oGFAHMAzq+hdqEAgAFUL4CAAFnygIAEbJGQ
Date:   Mon, 3 Jul 2023 07:52:17 +0000
Message-ID: <a2f481fb2cf04422919754ad34ee5adb@realtek.com>
References: <20230629054523.7519-1-stanley_chang@realtek.com>
 <20230629054523.7519-4-stanley_chang@realtek.com>
 <20230629164220.GA3146341-robh@kernel.org>
 <f17378f003144f4ba50ec08e0ad38c0b@realtek.com>
 <20230630-trowel-pleat-5312a869dda2@spud>
In-Reply-To: <20230630-trowel-pleat-5312a869dda2@spud>
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

SGkgQ29ub3IsDQoNCj4gT24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMDc6MzM6NDVBTSArMDAwMCwg
U3RhbmxleSBDaGFuZ1up96h8vHddIHdyb3RlOg0KPiA+IEhpIFJvYiwNCj4gPg0KPiA+ID4gT24g
VGh1LCBKdW4gMjksIDIwMjMgYXQgMDE6NDU6MTJQTSArMDgwMCwgU3RhbmxleSBDaGFuZyB3cm90
ZToNCj4gPiA+ID4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGV4cGxhaW4gdGhlIHByb3BlcnR5IGFi
b3V0IFJlYWx0ZWsgVVNCIFBIWSBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gSW4gdGhlIHN1YmplY3Qs
IGRyb3AgInRoZSBkb2MgYWJvdXQgdGhlIi4gSXQncyByZWR1bmRhbnQuIEFuZCBwZXJoYXBzIGFk
ZCAnREhDDQo+ID4gPiBSVEQgU29DJyBpZiB0aGlzIGlzbid0IGZvciAqYWxsKiBSZWFsdGVrIFNv
Q3MuDQo+ID4gPg0KPiA+ID4gPiBSZWFsdGVrIERIQyAoZGlnaXRhbCBob21lIGNlbnRlcikgUlRE
IFNvQ3Mgc3VwcG9ydCBEV0MzIFhIQ0kgVVNCDQo+ID4gPiA+IGNvbnRyb2xsZXIuIEFkZGVkIHRo
ZSBkcml2ZXIgdG8gZHJpdmUgdGhlIFVTQiAyLjAgUEhZIHRyYW5zY2VpdmVycy4NCj4gPiA+DQo+
ID4gPiBkcml2ZXI/IFRoaXMgaXMgYSBiaW5kaW5nIGZvciB0aGUgaC93Lg0KPiA+DQo+ID4gSSBt
ZWFuLCB0aGUgZHJpdmVyIGlzIGRyaXZlcnMvcGh5L3JlYWx0ZWsvcGh5LXJ0ay11c2IyLmMNCj4g
PiBJIHdpbGwgcmV2aXNlIGFzDQo+ID4gICAgIGR0LWJpbmRpbmdzOiBwaHk6IHJlYWx0ZWs6IEFk
ZCB0aGUgUmVhbHRlayBESEMgUlREIFNvQyBVU0IgMi4wIFBIWQ0KPiA+DQo+ID4gICAgIEFkZCB0
aGUgZG9jdW1lbnRhdGlvbiBleHBsYWluIHRoZSBwcm9wZXJ0eSBhYm91dCBSZWFsdGVrIFVTQiBQ
SFkgZHJpdmVyLg0KPiA+DQo+ID4gICAgIFJlYWx0ZWsgREhDIChkaWdpdGFsIGhvbWUgY2VudGVy
KSBSVEQgU29DcyBzdXBwb3J0IERXQzMgWEhDSSBVU0INCj4gPiAgICAgY29udHJvbGxlciBhbmQg
dXNlcyBwaHktcnRrLXVzYjIgYXMgZHJpdmVyIGZvciBVU0IgMi4wIFBIWSB0cmFuc2NlaXZlci4u
DQo+IA0KPiBObywgeW91IHNob3VsZCBtZW50aW9uIG5vdGhpbmcgdG8gZG8gd2l0aCBob3cgYSBw
YXJ0aWN1bGFyIG9wZXJhdGluZw0KPiBzeXN0ZW0gY2hvb3NlcyB0byBzdHJ1Y3R1cmUgaXRzIGNv
ZGUgaGVyZS4gQmluZGluZ3MgZGVzY3JpYmUgaGFyZHdhcmUsDQo+IGFuZCB0aGUgY29tbWl0IG1l
c3NhZ2Ugc2hvdWxkIHJlZmxlY3QgdGhhdC4NCg0KT2theS4gSSBzaG91bGQgcmVtb3ZlIGFueSBy
ZWxhdGVkIGRyaXZlciBkZXNjcmlwdGlvbi4NCkhlcmUsIG9ubHkgZGVzY3JpYmUgdGhlIGhhcmR3
YXJlIGFib3V0IFNvQ3MuDQpGb3IgZXhhbXBsZSwNCiAgICAgZHQtYmluZGluZ3M6IHBoeTogcmVh
bHRlazogQWRkIHRoZSBSZWFsdGVrIERIQyBSVEQgU29DIFVTQiAyLjAgUEhZDQogDQogICAgIERv
Y3VtZW50IHRoZSBVU0IgUEhZIGJpbmRpbmdzIGZvciBSZWFsdGVrIFNvQ3MuDQogICAgIFJlYWx0
ZWsgREhDIChkaWdpdGFsIGhvbWUgY2VudGVyKSBSVEQgU29DcyBzdXBwb3J0IERXQzMgWEhDSSBV
U0INCiAgICAgY29udHJvbGxlciBhbmQgdXNpbmcgVVNCIDIuMCBQSFkgdHJhbnNjZWl2ZXIuDQoN
Cj4gPg0KPiA+ID4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9waHkvcmVh
bHRlayx1c2IycGh5LnlhbWwjDQo+ID4gPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiA+ID4gKw0KPiA+ID4gPiArdGl0bGU6IFJl
YWx0ZWsgREhDIFNvQ3MgVVNCIDIuMCBQSFkNCj4gPiA+ID4gKw0KPiA+ID4gPiArbWFpbnRhaW5l
cnM6DQo+ID4gPiA+ICsgIC0gU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNv
bT4NCj4gPiA+ID4gKw0KPiA+ID4gPiArZGVzY3JpcHRpb246DQo+ID4gPg0KPiA+ID4gWW91IG5l
ZWQgJ3wnIGlmIGZvcm1hdHRpbmcgKGxpbmUgYnJlYWtzKSBhcmUgaW1wb3J0YW50Lg0KPiA+DQo+
ID4gSSB0aGluayBJIG5lZWQgaXQuIEkgd2lsbCBhZGQgaXQuDQo+ID4NCj4gPiA+ID4gKyAgcmVh
bHRlayxpbnZlcnNlLWhzdHgtc3luYy1jbG9jazoNCj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gPiA+ID4gKyAgICAgIEZvciBvbmUgb2YgdGhlIHBoeXMgb2YgUlREMTYxOWIgU29DLCB0aGUg
c3luY2hyb25vdXMgY2xvY2sgb2YgdGhlDQo+ID4gPiA+ICsgICAgICBoaWdoLXNwZWVkIHR4IG11
c3QgYmUgaW52ZXJ0ZWQuDQo+ID4gPg0KPiA+ID4gImludmVydCIgYXNzdW1lcyBJIGtub3cgd2hh
dCBub24taW52ZXJ0ZWQgbWVhbnMuIEkgZG8gbm90LiBCZXR0ZXIgdG8gc3RhdGUgaW4NCj4gPiA+
IHRlcm1zIG9mIGFjdGl2ZSBoaWdoLCBsb3csIGZhbGxpbmcgZWRnZSwgcmlzaW5nIGVkZ2UsIGV0
Yy4NCj4gPg0KPiA+IE1lYW5pbmcsIHRoZSBjbG9jayBtdXN0IGJlIHJldmVyc2VkLg0KPiANCj4g
TWF5YmUgdGhhdCBtZWFucyBzb21ldGhpbmcgdG8gUm9iLCBidXQgInJldmVyc2VkIiBkb2Vzbid0
IHNlZW0gYW55IG1vcmUNCj4gbWVhbmluZ2Z1bCB0aGFuIGludmVyc2UuIEkgYWdyZWUgdGhhdCBp
dCBzaG91bGQgYmUgZGVzY3JpYmVkIGluIHRlcm1zIG9mDQo+ICJhY3RpdmUgaGlnaCIgZXRjLCBh
cyB0aGV5IGhhdmUgd2VsbCB1bmRlcnN0b29kIG1lYW5pbmdzLg0KDQpIZXJlIEkgZGVzY3JpYmUg
YSBjbG9jayBzZXF1ZW5jZSBpcyAiaW52ZXJ0ZWQiLCBub3QgImhpZ2giIG9yICJsb3ciLg0KQWRk
IHRoZSBwcm9wZXJ0eSwgdGhlbiBoc3R4LXN5bmMtY2xvY2sgc2VxdWVuY2UgaXMgYmVpbmcgaW52
ZXJ0ZWQuDQoNCj4gPiA+ID4gKyAgICB0eXBlOiBib29sZWFuDQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgcmVhbHRlayxkcml2aW5nLWxldmVsOg0KPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+
ID4gPiArICAgICAgQ29udHJvbCB0aGUgbWFnbml0dWRlIG9mIEhpZ2ggc3BlZWQgRHAvRG0gb3V0
cHV0IHN3aW5nLg0KPiA+ID4gPiArICAgICAgRm9yIGEgZGlmZmVyZW50IGJvYXJkIG9yIHBvcnQs
IHRoZSBvcmlnaW5hbCBtYWduaXR1ZGUgbWF5YmUgbm90DQo+ID4gPiBtZWV0DQo+ID4gPiA+ICsg
ICAgICB0aGUgc3BlY2lmaWNhdGlvbi4gSW4gdGhpcyBzaXR1YXRpb24gd2UgY2FuIGFkanVzdCB0
aGUgdmFsdWUgdG8gbWVldA0KPiA+ID4gPiArICAgICAgdGhlIHNwZWNpZmljYXRpb24uDQo+ID4g
Pg0KPiA+ID4gV2hhdCBhcmUgdGhlIHVuaXRzPw0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gdW5pdC4g
SXQgaXMgb25seSBhIGdhaW4gZm9yIGFkanVzdGluZyB0aGUgbWFnbml0dWRlLg0KPiANCj4gR2Fp
biBoYXMgdW5pdHMgdG9vLg0KDQpUaGUgbWFnbml0dWRlIG9mIEhpZ2ggc3BlZWQgRHAvRG0gb3V0
cHV0IGlzIHZvbHRhZ2UuDQoNCj4gPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4gPiA+ID4gKyAgICBkZWZhdWx0OiA4DQo+ID4gPiA+ICsg
ICAgbWluaW11bTogMA0KPiA+ID4gPiArICAgIG1heGltdW06IDMxDQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgcmVhbHRlayxkcml2aW5nLWNvbXBlbnNhdGU6DQo+ID4gPg0KPiA+ID4gY29tcGVuc2F0
ZSB3aGF0Pw0KPiA+DQo+ID4gSXQgaXMgdG8gY29tcGVuc2F0ZSB0aGUgZHJpdmluZyBsZXZlbC4N
Cj4gDQo+IFNob3VsZCBpdCBiZSBjYWxsZWQgImRyaXZpbmctbGV2ZWwtY29tcGVuc2F0ZSIgdGhl
bj8NClllcywgaXQgY2FuIGJlIG5hbWVkICJkcml2aW5nLWxldmVsLWNvbXBlbnNhdGUiLg0KSSB3
aWxsIHJlbmFtZSBpdC4NCg0KPiA+IEluIG90aGVyIHdvcmQsIHRvIGFkanVzdCB0aGUgZHJpdmlu
ZyBsZXZlbC4NCj4gDQo+IFNvLCAicmVhbHRlayxkcml2aW5nLWxldmVsIiBzZXRzIHRoZSBnYWlu
IGFuZA0KPiAicmVhbHRlayxkcml2aW5nLWNvbXBlbnNhdGUiIGFkanVzdHMgdGhlIGRyaXZpbmcg
bGV2ZWwuDQo+IEJ5IHRoYXQgbG9naWMsIGlzIHRoaXMgYWxzbyBhIGdhaW4/DQoNClllcywgdGhl
IHJlYWwgZHJpdmluZyBsZXZlbCBpcw0KZHJpdmluZyBsZXZlbCAocmVhZGluZyBmcm9tIG90cCkg
KyBkcml2aW5nLWxldmVsLWNvbXBlbnNhdGUuDQoNCj4gQWxzbyB0aGlzIHByb3BlcnR5IGlzIG9u
bHkgZm9yIHRoZSBSVEQxMzE1ZT8gVGhhdCBzaG91bGQgYmUNCj4gZGVzY3JpYmVkIGluL2NvbnN0
cmFpbmVkIGJ5IHRoZSBiaW5kaW5nIGl0c2VsZiwgbm90IGluIHRoZSB0ZXh0DQo+IGRlc2NyaXB0
aW9uIGFsb25lIElNTy4NCj4gDQoNCkRvZXMgeW91ciBtZWFuaW5nIGlzIGFzIGZvbGxvd3M/DQpp
ZjoNCiAgcHJvcGVydGllczoNCiAgICBjb21wYXRpYmxlOg0KICAgICAgY29udGFpbnM6DQogICAg
ICAgIGVudW06DQogICAgICAgICAgLSByZWFsdGVrLHJ0ZDEzMTVlLXVzYjJwaHkNCnRoZW46DQog
IHByb3BlcnRpZXM6DQogICAgcmVhbHRlayxkcml2aW5nLWxldmVsLWNvbXBlbnNhdGU6DQogICAg
ICBkZXNjcmlwdGlvbjoNCiAgICAgICAgRm9yIFJURDEzMTVlIFNvQywgdGhlIGRyaXZpbmcgbGV2
ZWwgY2FuIGJlIGFkanVzdGVkIGJ5IHJlYWRpbmcgdGhlDQogICAgICAgIGVmdXNlIHRhYmxlLiBU
aGlzIHByb3BlcnR5IHByb3ZpZGVzIGRyaXZlIGNvbXBlbnNhdGlvbi4NCiAgICAgICAgSWYgdGhl
IG1hZ25pdHVkZSBvZiBIaWdoIHNwZWVkIERwL0RtIG91dHB1dCBzd2luZyBzdGlsbCBub3QgbWVl
dCB0aGUNCiAgICAgICAgc3BlY2lmaWNhdGlvbiwgdGhlbiB3ZSBjYW4gc2V0IHRoaXMgdmFsdWUg
dG8gbWVldCB0aGUgc3BlY2lmaWNhdGlvbi4NCiAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL2ludDMyDQogICAgICBkZWZhdWx0OiAwDQogICAgICBtaW5pbXVtOiAt
OA0KICAgICAgbWF4aW11bTogOA0KDQpUaGFua3MsDQpTdGFubGV5DQo=
