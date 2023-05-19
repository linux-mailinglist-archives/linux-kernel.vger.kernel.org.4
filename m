Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D41709599
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjESLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjESLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:00:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0A10DC;
        Fri, 19 May 2023 04:00:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34JAwjybF004937, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34JAwjybF004937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 18:58:45 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 18:58:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 May 2023 18:58:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 19 May 2023 18:58:54 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Arnd Bergmann <arnd@arndb.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB
 2.0/3.0 PHY
Thread-Index: AQHZig6UEIendKXQakm8Ocfv4iAbD69gulMAgACuYvA=
Date:   Fri, 19 May 2023 10:58:54 +0000
Message-ID: <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
         <20230519045825.28369-2-stanley_chang@realtek.com>
 <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
In-Reply-To: <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

SGkgUGF1bCwNCg0KPiA+IFJlYWx0ZWsgREhDIChkaWdpdGFsIGhvbWUgY2VudGVyKSBSVEQgU29D
cyBzdXBwb3J0IERXQzMgWEhDSSBVU0INCj4gPiAyLjAvMy4wDQo+ID4gY29udHJvbGxlci4gQWRk
ZWQgdHdvIGRyaXZlcnMgdG8gZHJpdmUgdGhlICBVU0IgMi4wLzMuMCBQSFkNCj4gPiB0cmFuc2Nl
aXZlcnMuDQo+ID4gRm9yIFVTQiAzLjAgdHJhbnNjZWl2ZXJzLCBhIGRyaXZlciBwaHktcnRrLXVz
YjMgaXMgcHJvdmlkZWQuDQo+ID4gVGhlIGRyaXZlciBwaHktcnRrLXVzYjIgaXMgdXNlZCB0byBz
dXBwb3J0IFVTQiAyLjAgdHJhbnNjZWl2ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Rh
bmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy91c2IvcGh5L0tjb25maWcgICAgICAgIHzCoMKgIDE0ICsNCj4gPiAgZHJpdmVycy91c2Iv
cGh5L01ha2VmaWxlICAgICAgIHzCoMKgwqAgMiArDQo+ID4gIGRyaXZlcnMvdXNiL3BoeS9waHkt
cnRrLXVzYi5oICB8wqDCoCA4OCArKw0KPiA+ICBkcml2ZXJzL3VzYi9waHkvcGh5LXJ0ay11c2Iy
LmMgfCAyMTk2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJp
dmVycy91c2IvcGh5L3BoeS1ydGstdXNiMy5jIHwgMTE2NSArKysrKysrKysrKysrKysrKw0KPiA+
ICA1IGZpbGVzIGNoYW5nZWQsIDM0NjUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy91c2IvcGh5L3BoeS1ydGstdXNiLmgNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvdXNiL3BoeS9waHktcnRrLXVzYjIuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy91c2IvcGh5L3BoeS1ydGstdXNiMy5jDQo+IA0KPiBJJ20gcHJldHR5IHN1cmUg
dGhhdCBkcml2ZXJzL3VzYi9waHkvIGlzIGRlcHJlY2F0ZWQgbm93Li4uDQo+IA0KPiBOZXcgZHJp
dmVycyBzaG91bGQgYmUgd3JpdHRlbiBmb3IgdGhlIGdlbmVyaWMgUEhZIHN1YnN5c3RlbSBpbg0K
PiBkcml2ZXJzL3BoeS8uDQo+IA0KVGhhbmtzIGZvciB5b3VyIHJlbWluZGVyLg0KV2lsbCBkcml2
ZXJzL3VzYi9waHkgYmUgcmVtb3ZlZD8NCklzIGl0IG5vdCBhbGxvd2VkIHRvIGFkZCBuZXcgZHJp
dmVycz8NCg0KSW4gb3VyIGFwcGxpY2F0aW9uLCBkcml2ZXIvcGh5IGlzIG5vdCBzdWl0YWJsZS4N
CldlIG5lZWQgdG8gbm90aWZ5IHRoZSBwaHkgZHJpdmVyIHdoZW4gdGhlIFVTQiBodWIgcG9ydCBz
dGF0dXMgY2hhbmdlcy4NCkhvd2V2ZXIsIGdlbmVyaWMgUEhZIGRyaXZlcnMgYXJlIGRlc2lnbmVk
IGZvciB2YXJpb3VzIGRldmljZSdzIFBIWS4NCkFuZCBpdCBzZWVtcyBpbmFwcHJvcHJpYXRlIHRv
IGFkZCB0aGlzIGZ1bmN0aW9uLiBTbyB3ZSBjaG9vc2UgdG8gdXNlIGRyaXZlci91c2IvcGh5LiAN
Cg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo=
