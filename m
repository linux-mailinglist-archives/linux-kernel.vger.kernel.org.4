Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D86F6352
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEDD3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEDD3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:29:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51794198A;
        Wed,  3 May 2023 20:29:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3443SnV52008791, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3443SnV52008791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 4 May 2023 11:28:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 4 May 2023 11:28:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 May 2023 11:28:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 4 May 2023 11:28:53 +0800
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
Thread-Index: AQHZfLOhhQrACak8/kmYU8MJMzcjSq9HDZGAgADOLaCAAMRYgIAA1wBA
Date:   Thu, 4 May 2023 03:28:53 +0000
Message-ID: <3393bfb7d9284242ad95ca350558abd9@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
 <05bcd78a37e945528ec68592eb73d755@realtek.com>
 <20230503223704.c3kccy74o7h3iawx@synopsys.com>
In-Reply-To: <20230503223704.c3kccy74o7h3iawx@synopsys.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBpbmRleA0KPiA+IGQ1NjQ1N2MwMjk5Ni4uZGI0OGFhZTIx
MWJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiBAQCAtODQsNiArODQsOCBAQA0KPiA+ICAjZGVm
aW5lIERXQzNfT1RHX1JFR1NfU1RBUlQgICAgICAgICAgICAweGNjMDANCj4gPiAgI2RlZmluZSBE
V0MzX09UR19SRUdTX0VORCAgICAgICAgICAgICAgMHhjY2ZmDQo+ID4NCj4gPiArI2RlZmluZSBS
VEtfUlREMVhYWF9EV0MzX0dMT0JBTFNfUkVHU19TVEFSVCAgICAweDgxMDANCj4gDQo+IExldCdz
IGtlZXAgY29uc2lzdGVudCB3aXRoIHRoZSBEV0MzXyBwcmVmaXguIFNvbWV0aGluZyBsaWtlIHRo
aXM6DQo+IA0KPiAjZGVmaW5lIERXQzNfUlRLX1JURDFYWFhfR0xPQkFMX1JFR1NfU1RBUlQgMHg4
MTAwDQoNCk9rYXkuIEkgd2lsbCByZXZpc2UgaXQuDQoNCg0KVGhhbmtzLA0KU3RhbmxleQ0K
