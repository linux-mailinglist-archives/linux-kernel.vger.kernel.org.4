Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E476E1F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDNJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDNJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:37:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699D5FD0;
        Fri, 14 Apr 2023 02:37:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33E9aZTb9012399, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33E9aZTb9012399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 17:36:35 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Apr 2023 17:36:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Apr 2023 17:36:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 14 Apr 2023 17:36:57 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Thread-Topic: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Thread-Index: AQHZbO8UV6MphwFb1U6iZXdc0JZwLK8nG/AAgAFozGCAAXy5AIAAhuPA
Date:   Fri, 14 Apr 2023 09:36:57 +0000
Message-ID: <a8ceb3e4cae842118b805d92db0465bf@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412033006.10859-2-stanley_chang@realtek.com>
 <CAL_JsqLqTHbHjB1qiLduhzvTaO7EBMgL6KYqZJtgStGVGtX1vQ@mail.gmail.com>
 <5ae89b563e234acdb36a4ae253cec869@realtek.com>
 <94db291f-6d93-548b-92ad-3a9f480783e2@kernel.org>
In-Reply-To: <94db291f-6d93-548b-92ad-3a9f480783e2@kernel.org>
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

DQoNCj4gT24gMTMvMDQvMjAyMyAwNDo1MywgU3RhbmxleSBDaGFuZ1vmmIzogrLlvrddIHdyb3Rl
Og0KPiA+DQo+ID4+DQo+ID4+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDEwOjMw4oCvUE0gU3Rh
bmxleSBDaGFuZw0KPiA+PiA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4+
Pg0KPiA+Pj4gQWRkIGEgbmV3ICdzbnBzLGdsb2JhbC1yZWdzLXN0YXJ0aW5nLW9mZnNldCcgRFQg
dG8gZHdjMyBjb3JlIHRvDQo+ID4+PiByZW1hcCB0aGUgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0IGFk
ZHJlc3MNCj4gPj4+DQo+ID4+PiBUaGUgUlRLIERIQyBTb0NzIHdlcmUgZGVzaWduZWQgdGhlIGds
b2JhbCByZWdpc3RlciBhZGRyZXNzIG9mZnNldCBhdA0KPiA+Pj4gMHg4MTAwLiBUaGUgZGVmYXVs
dCBhZGRyZXNzIGlzIGF0IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUICgweGMxMDApLg0KPiA+Pj4g
VGhlcmVmb3JlLCBhZGQgdGhlIHByb3BlcnR5IG9mIGRldmljZS10cmVlIHRvIGFkanVzdCB0aGlz
IHN0YXJ0IGFkZHJlc3MuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFu
ZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwgfCA3ICsrKysrKysN
Cj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2Mz
LnlhbWwNCj4gPj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBz
LGR3YzMueWFtbA0KPiA+Pj4gaW5kZXggYmUzNjk1NmFmNTNiLi41Y2JmM2I3ZGVkMDQgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMs
ZHdjMy55YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3NucHMsZHdjMy55YW1sDQo+ID4+PiBAQCAtMzU5LDYgKzM1OSwxMyBAQCBwcm9wZXJ0aWVz
Og0KPiA+Pj4gICAgICBpdGVtczoNCj4gPj4+ICAgICAgICBlbnVtOiBbMSwgNCwgOCwgMTYsIDMy
LCA2NCwgMTI4LCAyNTZdDQo+ID4+Pg0KPiA+Pj4gKyAgc25wcyxnbG9iYWwtcmVncy1zdGFydGlu
Zy1vZmZzZXQ6DQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAgIHZhbHVlIGZv
ciByZW1hcHBpbmcgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0IGFkZHJlc3MuIEZvciBzb21lIGR3YzMN
Cj4gPj4+ICsgICAgICBjb250cm9sbGVyLCB0aGUgZHdjMyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQg
YWRkcmVzcyBpcyBub3QgYXQNCj4gPj4+ICsgICAgICBkZWZhdWx0IERXQzNfR0xPQkFMU19SRUdT
X1NUQVJUICgweGMxMDApLiBUaGlzIHByb3BlcnR5IGlzDQo+ID4+IGFkZGVkIHRvDQo+ID4+PiAr
ICAgICAgYWRqdXN0IHRoZSBhZGRyZXNzLg0KPiA+Pg0KPiA+PiBXZSBhbHJlYWR5IGhhdmUgJ3Jl
Zycgb3IgdXNpbmcgYSBzcGVjaWZpYyBjb21wYXRpYmxlIHRvIGhhbmRsZQ0KPiA+PiBkaWZmZXJl
bmNlcy4gVXNlIG9uZSBvZiB0aG9zZSwgbm90IGEgY3VzdG9tIHByb3BlcnR5LiBHZW5lcmFsbHks
DQo+ID4+IHByb3BlcnRpZXMgc2hvdWxkIGJlIHVzZWQgZm9yIHRoaW5ncyB0aGF0IHZhcnkgcGVy
IGJvYXJkLCBub3QgZml4ZWQgaW4gYSBnaXZlbg0KPiBTb0MuDQo+ID4+DQo+ID4+IFJvYg0KPiA+
Pg0KPiA+DQo+ID4gVGhlIGRlZmF1bHQgb2Zmc2V0IGlzIGZpeGVkIGJ5IG1hY3JvIERXQzNfR0xP
QkFMU19SRUdTX1NUQVJULCBhbmQgaXQgaXMNCj4gbm90IHNwZWNpZmllZCBieSByZWcuDQo+IA0K
PiBBcmUgeW91IHNheWluZyB0aGF0IHJlZyBwb2ludHMgdG8gWEhDSSByZWdpc3RlcnMgYW5kIHRo
ZSBnYXAgYmV0d2VlbiB0aGVtIGFuZA0KPiBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVCBpcyBkaWZm
ZXJlbnQgb24gc29tZSBpbXBsZW1lbnRhdGlvbnMgb2YgdGhpcyBJUD8NCg0KWWVzLg0KDQo+ID4g
VGhlIGR3YzMvY29yZSBpcyBhIGdlbmVyYWwgZHJpdmVyIGZvciBldmVyeSBkd2MzIElQIG9mIFNv
Q3MsIGFuZA0KPiA+IHZlbmRvcidzIGRlZmluaXRpb24gYW5kIGNvbXBhdGlibGUgc2hvdWxkIHNw
ZWNpZnkgb24gaXRzIHBhcmVudC4NCj4gDQo+IE5vdCBlbnRpcmVseS4gSXQncyBob3cgY3VycmVu
dGx5IGl0IGlzIHdyaXR0ZW4sIGJ1dCBub3QgbmVjZXNzYXJpbHkgY29ycmVjdA0KPiByZXByZXNl
bnRhdGlvbi4gVGhlIHBhcmVudCBpcyBvbmx5IGdsdWUgcGFydCB3aGljaCBmb3Igc29tZSBub24t
SVAgcmVzb3VyY2VzLg0KDQpJIGFncmVlLiANCkkgdGhpbmsgdGhpcyBvZmZzZXQgYmVsb25ncyB0
byB0aGUgSVAgcmVzb3VyY2UuDQpCdXQgaXQgaXMgZml4ZWQgdmFsdWUgb24gZHdjMy9jb3JlIGRy
aXZlci4NClRoZXJlZm9yZSwgSSBoYWQgdG8gYWRkIHRoaXMgcGF0Y2ggdG8gYWRqdXN0IGl0Lg0K
DQo+ID4gSWYgd2UgYWRkIGEgc3BlY2lmaWMgY29tcGF0aWJsZSB0byBkd2MzL2NvcmUgZHJpdmVy
LCB0aGVuIGl0IHdpbGwgYnJlYWsgdGhpcw0KPiBydWxlLg0KPiANCj4gV2hhdCBydWxlPyBUaGUg
cnVsZSBpcyB0byBoYXZlIHNwZWNpZmljIGNvbXBhdGlibGVzLCBzbyBub3cgeW91IGFyZSBicmVh
a2luZyBpdC4NCj4gDQpJIGp1c3QgZG9uJ3Qgd2FudCBkd2MzL2NvcmUgdG8gbG9vayBsaWtlIGEg
c3BlY2lmaWMgUmVhbHRlayBkcml2ZXIuDQpJZiBJIGFkZCBjb21wYXRpYmxlIHRvIG91ciBwbGF0
Zm9ybSwgdGhlbiBhcHBseSB0aGlzIG9mZnNldC4NCkZvciBleGFtcGxlLA0KQEAgLTIwNDYsNiAr
MjA0Niw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX2R3YzNfbWF0Y2hb
XSA9IHsNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gInN5bm9wc3lz
LGR3YzMiDQogICAgICAgIH0sDQorICAgICAgIHsNCisgICAgICAgICAgICAgICAuY29tcGF0aWJs
ZSA9ICJyZWFsdGVrLGR3YzMiDQorICAgICAgIH0sDQogICAgICAgIHsgfSwNCiB9Ow0KDQpXaHkg
bm90IHVzZSBhIHByb3BlcnR5IG9mIHRoZSBkZXZpY2UgdHJlZSB0byBzcGVjaWZ5IHRoaXMgb2Zm
c2V0Pw0KSXQgd2lsbCBiZSBtb3JlIGdlbmVyYWwuIE90aGVyIHZlbmRvciBJUHMgY2FuIGFsc28g
dXNlIHRoaXMgb3B0aW9uIGlmIGRlc2lyZWQuDQpGb3IgZXhhbXBsZSwNCkBAIC0xMjMsNyArMTIz
LDcgQEAgcG9ydDBfZHdjMzogZHdjM191MmRyZEA5ODAyMDAwMCB7DQogICAgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gInN5bm9wc3lzLGR3YzMiLCAic3lzY29uIjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9IDwweDk4MDIwMDAwIDB4OTAwMD47DQogICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgOTUgND47DQorICAgICAgICAgICAgICAgICAgICAg
ICBzbnBzLGdsb2JhbC1yZWdzLXN0YXJ0aW5nLW9mZnNldCA9IDwweDgxMDA+Ow0KICAgICAgICAg
ICAgICAgICAgICAgICAgdXNiLXBoeSA9IDwmZHdjM191MmRyZF91c2IycGh5PjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGRyX21vZGUgPSAiaG9zdCI7DQogICAgICAgICAgICAgICAgICAgICAg
ICBzbnBzLGRpc191Ml9zdXNwaHlfcXVpcms7DQo=
