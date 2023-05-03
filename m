Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63466F4F06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECDJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjECDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:09:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330FA1FCD;
        Tue,  2 May 2023 20:09:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34338mTkA001432, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34338mTkA001432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 3 May 2023 11:08:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 3 May 2023 11:08:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 3 May 2023 11:08:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 3 May 2023 11:08:52 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's global register start address
Thread-Topic: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Index: AQHZfLOhhQrACak8/kmYU8MJMzcjSq9HDZGAgADOLaA=
Date:   Wed, 3 May 2023 03:08:52 +0000
Message-ID: <05bcd78a37e945528ec68592eb73d755@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
In-Reply-To: <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

SGkgVGhpbmgsDQoNCj4gSSB0aGluayB5b3UncmUgb3ZlcmNvbXBsaWNhdGluZyB0aGluZ3MgaGVy
ZS4NCj4gDQo+IENhbiB3ZSBqdXN0IG1hdGNoIHVzaW5nIGNvbXBhdGlibGUgc3RyaW5nIGFzIG1l
bnRpb25lZCBiZWZvcmU/IEkgYmVsaWV2ZSBJDQo+IHN1Z2dlc3RlZCB0byB1c2UgdGhhdCBiZWZv
cmUgYnV0IEkgdGhpbmsgeW91IGhhZCBpc3N1ZSB3ZSBnZXR0aW5nIGl0IGJlY2F1c2UgaXQncw0K
PiBmcm9tIHRoZSBwYXJlbnQgZGV2aWNlPw0KPiANCj4gRGlkIHlvdSB0cnkgdGhpcz8NCj4gDQo+
ICAgICAgICAgZHdjX3Jlcy5zdGFydCA9IERXQzNfUlRLX0FCQ19HTE9CQUxfT0ZGU0VUOw0KPiAN
Cj4gICAgICAgICBpZiAoZGV2LT5vZl9ub2RlKSB7DQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnBhcmVudCA9DQo+IG9mX2dldF9wYXJlbnQoZGV2LT5vZl9ub2RlKTsNCj4g
DQo+ICAgICAgICAgICAgICAgICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUocGFyZW50LCAi
eW91ci1jb21wYXRpYmxlIikpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGR3Y19yZXMuc3Rh
cnQgPQ0KPiBEV0MzX1JUS19BQkNfR0xPQkFMX09GRlNFVDsNCj4gDQo+ICAgICAgICAgICAgICAg
ICBvZl9ub2RlX3B1dChwYXJlbnQpOw0KPiAgICAgICAgIH0NCg0KVGhpcyBpcyBhIGdvb2QgaWRl
YS4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpUaGlzIHBhdGNoIHdvcmtzIGZpbmUgYW5k
IGl0IGlzIHNpbXBseS4gDQpGb3IgdGhlIGNvbXBhdGlibGUgbmFtZSwgSSB1c2UgdGhhdCAicmVh
bHRlayxydGQxeHh4LWR3YzMiLiANCnJ0ZDF4eHggaXMgdGhlIG5hbWUgb2YgU29DcywgZm9yIHJ0
ZDEyOXgsIHJ0ZDEzOXgsIHJ0ZDE2eHgsIC4uLiBldGMuDQpEbyB5b3UgaGF2ZSBhbnkgY29uY2Vy
bj8NCg0KTmV3IHBhdGNoIGFzIGZvbGxvd3MNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQppbmRleCAwYmVhYWI5MzJlN2QuLmNk
NGI2OTU0MTc3NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQorKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KQEAgLTE4MDAsNiArMTgwMCwxNyBAQCBzdGF0aWMgaW50
IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAgICAgICAgZHdjX3Jl
cyA9ICpyZXM7DQogICAgICAgIGR3Y19yZXMuc3RhcnQgKz0gRFdDM19HTE9CQUxTX1JFR1NfU1RB
UlQ7DQoNCisgICAgICAgaWYgKGRldi0+b2Zfbm9kZSkgew0KKyAgICAgICAgICAgICAgIHN0cnVj
dCBkZXZpY2Vfbm9kZSAqcGFyZW50ID0gb2ZfZ2V0X3BhcmVudChkZXYtPm9mX25vZGUpOw0KKw0K
KyAgICAgICAgICAgICAgIGlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShwYXJlbnQsICJyZWFs
dGVrLHJ0ZDF4eHgtZHdjMyIpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBkd2NfcmVzLnN0
YXJ0IC09IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KKyAgICAgICAgICAgICAgICAgICAgICAg
ZHdjX3Jlcy5zdGFydCArPSBSVEtfUlREMVhYWF9EV0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCisg
ICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQocGFyZW50KTsN
CisgICAgICAgfQ0KKw0KICAgICAgICByZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwg
JmR3Y19yZXMpOw0KICAgICAgICBpZiAoSVNfRVJSKHJlZ3MpKQ0KICAgICAgICAgICAgICAgIHJl
dHVybiBQVFJfRVJSKHJlZ3MpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCmluZGV4IGQ1NjQ1N2MwMjk5Ni4uZGI0OGFhZTIx
MWJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCisrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQpAQCAtODQsNiArODQsOCBAQA0KICNkZWZpbmUgRFdDM19PVEdfUkVH
U19TVEFSVCAgICAgICAgICAgIDB4Y2MwMA0KICNkZWZpbmUgRFdDM19PVEdfUkVHU19FTkQgICAg
ICAgICAgICAgIDB4Y2NmZg0KDQorI2RlZmluZSBSVEtfUlREMVhYWF9EV0MzX0dMT0JBTFNfUkVH
U19TVEFSVCAgICAweDgxMDANCisNCiAvKiBHbG9iYWwgUmVnaXN0ZXJzICovDQogI2RlZmluZSBE
V0MzX0dTQlVTQ0ZHMCAgICAgICAgIDB4YzEwMA0KICNkZWZpbmUgRFdDM19HU0JVU0NGRzEgICAg
ICAgICAweGMxMDQNCg0K
