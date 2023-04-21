Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46106EA5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDUIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDUIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:33:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5514C0E;
        Fri, 21 Apr 2023 01:33:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L8WUx44027321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L8WUx44027321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 16:32:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 16:32:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 16:32:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 21 Apr 2023 16:32:19 +0800
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
Thread-Index: AQHZdCfF18CT8wCSd0W6JiweSZ5Lg6805bGAgACHUUA=
Date:   Fri, 21 Apr 2023 08:32:19 +0000
Message-ID: <efd6e621210a407db9c153712f362366@realtek.com>
References: <20230421080333.18681-1-stanley_chang@realtek.com>
 <ZEJHLR27pVwVI3_J@kroah.com>
In-Reply-To: <ZEJHLR27pVwVI3_J@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

PiANCj4gT24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMDQ6MDM6MzFQTSArMDgwMCwgU3RhbmxleSBD
aGFuZyB3cm90ZToNCj4gPiBJbiBSZWFsdGVrIFNvQywgdGhlIHBhcmFtZXRlciBvZiB1c2IgcGh5
IGlzIGRlc2lnbmVkIHRvIGNhbiBkeW5hbWljDQo+ID4gdHVuaW5nIGJhc2Ugb24gcG9ydCBzdGF0
dXMuIFRoZXJlZm9yZSwgYWRkIGEgbm90aWZ5IGNhbGxiYWNrIG9mIHBoeQ0KPiA+IGRyaXZlciB3
aGVuIHVzYiBwb3J0IHN0YXR1cyBjaGFuZ2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFu
bGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3VzYi9jb3JlL2h1Yi5jICB8IDEzICsrKysrKysrKysrKysgIGluY2x1ZGUvbGludXgvdXNi
L3BoeS5oIHwNCj4gPiAxNCArKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKykNCj4gDQo+IFdlIGNhbiBub3QgYWRkIGNhbGxiYWNrcyBpbiB0aGUga2Vy
bmVsIHRoYXQgYXJlIG5vdCBhY3R1YWxseSB1c2VkLCBvdGhlcndpc2UNCj4gdGhleSB3aWxsIGp1
c3QgYmUgaW5zdGFudGx5IHJlbW92ZWQuDQo+IA0KPiBQbGVhc2Ugc3VibWl0IGFueSBkcml2ZXJz
IHRoYXQgbmVlZCB0aGlzIGNoYW5nZSBhdCB0aGUgc2FtZSB0aW1lIHNvIHRoYXQgd2UNCj4gY2Fu
IHZlcmlmeSB0aGF0IHRoZSBjYWxsYmFjayBpcyBhY3R1YWxseSBjb3JyZWN0IGFuZCBuZWVkZWQs
IG90aGVyd2lzZSB3ZSBjYW4NCj4gbm90IHRha2UgdGhpcyBjaGFuZ2UuDQo+IA0KDQpJbiB0aGlz
IHN0YWdlLCB3ZSB1c2IgcGh5IGRyaXZlciBpcyBub3QgYXQgbGludXggdXBzdHJlYW0uIA0KRm9y
IHRoZSBhbmRyb2lkIEdLSSwgd2UgaGF2ZSB0byBhZGQgdGhpcyBjYWxsYmFjayB0byB1cHN0cmVh
bSBvciB1c2UgdGhlIHZlbmRvciBob29rIG9mIGFuZHJvaWQuDQpJIHdpbGwgcGxhbiB0byB1cHN0
cmVhbSB0aGUgcmVhbHRlayB1c2IgcGh5IGRyaXZlci4NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
