Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD46EAEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjDUQNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDUQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:13:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35414F7D;
        Fri, 21 Apr 2023 09:13:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33LGCXn14002175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33LGCXn14002175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 22 Apr 2023 00:12:33 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 22 Apr 2023 00:12:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 22 Apr 2023 00:12:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 22 Apr 2023 00:12:33 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Thread-Topic: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Thread-Index: AQHZdBkVGzo+T+kwpkqSDn6NeDDx1681NUYAgAC6KHA=
Date:   Fri, 21 Apr 2023 16:12:33 +0000
Message-ID: <6273cc836dee42809f6ac5c5cdbcec04@realtek.com>
References: <20230421061825.2233-1-stanley_chang@realtek.com>
 <20230421061825.2233-2-stanley_chang@realtek.com>
 <CAL_JsqJBDuxCAnZmHBnHuMkjTXTLet2d3o5kLRZQ_YuqVB9Pcw@mail.gmail.com>
In-Reply-To: <CAL_JsqJBDuxCAnZmHBnHuMkjTXTLet2d3o5kLRZQ_YuqVB9Pcw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IEFnYWluLCB3ZSdyZSBub3QgZ29pbmcgdG8ga2VlcCBhZGRpbmcgcHJvcGVy
dGllcyBmb3IgZXZlcnkgRFdDMyB2YXJpYXRpb24uIElmDQo+IGl0IGlzIGJvYXJkIHNwZWNpZmlj
LCB0aGVuIHllcyBhIHByb3BlcnR5IGlzIGFwcHJvcHJpYXRlLiBJZiBpdCBpcyBTb0Mgc3BlY2lm
aWMsIHRoZW4NCj4gaW1wbHkgaXQgZnJvbSB0aGUgY29tcGF0aWJsZS4NCj4gT3IgaW4gdGhpcyBj
YXNlLCB5b3UgY291bGQgcG9zc2libHkgYWRkIGFub3RoZXIgcmVnIGVudHJ5Lg0KPiANCj4gUm9i
DQo+IA0KTGV0IG1lIHRyeSB0byB1bmRlcnN0YW5kIHlvdXIgY29uY2VybnMuDQoNClRoZSBkZXZp
Y2UtdHJlZSBwcm9wZXJ0eSBzaG91bGQgd29yayBmb3IgYWxsIGR3YzMgSVBzIGFuZCBjYW4gYmUg
c3BlY2lmaWVkIGJ5IGRpZmZlcmVudCBib2FyZHMuDQpGb3IgYSBTb0Mgc3BlY2lmaWMsIGl0IHNo
b3VsZCB1c2UgYSBjb21wYXRpYmxlIG9yIHJlZ2lzdHJ5IGVudHJ5IHRvIGNoYW5nZSBpdC4NClNv
IHlvdSB0aGluayB3ZSBjYW4ndCB1c2UgYSBwcm9wZXJ0eSB0byBzcGVjaWZ5IHRoaXMgb2Zmc2V0
Lg0KDQpJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/DQoNCklmIGl0IGlzIHJpZ2h0LCB1c2lu
ZyBwcm9wZXJ0eSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gd2FzIG15IG1pc3Rha2UuDQpJIHdpbGwg
dGhpbmsgYSBuZXcgbWV0aG9kIHRvIHJlc29sdmUgaXQuDQoNCg==
