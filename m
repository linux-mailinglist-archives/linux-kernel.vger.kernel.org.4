Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE87274E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjFHCT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjFHCTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:19:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B46173A;
        Wed,  7 Jun 2023 19:19:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3582IccrE030853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3582IccrE030853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 10:18:38 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 10:18:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Jun 2023 10:18:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 10:18:54 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Ray Chi" <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY
Thread-Topic: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Thread-Index: AQHZmQjXaabXymTUEkebktrVQM6RHa9/mteAgACSIHA=
Date:   Thu, 8 Jun 2023 02:18:54 +0000
Message-ID: <3d2e828cedba4ed0bb3fa09e3d306e1d@realtek.com>
References: <20230607062500.24669-3-stanley_chang@realtek.com>
 <202306080940.5Lcjwfck-lkp@intel.com>
In-Reply-To: <202306080940.5Lcjwfck-lkp@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

PiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Piwgb2xkIG9uZXMgcHJlZml4ZWQg
YnkgPDwpOg0KPiANCj4gRVJST1I6IG1vZHBvc3Q6ICJ1c2JfcmVtb3ZlX3BoeSIgW2RyaXZlcnMv
cGh5L3JlYWx0ZWsvcGh5LXJ0ay11c2IyLmtvXQ0KPiB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rw
b3N0OiAidXNiX2RlYnVnX3Jvb3QiIFtkcml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstdXNiMi5r
b10NCj4gdW5kZWZpbmVkIQ0KPiBFUlJPUjogbW9kcG9zdDogIm9mX2lvbWFwIiBbZHJpdmVycy9w
aHkvcmVhbHRlay9waHktcnRrLXVzYjIua29dIHVuZGVmaW5lZCENCj4gRVJST1I6IG1vZHBvc3Q6
ICJ1c2JfYWRkX3BoeV9kZXYiIFtkcml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstdXNiMi5rb10N
Cj4gdW5kZWZpbmVkIQ0KPiA+PiBFUlJPUjogbW9kcG9zdDogInVzYl9yZW1vdmVfcGh5IiBbZHJp
dmVycy9waHkvcmVhbHRlay9waHktcnRrLXVzYjMua29dDQo+IHVuZGVmaW5lZCENCj4gPj4gRVJS
T1I6IG1vZHBvc3Q6ICJ1c2JfZGVidWdfcm9vdCIgW2RyaXZlcnMvcGh5L3JlYWx0ZWsvcGh5LXJ0
ay11c2IzLmtvXQ0KPiB1bmRlZmluZWQhDQo+ID4+IEVSUk9SOiBtb2Rwb3N0OiAib2ZfaW9tYXAi
IFtkcml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstdXNiMy5rb10NCj4gdW5kZWZpbmVkIQ0KPiA+
PiBFUlJPUjogbW9kcG9zdDogInVzYl9hZGRfcGh5X2RldiIgW2RyaXZlcnMvcGh5L3JlYWx0ZWsv
cGh5LXJ0ay11c2IzLmtvXQ0KPiB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rwb3N0OiAiZGV2bV9p
b3JlbWFwX3Jlc291cmNlIiBbZHJpdmVycy9kbWEvcWNvbS9oZG1hLmtvXQ0KPiB1bmRlZmluZWQh
DQo+IEVSUk9SOiBtb2Rwb3N0OiAiZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIg0KPiBb
ZHJpdmVycy9kbWEvZnNsLWVkbWEua29dIHVuZGVmaW5lZCENCj4gV0FSTklORzogbW9kcG9zdDog
c3VwcHJlc3NlZCAyNiB1bnJlc29sdmVkIHN5bWJvbCB3YXJuaW5ncyBiZWNhdXNlIHRoZXJlDQo+
IHdlcmUgdG9vIG1hbnkpDQo+IA0KPiBLY29uZmlnIHdhcm5pbmdzOiAoZm9yIHJlZmVyZW5jZSBv
bmx5KQ0KPiAgICBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVkIGZv
ciBVU0JfUEhZDQo+ICAgIERlcGVuZHMgb24gW25dOiBVU0JfU1VQUE9SVCBbPW5dDQo+ICAgIFNl
bGVjdGVkIGJ5IFttXToNCj4gICAgLSBQSFlfUlRLX1JURF9VU0IyUEhZIFs9bV0NCj4gICAgLSBQ
SFlfUlRLX1JURF9VU0IzUEhZIFs9bV0NCj4gDQoNCkkgd2lsbCBhZGQgVVNCX1NVVVBSVCBkZXBl
bmRlbmN5IHRvIEtjb25maWcuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9yZWFsdGVrL0tj
b25maWcgYi9kcml2ZXJzL3BoeS9yZWFsdGVrL0tjb25maWcNCmluZGV4IDI4ZWUzZDliZTU2OC4u
YTVhNWE3MWVkYzljIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvcmVhbHRlay9LY29uZmlnDQor
KysgYi9kcml2ZXJzL3BoeS9yZWFsdGVrL0tjb25maWcNCkBAIC00LDYgKzQsNyBAQA0KICMNCiBj
b25maWcgUEhZX1JUS19SVERfVVNCMlBIWQ0KICAgICAgICB0cmlzdGF0ZSAiUmVhbHRlayBSVEQg
VVNCMiBQSFkgVHJhbnNjZWl2ZXIgRHJpdmVyIg0KKyAgICAgICBkZXBlbmRzIG9uIFVTQl9TVVBQ
T1JUDQogICAgICAgIHNlbGVjdCBHRU5FUklDX1BIWQ0KICAgICAgICBzZWxlY3QgVVNCX1BIWQ0K
ICAgICAgICBoZWxwDQpAQCAtMTQsNiArMTUsNyBAQCBjb25maWcgUEhZX1JUS19SVERfVVNCMlBI
WQ0KDQogY29uZmlnIFBIWV9SVEtfUlREX1VTQjNQSFkNCiAgICAgICAgdHJpc3RhdGUgIlJlYWx0
ZWsgUlREIFVTQjMgUEhZIFRyYW5zY2VpdmVyIERyaXZlciINCisgICAgICAgZGVwZW5kcyBvbiBV
U0JfU1VQUE9SVA0KICAgICAgICBzZWxlY3QgR0VORVJJQ19QSFkNCiAgICAgICAgc2VsZWN0IFVT
Ql9QSFkNCiAgICAgICAgaGVscA0KDQo=
