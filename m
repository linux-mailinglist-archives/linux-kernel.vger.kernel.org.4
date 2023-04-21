Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7A6EA606
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDUIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDUIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:40:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B47DA8;
        Fri, 21 Apr 2023 01:40:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L8e5glD015276, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L8e5glD015276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 16:40:05 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 16:40:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 16:40:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 21 Apr 2023 16:40:05 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] usb: phy: add usb phy notify port status API
Thread-Topic: [PATCH v1] usb: phy: add usb phy notify port status API
Thread-Index: AQHZdCfF18CT8wCSd0W6JiweSZ5Lg6805gYAgACG7aA=
Date:   Fri, 21 Apr 2023 08:40:05 +0000
Message-ID: <fdf65c4eca9b420bb1ed29edb66482fb@realtek.com>
References: <20230421080333.18681-1-stanley_chang@realtek.com>
 <ZEJHdCpLZ7f0946B@kroah.com>
In-Reply-To: <ZEJHdCpLZ7f0946B@kroah.com>
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

DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgYi9kcml2ZXJzL3VzYi9j
b3JlL2h1Yi5jIGluZGV4DQo+ID4gOTdhMGY4ZmFlYTZlLi5iNGZiYmVhZTE5MjcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2Nv
cmUvaHViLmMNCj4gPiBAQCAtNjE0LDYgKzYxNCwxOSBAQCBzdGF0aWMgaW50IGh1Yl9leHRfcG9y
dF9zdGF0dXMoc3RydWN0IHVzYl9odWIgKmh1YiwNCj4gaW50IHBvcnQxLCBpbnQgdHlwZSwNCj4g
PiAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ID4gICAgICAgfQ0KPiA+ICAgICAgIG11dGV4X3Vu
bG9jaygmaHViLT5zdGF0dXNfbXV0ZXgpOw0KPiA+ICsNCj4gPiArICAgICBpZiAoIXJldCkgew0K
PiA+ICsgICAgICAgICAgICAgc3RydWN0IHVzYl9kZXZpY2UgKmhkZXYgPSBodWItPmhkZXY7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgaWYgKGhkZXYgJiYgIWhkZXYtPnBhcmVudCkgew0KPiAN
Cj4gSG93IGNhbiB5b3UgaGF2ZSBhIGRldmljZSB3aXRob3V0IGEgcGFyZW50PyAgQW5kIHdoeSBk
b2VzIGl0IG1hdHRlcj8NCg0KSWYgdGhlIGh1YiBpcyBhIHJvb3QgaHViLCB0aGUgcGFyZW50IG9m
IGh1YiB3aWxsIGJlIE5VTEwuDQpBbmQgd2Ugb25seSBzZW5kIHRoZSBwb3J0IHN0YXR1cyB0byBw
aHkgZHJpdmVyIGZvciByb290IGh1Yi4NCj4gDQo+IEFuZCBob3cgY291bGQgaGRldiBiZSBOVUxM
PyAgQW5kIGlmIGl0IGNhbiBjaGFuZ2UgdG8gYmUgTlVMTCwgd2hhdCBwcmV2ZW50cw0KPiBpdCBm
cm9tIGNoYW5naW5nIHJpZ2h0IGFmdGVyIHlvdSBjaGVja2VkIGZvciBpdD8NCj4gDQoNCkl0IGlz
IHJpZ2h0LiBoZGV2IGlzIG5ldmVyIE5VTEwsIHRoaXMgaXMgYSByZWR1bmRhbnQgY2hlY2suDQoN
ClRoYW5rcywNClN0YW5sZXkNCg==
