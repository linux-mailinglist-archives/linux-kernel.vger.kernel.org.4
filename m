Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68A727803
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjFHHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjFHHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:00:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE5268F;
        Thu,  8 Jun 2023 00:00:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3586wvonF021044, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3586wvonF021044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 14:58:57 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 8 Jun 2023 14:59:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Jun 2023 14:59:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 14:59:13 +0800
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
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Thread-Index: AQHZmQjR4Z6nmQOlk0qvgFcnmBMR/a9+tYIAgAGmBLA=
Date:   Thu, 8 Jun 2023 06:59:13 +0000
Message-ID: <8cb2d82c3b484262aa866c5e989fc8cd@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-2-stanley_chang@realtek.com>
 <79201bd6-6048-7013-aeb7-34d218139844@linaro.org>
In-Reply-To: <79201bd6-6048-7013-aeb7-34d218139844@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

SGkgS3J6eXN6dG9mLA0KDQoNCj4gSSBjb21tZW50ZWQgb24geW91ciBzZWNvbmQgcGF0Y2gsIGJ1
dCBldmVyeXRoaW5nIGlzIGFwcGxpY2FibGUgaGVyZSBhcyB3ZWxsLg0KPiBZb3UgaGF2ZSBtYW55
IHVzZWxlc3MgZGVidWcgbWVzc2FnZXMuIE1hbnkgaW5jb3JyZWN0IG9yIHVzZWxlc3MNCj4gImlm
KCkgcmV0dXJuIiB3aGljaCBwb2ludCB0byBicm9rZW4gZHJpdmVyIGRlc2lnbiAoZS5nLiBjb25j
dXJyZW50IGFjY2VzcyB0byBoYWxmDQo+IGluaXRpYWxpemVkIHN0cnVjdHVyZXMgd2hlcmUgeW91
IHN1YnN0aXR1dGUgbGFjayBvZiBzeW5jaHJvbml6YXRpb24gd2l0aA0KPiBpbmNvcnJlY3QgImlm
KCkgcmV0dXJuIikuIFVuZG9jdW1lbnRlZCB1c2VyIGludGVyZmFjZSBpcyBvbmUgbW9yZSBiaWcg
dHJvdWJsZS4NCj4gDQo+IEkgZG91YnQgeW91IHJ1biBjaGVja3BhdGNoIG9uIHRoaXMgKGJlIHN1
cmUgdG8gcnVuIGl0IHdpdGggLS1zdHJpY3QgYW5kIGZpeCBhbG1vc3QNCj4gZXZlcnl0aGluZyku
DQo+IA0KPiANCjEuIEkgdXNlIGNoZWNrcGF0Y2ggYnV0IHdpdGhvdXQgLS1zdHJpY3QuIEkgd2ls
bCBhZGQgaXQgYWRkIGFuZCBjaGVjayBhZ2Fpbi4NCjIuIERvIHRoZSBkZWJ1Z2ZzIGludGVyZmFj
ZXMgbmVlZCB0byBwcm92aWRlIGEgZG9jdW1lbnQ/DQpJIGRvbid0IGZpbmQgYW55IHJlZmVyZW5j
ZSBhYm91dCB0aGlzLg0KMy4gSSB3aWxsIGZvbGxvdyB0aGUgY29tbWVudCBvZiBzZWNvbmQgcGF0
Y2ggdG8gZml4IHRoaXMgcGF0Y2gNCg0KVGhhbmtzLA0KU3RhbmxleQ0K
