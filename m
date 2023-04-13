Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0E6E0890
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDMIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:05:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E619A;
        Thu, 13 Apr 2023 01:05:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D84ZUQ0002708, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D84ZUQ0002708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 16:04:35 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 13 Apr 2023 16:04:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 13 Apr 2023 16:04:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 16:04:57 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,parkmode-disable-hs-quirk' quirk
Thread-Topic: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Thread-Index: AQHZbDd6gxCuA7crRky4J7/Z72smRa8oCpIAgABLvACAAI03kA==
Date:   Thu, 13 Apr 2023 08:04:56 +0000
Message-ID: <30861bce0ef44bdea36b2c90ec033850@realtek.com>
References: <20230411053550.16360-2-stanley_chang@realtek.com>
 <20230413030344.13483-1-stanley_chang@realtek.com>
 <2d058629-bd97-5e4d-8630-598cc22e5c58@kernel.org>
In-Reply-To: <2d058629-bd97-5e4d-8630-598cc22e5c58@kernel.org>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDEzLzA0LzIwMjMgMDU6MDMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+ID4gQWRkIGEg
bmV3ICdzbnBzLHBhcmttb2RlLWRpc2FibGUtaHMtcXVpcmsnIERUIHF1aXJrIHRvIGR3YzMgY29y
ZSBmb3INCj4gPiBkaXNhYmxlIHRoZSBoaWdoLXNwZWVkIHBhcmttb2RlLg0KPiANCj4gUGxlYXNl
IHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2Fy
eSBwZW9wbGUgYW5kIGxpc3RzDQo+IHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1h
bmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcw0KPiB5b3Ugb3V0ZGF0ZWQgZW50
cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24N
Cj4gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+IEl0J3MgdGhlIHNlY29uZCB0aW1lIEkgYW0g
d3JpdGluZyBpdC4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3Uga2VlcCBpZ25vcmluZw0KPiBp
dC4NCg0KU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQpJbiB0aGUgYmVnaW5uaW5nIEkgZGlkbid0
IGhhdmUgY2MgYWxsIG1haW50YWluZXJzLg0KSSdsbCByZXN1Ym1pdCBhIG5ldyByZXZpZXcgdGhy
ZWFkLg0KUGxlYXNlIGlnbm9yZSB0aGlzIGVtYWlsLg0KDQo+IFlvdXIgY29tbWl0IG1zZyBkb2Vz
IG5vdCBleHBsYWluIHdoeSBkbyB3ZSBuZWVkIGl0Lg0KDQpJIHdpbGwgYWRkIGl0IGF0IG5ldyBw
YXRjaC4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9j
aGFuZ0ByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBpbmRleCBiZTM2
OTU2YWY1M2IuLjQ1Y2E5NjdiOGQxNCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+IEBAIC0yMzIs
NiArMjMyLDExIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIFdoZW4gc2V0LCBhbGwgU3VwZXJT
cGVlZCBidXMgaW5zdGFuY2VzIGluIHBhcmsgbW9kZSBhcmUgZGlzYWJsZWQuDQo+ID4gICAgICB0
eXBlOiBib29sZWFuDQo+ID4NCj4gPiArICBzbnBzLHBhcmttb2RlLWRpc2FibGUtaHMtcXVpcms6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgV2hlbiBzZXQsIGFsbCBIaWdoU3Bl
ZWQgYnVzIGluc3RhbmNlcyBpbiBwYXJrIG1vZGUgYXJlIGRpc2FibGVkLg0KPiANCj4gV2h5Pw0K
PiANCg0KRm9yIHNvbWUgVVNCIHdpZmkgZGV2aWNlcywgaWYgZW5hYmxlIHRoaXMgZmVhdHVyZSBp
dCB3aWxsIHJlZHVjZSB0aGUNCnBlcmZvcm1hbmNlLiBUaGVyZWZvcmUsIGFkZCBhbiBvcHRpb24g
Zm9yIGRpc2FibGluZyBIUyBwYXJrIG1vZGUgYnkgZGV2aWNlLXRyZWUuDQoNClRoYW5rcywNClN0
YW5sZXkNCg==
