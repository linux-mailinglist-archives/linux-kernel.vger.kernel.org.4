Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F272D756
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFMCUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbjFMCUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:20:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED71734;
        Mon, 12 Jun 2023 19:20:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35D2JutN6011000, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35D2JutN6011000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Jun 2023 10:19:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 13 Jun 2023 10:20:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 13 Jun 2023 10:20:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 13 Jun 2023 10:20:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Topic: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Index: AQHZnKKRatqDIe8IxUOv8mL1iw8+va+H/hkQ
Date:   Tue, 13 Jun 2023 02:20:13 +0000
Message-ID: <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com>
References: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
In-Reply-To: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEJsdW1lbnN0
aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBKdW5lIDEyLCAyMDIzIDQ6MjMgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZzsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBMdWthcyBGLiBI
YXJ0bWFubiA8bHVrYXNAbW50cmUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
dG9ueTA2MjBlbW1hQGdtYWlsLmNvbTsNCj4gamVybmVqLnNrcmFiZWNAZ21haWwuY29tDQo+IFN1
YmplY3Q6IHdpZmk6IHJ0dzg4OiBxdWVzdGlvbiBhYm91dCBTRElPIFJYIGFnZ3JlZ2F0aW9uIGxp
bWl0aW5nDQo+IA0KPiBIZWxsbyBQaW5nLUtlLA0KPiANCj4gY2VydGFpbiBBbWxvZ2ljIFNESU8g
aG9zdCBjb250cm9sbGVycyBoYXZlIGEgbGltaXQgb2YNCj4gcmVjZWl2aW5nL3RyYW5zbWl0dGlu
ZyBhdCBtb3N0IDE1MzYgYnl0ZXMgYXQgYSB0aW1lLg0KPiBJdCB0dXJucyBvdXQgdGhhdCBydHdf
c2Rpb19lbmFibGVfcnhfYWdncmVnYXRpb24oKSBmcm9tIHJ0dzg4L3NkaW8uYw0KPiBpcyBub3Qg
dGFraW5nIHRoaXMgaW50byBhY2NvdW50IGN1cnJlbnRseS4NCj4gRm9yIGFueSBSWCBidWZmZXIg
dGhhdCBpcyBiaWdnZXIgdGhhbiAxNTM2IGJ5dGVzICh3aGljaCBjYW4gaGFwcGVuIGR1ZQ0KPiB0
byBSWCBhZ2dyZWdhdGlvbikgd2UncmUgdW5hYmxlIHRvIGRvIGFueSBwcm9jZXNzaW5nIG9uIHRo
ZSBob3N0IHNpZGUNCj4gYmVjYXVzZSBhbGwgYnl0ZXMgYmV5b25kIHRoZSAxNTM2IGJ5dGVzIG1h
cmsgYXJlIGxvc3QuDQo+IA0KPiBMdWthcyBmb3VuZCB0aGF0IGxpbWl0aW5nIEJJVF9SWERNQV9B
R0dfUEdfVEggdG8gMHg2IG1ha2VzIGhpcw0KPiBSVEw4ODIyQ1Mgd29yayBvbiB0aGUgYWZmZWN0
ZWQgQW1sb2dpYyBTb0NzLg0KPiANCj4gTXkgcXVlc3Rpb24gbm93IGlzOiBob3cgY2FuIHdlIHBy
b3Blcmx5IGxpbWl0IEJJVF9SWERNQV9BR0dfUEdfVEgNCj4gd2l0aG91dCBoYXJkLWNvZGluZyBh
IG9uZS1maXRzLWFsbCB2YWx1ZSAod2hpY2ggbWF5IHJlZHVjZQ0KPiBwZXJmb3JtYW5jZSk/DQo+
IA0KPiBJbml0aWFsbHkgSSB0aG91Z2h0IHRoYXQgd2UgY291bGQganVzdCBjYWxjdWxhdGUgaXQ6
DQo+ICAgaG9zdF9tYXhfcGFnZXMgPSBtbWNfaG9zdC0+bWF4X3JlcV9zaXplIC8gcnR3ZGV2LT5j
aGlwLT5wYWdlX3NpemUNCj4gbWF4X3JlcV9zaXplIGZvciB0aGUgYWZmZWN0ZWQgY29udHJvbGxl
ciBpcyAxNTM2IGFuZCBjaGlwLT5wYWdlX3NpemUNCj4gaXMgMTI4LCBzbyB0aGUgcmVzdWx0IHdv
dWxkIGJlIDEyIChJIHRob3VnaHQgaXQgd291bGQgYmUgY2xvc2UgdG8gdGhpcw0KPiBudW1iZXIs
IG1heWJlICsvLTEpLg0KPiBVbmZvcnR1bmF0ZWx5IHRoaXMgZG9lc24ndCBmaXggdGhlIGlzc3Vl
IGFuZCBmb3IgaGlzIGJvYXJkDQo+IEJJVF9SWERNQV9BR0dfUEdfVEggdGhlIGxpbWl0IGlzIDYg
b3IgNy4NCj4gDQo+IElmIHlvdSBjb3VsZCBkZXNjcmliZSBob3cgQklUX1JYRE1BX0FHR19QR19U
SCBnZW5lcmFsbHkgd29ya3MgSSBjYW4NCj4gY29tZSB1cCB3aXRoIHRoZSBhbGdvcml0aG0gdG8g
Y2FsY3VsYXRlIHRoZSBsaW1pdCBvbiBteSBvd24gKGF0IGxlYXN0DQo+IEkgaG9wZSBzbykuDQo+
IEx1a2FzIGhhcyBiZWVuIHZlcnkgcGF0aWVudCB3aXRoIHRlc3Rpbmcgc28gZmFyIGFuZCBJIHVu
ZGVyc3Rvb2QgdGhhdA0KPiBoZSdzIHdpbGxpbmcgdG8gdGVzdCBmdXJ0aGVyIHBhdGNoZXMgaWYg
d2UgdGhpbmsgdGhhdCBpdCBmaXhlcyB0aGUNCj4gcnR3ODggZHJpdmVyIGlzc3VlIGhlJ3Mgc2Vl
aW5nLg0KPiANCg0KVGhlIHVuaXQgb2YgQklUX1JYRE1BX0FHR19QR19USCBpcyAxayBieXRlcywg
c28gSSB0aGluayB5b3UgY2FuDQpzZXQgbW1jX2hvc3QtPm1heF9yZXFfc2l6ZS8xMDI0Lg0KDQpJ
IHdvbmRlciB3aHkgMHg2IHdvcmtzIG9uIEFtbG9naWMgU29Dcy4gQ291bGQgeW91IG9yIEx1a2Fz
IGNvbXBhcmUgcGVyZm9ybWFuY2UNCmJldHdlZW4gdGhlIHNldHRpbmdzIG9mIDB4MSBhbmQgMHg2
Pw0KDQpQaW5nLUtlDQoNCg==
