Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32B7366E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFTJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFTJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:02:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0110DB;
        Tue, 20 Jun 2023 02:01:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35K90aPyA001800, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35K90aPyA001800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 20 Jun 2023 17:00:36 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 20 Jun 2023 17:00:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Jun 2023 17:00:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 20 Jun 2023 17:00:56 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 3.0 PHY
Thread-Topic: [PATCH v4 5/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 3.0 PHY
Thread-Index: AQHZnqK7bNeHfuoIkUaXuk63ITG3c6+OKjAAgAUwpXA=
Date:   Tue, 20 Jun 2023 09:00:56 +0000
Message-ID: <79731b2216f24df9b2db0bc8795b26bb@realtek.com>
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-5-stanley_chang@realtek.com>
 <90f802db-79cc-010a-9a83-c7bdbf0d0c00@linaro.org>
In-Reply-To: <90f802db-79cc-010a-9a83-c7bdbf0d0c00@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gK8KgIGNvbXBhdGlibGU6DQo+
ID4gK8KgwqDCoCBpdGVtczoNCj4gPiArwqDCoMKgwqDCoCAtIGVudW06DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoCAtIHJlYWx0ZWsscnRkMTI5NS11c2IzcGh5DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoCAtIHJlYWx0ZWsscnRkMTMxOS11c2IzcGh5DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCAt
IHJlYWx0ZWsscnRkMTMxOWQtdXNiM3BoeQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSByZWFs
dGVrLHJ0ZDE2MTktdXNiM3BoeQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSByZWFsdGVrLHJ0
ZDE2MTliLXVzYjNwaHkNCj4gPiArwqDCoMKgwqDCoCAtIGNvbnN0OiByZWFsdGVrLHVzYjNwaHkN
Cj4gDQo+IERyb3AgbGFzdCBjb21wYXRpYmxlLCBpdCBpcyBub3QgdXNlZCBub3cuIERvZXMgbm90
IG1ha2Ugc2Vuc2UuDQoNCk9rYXkuIEkgd2lsbCByZW1vdmUgaXQuDQoNCj4gPiArDQo+ID4gK8Kg
IHJlZzoNCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiBQSFkgZGF0YSByZWdpc3RlcnMNCj4gDQo+
IERyb3AgZGVzY3JpcHRpb24sIGl0J3Mgb2J2aW91cy4NCg0KT2theS4NCg0KPiA+ICvCoMKgwqAg
bWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK8KgICIjcGh5LWNlbGxzIjoNCj4gPiArwqDCoMKgIGNv
bnN0OiAwDQo+ID4gKw0KPiA+ICvCoCBudm1lbS1jZWxsczoNCj4gPiArwqDCoMKgIG1heEl0ZW1z
OiAxDQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogQSBwaGFuZGxlIHRvIHRoZSB0eCBsZnBzIHN3
aW5nIHRyaW0gZGF0YSBwcm92aWRlZCBieQ0KPiA+ICvCoMKgwqDCoMKgIGEgbnZtZW0gZGV2aWNl
LCBpZiB1bnNwZWNpZmllZCwgZGVmYXVsdCB2YWx1ZXMgc2hhbGwgYmUgdXNlZC4NCj4gPiArDQo+
ID4gK8KgIG52bWVtLWNlbGwtbmFtZXM6DQo+ID4gK8KgwqDCoCBpdGVtczoNCj4gPiArwqDCoMKg
wqDCoCAtIGNvbnN0OiB1c2JfdTNfdHhfbGZwc19zd2luZ190cmltDQo+ID4gKw0KPiA+ICvCoCBy
ZWFsdGVrLGFtcGxpdHVkZS1jb250cm9sLWNvYXJzZS10dW5pbmc6DQo+ID4gK8KgwqDCoCBkZXNj
cmlwdGlvbjoNCj4gPiArwqDCoMKgwqDCoCBUaGlzIGFkanVzdHMgdGhlIHNpZ25hbCBhbXBsaXR1
ZGUgZm9yIG5vcm1hbCBvcGVyYXRpb24gYW5kIGJlYWNvbg0KPiBMRlBTLg0KPiA+ICvCoMKgwqDC
oMKgIFRoaXMgdmFsdWUgaXMgYSBwYXJhbWV0ZXIgZm9yIGNvYXJzZSB0dW5pbmcuDQo+ID4gK8Kg
wqDCoMKgwqAgRm9yIGRpZmZlcmVudCBib2FyZHMsIGlmIHRoZSBkZWZhdWx0IHZhbHVlIGlzIGlu
YXBwcm9wcmlhdGUsIHRoaXMNCj4gPiArwqDCoMKgwqDCoCBwcm9wZXJ0eSBjYW4gYmUgYXNzaWdu
ZWQgdG8gYWRqdXN0Lg0KPiANCj4gZGVmYXVsdDoNCg0KSSB3aWxsIGFkZCBpdC4NCg0KPiA+ICvC
oMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4g
K8KgwqDCoCBtaW5pbXVtOiAwDQo+ID4gK8KgwqDCoCBtYXhpbXVtOiAyNTUNCj4gPiArDQo+ID4g
K8KgIHJlYWx0ZWssYW1wbGl0dWRlLWNvbnRyb2wtZmluZS10dW5pbmc6DQo+ID4gK8KgwqDCoCBk
ZXNjcmlwdGlvbjoNCj4gPiArwqDCoMKgwqDCoCBUaGlzIGFkanVzdHMgdGhlIHNpZ25hbCBhbXBs
aXR1ZGUgZm9yIG5vcm1hbCBvcGVyYXRpb24gYW5kIGJlYWNvbg0KPiBMRlBTLg0KPiA+ICvCoMKg
wqDCoMKgIFRoaXMgdmFsdWUgaXMgdXNlZCBmb3IgZmluZS10dW5pbmcgcGFyYW1ldGVycy4NCj4g
PiArwqDCoMKgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0K
PiANCj4gZGVmYXVsdDoNCg0KSSB3aWxsIGFkZCBpdC4NCg0KPiA+ICvCoMKgwqAgbWluaW11bTog
MA0KPiA+ICvCoMKgwqAgbWF4aW11bTogNjU1MzUNCj4gPiArDQo+IA0KDQpUaGFua3MsDQpTdGFu
bGV5DQo=
