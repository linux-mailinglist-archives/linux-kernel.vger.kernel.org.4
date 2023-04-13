Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C86E04EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjDMCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDMCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:54:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE0901B;
        Wed, 12 Apr 2023 19:53:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D2rOcgD020527, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D2rOcgD020527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 10:53:24 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 13 Apr 2023 10:53:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 13 Apr 2023 10:53:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 10:53:46 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Thread-Topic: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Thread-Index: AQHZbO8UV6MphwFb1U6iZXdc0JZwLK8nG/AAgAFozGA=
Date:   Thu, 13 Apr 2023 02:53:45 +0000
Message-ID: <5ae89b563e234acdb36a4ae253cec869@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412033006.10859-2-stanley_chang@realtek.com>
 <CAL_JsqLqTHbHjB1qiLduhzvTaO7EBMgL6KYqZJtgStGVGtX1vQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLqTHbHjB1qiLduhzvTaO7EBMgL6KYqZJtgStGVGtX1vQ@mail.gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAxMDozMOKAr1BNIFN0YW5sZXkgQ2hhbmcN
Cj4gPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGEgbmV3
ICdzbnBzLGdsb2JhbC1yZWdzLXN0YXJ0aW5nLW9mZnNldCcgRFQgdG8gZHdjMyBjb3JlIHRvIHJl
bWFwDQo+ID4gdGhlIGdsb2JhbCByZWdpc3RlciBzdGFydCBhZGRyZXNzDQo+ID4NCj4gPiBUaGUg
UlRLIERIQyBTb0NzIHdlcmUgZGVzaWduZWQgdGhlIGdsb2JhbCByZWdpc3RlciBhZGRyZXNzIG9m
ZnNldCBhdA0KPiA+IDB4ODEwMC4gVGhlIGRlZmF1bHQgYWRkcmVzcyBpcyBhdCBEV0MzX0dMT0JB
TFNfUkVHU19TVEFSVCAoMHhjMTAwKS4NCj4gPiBUaGVyZWZvcmUsIGFkZCB0aGUgcHJvcGVydHkg
b2YgZGV2aWNlLXRyZWUgdG8gYWRqdXN0IHRoaXMgc3RhcnQgYWRkcmVzcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxk
d2MzLnlhbWwgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBpbmRleCBiZTM2OTU2YWY1M2IuLjVjYmYzYjdk
ZWQwNCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3NucHMsZHdjMy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+IEBAIC0zNTksNiArMzU5LDEzIEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgZW51bTogWzEsIDQsIDgsIDE2LCAz
MiwgNjQsIDEyOCwgMjU2XQ0KPiA+DQo+ID4gKyAgc25wcyxnbG9iYWwtcmVncy1zdGFydGluZy1v
ZmZzZXQ6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgdmFsdWUgZm9yIHJlbWFw
cGluZyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcy4gRm9yIHNvbWUgZHdjMw0KPiA+ICsg
ICAgICBjb250cm9sbGVyLCB0aGUgZHdjMyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcyBp
cyBub3QgYXQNCj4gPiArICAgICAgZGVmYXVsdCBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVCAoMHhj
MTAwKS4gVGhpcyBwcm9wZXJ0eSBpcw0KPiBhZGRlZCB0bw0KPiA+ICsgICAgICBhZGp1c3QgdGhl
IGFkZHJlc3MuDQo+IA0KPiBXZSBhbHJlYWR5IGhhdmUgJ3JlZycgb3IgdXNpbmcgYSBzcGVjaWZp
YyBjb21wYXRpYmxlIHRvIGhhbmRsZSBkaWZmZXJlbmNlcy4gVXNlDQo+IG9uZSBvZiB0aG9zZSwg
bm90IGEgY3VzdG9tIHByb3BlcnR5LiBHZW5lcmFsbHksIHByb3BlcnRpZXMgc2hvdWxkIGJlIHVz
ZWQgZm9yDQo+IHRoaW5ncyB0aGF0IHZhcnkgcGVyIGJvYXJkLCBub3QgZml4ZWQgaW4gYSBnaXZl
biBTb0MuDQo+IA0KPiBSb2INCj4gDQoNClRoZSBkZWZhdWx0IG9mZnNldCBpcyBmaXhlZCBieSBt
YWNybyBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVCwgYW5kIGl0IGlzIG5vdCBzcGVjaWZpZWQgYnkg
cmVnLg0KVGhlIGR3YzMvY29yZSBpcyBhIGdlbmVyYWwgZHJpdmVyIGZvciBldmVyeSBkd2MzIElQ
IG9mIFNvQ3MsDQphbmQgdmVuZG9yJ3MgZGVmaW5pdGlvbiBhbmQgY29tcGF0aWJsZSBzaG91bGQg
c3BlY2lmeSBvbiBpdHMgcGFyZW50Lg0KSWYgd2UgYWRkIGEgc3BlY2lmaWMgY29tcGF0aWJsZSB0
byBkd2MzL2NvcmUgZHJpdmVyLCB0aGVuIGl0IHdpbGwgYnJlYWsgdGhpcyBydWxlLg0KVGhlcmVm
b3JlLCBJIHVzZSBhIHByb3BlcnR5IHRvIGFkanVzdCB0aGlzIG9mZnNldC4gDQpJZiBubyBkZWZp
bmUgdGhpcyBwcm9wZXJ0eSwgaXQgd2lsbCB1c2UgZGVmYXVsdCBvZmZzZXQuIFNvIGl0IHdpbGwg
bm90IGFmZmVjdCBvdGhlciBib2FyZC4NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
