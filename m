Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB837366D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFTJBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjFTJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:00:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAB10FB;
        Tue, 20 Jun 2023 02:00:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35K8xwmaF000412, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35K8xwmaF000412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 20 Jun 2023 16:59:58 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 20 Jun 2023 17:00:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Jun 2023 17:00:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 20 Jun 2023 17:00:18 +0800
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY
Thread-Topic: [PATCH v4 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Thread-Index: AQHZnqKu2e8zIA9siU2Lwklo+4Zzaa+OKdoAgAVD7IA=
Date:   Tue, 20 Jun 2023 09:00:18 +0000
Message-ID: <ebe51f77c5c44936820c4ee36fb3b8b6@realtek.com>
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-3-stanley_chang@realtek.com>
 <2341d5c2-1865-b7fa-b0a1-b281563490d5@linaro.org>
In-Reply-To: <2341d5c2-1865-b7fa-b0a1-b281563490d5@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KPiANCj4gDQo+IE9uIDE0LzA2LzIwMjMgMTE6MjgsIFN0YW5sZXkgQ2hh
bmcgd3JvdGU6DQo+ID4gUmVhbHRlayBESEMgKGRpZ2l0YWwgaG9tZSBjZW50ZXIpIFJURCBTb0Nz
IHN1cHBvcnQgRFdDMyBYSENJIFVTQg0KPiA+IGNvbnRyb2xsZXIuIEFkZGVkIHRoZSBkcml2ZXIg
dG8gZHJpdmUgdGhlIFVTQiAzLjAgUEhZIHRyYW5zY2VpdmVycy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+ID4gLS0t
DQo+IA0KPiBBbGwgbXkgY29tbWVudHMgYXBwbHkgaGVyZSBhcyB3ZWxsLg0KPiANCkkgd2lsbCBy
ZWZlciB0aGUgY29tbWVudHMgb2YgdGhlIHNlY29uZCBwYXRjaC4NCg0KVGhhbmtzLA0KU3Rhbmxl
eQ0KDQo=
