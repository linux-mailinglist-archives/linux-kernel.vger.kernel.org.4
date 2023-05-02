Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC86F3EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjEBIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjEBIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:05:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BF449E;
        Tue,  2 May 2023 01:05:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34285Yb44010207, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34285Yb44010207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 2 May 2023 16:05:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 2 May 2023 16:05:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 May 2023 16:05:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 2 May 2023 16:05:37 +0800
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
Thread-Index: AQHZfLOhYfbzHfxzYE2TNUg+fEIenq9GE1eAgACG7nA=
Date:   Tue, 2 May 2023 08:05:37 +0000
Message-ID: <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
In-Reply-To: <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IE9uIDAyLzA1LzIwMjMgMDc6MDQsIFN0YW5sZXkgQ2hhbmcgd3Jv
dGU6DQo+ID4gQWRkIGEgbmV3IGNvbXBhdGlibGUgbmFtZSAnc25wcyxkd2MzLXJ0ay1zb2MnIG9m
IERUIGZvciByZWFsdGVrIGR3YzMNCj4gPiBjb3JlIHRvIGFkanVzdCB0aGUgZ2xvYmFsIHJlZ2lz
dGVyIHN0YXJ0IGFkZHJlc3MNCj4gPg0KPiA+IFRoZSBSVEsgREhDIFNvQ3Mgd2VyZSBkZXNpZ25l
ZCwgdGhlIGdsb2JhbCByZWdpc3RlciBhZGRyZXNzIG9mZnNldCBhdA0KPiANCj4gV2hhdCBhcmU6
ICJSVEsiIGFuZCAiREhDIj8gVGhlc2UgYXJlIG1hbnVmYWN0dXJlZCBieSBTeW5vcHN5cyBhcyB5
b3UNCj4gc3VnZ2VzdCBpbiB0aGUgcGF0Y2g/DQoNClJUSyBpcyBSZWFsdGVrLg0KREhDIGlzIHRo
ZSBkZXBhcnRtZW50IG5hbWUgaW4gUmVhbHRlayBhbmQgdGhlIGFiYnJldmlhdGlvbiBvZiB0aGUg
RGlnaXRhbCBIb21lIENlbnRlci4NClRoZSBVU0IgY29udHJvbGxlciBvZiBSVEsgREhDIFNvQ3Mg
dXNlZCB0aGUgRFdDMyBJUCBvZiBTeW5vcHN5cy4NCg0KPiA+IDB4ODEwMC4gVGhlIGRlZmF1bHQg
YWRkcmVzcyBvZmZzZXQgaXMgY29uc3RhbnQgYXQNCj4gPiBEV0MzX0dMT0JBTFNfUkVHU19TVEFS
VCAoMHhjMTAwKS4gVGhlcmVmb3JlLCBhZGQgdGhlIGNvbXBhdGlibGUNCj4gbmFtZQ0KPiA+IG9m
IGRldmljZS10cmVlIHRvIHNwZWNpZnkgdGhlIFNvQyBjdXN0b20ncyBnbG9iYWwgcmVnaXN0ZXIg
c3RhcnQgYWRkcmVzcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0
YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+IA0KPiBCYXNlZCBvbiB5b3VyIGVtYWlsLCBydGsg
Y291bGQgbWVhbiBSZWFsdGVrLCBzbyB0aGUgY29tcGF0aWJsZSBpcyBjbGVhcmx5DQo+IHdyb25n
Lg0KDQpUaGUgY29tcGF0aWJsZSBuYW1lICJzbnBzLGR3YzMtcnRrLXNvYyIgd2FudHMgdG8gcmVw
cmVzZW50IHRoZSBkd2MzIGRyaXZlciwgd2hpY2ggcmVxdWlyZXMgYSBkaWZmZXJlbnQgb2Zmc2V0
IGZvciBSZWFsdGVrIFNvQ3MNCg0KPiA+IC0tLQ0KPiA+ICB2MyB0byB2NCBjaGFuZ2U6DQo+ID4g
VXNlIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gc3BlY2lmeSB0aGUgZ2xvYmFsIHJlZ2lzdGVyIGFk
ZHJlc3Mgb2Zmc2V0Lg0KPiA+IElmIHRoZSBjb21wYXRpYmxlIG5hbWUgaXMgInNucHMsZHdjMy1y
dGstc29jIiwgdGhlbiB0aGUgb2Zmc2V0IHVzZSAweDgxMDAuDQo+ID4gT3RoZXJ3aXNlLCB0aGUg
b2Zmc2V0IGlzIGRlZmF1bHQgdmFsdWUgMHhjMTAwLg0KPiA+DQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KPiANCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJv
bm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
