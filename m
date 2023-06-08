Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3BF7278FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFHHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFHHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:43:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFDB1BF7;
        Thu,  8 Jun 2023 00:43:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3587e8uA5026139, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3587e8uA5026139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 15:40:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 15:40:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 15:40:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 15:40:23 +0800
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
        Ray Chi <raychi@google.com>,
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
Thread-Index: AQHZmQjXaabXymTUEkebktrVQM6RHa9+tOwAgAF5CeD//82RgIAAicGw
Date:   Thu, 8 Jun 2023 07:40:23 +0000
Message-ID: <96152ac15f5a4dd8901d6b126da8e7e2@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-3-stanley_chang@realtek.com>
 <a9a2f3d0-9580-f027-8ec3-ac6e6bed5ed6@linaro.org>
 <0ac12a13a91d41f0ab3a58b435ccb17a@realtek.com>
 <b343df1a-dbd8-919d-5bea-36d532ec4103@linaro.org>
In-Reply-To: <b343df1a-dbd8-919d-5bea-36d532ec4103@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

PiA+PiBQbGVhc2UgZHJvcCBhbGwgc2ltcGxlIGRlYnVnIHN1Y2Nlc3MgbWVzc2FnZXMuIExpbnV4
IGhhcyBhbHJlYWR5DQo+ID4+IGluZnJhc3RydWN0dXJlIGZvciB0aGlzLg0KPiA+Pg0KPiA+IE9r
YXkuIEkgd2lsbCBjaGFuZ2UgdGhlIHByaW50IGRldl9pbmZvIHRvIGRldl9kYmcgYWJvdXQgZGVi
dWcgbWVzc2FnZS4NCj4gDQo+IE5vLCBkcm9wIHRoZW0uIFRoaXMgcGllY2Ugb2YgY29kZSBoYWQg
YWxyZWFkeSAyIHByaW50a3MgZm9yIHJlZ2lzdGVyIGNvbnRlbnRzIQ0KPiBZb3VyIGRyaXZlciBp
cyBvdmVybG9hZGVkIHdpdGggcHJpbnRrcyBhbmQgdGhleSBhcmUgbW9zdGx5IHVzZWxlc3MgZm9y
IHRoZSB1c2VyLg0KDQpJIHdpbGwgZHJvcCB0aGVtIHRvIHNpbXBsaWZ5IHRoZSBjb2RlLg0KDQo+
ID4+IFBsZWFzZSBkcm9wIGFsbCBzaW1wbGUgZGVidWcgc3VjY2VzcyBtZXNzYWdlcy4gTGludXgg
aGFzIGFscmVhZHkNCj4gPj4gaW5mcmFzdHJ1Y3R1cmUgZm9yIHRoaXMuDQo+ID4NCj4gPiBDYW4g
SSBrZWVwIGxvZyBmb3IgZGV2X2RiZz8NCj4gDQo+IE9mIGNvdXJzZSBub3QuIFRoaXMgd2FzIGRl
dl9kYmcgYW5kIEkgY29tbWVudGVkIG9uIHRoaXMuIFRoaXMgaXMgbm90IGEgZ29vZA0KPiBkZWJ1
Zywgd2UgZG8gbm90IHByaW50IGFueXRoaW5nIG9uIGZ1bmN0aW9uIGVudHJhbmNlIGFuZCBleGl0
Lg0KPiBmdHJhY2UoKSBpcyBmb3IgdGhpcy4NCg0KV2VsbCwgZm9yIGRlYnVnZ2luZyBwdXJwb3Nl
cywgSSdtIGdvaW5nIHRvIGhhdmUgdG8gZGlnIGludG8gZnRyYWNlLg0KVGhpcyBpcyBhIGdyZWF0
IHRpcC4NCj4gPj4NCj4gPj4gQXJlIHlvdSBzdXJlIHlvdSBydW4gY2hlY2twYXRjaCBvbiB0aGlz
PyBFcnJvciBtZXNzYWdlcyBvbiBkZWJ1Z2ZzDQo+ID4+IGFyZSBhbG1vc3QgYWx3YXlzIGluY29y
cmVjdC4NCj4gPg0KPiA+IFllcywgSSBoYXZlIHJ1biBjaGVja3BhdGNoIGZvciBwYXRjaGVzLg0K
PiA+IFdoeSB0aGUgbWVzc2FnZSBpcyBpbmNvcnJlY3Q/DQo+IA0KPiBCZWNhdXNlIGRlYnVnZnMg
ZmFpbHVyZXMgc2hvdWxkIG5vdCBjYXVzZSBhbnkgZXJyb3IgcHJpbnRzLiBJdCdzIGRlYnVnLCBu
b3QNCj4gaW1wb3J0YW50Lg0KPiANCj4gRG8geW91IHNlZSBhbnl3aGVyZSBlcnJvciBtZXNzYWdl
cz8NCj4gDQo+IEVudGlyZSBkZWJ1Z2ZzIGhhbmRsaW5nIGNvZGUgc2hvdWxkIGJlIHNpbGVudCBh
bmQgZXZlbiBza2lwIGFsbCBlcnJvciBjaGVja2luZywNCj4gYXMgbW9zdCBBUEkgaXMgcmVhZHkg
Zm9yIGhhbmRsaW5nIHByZXZpb3VzIGVycm9ycywgSSB0aGluay4NCg0KVGhhbmtzLCBJIHVuZGVy
c3RhbmQgbm93Lg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
