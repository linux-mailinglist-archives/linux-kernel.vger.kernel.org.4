Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B256DF2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDLLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDLLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:12:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06B72AA;
        Wed, 12 Apr 2023 04:12:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33CBBB1S0003028, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33CBBB1S0003028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 12 Apr 2023 19:11:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 12 Apr 2023 19:11:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Apr 2023 19:11:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 12 Apr 2023 19:11:32 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Thread-Topic: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Thread-Index: AQHZbO8UV6MphwFb1U6iZXdc0JZwLK8m+XKAgACLYrA=
Date:   Wed, 12 Apr 2023 11:11:32 +0000
Message-ID: <aa52c3b14b3b4f8dbf3c5403392dac42@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412033006.10859-2-stanley_chang@realtek.com>
 <955cc334-eaac-5880-51cf-8ab171f0ef48@kernel.org>
In-Reply-To: <955cc334-eaac-5880-51cf-8ab171f0ef48@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMi8wNC8yMDIzIDA1OjMwLCBTdGFubGV5IENoYW5nIHdyb3RlOg0KPiA+IEFkZCBhIG5l
dyAnc25wcyxnbG9iYWwtcmVncy1zdGFydGluZy1vZmZzZXQnIERUIHRvIGR3YzMgY29yZSB0byBy
ZW1hcA0KPiA+IHRoZSBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcw0KPiA+DQo+ID4gVGhl
IFJUSyBESEMgU29DcyB3ZXJlIGRlc2lnbmVkIHRoZSBnbG9iYWwgcmVnaXN0ZXIgYWRkcmVzcyBv
ZmZzZXQgYXQNCj4gPiAweDgxMDAuIFRoZSBkZWZhdWx0IGFkZHJlc3MgaXMgYXQgRFdDM19HTE9C
QUxTX1JFR1NfU1RBUlQgKDB4YzEwMCkuDQo+ID4gVGhlcmVmb3JlLCBhZGQgdGhlIHByb3BlcnR5
IG9mIGRldmljZS10cmVlIHRvIGFkanVzdCB0aGlzIHN0YXJ0IGFkZHJlc3MuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0K
PiANCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0
IG9mIG5lY2Vzc2FyeSBwZW9wbGUgYW5kIGxpc3RzDQo+IHRvIENDLiAgSXQgbWlnaHQgaGFwcGVu
LCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcw0KPiB5b3Ug
b3V0ZGF0ZWQgZW50cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3Vy
IHBhdGNoZXMgb24NCj4gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+IFNpbmNlIHlvdSBza2lw
cGVkIGxpc3RzIHVzZWQgaW4gYXV0b21hdGVkIGNoZWNrLCB0aGF0J3MNCj4gdW5mb3J0dW5hdGVs
eTogTkFLDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiAN
CkNDIG1vcmUgbWFpbnRhaW5lcnMgYnkgdXNpbmcgc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwN
Cg0KVGhhbmtzLA0KU3RhbmxleQ0K
