Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962326F3FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjEBI4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:56:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA72E19A1;
        Tue,  2 May 2023 01:56:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3428uMIx9012413, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3428uMIx9012413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 2 May 2023 16:56:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 2 May 2023 16:56:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 May 2023 16:56:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 2 May 2023 16:56:26 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] dt-bindings: usb: snps,dwc3: Add the compatible name 'snps,dwc3-rtk-soc'
Thread-Topic: [PATCH v4 2/2] dt-bindings: usb: snps,dwc3: Add the compatible
 name 'snps,dwc3-rtk-soc'
Thread-Index: AQHZfLOhYfbzHfxzYE2TNUg+fEIenq9GE1eAgACG7nD//4ryAIAAh9bw
Date:   Tue, 2 May 2023 08:56:26 +0000
Message-ID: <a04e70f97bcb48048edb2f6db7bb6c25@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
 <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
 <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
In-Reply-To: <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+ID4+IE9uIDAyLzA1LzIwMjMgMDc6MDQsIFN0YW5sZXkgQ2hhbmcg
d3JvdGU6DQo+ID4+PiBBZGQgYSBuZXcgY29tcGF0aWJsZSBuYW1lICdzbnBzLGR3YzMtcnRrLXNv
Yycgb2YgRFQgZm9yIHJlYWx0ZWsgZHdjMw0KPiA+Pj4gY29yZSB0byBhZGp1c3QgdGhlIGdsb2Jh
bCByZWdpc3RlciBzdGFydCBhZGRyZXNzDQo+ID4+Pg0KPiA+Pj4gVGhlIFJUSyBESEMgU29DcyB3
ZXJlIGRlc2lnbmVkLCB0aGUgZ2xvYmFsIHJlZ2lzdGVyIGFkZHJlc3Mgb2Zmc2V0DQo+ID4+PiBh
dA0KPiA+Pg0KPiA+PiBXaGF0IGFyZTogIlJUSyIgYW5kICJESEMiPyBUaGVzZSBhcmUgbWFudWZh
Y3R1cmVkIGJ5IFN5bm9wc3lzIGFzIHlvdQ0KPiA+PiBzdWdnZXN0IGluIHRoZSBwYXRjaD8NCj4g
Pg0KPiA+IFJUSyBpcyBSZWFsdGVrLg0KPiA+IERIQyBpcyB0aGUgZGVwYXJ0bWVudCBuYW1lIGlu
IFJlYWx0ZWsgYW5kIHRoZSBhYmJyZXZpYXRpb24gb2YgdGhlIERpZ2l0YWwNCj4gSG9tZSBDZW50
ZXIuDQo+ID4gVGhlIFVTQiBjb250cm9sbGVyIG9mIFJUSyBESEMgU29DcyB1c2VkIHRoZSBEV0Mz
IElQIG9mIFN5bm9wc3lzLg0KPiANCj4gVGhlbiBlbnRpcmUgY29tcGF0aWJsZSBpcyBub3QgY29y
cmVjdC4gVmVuZG9yIGlzIFJlYWx0ZWsgbm90IFN5bm9wc3lzLg0KPiBESEMgaXMgbm90IGV2ZW4g
ZGV2aWNlIG5hbWUuIFVzZSByZWFsIGRldmljZSBuYW1lcy4NCg0KU28sIGNhbiB3ZSB1c2UgdGhl
IGNvbXBhdGlibGUgbmFtZSBhcyAncmVhbHRlayxkd2MzJyA/DQpGb3IgZXhhbXBsZSwNCkBAIC0y
MjI0LDEwICsyMjMwLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2Rl
dl9wbV9vcHMgPSB7DQogI2lmZGVmIENPTkZJR19PRg0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG9mX2R3YzNfbWF0Y2hbXSA9IHsNCiAgICAgICAgew0KLSAgICAgICAgICAgICAg
IC5jb21wYXRpYmxlID0gInNucHMsZHdjMyINCisgICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9
ICJzbnBzLGR3YzMiLA0KKyAgICAgICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilEV0MzX0dMT0JB
TFNfUkVHU19TVEFSVCwNCisgICAgICAgfSwNCisgICAgICAgew0KKyAgICAgICAgICAgICAgIC5j
b21wYXRpYmxlID0gInJlYWx0ZWssZHdjMyIsDQorICAgICAgICAgICAgICAgLmRhdGEgPSAodm9p
ZCAqKURXQzNfR0xPQkFMU19SRUdTX1NUQVJUX0ZPUl9SVEssDQogICAgICAgIH0sDQogICAgICAg
IHsNCi0gICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9ICJzeW5vcHN5cyxkd2MzIg0KKyAgICAg
ICAgICAgICAgIC5jb21wYXRpYmxlID0gInN5bm9wc3lzLGR3YzMiLA0KKyAgICAgICAgICAgICAg
IC5kYXRhID0gKHZvaWQgKilEV0MzX0dMT0JBTFNfUkVHU19TVEFSVCwNCiAgICAgICAgfSwNCiAg
ICAgICAgeyB9LA0KIH07DQoNCj4gPg0KPiA+Pj4gMHg4MTAwLiBUaGUgZGVmYXVsdCBhZGRyZXNz
IG9mZnNldCBpcyBjb25zdGFudCBhdA0KPiA+Pj4gRFdDM19HTE9CQUxTX1JFR1NfU1RBUlQgKDB4
YzEwMCkuIFRoZXJlZm9yZSwgYWRkIHRoZSBjb21wYXRpYmxlDQo+ID4+IG5hbWUNCj4gPj4+IG9m
IGRldmljZS10cmVlIHRvIHNwZWNpZnkgdGhlIFNvQyBjdXN0b20ncyBnbG9iYWwgcmVnaXN0ZXIg
c3RhcnQgYWRkcmVzcy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5n
IDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+Pg0KPiA+PiBCYXNlZCBvbiB5b3VyIGVt
YWlsLCBydGsgY291bGQgbWVhbiBSZWFsdGVrLCBzbyB0aGUgY29tcGF0aWJsZSBpcw0KPiA+PiBj
bGVhcmx5IHdyb25nLg0KPiA+DQo+ID4gVGhlIGNvbXBhdGlibGUgbmFtZSAic25wcyxkd2MzLXJ0
ay1zb2MiIHdhbnRzIHRvIHJlcHJlc2VudCB0aGUgZHdjMw0KPiA+IGRyaXZlciwgd2hpY2ggcmVx
dWlyZXMgYSBkaWZmZXJlbnQgb2Zmc2V0IGZvciBSZWFsdGVrIFNvQ3MNCj4gDQo+IE5vLiBUaGUg
Y29tcGF0aWJsZSByZXByZXNlbnRzIGhhcmR3YXJlLCBub3QgZHJpdmVyLiBVc2UgY29tcGF0aWJs
ZSBtYXRjaGluZw0KPiByZWFsIGhhcmR3YXJlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCj4gDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJl
Zm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
