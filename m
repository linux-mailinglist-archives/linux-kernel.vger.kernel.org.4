Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC85746D27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjGDJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGDJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:21:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF0D2172A;
        Tue,  4 Jul 2023 02:20:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3649KCpM4007284, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3649KCpM4007284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Jul 2023 17:20:12 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 4 Jul 2023 17:20:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 4 Jul 2023 17:20:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 4 Jul 2023 17:20:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Topic: wifi: rtw88: question about SDIO RX aggregation limiting
Thread-Index: AQHZnKKRatqDIe8IxUOv8mL1iw8+va+H/hkQgAoeggCAARZ68IAU90gAgAFFobA=
Date:   Tue, 4 Jul 2023 09:20:14 +0000
Message-ID: <b41adc34ecc5460cb0c1c7cad1ba6b42@realtek.com>
References: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
 <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com>
 <CAFBinCBsg8jPhpqSOr9w2JhwN5YjPeME1Uye7meSY8h=b_N4Qg@mail.gmail.com>
 <e87abbe35f4945cba3440232880424b1@realtek.com>
 <CAFBinCB6Q67nG3Z33i=nDLcYGENCSHFKNq=ViJks0j9aXbcYpA@mail.gmail.com>
In-Reply-To: <CAFBinCB6Q67nG3Z33i=nDLcYGENCSHFKNq=ViJks0j9aXbcYpA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
eSwgSnVseSA0LCAyMDIzIDU6MjUgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBMdWthcyBGLiBI
YXJ0bWFubiA8bHVrYXNAbW50cmUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gdG9ueTA2MjBlbW1hQGdtYWlsLmNvbTsgamVybmVqLnNrcmFiZWNAZ21haWwuY29tDQo+IFN1
YmplY3Q6IFJlOiB3aWZpOiBydHc4ODogcXVlc3Rpb24gYWJvdXQgU0RJTyBSWCBhZ2dyZWdhdGlv
biBsaW1pdGluZw0KPiANCj4gSGVsbG8gUGluZy1LZSwNCj4gDQo+IHNvcnJ5IGFnYWluIGZvciB0
aGUgbG9uZyB3YWl0aW5nIHRpbWUuIEknbGwgYmUgcXVpY2tlciBuZXh0IHRpbWUuDQo+IA0KPiBP
biBUdWUsIEp1biAyMCwgMjAyMyBhdCA3OjI24oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gPiBUaGUgdW5pdCBvZiBCSVRfUlhETUFf
QUdHX1BHX1RIIGlzIDFrIGJ5dGVzLCBzbyBJIHRoaW5rIHlvdSBjYW4NCj4gPiA+ID4gc2V0IG1t
Y19ob3N0LT5tYXhfcmVxX3NpemUvMTAyNC4NCj4gPiA+IEkgdHJpZWQgdGhpcyBidXQgSSBnb3Qg
YSByZXN1bHQgdGhhdCBJIGRvbid0IHVuZGVyc3RhbmQuDQo+ID4gPiBJJ3ZlIGJlZW4gdGVzdGlu
ZyB3aXRoIHRocmVlIEJJVF9SWERNQV9BR0dfUEdfVEggdmFsdWVzIG9uIGEgU29DIHRoYXQNCj4g
PiA+IGNhbiBoYW5kbGUgMjU1ICogMTAyNCBieXRlcy4gRWFjaCB0aW1lIEkgY29ubmVjdGVkIHRv
IHRoZSBzYW1lIEFQIGFuZA0KPiA+ID4gZG93bmxvYWRlZCBhIGJpZ2dlciBmaWxlIG92ZXIgaHR0
cChzKS4NCj4gPiA+IEJJVF9SWERNQV9BR0dfUEdfVEg6IGJpZ2dlc3Qgb2JzZXJ2ZWQgcnhfbGVu
IGluIHJ0d19zZGlvX3J4Zmlmb19yZWN2KCkNCj4gPiA+IDI1NTogMjA5NjgNCj4gPiA+IDY6IDUx
MjINCj4gPiA+IDE6IDE2MDINCj4gPg0KPiA+IFBsZWFzZSBhbHNvIHByaW50IG91dCBudW1iZXIg
b2YgcGFja2V0cyB5b3UgcmVjZWl2ZSwgYW5kIHRoZW4gd2UgY2FuIHNlZSBob3cNCj4gPiBtYW55
IHBhY2tldHMgYWdncmVnYXRlLg0KPiBzdXJlIC0gaGVyZSBhcmUgdGhlIHJlc3VsdHM6DQo+IEJJ
VF9SWERNQV9BR0dfUEdfVEg6IGJpZ2dlc3Qgb2JzZXJ2ZWQgcnhfbGVuIGluIHJ0d19zZGlvX3J4
Zmlmb19yZWN2KCkNCj4gLyBudW1iZXIgb2YgKGFnZ3JlZ2F0ZWQpIHBhY2tldHMNCj4gMjU1OiAy
MDgyNCAvIDEyDQo+IDY6IDUxMjggLyA0DQo+IDE6IDMxMzIgLyAxICh0aGVzZSB3ZXJlIGEgZmV3
IGV4Y2VwdGlvbnMgYW5kIEknbSBub3QgYWJsZSB0byByZWxpYWJseQ0KPiByZXByb2R1Y2UgaXQs
IDE2MDIgLyAxIGlzIHdoYXQgSSBjYW4gZWFzaWx5IHJlcHJvZHVjZSkNCg0KVGhlc2UgcmVzdWx0
cyBhcmUgZXhwZWN0ZWQuIA0KDQpUaGUgbWluaW11bSBudW1iZXIgb2YgcmVjZWl2ZWQgcGFja2V0
IGlzIG9uZSwgc28gaXQgaXMgcG9zc2libGUgdGhhdCBwYWNrZXQgc2l6ZQ0KaXMgbGFyZ2VyIHRo
YW4gMWsuDQoNCj4gDQo+ID4gPiBUaGUgYmlnZ2VzdCByeF9sZW4gSSBoYXZlIG9ic2VydmVkIGZv
ciBCSVRfUlhETUFfQUdHX1BHX1RIIDEgbG9va3Mgc3VzcGljaW91czoNCj4gPiA+IE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCBJIHNob3VsZG4ndCBiZSBzZWVpbmcgcnhfbGVuIGxhcmdlciB0aGFu
DQo+ID4gPiBCSVRfUlhETUFfQUdHX1BHX1RIICogMTAyNC4NCj4gPiA+IEJJVF9SWERNQV9BR0df
UEdfVEggPSA2IGlzIHdpdGhpbiB0aGlzIGxpbWl0IGJ1dCBCSVRfUlhETUFfQUdHX1BHX1RIID0N
Cj4gPiA+IDEgaXNuJ3QgKEknbSBzZWVpbmcgNTc4IGV4dHJhIGJ5dGVzIGluIGFkZGl0aW9uIHRv
IHRoZSAxMDI0IGJ5dGVzIHRoYXQNCj4gPiA+IEkgd2FzIGV4cGVjdGluZykuDQo+ID4NCj4gPiBB
c3N1bWUgdGhyZXNob2xkIGlzIDFrLCBhbmQgc2luZ2xlIG9uZSBwYWNrZXQgaXMgbGFyZ2VyIHRo
YW4gMWsuIEhhcmR3YXJlDQo+ID4gd2lsbCBub3Qgc3BsaXQgaXQgaW50byB0d28uIEFsc28sIHBs
ZWFzZSBtYWtlIHN1cmUgMHgyODBbMjldIEJJVF9FTl9QUkVfQ0FMQw0KPiA+IGlzIDEuIE90aGVy
d2lzZSwgaXQgd2lsbCBwb3NzaWJseSBhZ2dyZWdhdGUgYWRkaXRpb25hbCBvbmUgcGFja2V0IHRv
IG92ZXINCj4gPiB0aGUgdGhyZXNob2xkLg0KPiBGcm9tIHRoZSBudW1iZXJzIGFib3ZlIGl0IHNl
ZW1zIG1vc3QgbGlrZWx5IHRoYXQgd2UncmUgaGl0dGluZyB0aGUNCj4gIm9uZSBwYWNrZXQgaXMg
bGFyZ2VyIHRoYW4gMWsiIGNhc2UuDQo+IA0KPiBBbHNvIEknbSBzZWVpbmc6DQo+ICAgd2xhbjA6
IDxCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYyBub3F1ZXVl
DQo+IHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQo+IE15IGludGVyZmFjZSdzIE1U
VSBpcyAxNTAwIGJ5dGVzLiBTZWVpbmcgMTYwMiBieXRlcyByeF9sZW4gd2l0aCBvbmUNCj4gcGFj
a2V0IGlzIGFscmVhZHkgb2RkICh0aGF0IHdvdWxkIG1lYW4gMTAyIGJ5dGVzIGZvciBvdmVyaGVh
ZCBsaWtlIFJYDQo+IGRlc2NyaXB0b3IgYW5kIG90aGVyIGhlYWRlcnMvbWV0YWRhdGEpLiBCdXQg
MzEzMiBieXRlcyByeF9sZW4gaXMgdmVyeQ0KPiBvZGQuDQoNCkkgdGhpbmsgTVRVIG9ubHkgYWZm
ZWN0cyB0cmFuc21pdHRpbmcgcGFja2V0cy4gV291bGQgeW91IG1pbmQgdG8gdHJ5IHRvDQpzZXQg
cGVlcidzIE1UVSB0byAxMDAwIG9yIGxvd2VyPw0KDQpGb3IgcmVjZWl2ZWQgcGFja2V0cywgZHJp
dmVyIGlzIHRoZSBmaXJzdCBlbnRyeSwgc28gbWF5YmUgbmV0IHN0YWNrIGNhbg0Kc2hyaW5rIHBh
Y2tldCBzaXplIHRvIGZpdCBNVFUsIG5vdCBzdXJlIHRob3VnaC4NCg0KVGhlIGxhcmdlIDMxMzIt
Ynl0ZSBwYWNrZXQgaXMgYWxzbyB2ZXJ5IG9kZCB0byBtZS4gVHJ5IHRvIGR1bXAgcmF3IGRhdGEN
CmFuZCBjaGVjayB0aGUgY29udGVudCB0aGF0IHBhY2tldCBzaXplIGlzIGxhcmdlciB0aGFuIDE1
MDAuDQoNCg0KQW4gaWRlYSBmcm9tIG15IGNvbGxlYWd1ZS4gSXMgaXQgcG9zc2libGUgdG8gbXVs
dGlwbGUgcmVhZF9wb3J0IGZvciBhIGNlcnRhaW4NCnJlY2VpdmluZz8gTGlrZSBiZWxvdyBwc2V1
ZG8gY29kZTogKEkgZG9uJ3QgZGVmaW5lICcqIGhvc3QnKQ0KDQpAQCAtNTAyLDE3ICs1MDIsMjYg
QEAgc3RhdGljIGludCBydHdfc2Rpb19yZWFkX3BvcnQoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwg
dTggKmJ1Ziwgc2l6ZV90IGNvdW50KQ0KICAgICAgICBzdHJ1Y3QgcnR3X3NkaW8gKnJ0d3NkaW8g
PSAoc3RydWN0IHJ0d19zZGlvICopcnR3ZGV2LT5wcml2Ow0KICAgICAgICBib29sIGJ1c19jbGFp
bSA9IHJ0d19zZGlvX2J1c19jbGFpbV9uZWVkZWQocnR3c2Rpbyk7DQogICAgICAgIHUzMiByeGFk
ZHIgPSBydHdzZGlvLT5yeF9hZGRyKys7DQorICAgICAgIHNpemVfdCBuOw0KICAgICAgICBpbnQg
cmV0Ow0KDQogICAgICAgIGlmIChidXNfY2xhaW0pDQogICAgICAgICAgICAgICAgc2Rpb19jbGFp
bV9ob3N0KHJ0d3NkaW8tPnNkaW9fZnVuYyk7DQoNCi0gICAgICAgcmV0ID0gc2Rpb19tZW1jcHlf
ZnJvbWlvKHJ0d3NkaW8tPnNkaW9fZnVuYywgYnVmLA0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUlRXX1NESU9fQUREUl9SWF9SWDBGRl9HRU4ocnhhZGRyKSwgY291bnQpOw0KLSAg
ICAgICBpZiAocmV0KQ0KLSAgICAgICAgICAgICAgIHJ0d193YXJuKHJ0d2RldiwNCi0gICAgICAg
ICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIHJlYWQgJXp1IGJ5dGUocykgZnJvbSBTRElPIHBv
cnQgMHglMDh4IiwNCi0gICAgICAgICAgICAgICAgICAgICAgICBjb3VudCwgcnhhZGRyKTsNCisg
ICAgICAgd2hpbGUgKGNvdW50ID4gMCkgew0KKyAgICAgICAgICAgICAgIG4gPSBtaW4oaG9zdC0+
bWF4X3JlcV9zaXplLCBjb3VudCk7DQorDQorICAgICAgICAgICAgICAgcmV0ID0gc2Rpb19tZW1j
cHlfZnJvbWlvKHJ0d3NkaW8tPnNkaW9fZnVuYywgYnVmLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBSVFdfU0RJT19BRERSX1JYX1JYMEZGX0dFTihyeGFkZHIpLCBu
KTsNCisgICAgICAgICAgICAgICBpZiAocmV0KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcnR3
X3dhcm4ocnR3ZGV2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0
byByZWFkICV6dSBieXRlKHMpIGZyb20gU0RJTyBwb3J0IDB4JTA4eCIsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBuLCByeGFkZHIpOw0KKw0KKyAgICAgICAgICAgICAgIGNvdW50
IC09IG47DQorICAgICAgICAgICAgICAgYnVmICs9IG47DQorICAgICAgIH0NCisNCg0KICAgICAg
ICBpZiAoYnVzX2NsYWltKQ0KICAgICAgICAgICAgICAgIHNkaW9fcmVsZWFzZV9ob3N0KHJ0d3Nk
aW8tPnNkaW9fZnVuYyk7DQoNCg0KUGluZy1LZQ0KDQo=
