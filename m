Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402E70A5A3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjETFTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETFTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:19:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9CB1B0;
        Fri, 19 May 2023 22:19:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34K5ILO00007046, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34K5ILO00007046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 20 May 2023 13:18:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 20 May 2023 13:18:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 20 May 2023 13:18:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 20 May 2023 13:18:30 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHZig6UEIendKXQakm8Ocfv4iAbD69gulMAgACuYvD//3+eAIAAb2SAgAFHdSA=
Date:   Sat, 20 May 2023 05:18:30 +0000
Message-ID: <1b32419b8024407298e9bb5f33d3d47b@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
 <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
 <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
 <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
 <ZGe0f4OfaXzweSp3@matsya>
In-Reply-To: <ZGe0f4OfaXzweSp3@matsya>
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

SGkgVmlub2QsDQoNCj4gVGhlIGlzIGNvcnJlY3QsIHBoeSBpbnRlcmZhY2VzIGNhbiBiZSBpbXBy
b3ZlZCB1cG9uIGFuZCBoYXZlIGJlZW4gYWRkZWQNCj4gdXBvbiBhcyBhbmQgd2hlbiB3ZSBoYXZl
IHVzZXJzLg0KPiANCj4gRldJVyB0aGVyZSBhcmUgYWxyZWFkeSB1c2IgcGh5IGRyaXZlcnMgaW4g
R2VuZXJpYyBwaHkgc3VzYnlzdGVtLCBzbyB5b3UgbmVlZA0KPiB0byByZWFsbHkganVzdGlmeSB3
aHkgeW91IG5lZWQgYSBuZXcgaW50ZXJmYWNlPw0KPiANCg0KSSB3aWxsIHJlZmVyZW5jZSB0aGUg
dXMgcGh5IGRyaXZlcnMgaW4gZHJpdmVycy9waHkuDQpJcyB1c2luZyB1c2IgcGh5IGluIGRyaXZl
cnMvcGh5IHRoZSByaWdodCBjaG9pY2U/DQpBcyB0aGUgZm9sbG93aW5nIGFzOg0KZHJpdmVycy9w
aHkvdGkvcGh5LXR3bDQwMzAtdXNiLmMNCmRyaXZlcnMvcGh5L3RpL3BoeS1vbWFwLXVzYjIuYw0K
ZHJpdmVycy9waHkvdGkvcGh5LWRtODE2eC11c2IuYw0KZHJpdmVycy9waHkvcGh5LWxnbS11c2Iu
Yw0KZHJpdmVycy9waHkvdGVncmEveHVzYi5jDQpkcml2ZXJzL3BoeS9tb3Rvcm9sYS9waHktY3Bj
YXAtdXNiLmMNCg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo=
