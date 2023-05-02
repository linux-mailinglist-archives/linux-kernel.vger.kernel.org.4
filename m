Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498906F41D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjEBKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjEBKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:38:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47459F0;
        Tue,  2 May 2023 03:37:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 342AbZoT5026435, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 342AbZoT5026435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 2 May 2023 18:37:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 2 May 2023 18:37:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 2 May 2023 18:37:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 2 May 2023 18:37:39 +0800
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
Thread-Index: AQHZfLOhYfbzHfxzYE2TNUg+fEIenq9GE1eAgACG7nD//4ryAIAAh9bw//+RWQCAAIlt4A==
Date:   Tue, 2 May 2023 10:37:39 +0000
Message-ID: <c44baa9fae5c445c90103cd2e129ab0b@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
 <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
 <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
 <a04e70f97bcb48048edb2f6db7bb6c25@realtek.com>
 <f51b4dc9-e1da-7c9c-1e39-c8510569db9d@linaro.org>
In-Reply-To: <f51b4dc9-e1da-7c9c-1e39-c8510569db9d@linaro.org>
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

SGkgS3J6eXN6dG9mLA0KDQo+ID4+Pj4gT24gMDIvMDUvMjAyMyAwNzowNCwgU3RhbmxleSBDaGFu
ZyB3cm90ZToNCj4gPj4+Pj4gQWRkIGEgbmV3IGNvbXBhdGlibGUgbmFtZSAnc25wcyxkd2MzLXJ0
ay1zb2MnIG9mIERUIGZvciByZWFsdGVrDQo+ID4+Pj4+IGR3YzMgY29yZSB0byBhZGp1c3QgdGhl
IGdsb2JhbCByZWdpc3RlciBzdGFydCBhZGRyZXNzDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoZSBSVEsg
REhDIFNvQ3Mgd2VyZSBkZXNpZ25lZCwgdGhlIGdsb2JhbCByZWdpc3RlciBhZGRyZXNzIG9mZnNl
dA0KPiA+Pj4+PiBhdA0KPiA+Pj4+DQo+ID4+Pj4gV2hhdCBhcmU6ICJSVEsiIGFuZCAiREhDIj8g
VGhlc2UgYXJlIG1hbnVmYWN0dXJlZCBieSBTeW5vcHN5cyBhcw0KPiA+Pj4+IHlvdSBzdWdnZXN0
IGluIHRoZSBwYXRjaD8NCj4gPj4+DQo+ID4+PiBSVEsgaXMgUmVhbHRlay4NCj4gPj4+IERIQyBp
cyB0aGUgZGVwYXJ0bWVudCBuYW1lIGluIFJlYWx0ZWsgYW5kIHRoZSBhYmJyZXZpYXRpb24gb2Yg
dGhlDQo+ID4+PiBEaWdpdGFsDQo+ID4+IEhvbWUgQ2VudGVyLg0KPiA+Pj4gVGhlIFVTQiBjb250
cm9sbGVyIG9mIFJUSyBESEMgU29DcyB1c2VkIHRoZSBEV0MzIElQIG9mIFN5bm9wc3lzLg0KPiA+
Pg0KPiA+PiBUaGVuIGVudGlyZSBjb21wYXRpYmxlIGlzIG5vdCBjb3JyZWN0LiBWZW5kb3IgaXMg
UmVhbHRlayBub3QgU3lub3BzeXMuDQo+ID4+IERIQyBpcyBub3QgZXZlbiBkZXZpY2UgbmFtZS4g
VXNlIHJlYWwgZGV2aWNlIG5hbWVzLg0KPiA+DQo+ID4gU28sIGNhbiB3ZSB1c2UgdGhlIGNvbXBh
dGlibGUgbmFtZSBhcyAncmVhbHRlayxkd2MzJyA/DQo+IA0KPiBkd2MzIGlzIG5vdCBhIHJlYWwg
ZGV2aWNlIG5hbWUgZm9yIFJlYWx0ZWsuDQoNCldlIHN0aWxsIHVzZSBkd2MzIElQIGluIFJlYWx0
ZWsncyBTb0MuIFdoeSBpcyB0aGUgbmFtZSAiZHdjMyIgaW5hcHByb3ByaWF0ZT8NCg0KU2hvdWxk
IGNvbXBhdGliaWxpdHkgbmFtZXMgdXNlIHRoZSBTb0MgbmFtZT8NCkZvciBleGFtcGxlLCBvdXIg
U29DIG5hbWUNClJURDEyOXgsIFJURDEzOXgsIFJURDE2MXgsIFJURDE2MXhCLCBldGMuDQpTaG91
bGQgd2UgdXNlIHRoZXNlIG5hbWVzIGluIGNvbXBhdGlibGUgbmFtZXM/DQoicmVhbHRlaywgcnRk
MTI5eCIsICJyZWFsdGVrLCBydGQxMzl4IiwgInJlYWx0ZWssIHJ0ZDE2MXgiLi4uZXRjLg0KDQpU
aGFua3MsDQpTdGFubGV5DQo=
