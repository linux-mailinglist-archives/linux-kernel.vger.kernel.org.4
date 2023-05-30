Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5871580A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjE3IKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjE3IJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:09:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F09D;
        Tue, 30 May 2023 01:09:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U7cjUaB028078, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U7cjUaB028078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 15:38:45 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 30 May 2023 15:38:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 15:38:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 30 May 2023 15:38:58 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Thread-Topic: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Thread-Index: AQHZjrBJqs57LUq3CEa1m1O4SeqC6K9wz9gAgAFFkID//9jvAIAAh3eg
Date:   Tue, 30 May 2023 07:38:58 +0000
Message-ID: <1014346aa8c24edd981e8b5e65524bd0@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <2023052905-maimed-studied-3563@gregkh>
 <647ded70ff024a3081cbf5c45f5da12c@realtek.com>
 <2023053014-reassure-footwork-f51c@gregkh>
In-Reply-To: <2023053014-reassure-footwork-f51c@gregkh>
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

SGkgR3JlZywNCg0KPiA+IFdoeSBjYW4ndCB0aGlzIGJlIHBhcnQgb2YgdGhlIHNhbWUgbm90aWZ5
X2Nvbm5lY3QoKSBjYWxsYmFjaz8NCj4gPg0KPiA+IFRoZSBub3RpZnkgY29ubmVjdCBpcyBhdCBk
ZXZpY2UgcmVhZHkuIEJ1dCBJIHdhbnQgbm90aWZ5IHBvcnQgc3RhdHVzIGNoYW5nZQ0KPiBiZWZv
cmUgcG9ydCByZXNldC4NCj4gPg0KPiA+ID4gV2hhdCBtYWtlcyBpdCBkaWZmZXJlbnQgc29tZWhv
dz8gIFBsZWFzZSBkb2N1bWVudCB0aGlzIG11Y2ggYmV0dGVyLg0KPiA+DQo+ID4gSW4gUmVhbHRl
ayBwaHkgZHJpdmVyLCB3ZSBoYXZlIGRlc2lnbmVkIHRvIGR5bmFtaWNhbGx5IGFkanVzdCBkaXNj
b25uZWN0aW9uDQo+IGxldmVsIGFuZCBjYWxpYnJhdGUgcGh5IHBhcmFtZXRlcnMuDQo+ID4gU28g
d2UgZG8gdGhpcyB3aGVuIHRoZSBkZXZpY2UgY29ubmVjdGVkIGJpdCBjaGFuZ2VzIGFuZCB3aGVu
IHRoZQ0KPiBkaXNjb25uZWN0ZWQgYml0IGNoYW5nZXMuDQo+ID4gUG9ydCBzdGF0dXMgY2hhbmdl
IG5vdGlmaWNhdGlvbjoNCj4gPiAxLiBDaGVjayBpZiBwb3J0c3RhdHVzIGlzIFVTQl9QT1JUX1NU
QVRfQ09OTkVDVElPTiBhbmQgcG9ydGNoYW5nZSBpcw0KPiBVU0JfUE9SVF9TVEFUX0NfQ09OTkVD
VElPTi4NCj4gPiAgIFRoZSBkZXZpY2UgaXMgY29ubmVjdGVkLCB0aGUgZHJpdmVyIGxvd2VycyB0
aGUgZGlzY29ubmVjdGlvbiBsZXZlbCBhbmQNCj4gY2FsaWJyYXRlcyB0aGUgcGh5IHBhcmFtZXRl
cnMuDQo+ID4gMi4gVGhlIGRldmljZSBkaXNjb25uZWN0cywgdGhlIGRyaXZlciBpbmNyZWFzZXMg
dGhlIGRpc2Nvbm5lY3QgbGV2ZWwgYW5kDQo+IGNhbGlicmF0ZXMgdGhlIHBoeSBwYXJhbWV0ZXJz
Lg0KPiA+DQo+ID4gSWYgd2UgYWRqdXN0IHRoZSBkaXNjb25uZWN0aW9uIGxldmVsIGluIG5vdGlm
eV9jb25uZWN0ICwgdGhlIGRpc2Nvbm5lY3QgbWF5DQo+IGhhdmUgYmVlbiB0cmlnZ2VyZWQgYXQg
dGhpcyBzdGFnZS4NCj4gPiBTbyB3ZSBuZWVkIHRvIGNoYW5nZSB0aGF0IGFzIGVhcmx5IGFzIHBv
c3NpYmxlLg0KPiANCj4gUGxlYXNlIHB1dCB0aGlzIHR5cGUgb2YgaW5mb3JtYXRpb24gaW4gdGhl
IGNoYW5nZWxvZyBhbmQgaW4gdGhlIGNvbW1lbnRzIGZvcg0KPiB0aGUgY2FsbGJhY2sgd2hlbiB5
b3UgcmVzdWJtaXQgaXQuDQoNCk9rYXksIEkgd2lsbCBhZGQgdGhpcyBpbmZvcm1hdGlvbiBhdCBu
ZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClN0YW5sZXkNCg==
