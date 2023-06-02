Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25B171F8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFBDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjFBDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:21:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06CC136;
        Thu,  1 Jun 2023 20:21:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3523JoxsE028351, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3523JoxsE028351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 11:19:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 11:20:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Jun 2023 11:20:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 2 Jun 2023 11:20:04 +0800
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
Thread-Index: AQHZjrBYcJlLsVj/HkuHUZRifSysgq90OEaAgAGJYxD//9d+gIABRKMg
Date:   Fri, 2 Jun 2023 03:20:04 +0000
Message-ID: <f53b5c21247c49db8be7071de36c773b@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
 <ee65a9d6d40d4099987db5ff1ad1753f@realtek.com>
 <c49f5619-286c-fbb7-0f18-5869527081c8@linaro.org>
In-Reply-To: <c49f5619-286c-fbb7-0f18-5869527081c8@linaro.org>
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

SGkgS3J6eXN6dG9mLA0KDQo+ID4NCj4gPiBNb3N0IG9mIHRoZSBwcm9wZXJ0aWVzIGFyZSBhYm91
dCB0aGUgcGh5IHBhcmFtZXRlcnMuDQo+ID4gSXMgdGhlIHBoeSBwYXJhbWV0ZXIgZGF0YSBzdWl0
YWJsZSB0byBiZSBwbGFjZWQgaW4gRFRTPw0KPiA+IEkgcmVmZXJlbmNlZCBvdGhlciBwaHkgZHJp
dmVycy4NCj4gPiBUaGVzZSBwYXJhbWV0ZXJzIHNob3VsZCBub3QgYmUgZGVmaW5lZCBpbiBkdHMu
DQo+ID4gSSB3b3VsZCBtb3ZlIHRoZSBwYXJhbWV0ZXJzIHRvIHRoZSBkcml2ZXIuDQo+IA0KPiBJ
ZiB0aGVzZSBjYW4gYmUgaW4gdGhlIGRyaXZlciwgd2h5IHdvdWxkIGV2ZXIgdGhleSBiZSBpbiBE
VFMgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPiANCk91ciBwbGF0Zm9ybXMgaGF2ZSAzIHhoY2kgY29u
dHJvbGxlcnMgd2hpY2ggbWFwIHRvIDMgZGlmZmVyZW50IHBoeSBwb3J0cy4NCkFuZCB0aGUgdGhy
ZWUgcGh5IHBvcnRzIHVzZSB0aGUgc2FtZSBkcml2ZXIsIGJ1dCB0aGUgcGFyYW1ldGVycyBhcmUg
ZGlmZmVyZW50Lg0KU28gSSBwdXQgdGhlIHBhcmFtZXRlciBzZXR0aW5ncyBpbiBEVFMsIHdlIGhh
dmUgMyB1c2ItcGh5IG5vZGVzIHJlcHJlc2VudGluZyAzIHBoeSBwb3J0cy4NCkFsc28sIHNvbWUg
cGFyYW1ldGVycyBoYXZlIHRvIGJlIGFkanVzdGVkIGZvciBkaWZmZXJlbnQgYm9hcmRzLg0KVGhl
cmVmb3JlLCBpdCBpcyBtb3JlIGFwcGxpY2FibGUgaW4gRFRTIHRoYW4gaW4gZHJpdmVyLg0KDQo+
ID4+PiArICByZWFsdGVrLHVzYjoNCj4gPj4+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxl
ciBvZiByZWFsdGVrIGR3YzMgbm9kZQ0KPiA+Pg0KPiA+PiAicGhhbmRsZXIiPyBFeGNlcHQgb2J2
aW91cyB0eXBvLCBkcm9wICJUaGUgcGhhbmRsZXIgb2YiIGFuZCBkZXNjcmliZQ0KPiA+PiB3aGF0
IGlzIGl0IGZvci4NCj4gPg0KPiA+IHJlYWx0ZWssdXNiIGlzIGEgcGhhbmRsZSBvZiBzeXNjb24g
dXNlZCB0byBjb250cm9sIHJlYWx0ZWsgZHdjMyByZWdpc3Rlci4NCj4gDQo+IFRoZW4gbm8sIHBo
eSBzaG91bGQgbm90IGNvbnRyb2wgZHdjMy4NCg0KT0sgSSBrbm93IGl0IGRvZXNuJ3QgbWFrZSBz
ZW5zZS4NCldlIHdhbnQgdG8gZGlzYWJsZSBwaHkgc3VzcGVuZCBmcm9tIG1hYyBsYXllci4NCkkg
d2lsbCB0cnkgb3RoZXIgbWV0aG9kLg0KDQo+ID4NCj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+Pg0KPiA+PiBBbnl3YXksIGl0IHNo
b3VsZG4ndCBiZSBoZXJlLiBObywgbm8uDQo+ID4NCj4gPiBDYW4gSSB1c2UgaXQgZm9yIHBoYW5k
bGUgb2Ygc3lzY29uPw0KPiANCj4gUEhZIGdldHRpbmcgcGhhbmRsZSB0byBibG9jayB1c2luZyB0
aGlzIFBIWT8gTG9va3Mgd3JvbmcuIFdoeSB3b3VsZCBQSFkNCj4gbmVlZCB0byBwb2tlIElQIGJs
b2NrIHJlZ2lzdGVyPw0KPiANCg0KT0suIEkga25vdyBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UuDQo=
