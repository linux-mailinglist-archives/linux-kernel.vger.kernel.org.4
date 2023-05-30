Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE471573A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjE3Hka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjE3HjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:39:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A16E61;
        Tue, 30 May 2023 00:38:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U7bFpB5027626, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U7bFpB5027626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 15:37:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 30 May 2023 15:37:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 May 2023 15:37:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 30 May 2023 15:37:28 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ray Chi <raychi@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v2 2/3] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0/3.0 PHY
Thread-Index: AQHZjrBQ+6WcWUIIakaazG2RI9C3Xq9wz12AgAFERBD//9p/AIAAhrWA
Date:   Tue, 30 May 2023 07:37:28 +0000
Message-ID: <9b64905acd2a4d97ad0b4535d8b868b9@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-2-stanley_chang@realtek.com>
 <2023052915-repurpose-partner-20a8@gregkh>
 <1dfa6d4026364fb99eeffa548cda0cfc@realtek.com>
 <2023053041-cane-jokester-d433@gregkh>
In-Reply-To: <2023053041-cane-jokester-d433@gregkh>
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

SGkgR3JlZywNCg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5n
IDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+ID4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gVGhlIGtlcm5lbCB0ZXN0
IHJvYm90IGRpZCBub3QgcmVwb3J0IHRoYXQgYSBuZXcgZHJpdmVyIHdhcyBuZWVkZWQgOigNCj4g
PiA+DQo+ID4NCj4gPiBUaGlzIHJlcG9ydCBpcyBiYXNlZCBvbiB2MSBwYXRjaC4NCj4gPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtdXNiL3BhdGNoLzIwMjMwNTE5
MDQ1ODI1LjI4DQo+ID4gMzY5LTItc3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbS8NCj4gPg0KPiA+
IFRoZSBvcmlnaW5hbCBkcml2ZXIgaXMgYXQgZHJpdmVycy91c2IvcGh5LyBJZiB0aGlzIHJlcG9y
dCBpcyBub3QNCj4gPiBhcHByb3ByaWF0ZSwgSSB3aWxsIHJlbW92ZSBpdC4NCj4gDQo+IERvZXMg
aXQgbWFrZSBzZW5zZSB0byBpbmNsdWRlIGl0Pw0KDQpJIGhhdmUgZml4ZWQgdGhlIHNhbWUgZXJy
b3JzIGluIHYyIGFzIHYxLiBTbyBJIGFkZGVkIGl0Lg0KSSB3aWxsIHJlbW92ZSBpdCBhdCBuZXh0
IHZlcnNpb24uDQoNClRoYW5rcywNClN0YW5sZXkNCg==
