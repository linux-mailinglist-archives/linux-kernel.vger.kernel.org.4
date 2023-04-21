Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44B6EA903
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDULUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDULUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:20:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB18186;
        Fri, 21 Apr 2023 04:20:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33LBJeXmA015562, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33LBJeXmA015562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 19:19:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 21 Apr 2023 19:19:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 19:19:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 21 Apr 2023 19:19:40 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
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
Thread-Index: AQHZdCfF18CT8wCSd0W6JiweSZ5Lg6805bGAgACHUUD//6flgIAAhuoQ
Date:   Fri, 21 Apr 2023 11:19:40 +0000
Message-ID: <eecf54cdc06a4e3690e2cad62a8d4596@realtek.com>
References: <20230421080333.18681-1-stanley_chang@realtek.com>
 <ZEJHLR27pVwVI3_J@kroah.com> <efd6e621210a407db9c153712f362366@realtek.com>
 <ZEJux2KTnGw-WE1A@kroah.com>
In-Reply-To: <ZEJux2KTnGw-WE1A@kroah.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gV2UgY2FuIG5vdCBhZGQgY2FsbGJhY2tzIGluIHRoZSBrZXJuZWwgdGhhdCBhcmUgbm90
IGFjdHVhbGx5IHVzZWQsDQo+ID4gPiBvdGhlcndpc2UgdGhleSB3aWxsIGp1c3QgYmUgaW5zdGFu
dGx5IHJlbW92ZWQuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIHN1Ym1pdCBhbnkgZHJpdmVycyB0aGF0
IG5lZWQgdGhpcyBjaGFuZ2UgYXQgdGhlIHNhbWUgdGltZSBzbw0KPiA+ID4gdGhhdCB3ZSBjYW4g
dmVyaWZ5IHRoYXQgdGhlIGNhbGxiYWNrIGlzIGFjdHVhbGx5IGNvcnJlY3QgYW5kIG5lZWRlZCwN
Cj4gPiA+IG90aGVyd2lzZSB3ZSBjYW4gbm90IHRha2UgdGhpcyBjaGFuZ2UuDQo+ID4gPg0KPiA+
DQo+ID4gSW4gdGhpcyBzdGFnZSwgd2UgdXNiIHBoeSBkcml2ZXIgaXMgbm90IGF0IGxpbnV4IHVw
c3RyZWFtLg0KPiANCj4gVGhlbiBvYnZpb3VzbHkgd2UgY2FuIG5vdCB0YWtlIHRoaXMgY2hhbmdl
IChub3Igd291bGQgeW91IHdhbnQgdXMgdG8uKQ0KDQpJIHdpbGwgcHJlcGFyZSBhIGNvbXBsZXRl
IGRyaXZlciBmb3IgcmV2aWV3Lg0KDQo+ID4gRm9yIHRoZSBhbmRyb2lkIEdLSSwgd2UgaGF2ZSB0
byBhZGQgdGhpcyBjYWxsYmFjayB0byB1cHN0cmVhbSBvciB1c2UgdGhlDQo+IHZlbmRvciBob29r
IG9mIGFuZHJvaWQuDQo+ID4gSSB3aWxsIHBsYW4gdG8gdXBzdHJlYW0gdGhlIHJlYWx0ZWsgdXNi
IHBoeSBkcml2ZXIuDQo+IA0KPiBBcyB5b3UgYWxyZWFkeSBoYXZlIHRoaXMgZHJpdmVyLCB3aHkg
bm90IHNlbmQgaXQgdG8gdXMgbm93Pw0KPiANCk5vdyB0aGUgZHJpdmVyIGRvZXNuJ3QgbWF0Y2gg
dGhlIGNvZGluZyBzdHlsZS4NCkFmdGVyIEkgcmVmYWN0b3IgaXQsIEkgd2lsbCBzZW5kIHRoaXMg
ZHJpdmVyIHVwc3RyZWFtLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
