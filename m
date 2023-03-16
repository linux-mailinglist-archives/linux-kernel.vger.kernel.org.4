Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F416BC750
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCPHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCPHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:36:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6137C672;
        Thu, 16 Mar 2023 00:35:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32G7YwgpE031149, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32G7YwgpE031149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 15:34:58 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 15:35:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 16 Mar 2023 15:35:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 15:35:07 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgD//4V8AIAAjaUA//+VWgCAAK9BgA==
Date:   Thu, 16 Mar 2023 07:35:07 +0000
Message-ID: <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
In-Reply-To: <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.242.6]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMTYg5LiK5Y2IIDA2OjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2EDE9B386173E4AA89CFC8F500A3ADA@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNi8yMyAxMzowOCwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdtYWlsLmNvbSA8bWFp
bHRvOmdyb2VjazdAZ21haWwuY29tPiB3cm90ZToNCg0KDQo+V3JvbmcgY29uY2x1c2lvbi4gWW91
IGhhdmUgKG9yIHNob3VsZCBoYXZlKSBkZXZpY2V0cmVlIG5vZGUocykgc3VjaCBhcw0KDQoNCj5z
YXRhOiBzYXRhQDgwMDAwIHsNCj5jb21wYXRpYmxlID0gIm1hcnZlbGwsb3Jpb24tc2F0YSI7DQo+
cmVnID0gPDB4ODAwMDAgMHg1MDAwPjsNCj5pbnRlcnJ1cHRzID0gPDIxPjsNCj5jbG9ja3MgPSA8
JmdhdGVfY2xrIDE0PiwgPCZnYXRlX2NsayAxNT47DQo+Y2xvY2stbmFtZXMgPSAiMCIsICIxIjsN
Cj5waHlzID0gPCZzYXRhX3BoeTA+LCA8JnNhdGFfcGh5MT47DQo+cGh5LW5hbWVzID0gInBvcnQw
IiwgInBvcnQxIjsNCj5zdGF0dXMgPSAiZGlzYWJsZWQiOw0KPn07DQoNCkkgZGlkIHNlZSB0aGlz
LCBidXQganVzdCB0aG91Z2ggdGhhdCBpcyBhIGNvbXBhdGlibGUgbWF0Y2ggdG8gbWFydmVsbCdz
IHNhdGEgZHJpdmVyLg0KDQpOb3RoaW5nIHRvIGRvIHdpdGggeW91ciBkcml2ZXRlbXAuDQoNCg0K
PlRob3NlIG5vZGVzIHNob3VsZCBoYXZlIGRldmljZXMgYXNzb2NpYXRlZCB3aXRoIHRoZW0gKGlu
IHRoaXMgY2FzZSBpbnN0YW50aWF0ZWQNCj5ieSBkcml2ZXJzL2F0YS9zYXRhX212LmMpLiBBdCB0
aGUgc2FtZSB0aW1lLCB0aGUgZHJpdmV0ZW1wIGRyaXZlciBjYWxsYmFjaw0KPihkcml2ZXRlbXBf
YWRkKSBnZXRzIGNhbGxlZCB3aXRoIGEgZGV2aWNlIHBvaW50ZXIgYXMgcGFyYW1ldGVyLiBUaGUg
cXVlc3Rpb24NCj5pcyBob3cgdG8gZ2V0IGZyb20gdGhlIGRldmljZSBwb2ludGVyIHBhc3NlZCB0
byBkcml2ZXRlbXBfYWRkKCkgdG8gdGhlIGRldmljZQ0KPmNyZWF0ZWQgYnkgdGhlIHNhdGFfbXYg
ZHJpdmVyLiBJcyBpdCBkZXYgPyBvciBkZXYtPnBhcmVudCA/IE9yIGRldi0+cGFyZW50LT5wYXJl
bnQgPw0KPlRoZSBkZXZpY2V0cmVlIG5vZGUgYXNzb2NpYXRlZCB3aXRoIHRoYXQgZGV2aWNlIGlz
IHRoZSBvbmUgd2hpY2ggc2hvdWxkIGJlIHVzZWQNCj50byBzZXQgdGhlIGh3bW9uIGRldmljZSBk
ZXZpY2V0cmVlIG5vZGUuIEVzc2VudGlhbGx5IHlvdSdsbCBoYXZlIHRvIGZpbmQgb3V0IHdoZXJl
DQo+aW4gdGhlIGRldmljZSBsaXN0IHRvIGZpbmQgdGhlIG9mX25vZGUgcG9pbnRpbmcgdG8gdGhl
IGFib3ZlIHNhdGEgbm9kZS4gVGhlbiB3ZQ0KPmNhbiBkaXNjdXNzIGhvdyB0byBtYWtlIHRoYXQg
bm9kZSBhdmFpbGFibGUgdG8gdGhlIHRoZXJtYWwgc3Vic3lzdGVtLg0KDQpUaGFua3MgZm9yIHRo
ZSBoaW50Lg0KDQpCeSBjaGVja2luZyBtYXJ2ZWxsJ3MgU0FUQSBkcml2ZXIsIGl0IHVzZXMgImF0
YV9ob3N0X2FjdGl2YXRlIiB0byByZWdpc3RlciBhIHBsYXRmb3JtIFNBVEEgZHJpdmVyLg0KDQpJ
biBvdXIgU0FUQSBkcml2ZXIsIHdlIHJlbHkgb24gImFoY2lfcGxhdGZvcm1faW5pdF9ob3N0IiB0
byByZWdpc3RlciBhIHBsYXRmb3JtIFNBVEEgZHJpdmVyLg0KDQpOb3Qgc3VyZSB3aGV0aGVyIHRo
aXMgaXMgdGhlIGRpZmZlcmVuY2UsIGJ1dCB1c2UgdGhlIGZvbGxvd2luZyBwYXRjaCBjYW4gc29s
dmUgdGhpcyBpc3N1ZS4NCg0KQEAgLTU0MCw5ICs1MzEsOSBAQCBzdGF0aWMgaW50IGRyaXZldGVt
cF9hZGQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY2xhc3NfaW50ZXJmYWNlICppbnRmKQ0K
ICAgICAgICAgICAgICAgIGdvdG8gYWJvcnQ7DQogICAgICAgIH0NCg0KLSAgICAgICBzdC0+aHdk
ZXYgPSBod21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvKGRldi0+cGFyZW50LCAiZHJpdmV0
ZW1wIiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdCwgJmRyaXZldGVtcF9jaGlwX2luZm8sDQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQorICAgICAgIHN0LT5od2RldiA9IGh3bW9u
X2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oDQorICAgICAgICAgICAgICAgZGV2LT5wYXJlbnQt
PnBhcmVudC0+cGFyZW50LT5wYXJlbnQtPnBhcmVudCwgImRyaXZldGVtcCIsIHN0LA0KKyAgICAg
ICAgICAgICAgICZkcml2ZXRlbXBfY2hpcF9pbmZvLCBOVUxMKTsNCg0KDQpUaGUgcHJvYmxlbSBp
cyB0aGF0IGluIG91ciBjYXNlLCBkZXYgaXMgYSBzY3NpX2RldmljZSwgZGV2LT5wYXJlbnQgaXMg
YSBzZCBkZXZpY2UsDQpkZXYtPnBhcmVudC0+cGFyZW50IGlzIGEgc2NzaSB0YXJnZXQsIGRldi0+
cGFyZW50LT5wYXJlbnQtPnBhcmVudCBpcyBhIHNjc2kgaG9zdA0KZGV2LT5wYXJlbnQtPnBhcmVu
dC0+cGFyZW50LT5wYXJlbnQgaXMgYW4gQVRBIGRldmljZSwgd2hpbGUgaXRzIHBhcmVudCBpcyBv
dXIgcGxhdGZvcm0gZGV2aWNlIChhaGNpKS4NCg0KQmVzaWRlcywgYSBjaGFuZ2UgaW4gZHRzIGlz
IHJlcXVpcmVkIHRvIG1vdmUgI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+IGZyb20gYSBTQVRB
IHBvcnQgdG8gYW4gYWhjaSBob3N0Lg0KDQpAQCAtOTQsMTYgKzk0LDE1IEBADQogICAgICAgICAg
ICAgICAgcmVhbHRlayxzYXRhd3JhcCA9IDwmc2F0YV9waHk+Ow0KICAgICAgICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0K
KyAgICAgICAgICAgICAgICN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwwPjsNCiAgICAgICAgICAg
ICAgICBzdGF0dXMgPSAib2theSI7DQoNCiAgICAgICAgICAgICAgICBzYXRhX3BvcnQwOiBzYXRh
LXBvcnRAMCB7DQogICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQogICAgICAgICAg
ICAgICAgICAgICAgICBwaHlzID0gPCZzYXRhX3BoeSAwPjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIHJlc2V0cyA9IDwmY2xrYyBSVEQxMjk1X1JTVE5fU0FUQV8wPiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDwmY2xrYyBSVEQxMjk1X1JTVE5fU0FUQV9QSFlfMD47DQogICAg
ICAgICAgICAgICAgICAgICAgICBzYXRhLWdwaW9zID0gPCZtaXNjX2dwaW8gMTYgR1BJT19BQ1RJ
VkVfSElHSD47DQotICAgICAgICAgICAgICAgICAgICAgICAjdGhlcm1hbC1zZW5zb3ItY2VsbHMg
PSA8MD47DQogICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQogICAgICAg
ICAgICAgICAgfTsNCiAgICAgICAgfTsNCg0KV2l0aG91dCB0aGlzIGNoYW5nZSwgc2Vuc29yIHJl
Z2lzdHJhdGlvbiB3b3VsZCBzdGlsbCBmYWlsIGR1ZSB0byBtaXNtYXRjaCBvZiB0aGUgbnAgbm9k
ZSBpbiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyIGZ1bmN0aW9uLg0KDQogICAgICAg
ICAgICAgICAgaWYgKHNlbnNvcl9zcGVjcy5ucCA9PSBzZW5zb3JfbnAgJiYgaWQgPT0gc2Vuc29y
X2lkKSB7DQogICAgICAgICAgICAgICAgICAgICAgICB0emQgPSB0aGVybWFsX3pvbmVfb2ZfYWRk
X3NlbnNvcihjaGlsZCwgc2Vuc29yX25wLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSwgb3BzKTsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIGlmICghSVNfRVJSKHR6ZCkpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHR6ZC0+b3BzLT5zZXRfbW9kZSh0emQsIFRIRVJNQUxfREVWSUNFX0VOQUJMRUQpOw0KDQogICAg
ICAgICAgICAgICAgICAgICAgICBvZl9ub2RlX3B1dChzZW5zb3Jfc3BlY3MubnApOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQoY2hpbGQpOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBleGl0Ow0KICAgICAgICAgICAgICAgIH0NCg0KVGhpcyBtaWdodCBiZSBhIGdv
b2Qgc29sdXRpb24gZm9yIG15IGluaXRpYWwgcHJvYmxlbSwgYW5kIGl0IHdvcmtzIHBlcmZlY3Rs
eSBmb3IgYSBzaW5nbGUgZHJpdmUgY2FzZS4NCg0KVGhhbmsgeW91IGFnYWluIGZvciB0aGUgYWR2
aWNlLg0KDQpGb3IgYSBzeXN0ZW0gd2l0aCBtb3JlIHRoYW4gMSBkcml2ZSwgdGhlcmUgaXMgc3Rp
bGwgYSBtYXBwaW5nIGJldHdlZW4gbXVsdGlwbGUgaHdtb24gZGV2aWNlcyBhbmQgYSB0aGVybWFs
IHpvbmUuDQoNClNpbmNlIEkgbW92ZSB0aGUgI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+IGZy
b20gU0FUQSBwb3J0IHRvIGEgQUhDSSBob3N0LCB0aGVybWFsIHpvbmUgaXMgYXNzb2NpYXRlZCB3
aXRoIHRoZSBob3N0LCBub3QgZWFjaCBTQVRBIHBvcnQuDQoNClRha2UgdGhlIGJlbG93IGNhc2Ug
Zm9yIGV4YW1wbGUsIGl0IHNvdW5kcyB0aGF0IHRoZSB0aGVybWFsIHpvbmUgaXMgYXNzb2NpYXRl
ZCB3aXRoIGh3bW9uMiBvbmx5Lg0KDQpyb290QE9wZW5XUlQtS3lsaW46L3N5cy9jbGFzcy90aGVy
bWFsIyBjYXQgdGhlcm1hbF96b25lMS90ZW1wDQo0ODAwMA0Kcm9vdEBPcGVuV1JULUt5bGluOi9z
eXMvY2xhc3MvdGhlcm1hbCMgY2F0IC4uL2h3bW9uL2h3bW9uMS90ZW1wMV9pbnB1dA0KNTAwMDAN
CnJvb3RAT3BlbldSVC1LeWxpbjovc3lzL2NsYXNzL3RoZXJtYWwjIGNhdCAuLi9od21vbi9od21v
bjIvdGVtcDFfaW5wdXQNCjQ4MDAwDQoNClRoYW5rcw0KDQpSZWdhcmRzLA0KUGhpbmV4DQoNCg==
