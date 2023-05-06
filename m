Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED356F8E83
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 06:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjEFEO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 00:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFEO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 00:14:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356476A1;
        Fri,  5 May 2023 21:14:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3464Ee0oA002832, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3464Ee0oA002832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 6 May 2023 12:14:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 6 May 2023 12:14:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 6 May 2023 12:14:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 6 May 2023 12:14:45 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] usb: dwc3: core: add support for realtek SoCs custom's global register start address
Thread-Topic: [PATCH v6] usb: dwc3: core: add support for realtek SoCs
 custom's global register start address
Thread-Index: AQHZfvxzwn149jVs0EaS9yoI48utba9L8vMAgACxUKA=
Date:   Sat, 6 May 2023 04:14:45 +0000
Message-ID: <c2ddb17c182a42be9fc22afa85669695@realtek.com>
References: <20230505025104.18321-1-stanley_chang@realtek.com>
 <20230506013842.7iu4hq35uyamt6np@synopsys.com>
In-Reply-To: <20230506013842.7iu4hq35uyamt6np@synopsys.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBpbmRleA0KPiA+IDBiZWFhYjkzMmU3ZC4uMjc4Y2QxYzMz
ODQxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAtMTgwMCw2ICsxODAwLDE3IEBAIHN0YXRp
YyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAg
ICAgIGR3Y19yZXMgPSAqcmVzOw0KPiA+ICAgICAgIGR3Y19yZXMuc3RhcnQgKz0gRFdDM19HTE9C
QUxTX1JFR1NfU1RBUlQ7DQo+ID4NCj4gPiArICAgICBpZiAoZGV2LT5vZl9ub2RlKSB7DQo+ID4g
KyAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnBhcmVudCA9DQo+ID4gKyBvZl9nZXRf
cGFyZW50KGRldi0+b2Zfbm9kZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgaWYgKG9mX2Rl
dmljZV9pc19jb21wYXRpYmxlKHBhcmVudCwgInJlYWx0ZWsscnRkLWR3YzMiKSkNCj4gPiArIHsN
Cj4gDQo+IElzIHlvdXIgcGxhdGZvcm0gYWxyZWFkeSByZWxlYXNlZCBvciBpcyBpdCBzdGlsbCB1
bmRlciBkZXZlbG9wbWVudD8gSnVzdCBjdXJpb3VzDQo+IHNpbmNlIHRoZSBjb21wYXRpYmxlIHN0
cmluZyBpc24ndCBmaXhlZC4gSXMgaXQgZ29pbmcgdG8gYmUgY2hhbmdlZCBpbiB0aGUgZnV0dXJl
Pw0KDQpZZXMsIG91ciBwbGF0Zm9ybSBpcyByZWxlYXNlZC4NCkluIG91ciBkcml2ZXIgKHRoZSBw
YXJlbnQgb2YgdGhlIGR3YzMgZHJpdmVyKSwgd2UgdXNlZCB0aGUgY29tcGF0aWJsZSBuYW1lICJS
ZWFsdGVrLGR3YzMiLg0KVG8gc3VwcG9ydCB0aGlzIHBhdGNoLCBJIHdpbGwgYWRkIGFuIGFsdGVy
bmF0aXZlIG5hbWUgIlJlYWx0ZWsscnRkLWR3YzMiIHRvIG91ciBkcml2ZXIuDQoNClRoYW5rcywN
ClN0YW5sZXkNCg==
