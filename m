Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4F715311
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjE3Bw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE3BwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:52:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37DE5;
        Mon, 29 May 2023 18:52:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U1odtwF008068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U1odtwF008068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 09:50:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 30 May 2023 09:50:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 May 2023 09:50:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 30 May 2023 09:50:51 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
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
Thread-Index: AQHZjrBQ+6WcWUIIakaazG2RI9C3Xq9wz12AgAFERBA=
Date:   Tue, 30 May 2023 01:50:51 +0000
Message-ID: <1dfa6d4026364fb99eeffa548cda0cfc@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-2-stanley_chang@realtek.com>
 <2023052915-repurpose-partner-20a8@gregkh>
In-Reply-To: <2023052915-repurpose-partner-20a8@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

SGkgR3JlZywNCg0KPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMDoyNjowM0FNICswODAwLCBT
dGFubGV5IENoYW5nIHdyb3RlOg0KPiA+IFJlYWx0ZWsgREhDIChkaWdpdGFsIGhvbWUgY2VudGVy
KSBSVEQgU29DcyBzdXBwb3J0IERXQzMgWEhDSSBVU0INCj4gPiAyLjAvMy4wIGNvbnRyb2xsZXIu
IEFkZGVkIHR3byBkcml2ZXJzIHRvIGRyaXZlIHRoZSAgVVNCIDIuMC8zLjAgUEhZDQo+IHRyYW5z
Y2VpdmVycy4NCj4gPiBGb3IgVVNCIDMuMCB0cmFuc2NlaXZlcnMsIGEgZHJpdmVyIHBoeS1ydGst
dXNiMyBpcyBwcm92aWRlZC4NCj4gPiBUaGUgZHJpdmVyIHBoeS1ydGstdXNiMiBpcyB1c2VkIHRv
IHN1cHBvcnQgVVNCIDIuMCB0cmFuc2NlaXZlcnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
dGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+IFJlcG9ydGVkLWJ5
OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IFRoZSBrZXJuZWwgdGVz
dCByb2JvdCBkaWQgbm90IHJlcG9ydCB0aGF0IGEgbmV3IGRyaXZlciB3YXMgbmVlZGVkIDooDQo+
IA0KDQpUaGlzIHJlcG9ydCBpcyBiYXNlZCBvbiB2MSBwYXRjaC4NCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC11c2IvcGF0Y2gvMjAyMzA1MTkwNDU4MjUuMjgzNjkt
Mi1zdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tLw0KDQpUaGUgb3JpZ2luYWwgZHJpdmVyIGlzIGF0
IGRyaXZlcnMvdXNiL3BoeS8NCklmIHRoaXMgcmVwb3J0IGlzIG5vdCBhcHByb3ByaWF0ZSwgSSB3
aWxsIHJlbW92ZSBpdC4NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
