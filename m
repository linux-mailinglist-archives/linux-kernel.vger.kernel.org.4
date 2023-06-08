Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF270727838
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjFHHIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjFHHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:08:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02318137;
        Thu,  8 Jun 2023 00:08:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35877TY00031506, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35877TY00031506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 15:07:29 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 8 Jun 2023 15:07:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 15:07:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 15:07:44 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
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
Thread-Index: AQHZmQjR4Z6nmQOlk0qvgFcnmBMR/a9/E4qAgAEY5bD//8fNAIAAhy2g
Date:   Thu, 8 Jun 2023 07:07:44 +0000
Message-ID: <46a2378df94d4b6f9118c1bc4bb4fea3@realtek.com>
References: <20230607062500.24669-2-stanley_chang@realtek.com>
 <202306080128.Gh3c2H1O-lkp@intel.com>
 <2444f4875f484cc4bf2ff9c52815fa0c@realtek.com>
 <1069d6fa-7b17-00de-ad0b-e91794fae9f2@kernel.org>
In-Reply-To: <1069d6fa-7b17-00de-ad0b-e91794fae9f2@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IE9uIDA4LzA2LzIwMjMgMDQ6MTgsIFN0YW5sZXkgQ2hhbmdb5piM
6IKy5b63XSB3cm90ZToNCj4gPj4gRVJST1I6IG1vZHBvc3Q6ICJkZXZtX3VzYl9nZXRfcGh5X2J5
X3BoYW5kbGUiDQo+ID4+IFtkcml2ZXJzL3Bvd2VyL3N1cHBseS93bTgzMXhfcG93ZXIua29dIHVu
ZGVmaW5lZCENCj4gPj4+PiBFUlJPUjogbW9kcG9zdDogImRldm1fdXNiX2dldF9waHkiDQo+ID4+
IFtkcml2ZXJzL3Bvd2VyL3N1cHBseS9kYTkxNTAtY2hhcmdlci5rb10gdW5kZWZpbmVkIQ0KPiA+
Pg0KPiA+PiBLY29uZmlnIHdhcm5pbmdzOiAoZm9yIHJlZmVyZW5jZSBvbmx5KQ0KPiA+PiAgICBX
QVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVkIGZvciBVU0JfUEhZDQo+
ID4+ICAgIERlcGVuZHMgb24gW25dOiBVU0JfU1VQUE9SVCBbPW5dDQo+ID4+ICAgIFNlbGVjdGVk
IGJ5IFt5XToNCj4gPj4gICAgLSBQSFlfUlRLX1JURF9VU0IyUEhZIFs9eV0NCj4gPj4NCj4gPg0K
PiA+IEkgd2lsbCBhZGQgVVNCX1NVVVBSVCBkZXBlbmRlbmN5IHRvIEtjb25maWcuDQo+IA0KPiBX
aHk/IERvIHlvdSBzZWUgb3RoZXIgcGh5IGRyaXZlcnMgbmVlZGluZyBpdD8gRmV3IGhhdmUgaXQg
YnV0IG1hbnkgZG9uJ3QsIHNvDQo+IHlvdSBzaG91bGQgcmVhbGx5IGludmVzdGlnYXRlIHRoZSBy
b290IGNhdXNlLCBub3QganVzdCBhZGQgc29tZSBkZXBlbmRlbmNpZXMuDQo+IA0KPiBCdWlsZCB0
ZXN0IHlvdXIgcGF0Y2hlcyBsb2NhbGx5IGJlZm9yZSBzZW5kaW5nIGFuZCBpbnZlc3RpZ2F0ZSB0
aGUgaXNzdWVzLg0KDQpVU0JfU1VQUE9SVCBpcyByZXF1aXJlZC4NCkJlY2F1c2UgSSBoYXZlIHNl
bGVjdCBLY29uZmlnIFVTQl9QSFkuDQpTb21lIGRyaXZlcnMgaGF2ZSB1c2VkIGl0IGFzIGZvbGxv
dw0KZHJpdmVycy9waHkvdGkvS2NvbmZpZw0KZHJpdmVycy9waHkvYW1sb2dpYy9LY29uZmlnDQpk
cml2ZXJzL3BoeS9yZW5lc2FzL0tjb25maWcNCmRyaXZlcnMvcGh5L3JvY2tjaGlwL0tjb25maWcN
CmRyaXZlcnMvcGh5L2FsbHdpbm5lci9LY29uZmlnDQoNClRoYW5rcywNClN0YW5sZXkNCg==
