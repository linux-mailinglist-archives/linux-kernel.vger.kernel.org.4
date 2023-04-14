Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED86E1A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNCM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDNCMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:12:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381F2D4A;
        Thu, 13 Apr 2023 19:12:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33E2BnsnE014072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33E2BnsnE014072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 10:11:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 14 Apr 2023 10:12:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Apr 2023 10:12:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 14 Apr 2023 10:12:11 +0800
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
Thread-Index: AQHZbO8UV6MphwFb1U6iZXdc0JZwLK8oH9uAgAA0XICAAQIqgP//ld+AgAEmdrA=
Date:   Fri, 14 Apr 2023 02:12:11 +0000
Message-ID: <313863df3a3b492aa7590e1354d22d8b@realtek.com>
References: <20230412033006.10859-2-stanley_chang@realtek.com>
 <20230413042503.4047-1-stanley_chang@realtek.com>
 <167e4a8c-3ebd-92b7-1481-947f08901f97@kernel.org>
 <9f6abbe7a6fd479c98e2fd6c1080ad8a@realtek.com>
 <19946f94-db48-fe0d-722c-cbb45b8bd0ba@kernel.org>
In-Reply-To: <19946f94-db48-fe0d-722c-cbb45b8bd0ba@kernel.org>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+IERpZG4ndCB5b3UgZ290IGFscmVhZHkgY29tbWVudCBmb3IgdGhpcyBwYXRjaD8gSG93
IGRpZCB5b3UgaW1wbGVtZW50IGl0Pw0KPiA+Pg0KPiA+PiBBbHNvLCBJIGFza2VkIHlvdSBtdWx0
aXBsZSB0aW1lczoNCj4gPj4NCj4gPj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVy
cy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeQ0KPiA+PiBwZW9wbGUgYW5kIGxpc3RzIHRv
IENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4NCj4gPj4g
b2xkZXIga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gIFRoZXJlZm9yZSBwbGVh
c2UgYmUgc3VyZQ0KPiA+PiB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24gcmVjZW50IExpbnV4IGtl
cm5lbC4NCj4gPj4NCj4gPj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UgaWdub3JlIHRoaXMu
DQo+ID4+DQo+ID4+IE5BSywgcGF0Y2ggaXMgbm90IGNvcnJlY3QuDQo+ID4+DQo+ID4+IEJlc3Qg
cmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4+DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlv
dXIgcGF0aWVudCBndWlkYW5jZS4NCj4gPiBCZWNhdXNlIEknbSBub3QgZmFtaWxpYXIgd2l0aCB0
aGUgcmV2aWV3IHByb2Nlc3MgYW5kIGRpZG4ndCB1c2UNCj4gc2NyaXB0cy9nZXRfbWFpbnRhaW5l
cnMucGwgcHJvcGVybHkgaW4gdGhlIGluaXRpYWwgZW1haWwgdGhyZWFkLg0KPiA+IFRoZXJlZm9y
ZSwgdGhpcyBzZXJpZXMgb2YgZXJyb3JzIHdhcyBjYXVzZWQuIFNvcnJ5IGZvciB0aGUgY29uZnVz
aW9uLg0KPiA+IE5vdyBJIGtub3cgaG93IHRvIHVzZSB0aGUgc2NyaXB0IHByb3Blcmx5Lg0KPiA+
IEFmdGVyIGNvcnJlY3RpbmcgdGhlIG1haW50YWluZXIncyBzdWdnZXN0aW9uLCBJJ2xsIHJlc3Rh
cnQgYSBuZXcgZW1haWwgdGhyZWFkDQo+IGFuZCByZXZpZXcgYWdhaW4uDQo+IA0KPiBEaWQgeW91
IHJlc3BvbmQgdG8gZmVlZGJhY2sgeW91IGdvdCBhYm91dCB0aGUgcHJvcGVydHk/IERpZCByZXZp
ZXdlciBhZ3JlZWQNCj4gb24geW91ciB2aWV3IGFmdGVyIHlvdXIgZmVlZGJhY2s/DQo+IA0KPiBJ
ZiBub3QsIHRoZW4gd2h5IHJlc2VuZGluZyB0aGlzIHBhdGNoPw0KPiANCg0KMS4gQmVjYXVzZSB5
b3Ugc2FpZCwgIlRoaXMgcGF0Y2ggaXMgaW5jb3JyZWN0Ii4gQW5kIEkgd29uJ3QgYmUgY2MnaW5n
IHRoZSBwcm9wZXIgbWFpbnRhaW5lci4NCkkgdGhpbmsgSSBuZWVkIHRvIHJlc3RhcnQgYSBuZXcg
cmV2aWV3IHByb2Nlc3MuDQoyLiBNb2RpZnkgdGhlIHByZXZpb3VzIHJldmlld2VyJ3MgY29tbWVu
dHMgYW5kIGZpeCB0aGUgZHRzY2hlbWEgdmFsaWRhdGlvbiBlcnJvci4NCg0KQW0gSSBtaXN1bmRl
cnN0YW5kaW5nIHdoYXQgeW91IG1lYW4/DQpDYW4gSSBrZWVwIHJldmlld2luZyB0aGlzIHBhdGNo
IG9uIHRoaXMgZW1haWwgdGhyZWFkIHVudGlsIGNvbnNlbnN1cyBpcyByZWFjaGVkIHdpdGggdGhl
IHJldmlld2Vycz8NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
