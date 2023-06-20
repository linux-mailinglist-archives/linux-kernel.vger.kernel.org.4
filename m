Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A89736325
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFTF0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFTF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:26:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECC1AC;
        Mon, 19 Jun 2023 22:26:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35K5Q01n8003506, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35K5Q01n8003506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 20 Jun 2023 13:26:00 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 20 Jun 2023 13:26:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Jun 2023 13:26:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 20 Jun 2023 13:26:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Topic: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Index: AQHZnKKRatqDIe8IxUOv8mL1iw8+va+H/hkQgAoeggCAARZ68A==
Date:   Tue, 20 Jun 2023 05:26:20 +0000
Message-ID: <e87abbe35f4945cba3440232880424b1@realtek.com>
References: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
 <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com>
 <CAFBinCBsg8jPhpqSOr9w2JhwN5YjPeME1Uye7meSY8h=b_N4Qg@mail.gmail.com>
In-Reply-To: <CAFBinCBsg8jPhpqSOr9w2JhwN5YjPeME1Uye7meSY8h=b_N4Qg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEJsdW1lbnN0
aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVuZSAyMCwgMjAyMyA0OjM4IEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFs
dGVrLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTHVrYXMgRi4g
SGFydG1hbm4gPGx1a2FzQG1udHJlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IHRvbnkwNjIwZW1tYUBnbWFpbC5jb207IGplcm5lai5za3JhYmVjQGdtYWlsLmNvbQ0KPiBT
dWJqZWN0OiBSZTogd2lmaTogcnR3ODg6IHF1ZXN0aW9uIGFib3V0IFNESU8gUlggYWdncmVnYXRp
b24gbGltaXRpbmcNCj4gDQo+IEhlbGxvIFBpbmctS2UsDQo+IA0KPiBhcG9sb2dpZXMgZm9yIHRo
ZSBsb25nIGRlbGF5Lg0KPiANCj4gT24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgNDoyMOKAr0FNIFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gWy4uLl0NCj4gPiBUaGUg
dW5pdCBvZiBCSVRfUlhETUFfQUdHX1BHX1RIIGlzIDFrIGJ5dGVzLCBzbyBJIHRoaW5rIHlvdSBj
YW4NCj4gPiBzZXQgbW1jX2hvc3QtPm1heF9yZXFfc2l6ZS8xMDI0Lg0KPiBJIHRyaWVkIHRoaXMg
YnV0IEkgZ290IGEgcmVzdWx0IHRoYXQgSSBkb24ndCB1bmRlcnN0YW5kLg0KPiBJJ3ZlIGJlZW4g
dGVzdGluZyB3aXRoIHRocmVlIEJJVF9SWERNQV9BR0dfUEdfVEggdmFsdWVzIG9uIGEgU29DIHRo
YXQNCj4gY2FuIGhhbmRsZSAyNTUgKiAxMDI0IGJ5dGVzLiBFYWNoIHRpbWUgSSBjb25uZWN0ZWQg
dG8gdGhlIHNhbWUgQVAgYW5kDQo+IGRvd25sb2FkZWQgYSBiaWdnZXIgZmlsZSBvdmVyIGh0dHAo
cykuDQo+IEJJVF9SWERNQV9BR0dfUEdfVEg6IGJpZ2dlc3Qgb2JzZXJ2ZWQgcnhfbGVuIGluIHJ0
d19zZGlvX3J4Zmlmb19yZWN2KCkNCj4gMjU1OiAyMDk2OA0KPiA2OiA1MTIyDQo+IDE6IDE2MDIN
Cg0KUGxlYXNlIGFsc28gcHJpbnQgb3V0IG51bWJlciBvZiBwYWNrZXRzIHlvdSByZWNlaXZlLCBh
bmQgdGhlbiB3ZSBjYW4gc2VlIGhvdw0KbWFueSBwYWNrZXRzIGFnZ3JlZ2F0ZS4NCg0KPiANCj4g
VGhlIGJpZ2dlc3QgcnhfbGVuIEkgaGF2ZSBvYnNlcnZlZCBmb3IgQklUX1JYRE1BX0FHR19QR19U
SCAxIGxvb2tzIHN1c3BpY2lvdXM6DQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBJIHNob3Vs
ZG4ndCBiZSBzZWVpbmcgcnhfbGVuIGxhcmdlciB0aGFuDQo+IEJJVF9SWERNQV9BR0dfUEdfVEgg
KiAxMDI0Lg0KPiBCSVRfUlhETUFfQUdHX1BHX1RIID0gNiBpcyB3aXRoaW4gdGhpcyBsaW1pdCBi
dXQgQklUX1JYRE1BX0FHR19QR19USCA9DQo+IDEgaXNuJ3QgKEknbSBzZWVpbmcgNTc4IGV4dHJh
IGJ5dGVzIGluIGFkZGl0aW9uIHRvIHRoZSAxMDI0IGJ5dGVzIHRoYXQNCj4gSSB3YXMgZXhwZWN0
aW5nKS4NCg0KQXNzdW1lIHRocmVzaG9sZCBpcyAxaywgYW5kIHNpbmdsZSBvbmUgcGFja2V0IGlz
IGxhcmdlciB0aGFuIDFrLiBIYXJkd2FyZQ0Kd2lsbCBub3Qgc3BsaXQgaXQgaW50byB0d28uIEFs
c28sIHBsZWFzZSBtYWtlIHN1cmUgMHgyODBbMjldIEJJVF9FTl9QUkVfQ0FMQw0KaXMgMS4gT3Ro
ZXJ3aXNlLCBpdCB3aWxsIHBvc3NpYmx5IGFnZ3JlZ2F0ZSBhZGRpdGlvbmFsIG9uZSBwYWNrZXQg
dG8gb3Zlcg0KdGhlIHRocmVzaG9sZC4NCg0KMHgyODBbMTU6OF0gaXMgdGltZW91dCB0aW1lIGlu
IHVuaXQgb2YgMXVzIGZvciBTRElPIGludGVyZmFjZS4gV2hlbiBzZXQNCnRocmVzaG9sZCB0byAy
NTUsIHlvdSBjYW4gZW5sYXJnZSB0aGlzIHRvIHNlZSBpZiBpdCBjYW4gYWdncmVnYXRlIG1vcmUg
YXMNCmV4cGVjdGVkLiANCg0KPiBEbyB5b3UgaGF2ZSBhbnkgaWRlYSB3aGVyZSB0aGlzIGlzIGNv
bWluZyBmcm9tPyBJJ20gd29ycmllZCB0aGF0IHdlDQo+IGNhbiBzdGlsbCBlbmQgdXAgd2l0aCB0
aGUgcHJvYmxlbSB0aGF0IEx1a2FzIGRlc2NyaWJlZCBidXQgc2VlbXMgdG8NCj4gbm90IGhhdmUg
aGl0IGluIGhpcyB0ZXN0aW5nIHdpdGggQklUX1JYRE1BX0FHR19QR19USCA9IDYNCj4gDQo+ID4g
SSB3b25kZXIgd2h5IDB4NiB3b3JrcyBvbiBBbWxvZ2ljIFNvQ3MuIENvdWxkIHlvdSBvciBMdWth
cyBjb21wYXJlIHBlcmZvcm1hbmNlDQo+ID4gYmV0d2VlbiB0aGUgc2V0dGluZ3Mgb2YgMHgxIGFu
ZCAweDY/DQo+IEkgY2FuIGRvIHRoaXMgbGF0ZXIgdGhpcyB3ZWVrIGJ1dCBJJ2QgbGlrZSB0byB1
bmRlcnN0YW5kIHRoZSBhYm92ZQ0KPiByZXN1bHRzIGZpcnN0Lg0KPiANCg0KUGluZy1LZQ0KDQo=
