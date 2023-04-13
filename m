Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C76E1082
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDMO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDMO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:58:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AEA260;
        Thu, 13 Apr 2023 07:58:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33DEvePkB015836, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33DEvePkB015836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 22:57:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 13 Apr 2023 22:58:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Apr 2023 22:58:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 22:58:02 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Thread-Topic: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Thread-Index: AQHZbO8UV6MphwFb1U6iZXdc0JZwLK8oH9uAgAA0XICAAQIqgA==
Date:   Thu, 13 Apr 2023 14:58:01 +0000
Message-ID: <9f6abbe7a6fd479c98e2fd6c1080ad8a@realtek.com>
References: <20230412033006.10859-2-stanley_chang@realtek.com>
 <20230413042503.4047-1-stanley_chang@realtek.com>
 <167e4a8c-3ebd-92b7-1481-947f08901f97@kernel.org>
In-Reply-To: <167e4a8c-3ebd-92b7-1481-947f08901f97@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMy8wNC8yMDIzIDA2OjI1LCBTdGFubGV5IENoYW5nIHdyb3RlOg0KPiA+IEFkZCBhIG5l
dyAnc25wcyxnbG9iYWwtcmVncy1zdGFydGluZy1vZmZzZXQnIERUIHRvIGR3YzMgY29yZSB0byBy
ZW1hcA0KPiA+IHRoZSBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcw0KPiA+DQo+ID4gVGhl
IFJUSyBESEMgU29DcyB3ZXJlIGRlc2lnbmVkIHRoZSBnbG9iYWwgcmVnaXN0ZXIgYWRkcmVzcyBv
ZmZzZXQgYXQNCj4gPiAweDgxMDAuIFRoZSBkZWZhdWx0IGFkZHJlc3MgaXMgYXQgRFdDM19HTE9C
QUxTX1JFR1NfU1RBUlQgKDB4YzEwMCkuDQo+ID4gVGhlcmVmb3JlLCBhZGQgdGhlIHByb3BlcnR5
IG9mIGRldmljZS10cmVlIHRvIGFkanVzdCB0aGlzIHN0YXJ0IGFkZHJlc3MuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICB2MSB0byB2MiBjaGFuZ2U6DQo+ID4gMS4gQ2hhbmdlIHRoZSBuYW1lIG9m
IHRoZSBwcm9wZXJ0eSAic25wcyxnbG9iYWwtcmVncy1zdGFydGluZy1vZmZzZXQiLg0KPiA+IC0t
LQ0KPiANCj4gRGlkbid0IHlvdSBnb3QgYWxyZWFkeSBjb21tZW50IGZvciB0aGlzIHBhdGNoPyBI
b3cgZGlkIHlvdSBpbXBsZW1lbnQgaXQ/DQo+IA0KPiBBbHNvLCBJIGFza2VkIHlvdSBtdWx0aXBs
ZSB0aW1lczoNCj4gDQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8g
Z2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cw0KPiB0byBDQy4gIEl0IG1p
Z2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2
ZXMNCj4geW91IG91dGRhdGVkIGVudHJpZXMuICBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91
IGJhc2UgeW91ciBwYXRjaGVzIG9uDQo+IHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0KPiBJIGRv
bid0IHVuZGVyc3RhbmQgd2h5IHlvdSBpZ25vcmUgdGhpcy4NCj4gDQo+IE5BSywgcGF0Y2ggaXMg
bm90IGNvcnJlY3QuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KVGhh
bmsgeW91IGZvciB5b3VyIHBhdGllbnQgZ3VpZGFuY2UuDQpCZWNhdXNlIEknbSBub3QgZmFtaWxp
YXIgd2l0aCB0aGUgcmV2aWV3IHByb2Nlc3MgYW5kIGRpZG4ndCB1c2Ugc2NyaXB0cy9nZXRfbWFp
bnRhaW5lcnMucGwgcHJvcGVybHkgaW4gdGhlIGluaXRpYWwgZW1haWwgdGhyZWFkLg0KVGhlcmVm
b3JlLCB0aGlzIHNlcmllcyBvZiBlcnJvcnMgd2FzIGNhdXNlZC4gU29ycnkgZm9yIHRoZSBjb25m
dXNpb24uDQpOb3cgSSBrbm93IGhvdyB0byB1c2UgdGhlIHNjcmlwdCBwcm9wZXJseS4NCkFmdGVy
IGNvcnJlY3RpbmcgdGhlIG1haW50YWluZXIncyBzdWdnZXN0aW9uLCBJJ2xsIHJlc3RhcnQgYSBu
ZXcgZW1haWwgdGhyZWFkIGFuZCByZXZpZXcgYWdhaW4uDQoNCg==
