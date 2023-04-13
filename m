Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1E6E056B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDMDor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDMDon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:44:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3559F0;
        Wed, 12 Apr 2023 20:44:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D3i5i55007128, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D3i5i55007128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 11:44:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 13 Apr 2023 11:44:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Apr 2023 11:44:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 11:44:27 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] usb: dwc3: core: add support for remapping global register start address
Thread-Topic: [PATCH v2 1/2] usb: dwc3: core: add support for remapping global
 register start address
Thread-Index: AQHZbO8TMZxQ6xFEbEmr471D6ePiYq8npgYAgADcPhCAABJZoA==
Date:   Thu, 13 Apr 2023 03:44:27 +0000
Message-ID: <651b2e92a400411f80823aa01635acb5@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412210856.xcbp3crhbedjvnix@synopsys.com> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

DQo+ID4gPiArICAgICAvKg0KPiA+ID4gKyAgICAgICogRm9yIHNvbWUgZHdjMyBjb250cm9sbGVy
LCB0aGUgZHdjMyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcw0KPiBpcw0KPiA+ID4gKyAg
ICAgICogbm90IGF0IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUICgweGMxMDApLg0KPiA+ID4gKyAg
ICAgICovDQo+ID4gPiArICAgICBpZiAoZGV2LT5vZl9ub2RlKSB7DQo+ID4gPiArICAgICAgICAg
ICAgIGludCBnbG9iYWxfcmVnc19zdGFydGluZ19vZmZzZXQgPSAwOw0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgICAgICAgICBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LA0KPiA+ICJzbnBzLGds
b2JhbC1yZWdzLXN0YXJ0aW5nLW9mZnNldCIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmdsb2JhbF9yZWdzX3N0YXJ0aW5nX29mZnNldCk7DQo+ID4NCj4gPiBJIHN1Z2dl
c3RlZCB0byB1c2UgY29tcGF0aWJsZSBzdHJpbmcgaW5zdGVhZCBzaW5jZSB0aGlzIGlzbid0IGNv
bW1vbg0KPiA+IGFuZCBvbmx5IHVuaXF1ZSB0byB5b3VyIHBsYXRmb3JtLiBBbnkgcmVhc29uIHdl
IHNob3VsZG4ndCBkbyB0aGF0Pw0KPiA+DQo+ID4gaWUuIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+
ID4NCj4gPiBpZiAoZGV2LT5vZl9ub2RlICYmIG9mX2RldmljZV9pc19jb21wYXRpYWJsZShkZXYt
Pm9mX25vZGUsDQo+ID4gInlvdXItcGxhdGZvcm0iKSkNCj4gPiAgICAgICAgIGR3Y19yZXMuc3Rh
cnQgKz0geW91cl9wbGF0Zm9ybV9vZmZzZXQ7IGVsc2UNCj4gPiAgICAgICAgIGR3Y19yZXMuc3Rh
cnQgPSBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gPg0KPiANCj4gSSB3aWxsIHRyeSB0aGlz
IHN1Z2dlc3Rpb24uDQo+IA0KPiBUaGFua3MsDQo+IFN0YW5sZXkNCg0KVGhlIGR3YzMvY29yZSBp
cyBhIGdlbmVyYWwgZHJpdmVyIGZvciBldmVyeSBkd2MzIElQIG9mIFNvQ3MsDQphbmQgdmVuZG9y
J3MgZGVmaW5pdGlvbiBhbmQgY29tcGF0aWJsZSBzaG91bGQgc3BlY2lmeSBvbiBpdHMgcGFyZW50
Lg0KVGhpcyBzaG91bGQgYmUgaW5hcHByb3ByaWF0ZSBpZiB3ZSBhZGQgYSBzcGVjaWFsIHBsYXRm
b3JtIGNvbXBhdGlibGUgdG8gZHdjMy9jb3JlIGRyaXZlci4NClRoZXJlZm9yZSwgSSBkZWZpbmUg
dGhpcyBwcm9wZXJ0eSB0byBhZGp1c3QgdGhpcyB2YWx1ZS4gVGhpcyBpcyBtb3JlIHJlc2lsaWVu
dC4NCklmIHRoZXJlIGFyZSBvdGhlciBwbGF0Zm9ybXMgdGhhdCBhbHNvIGhhdmUgbm9uLXN0YW5k
YXJkIG9mZnNldCwgdGhpcyBwcm9wZXJ0eSBpcyBhbHNvIGFwcGxpY2FibGUuDQoNClRoYW5rLA0K
U3RhbmxleQ0K
