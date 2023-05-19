Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A538A709549
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjESKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjESKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:43:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80FE73;
        Fri, 19 May 2023 03:43:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34JAepgaF004218, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34JAepgaF004218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 18:40:51 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 19 May 2023 18:41:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 May 2023 18:41:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 19 May 2023 18:41:00 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB
 2.0/3.0 PHY
Thread-Index: AQHZig6UEIendKXQakm8Ocfv4iAbD69gnCqAgADEzlA=
Date:   Fri, 19 May 2023 10:40:59 +0000
Message-ID: <6b415b1157ca4724a6e94657dff918b2@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
 <ed53d7d6-78e7-45af-a441-1c87fba4d420@app.fastmail.com>
In-Reply-To: <ed53d7d6-78e7-45af-a441-1c87fba4d420@app.fastmail.com>
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

SGkgQXJuZCwNCg0KPiA+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4gKyAgICAgc3RydWN0
IGRlbnRyeSAqZGVidWdfZGlyOw0KPiA+ICsjZW5kaWYNCj4gPiArfTsNCj4gDQo+IEknZCBhdm9p
ZCB0aGUgI2lmZGVmcyBoZXJlIGFuZCBqdXN0IGxlYXZlIHRoZSBkZWJ1Z2ZzIGNvZGUgaW4gdW5j
b25kaXRpb25hbGx5IGluDQo+IGZhdm9yIG9mIHJlYWRhYmlsaXR5LiBXaGVuIGRlYnVnZnMgaXMg
ZGlzYWJsZWQsIGV2ZXJ5dGhpbmcgZXhjZXB0IGZvciB0aGUgb25lDQo+IHBvaW50ZXIgdmFsdWUg
c2hvdWxkIGdldCBvcHRpbWl6ZWQgb3V0Lg0KDQpJIHdpbGwgcmVtb3ZlIHRoaXMgI2lmZGVmLg0K
DQo+ID4gKyNkZWZpbmUgcGh5X3JlYWQoYWRkcikgX19yYXdfcmVhZGwoYWRkcikgI2RlZmluZSBw
aHlfd3JpdGUoYWRkciwgdmFsKQ0KPiA+ICtkbyB7IFwNCj4gPiArICAgICAvKiBEbyBzbXBfd21i
ICovIFwNCj4gPiArICAgICBzbXBfd21iKCk7IF9fcmF3X3dyaXRlbCh2YWwsIGFkZHIpOyBcIH0g
d2hpbGUgKDApDQo+IA0KPiBVc2luZyBfX3Jhd19yZWFkbCgpL19fcmF3X3dyaXRlbCgpIGluIGEg
ZHJpdmVyIGlzIGFsbW9zdCBuZXZlciB0aGUgcmlnaHQNCj4gaW50ZXJmYWNlLCBpdCBkb2VzIG5v
dCBndWFyYW50ZWUgYXRvbWljaXR5IG9mIHRoZSBhY2Nlc3MsIGhhcyB0aGUgd3JvbmcNCj4gYnl0
ZS1vcmRlciBvbiBiaWctZW5kaWFuIGtlcm5lbHMgYW5kIG1pc3NlcyB0aGUgYmFycmllcnMgdG8g
c2VyaWFsaXplIGFnYWluc3QNCj4gRE1BIGFjY2Vzc2VzLiBzbXBfd21iKCkgc2hvdWxkIGhhdmUg
bm8gZWZmZWN0IGhlcmUgc2luY2UgdGhpcyBvbmx5IHNlcmlhbGl6ZXMNCj4gYWNjZXNzIHRvIG1l
bW9yeSBhZ2FpbnN0IGFub3RoZXIgQ1BVIGlmIGl0J3MgcGFpcmVkIHdpdGggYW4gc21wX3JtYigp
LCBidXQNCj4gbm90IG9uIE1NSU8gcmVnaXN0ZXJzLg0KDQpJIHdpbGwgdHJ5IHVzaW5nIHJlYWRs
L3dyaXRlbCBkaXJlY3RseS4NCg0KPiA+ICsjZGVmaW5lIFBIWV9JT19USU1FT1VUX01TRUMgICAg
ICAgICAgKDUwKQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBpbnQgdXRtaV93YWl0X3JlZ2lz
dGVyKHZvaWQgX19pb21lbSAqcmVnLCB1MzIgbWFzaywgdTMyDQo+ID4gcmVzdWx0KQ0KPiA+ICt7
DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQo+ID4gbXNlY3Nf
dG9famlmZmllcyhQSFlfSU9fVElNRU9VVF9NU0VDKTsNCj4gPiArDQo+ID4gKyAgICAgd2hpbGUg
KHRpbWVfYmVmb3JlKGppZmZpZXMsIHRpbWVvdXQpKSB7DQo+ID4gKyAgICAgICAgICAgICAvKiBE
byBzbXBfcm1iICovDQo+ID4gKyAgICAgICAgICAgICBzbXBfcm1iKCk7DQo+ID4gKyAgICAgICAg
ICAgICBpZiAoKHBoeV9yZWFkKHJlZykgJiBtYXNrKSA9PSByZXN1bHQpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsgICAgICAgICAgICAgdWRlbGF5KDEwMCk7DQo+
ID4gKyAgICAgfQ0KPiA+ICsgICAgIHByX2VycigiXDAzM1swOzMyOzMxbSBjYW4ndCBwcm9ncmFt
IFVTQiBwaHkgXDAzM1ttXG4iKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIC1FVElNRURPVVQ7
DQo+ID4gK30NCj4gDQo+IFRoaXMgc2hvdWxkIGp1c3QgdXNlIHJlYWRfcG9sbF90aW1lb3V0KCkg
b3IgcG9zc2libHkNCj4gcmVhZF9wb2xsX3RpbWVvdXRfYXRvbWljKCksIGJ1dCBub3QgYW4gb3Bl
bi1jb2RlZCB2ZXJzaW9uLg0KPiANCkkndmUgdHJpZWQgdXNpbmcgcmVhZF9wb2xsX3RpbWVvdXQo
KSBpbnN0ZWFkIGFuZCBpdCB3b3Jrcy4NCg0KPiBJIGRvbid0IHRoaW5rIEkndmUgc2VlbiBlc2Nh
cGUgc2VxdWVuY2VzIGluIGEgcHJpbnRrIGluIGFueSBvdGhlciBkcml2ZXIsIHNvDQo+IHBsZWFz
ZSBkb24ndCBzdGFydCB0aGF0IG5vdy4NCg0KT2theS4gSSB3aWxsIHJlbW92ZSBpdC4NCg0KPiA+
ICsjZGVmaW5lIERFRkFVTFRfQ0hJUF9SRVZJU0lPTiAweEEwMA0KPiA+ICsjZGVmaW5lIE1BWF9D
SElQX1JFVklTSU9OIDB4QzAwDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBfX2dldF9j
aGlwX3JldmlzaW9uKHZvaWQpIHsNCj4gPiArICAgICBpbnQgY2hpcF9yZXZpc2lvbiA9IDB4RkZG
Ow0KPiA+ICsgICAgIGNoYXIgcmV2aXNpb25bXSA9ICJGRkYiOw0KPiA+ICsgICAgIHN0cnVjdCBz
b2NfZGV2aWNlX2F0dHJpYnV0ZSBzb2NfYXR0W10gPSB7ey5yZXZpc2lvbiA9IHJldmlzaW9ufSwN
Cj4gPiAre319Ow0KPiANCj4gWW91IHNob3VsZCBwcm9iYWJseSBjaGVjayB0aGF0IHlvdSBhcmUg
YWN0dWFsbHkgb24gdGhlIHJpZ2h0IFNvQyB0eXBlIGhlcmUgYXMNCj4gd2VsbCwgbm90IGp1c3Qg
dGhlIHJpZ2h0IHJldmlzaW9uIG9mIGFuIGFyYml0cmFyeSBjaGlwLg0KPiANCj4gSWRlYWxseSBJ
IHRoaW5rIHRoZSByZXZpc2lvbiBjaGVjayBzaG91bGQgYmUgYmFzZWQgb2ZmIGEgRFQgcHJvcG9y
dHkgaWYgdGhhdCdzDQo+IHBvc3NpYmxlLCBzbyB5b3UgY2FuIGhhdmUgdGhpcyBjb2RlIGluIHRo
ZSBib290IGxvYWRlci4NCg0KSW4gdGhpcyBjYXNlIEkganVzdCBjYXJlIGluIHRoZSBjaGlwIHZl
cnNpb24gbnVtYmVyLg0KQmVjYXVzZSB0aGUgcmV2aXNpb24gbnVtYmVyIGlzIG5vdCByZWNvcmRl
ZCBpbiB0aGUgRFRCLg0KDQo+ID4gKyNkZWZpbmUgUlRLX1VTQjJQSFlfTkFNRSAicnRrLXVzYjJw
aHkiDQo+IA0KPiBCZXR0ZXIgYXZvaWQgaGlkaW5nIHRoZSBkcml2ZXIgbmFtZSBsaWtlIHRoaXMs
IGl0IG1ha2VzIGl0IGhhcmRlciB0byBncmVwIHRoZQ0KPiBzb3VyY2UgdHJlZSBmb3IgcGFydGlj
dWxhciBkcml2ZXIgbmFtZXMuDQoNCkkgd2lsbCByZW1vdmUgdGhpcyBjb2Rpbmcgc3R5bGUuDQoN
Cj4gPiArICAgICAvKiBybWIgZm9yIHJlZyByZWFkICovDQo+ID4gKyAgICAgc21wX3JtYigpOw0K
PiA+ICsgICAgIHJlZ1ZhbCA9IHBoeV9yZWFkKHJlZ19ndXNiMnBoeWFjYzApOw0KPiANCj4gSSB3
b3VsZCBleHBlY3QgdGhhdCB5b3UgZG9uJ3QgbmVlZCBiYXJyaWVycyBsaWtlIHRoaXMsIGVzcGVj
aWFsbHkgaWYgeW91IGNoYW5nZQ0KPiB0aGUgcGh5X3JlYWQoKSBoZWxwZXIgdG8gdXNlIHRoZSBw
cm9wZXIgcmVhZGwoKS4NCj4gDQo+IElmIHlvdSBkbyBuZWVkIHRvIHNlcmlhbGl6ZSBhZ2FpbnN0
IG90aGVyIENQVXMsIHN0aWxsLCB0aGVyZSBzaG91bGQgYmUgYSBsb25nZXINCj4gZXhwbGFuYXRp
b24gYWJvdXQgdGhhdCwgc2luY2UgaXQncyBzbyB1bmV4cGVjdGVkLg0KDQpJIHdpbGwgdXNlIHJl
YWRsIHRvIGluc3RlYWQgdGhlIHBoeV9yZWFkIGFuZCByZW1vdmUgc21wX3JtYi4NCg0KPiA+ICsN
Cj4gPiArc3RhdGljIHZvaWQgZG9fcnRrX3VzYjJfcGh5X3RvZ2dsZShzdHJ1Y3QgcnRrX3VzYl9w
aHkgKnJ0a19waHksDQo+ID4gKyAgICAgICAgIGludCBpbmRleCwgYm9vbCBpc0Nvbm5lY3QpOw0K
PiANCj4gSXQncyBiZXN0IHRvIHNvcnQgeW91ciBmdW5jdGlvbiBkZWZpbml0aW9ucyBpbiBhIHdh
eSB0aGF0IGF2b2lkcyBmb3J3YXJkDQo+IGRlY2xhcmF0aW9ucy4gVGhpcyBtYWtlcyBpdCBlYXNp
ZXIgdG8gcmVhZCBhbmQgc2hvd3MgdGhhdCB0aGVyZSBhcmUgbm8gb2J2aW91cw0KPiByZWN1cnNp
b25zIGluIHRoZSBzb3VyY2UuIElmIHlvdSBkbyBoYXZlIGFuIGludGVudGlvbmFsIHJlY3Vyc2lv
biwgbWFrZSBzdXJlIHRoYXQNCj4gdGhlcmUgaXMgYSB3YXkgdG8gcHJldmVudCB1bmJvdW5kZWQg
c3RhY2sgdXNhZ2UsIGFuZCBleHBsYWluIHRoYXQgaW4gYQ0KPiBjb21tZW50Lg0KDQpPaywgSSds
bCBtb3ZlIHRoaXMgZnVuY3Rpb24gdG8ganVzdCBiZWZvcmUgdGhlIGZpcnN0IHVzZS4NCg0KDQo+
ID4gKyAgICAgcmVnQWRkciA9ICYoKHN0cnVjdCByZWdfYWRkciAqKXJ0a19waHktPnJlZ19hZGRy
KVtpbmRleF07DQo+ID4gKyAgICAgcGh5X2RhdGEgPSAmKChzdHJ1Y3QgcGh5X2RhdGEgKilydGtf
cGh5LT5waHlfZGF0YSlbaW5kZXhdOw0KDQo+IFdoeSBkbyB5b3UgbmVlZCB0aGUgY2FzdHMgaGVy
ZT8gSXQgbG9va3MgbGlrZSByZWdBZGRyIHNob3VsZCBiZSBhbiBfX2lvbWVtDQo+IHBvaW50ZXIu
IFBsZWFzZSBidWlsZCB5b3VyIGRyaXZlciB3aXRoICdtYWtlIEM9MScNCj4gdG8gc2VlIGlmIHRo
ZXJlIGFyZSBhbnkgaW5jb3JyZWN0IGFkZHJlc3Mgc3BhY2UgYW5ub3RhdGlvbnMuDQoNCkkgZGVm
aW5lIG1lbWJlciByZWdfYWRkciBhcw0Kdm9pZCAqcmVnX2FkZHINClNvIEkgaGF2ZSB0byBjb252
ZXJ0IGl0IHRvICJzdHJ1Y3QgcmVnX2FkZHIiIGFuZCB1c2UgaXQgYXMgYXJyYXkuDQpBbmQgSSBy
YW4gIm1ha2UgQz0xIiB3aXRoIG5vIGVycm9yIG9yIHdhcm5pbmcuDQoNCj4gPiArc3RhdGljIGlu
dCBfX2dldF9waHlfcGFyYW1ldGVyX2J5X2VmdXNlKHN0cnVjdCBydGtfdXNiX3BoeSAqcnRrX3Bo
eSwNCj4gPiArICAgICAgICAgc3RydWN0IHBoeV9kYXRhICpwaHlfZGF0YSwgaW50IGluZGV4KSB7
DQo+ID4gKyAgICAgdTggdmFsdWUgPSAwOw0KPiA+ICsgICAgIHN0cnVjdCBudm1lbV9jZWxsICpj
ZWxsOw0KPiA+ICsgICAgIHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSBydGtfc29jX2dyb290
W10gPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHsgLmZhbWlseSA9ICJSZWFsdGVrIEdy
b290Iix9LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC8qIGVtcHR5ICovIH0NCj4gPiAr
ICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlIHJ0
a19zb2NfaGFua1tdID0gew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC5mYW1pbHkgPSAi
UmVhbHRlayBIYW5rIix9LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC8qIGVtcHR5ICov
IH0NCj4gPiArICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgc3RydWN0IHNvY19kZXZpY2VfYXR0
cmlidXRlIHJ0a19zb2NfZWZ1c2VfdjFbXSA9IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
eyAuZmFtaWx5ID0gIlJlYWx0ZWsgUGhvZW5peCIsfSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgeyAuZmFtaWx5ID0gIlJlYWx0ZWsgS3lsaW4iLH0sDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHsgLmZhbWlseSA9ICJSZWFsdGVrIEhlcmN1bGVzIix9LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB7IC5mYW1pbHkgPSAiUmVhbHRlayBUaG9yIix9LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB7IC5mYW1pbHkgPSAiUmVhbHRlayBIYW5rIix9LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB7IC5mYW1pbHkgPSAiUmVhbHRlayBHcm9vdCIsfSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgeyAuZmFtaWx5ID0gIlJlYWx0ZWsgU3RhcmsiLH0sDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHsgLmZhbWlseSA9ICJSZWFsdGVrIFBhcmtlciIsfSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgeyAvKiBlbXB0eSAqLyB9DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiA+ICsg
ICAgIHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSBydGtfc29jX2Rpc19sZXZlbF9hdF9wYWdl
MFtdID0gew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC5mYW1pbHkgPSAiUmVhbHRlayBQ
aG9lbml4Iix9LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC5mYW1pbHkgPSAiUmVhbHRl
ayBLeWxpbiIsfSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgeyAuZmFtaWx5ID0gIlJlYWx0
ZWsgSGVyY3VsZXMiLH0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHsgLmZhbWlseSA9ICJS
ZWFsdGVrIFRob3IiLH0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHsgLmZhbWlseSA9ICJS
ZWFsdGVrIEhhbmsiLH0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHsgLmZhbWlseSA9ICJS
ZWFsdGVrIEdyb290Iix9LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB7IC8qIGVtcHR5ICov
IH0NCj4gPiArICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgIGlmIChzb2NfZGV2aWNl
X21hdGNoKHJ0a19zb2NfZWZ1c2VfdjEpKSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZGJnKHJ0
a19waHktPmRldiwgIlVzZSBlZnVzZSB2MSB0byB1cGRhdGVkIHBoeQ0KPiBwYXJhbWV0ZXJcbiIp
Ow0KPiA+ICsgICAgICAgICAgICAgcGh5X2RhdGEtPmNoZWNrX2VmdXNlX3ZlcnNpb24gPSBDSEVD
S19FRlVTRV9WMTsNCj4gDQo+IEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5
aW5nIHRvIGRvIGhlcmUsIGJ1dCBpdCBsb29rcyB0aGUgcHVycG9zZSBpcw0KPiB0byB0ZWxsIHRo
ZSBkaWZmZXJlbmNlIGJldHdlZW4gaW1wbGVtZW50YXRpb25zIG9mIHRoZSBwaHkgZGV2aWNlIGJ5
IGxvb2tpbmcgYXQNCj4gd2hpY2ggU29DIGl0J3MgaW4uIFlvdSBzaG91bGQgb25seSBuZWVkIHRo
YXQgdmVyeSByYXJlbHkgd2hlbiB0aGlzIGluZm9ybWF0aW9uDQo+IGNhbm5vdCBiZSBwYXNzZWQg
dGhyb3VnaCB0aGUgRFQsIGJ1dCB5b3UgbGl0ZXJhbGx5IGFscmVhZHkgaGF2ZSB0aGUgcGVyLVNv
Qw0KPiBjb21wYXRpYmxlIHN0cmluZ3MgYmVsb3csIHNvIGp1c3QgdXNlIHRob3NlLCBvciBhZGQg
b3RoZXIgRFQgcHJvcGVydGllcyBpbiB0aGUNCj4gYmluZGluZyBmb3Igc3BlY2lmaWMgcXVpcmtz
IG9yIGNhcGFiaWxpdGllcy4NCg0KTXkgcHVycG9zZSBpcyB0byBqdWRnZSBkaWZmZXJlbnQgU29D
cyBhbmQgc2V0IGRpZmZlcmVudCBwYXJhbWV0ZXJzLg0KVGhlIERUUyBwcm9wZXJ0eSBtaWdodCBi
ZSBhIGdvb2Qgd2F5IHRvIGdvLCBJJ2xsIGNoZWNrIHRvIHNlZSBpZiBpdCdzIGEgZ29vZCBmaXQu
DQoNCj4gUmVtb3ZlIHRoYXQgb2ZfbWF0Y2hfcHRyKCkgYW5kIGlmZGVmIENPTkZJR19PRiBjaGVj
ayBoZXJlLCBuZXcgZHJpdmVycw0KPiBzaG91bGQgbm8gbG9uZ2VyIHVzZSBzdGF0aWMgcGxhdGZv
cm0gZGV2aWNlIGRlZmluaXRpb25zIGFuZCBqdXN0IGFzc3VtZSB0aGF0DQo+IENPTkZJR19PRiBp
cyB1c2VkLg0KPiANCk9rLCBJIHdpbGwgcmVtb3ZlIGl0Lg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
