Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3526BC7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCPHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCPHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:48:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49722149AA;
        Thu, 16 Mar 2023 00:48:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32G7lu6rB029583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32G7lu6rB029583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 15:47:56 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 15:48:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Mar 2023 15:48:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 15:48:08 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgD//4V8AIAAjaUA//+VWgCAAK9BgIAAA6MA
Date:   Thu, 16 Mar 2023 07:48:08 +0000
Message-ID: <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
 <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
In-Reply-To: <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.242.6]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMTYg5LiK5Y2IIDA2OjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <63FA54BA6D49BC4DA612F59A54F86DC7@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMTYvMjMgMTU6MzUgIlBoaW5leCBIdW5nIiA8cGhpbmV4QHJlYWx0ZWsuY29t
IDxtYWlsdG86cGhpbmV4QHJlYWx0ZWsuY29tPiB3cm90ZToNCg0KPk5vdCBzdXJlIHdoZXRoZXIg
dGhpcyBpcyB0aGUgZGlmZmVyZW5jZSwgYnV0IHVzZSB0aGUgZm9sbG93aW5nIHBhdGNoIGNhbiBz
b2x2ZSB0aGlzIGlzc3VlLg0KDQo+QEAgLTU0MCw5ICs1MzEsOSBAQCBzdGF0aWMgaW50IGRyaXZl
dGVtcF9hZGQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY2xhc3NfaW50ZXJmYWNlICppbnRm
KQ0KPmdvdG8gYWJvcnQ7DQo+fQ0KPg0KPg0KPi0gc3QtPmh3ZGV2ID0gaHdtb25fZGV2aWNlX3Jl
Z2lzdGVyX3dpdGhfaW5mbyhkZXYtPnBhcmVudCwgImRyaXZldGVtcCIsDQo+LSBzdCwgJmRyaXZl
dGVtcF9jaGlwX2luZm8sDQo+LSBOVUxMKTsNCj4rIHN0LT5od2RldiA9IGh3bW9uX2RldmljZV9y
ZWdpc3Rlcl93aXRoX2luZm8oDQo+KyBkZXYtPnBhcmVudC0+cGFyZW50LT5wYXJlbnQtPnBhcmVu
dC0+cGFyZW50LCAiZHJpdmV0ZW1wIiwgc3QsDQo+KyAmZHJpdmV0ZW1wX2NoaXBfaW5mbywgTlVM
TCk7DQoNCg0KQSBtb3JlIGdlbmVyaWMgcGF0Y2ggd29ya3MgaW4gbXkgY2FzZSwgbGlzdGVkIGJl
bG93Og0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9kcml2ZXRlbXAuYyBiL2RyaXZlcnMv
aHdtb24vZHJpdmV0ZW1wLmMNCmluZGV4IDFjZjRmOTAxNTMxNi4uYTRjZGRmZWE4ZDIyIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9od21vbi9kcml2ZXRlbXAuYw0KKysrIGIvZHJpdmVycy9od21vbi9k
cml2ZXRlbXAuYw0KQEAgLTUyNSw2ICs1MjUsNyBAQCBzdGF0aWMgaW50IGRyaXZldGVtcF9hZGQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY2xhc3NfaW50ZXJmYWNlICppbnRmKQ0KIHsNCiAg
ICAgICAgc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2ID0gdG9fc2NzaV9kZXZpY2UoZGV2LT5wYXJl
bnQpOw0KICAgICAgICBzdHJ1Y3QgZHJpdmV0ZW1wX2RhdGEgKnN0Ow0KKyAgICAgICBzdHJ1Y3Qg
ZGV2aWNlICp0ZGV2ID0gZGV2LT5wYXJlbnQ7DQogICAgICAgIGludCBlcnI7DQoNCiAgICAgICAg
c3QgPSBremFsbG9jKHNpemVvZigqc3QpLCBHRlBfS0VSTkVMKTsNCkBAIC01NDAsOCArNTQxLDEx
IEBAIHN0YXRpYyBpbnQgZHJpdmV0ZW1wX2FkZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBj
bGFzc19pbnRlcmZhY2UgKmludGYpDQogICAgICAgICAgICAgICAgZ290byBhYm9ydDsNCiAgICAg
ICAgfQ0KDQotICAgICAgIHN0LT5od2RldiA9IGh3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2lu
Zm8oZGV2LT5wYXJlbnQsICJkcml2ZXRlbXAiLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0LCAmZHJpdmV0ZW1wX2NoaXBfaW5mbywNCisgICAg
ICAgd2hpbGUoIXRkZXYtPm9mX25vZGUpDQorICAgICAgICAgICAgICAgdGRldiA9IHRkZXYtPnBh
cmVudDsNCisNCisgICAgICAgc3QtPmh3ZGV2ID0gaHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhf
aW5mbyh0ZGV2LCAiZHJpdmV0ZW1wIiwgc3QsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmRyaXZldGVtcF9jaGlwX2luZm8sDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQogICAgICAg
IGlmIChJU19FUlIoc3QtPmh3ZGV2KSkgew0KICAgICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIo
c3QtPmh3ZGV2KTsNCg0KVGhhbmtzDQoNClJlZ2FyZHMsDQpQaGluZXgNCg0KDQoNCg0K
