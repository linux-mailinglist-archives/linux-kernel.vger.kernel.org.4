Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1452D70A59C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjETFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjETFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:13:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84711F;
        Fri, 19 May 2023 22:13:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34K5Ae7A2003673, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34K5Ae7A2003673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 20 May 2023 13:10:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 20 May 2023 13:10:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 20 May 2023 13:10:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 20 May 2023 13:10:49 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
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
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB
 2.0/3.0 PHY
Thread-Index: AQHZig6UEIendKXQakm8Ocfv4iAbD69gulMAgACuYvD//3+eAIABtHCQ
Date:   Sat, 20 May 2023 05:10:49 +0000
Message-ID: <520a2595716d47359812dab8ad110f21@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
 <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
 <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
 <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
In-Reply-To: <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

SGkgQXJuZCwNCg0KPiA+PiBJJ20gcHJldHR5IHN1cmUgdGhhdCBkcml2ZXJzL3VzYi9waHkvIGlz
IGRlcHJlY2F0ZWQgbm93Li4uDQo+ID4+DQo+ID4+IE5ldyBkcml2ZXJzIHNob3VsZCBiZSB3cml0
dGVuIGZvciB0aGUgZ2VuZXJpYyBQSFkgc3Vic3lzdGVtIGluDQo+ID4+IGRyaXZlcnMvcGh5Ly4N
Cj4gDQo+IEluZGVlZCwgSSBtaXNzZWQgdGhhdCBpbiBteSByZXZpZXcuDQo+IA0KPiA+IFRoYW5r
cyBmb3IgeW91ciByZW1pbmRlci4NCj4gPiBXaWxsIGRyaXZlcnMvdXNiL3BoeSBiZSByZW1vdmVk
Pw0KPiA+IElzIGl0IG5vdCBhbGxvd2VkIHRvIGFkZCBuZXcgZHJpdmVycz8NCj4gPg0KPiA+IElu
IG91ciBhcHBsaWNhdGlvbiwgZHJpdmVyL3BoeSBpcyBub3Qgc3VpdGFibGUuDQo+ID4gV2UgbmVl
ZCB0byBub3RpZnkgdGhlIHBoeSBkcml2ZXIgd2hlbiB0aGUgVVNCIGh1YiBwb3J0IHN0YXR1cyBj
aGFuZ2VzLg0KPiA+IEhvd2V2ZXIsIGdlbmVyaWMgUEhZIGRyaXZlcnMgYXJlIGRlc2lnbmVkIGZv
ciB2YXJpb3VzIGRldmljZSdzIFBIWS4NCj4gPiBBbmQgaXQgc2VlbXMgaW5hcHByb3ByaWF0ZSB0
byBhZGQgdGhpcyBmdW5jdGlvbi4gU28gd2UgY2hvb3NlIHRvIHVzZQ0KPiA+IGRyaXZlci91c2Iv
cGh5Lg0KPiANCj4gSWYgeW91IHJ1biBpbnRvIHNvbWV0aGluZyB0aGF0IHdvcmtzIGluIHRoZSBv
bGQgdXNicGh5IGxheWVyIGJ1dCBjYW4ndCBiZSBkb25lDQo+IGluIGRyaXZlcnMvcGh5LCBJIHRo
aW5rIHRoZSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8gY2hhbmdlIHRoZSBkcml2ZXJzL3Bo
eS8NCj4gY29kZSB0byBhZGQgdGhpcy4NCj4gDQo+ICAgICAgIEFybmQNCj4gDQoNCkkgd291bGQg
bW92ZSB0aGUgY29kZSB0byBkcml2ZXJzL3BoeS4NCkNhbiBJIHVzZSB0aGUgInN0cnVjdCB1c2Jf
cGh5IiBpbnRlcmZhY2UgYWZ0ZXIgYWRkaW5nIHRoZSBjb2RlIHRvIHRoZSBkcml2ZXIvcGh5Pw0K
DQpJIGZvdW5kIHRoYXQgc29tZSBkcml2ZXJzIHVzZSAidXNiX3BoeSIgaW4gZGVpdmVycy9waHkv
Lg0KQ2FuIEkgZm9sbG93IHRoZXNlIGRyaXZlcnM/DQoNClRoYW5rcywNClN0YW5sZXkNCg==
