Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589B6F4F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECDPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjECDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:14:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA71FD2;
        Tue,  2 May 2023 20:14:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3433EZ4G0005230, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3433EZ4G0005230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 3 May 2023 11:14:35 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 3 May 2023 11:14:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 3 May 2023 11:14:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 3 May 2023 11:14:39 +0800
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
Thread-Index: AQHZfLOhYfbzHfxzYE2TNUg+fEIenq9GE1eAgACG7nD//4ryAIAAh9bw//+RWQCAAIlt4IAAEN2AgAEHGaA=
Date:   Wed, 3 May 2023 03:14:39 +0000
Message-ID: <9d3e976192364bde98adeb7d31767505@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
 <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
 <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
 <a04e70f97bcb48048edb2f6db7bb6c25@realtek.com>
 <f51b4dc9-e1da-7c9c-1e39-c8510569db9d@linaro.org>
 <c44baa9fae5c445c90103cd2e129ab0b@realtek.com>
 <676dae73-9b59-d0bb-37ca-eaa120e8dcb5@linaro.org>
In-Reply-To: <676dae73-9b59-d0bb-37ca-eaa120e8dcb5@linaro.org>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFJlZ3VsYXIgcnVsZXMgYXBwbHksIGJlY2F1c2UgeW91ciBkZXZp
Y2UgaXMgbm90IHNwZWNpYWwuDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjEtcmMxL3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluDQo+IGRpbmdzL3dyaXRp
bmctYmluZGluZ3MucnN0I0w0Mg0KPiANCj4gVGhlcmVmb3JlIGVpdGhlciBTb0MtYmFzZWQgZGV2
aWNlIHNwZWNpZmljIG5hbWUgb3IgZm9sbG93ZWQgYnk6DQo+IDEuIFNvQy1iYXNlZCBkZXZpY2Ug
c3BlY2lmaWMgZmFsbGJhY2ssDQo+IDIuIEZhbWlseS1kZXZpY2UgZ2VuZXJpYyBmYWxsYmFjaywN
Cj4gDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdpbGwgZm9sbG93IHRoZXNlIHJ1
bGVzLg0KVGhpbmggaGFzIGEgZ29vZCBzdWdnZXN0aW9uIGZvciB0aGlzIHByb2JsZW0uDQpIaXMg
c29sdXRpb24gaXMgc2ltcGx5LiBBbmQgbm8gbW9kaWZ5IHRoZSBjb21wYXRpYmxlIG5hbWUgYW5k
IHByb3BlcnR5IG9mIGR3YzMuDQoNClRoYW5rcywNClN0YW5sZXkNCg==
