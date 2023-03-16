Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7F6BC3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCPCVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCPCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:21:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C25F6DC;
        Wed, 15 Mar 2023 19:21:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32G2L9icC030357, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32G2L9icC030357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 10:21:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Mar 2023 10:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Mar 2023 10:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 10:21:07 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgA=
Date:   Thu, 16 Mar 2023 02:21:07 +0000
Message-ID: <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
In-Reply-To: <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.242.6]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B05974B694E044D900DDBCD317F02FF@realtek.com>
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

DQpPbiAzLzE1LzIzIDExOjM2LCBHdWVudGVyIFJvZWNrIiA8Z3JvZWNrN0BnbWFpbC5jb20gPG1h
aWx0bzpncm9lY2s3QGdtYWlsLmNvbT4gd3JvdGU6DQrvu78NCj5UaGlzIGlzIGNvbmNlcHR1YWxs
eSB3cm9uZy4gSXQgcmV0dXJucyB0aGUgbWF4aW11bSB0ZW1wZXJhdHVyZSBmcm9tIGFsbCBkcml2
ZXMsDQo+bm90IHRoZSB0ZW1wZXJhdHVyZSBmcm9tIGEgc2luZ2xlIGRyaXZlLg0KDQo+VGhpcyBp
cyBub3QgbXVjaCBkaWZmZXJlbnQgZnJvbSBjb2xsZWN0aW5nIGFsbCB0ZW1wZXJhdHVyZXMgZnJv
bSBhbGwgc2Vuc29ycw0KPmluIHRoZSBzeXN0ZW0gYW5kIGRlY2xhcmluZyB0aGUgbWF4aW11bSBv
ZiB0aG9zZSBhcyBzaW5nbGUgdGhlcm1hbCB6b25lLg0KDQo+SWYgYW55dGhpbmcsIGVhY2ggZHJp
dmUgd291bGQgaGF2ZSB0byByZWZsZWN0IGEgdGhlcm1hbCB6b25lLiBUaGUgYmlnIHF1ZXN0aW9u
DQo+aXMgaG93IHRvIGRldGVybWluZSB0aGUgYXNzb2NpYXRlZCBkZXZpY2V0cmVlIHByb3BlcnR5
Lg0KDQpNeSBiYXNpYyBpZGVhIGlzIHRvIHVzZSBhIHNpbmdsZSB0aGVybWFsIHpvbmUgZm9yIG11
bHRpcGxlIGRpc2tzLg0KDQpJbiBtb3N0IG9mIHRoZSBzeXN0ZW1zLCB0aGVyZSBtaWdodCBiZSBv
bmx5IGEgc2luZ2xlIGZhbiB0aGF0IHVzZWQgZm9yIGNvb2xpbmcuDQoNCklmIGVhY2ggZGlzayBo
YXMgaXRzIG93biB0aGVybWFsIHpvbmUsIHdlIG5lZWQgdG8gYWRkIGFsbW9zdCB0aGUgc2FtZSBk
dHMgZW50cmllcyBmb3IgZWFjaCB0aGVybWFsIHpvbmUsDQoNCmFuZCBkbyBhbG1vc3QgdGhlIHNh
bWUgY29vbGluZyBvcGVyYXRpb25zLg0KDQpUaGF0IGlzIHdoeSBJIGFtIHRyeWluZyB0byB1c2lu
ZyBhIHNpbmdsZSB0aGVybWFsIHpvbmUgZm9yIG11bHRpcGxlIGRpc2tzLg0KDQpJbiBhbnkgY2Fz
ZSwgaWYgdGVtcGVyYXR1cmUgb2YgYW55IGRpc2sgZ29lcyBoaWdoLCBjb29saW5nIHNob3VsZCB0
YWtlIGVmZmVjdC4NCg0KPkFsc28sIGVzc2VudGlhbGx5IHlvdXIgcGF0Y2ggY2xhaW1zIHRoYXQg
YXJjaC9hcm0vYm9vdC9kdHMva2lya3dvb2QtbnNhMzEwcy5kdHMNCj5kb2Vzbid0IHdvcmsgYW5k
IG5vIG9uZSBldmVyIG5vdGljZWQuIEkgd291bGQgbGlrZSB0byBzZWUgdGhhdCBjb25maXJtZWQu
DQoNClRvIGJlIGhvbmVzdCwgbXkgZmlyc3QgYXR0ZW1wdCB0byBnZXQgeW91ciBkcml2ZXRlbXAu
YyB3b3JrcyBpbiBvdXIgU29DIHdhcyByZWZlcnJpbmcgdG8gYSBzaW1pbGFyIHBhdGNoLA0KDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsL0NBSk4xS2t6UjdOUjhUZ3VT
N3VEczZwZURPcGtGbjBkdVZCcXZLS3ptM3huTXM5aUo3QUBtYWlsLmdtYWlsLmNvbS9ULw0KDQpC
eSBhZGRpbmcgdGhlIHNpbWlsYXIgZW50cmllcyBpbiBvdXIgZHRzIGJ1dCBmYWlsZWQuDQoNClR3
byBod21vbiBkZXZpY2VzIGFjdHVhbGx5IHBvcHVsYXRlZCwgYSB0aGVybWFsIHpvbmUgZGVzY3Jp
YmVkIGJ5IG15IGR0cyBhbHNvIHdhcyBjcmVhdGVkLg0KDQpCdXQgdGhlcmUgaXMgbm8gbGluayBi
ZXR3ZWVuIHRoZSB0aGVybWFsIHpvbmUgZGVzY3JpYmVkIGluIGR0cyBhbmQgaHdtb25zIGZyb20g
ZHJpdmV0ZW1wIGRyaXZlci4NCg0KU28gdGhhdCBJIHRyYWNlZCB0aGUgc291cmNlIGFuZCBmaW5k
aW5nIHRoYXQgdGhlIHRoZXJtYWwgem9uZSByZWdpc3RyYXRpb24gZmFpbGVkIGR1ZSB0byB0aGUg
bGFjayBvZiBhIGRldmljZSBub2RlIG9mIGEgcGxhdGZvcm0gZGV2aWNlLg0KDQpUaGF0IGlzIHdo
eSBJIGFtIHRyeWluZyB0byB1c2UgYSBwbGF0Zm9ybSBkZXZpY2UgZm9yIHJlZ2lzdHJhdGlvbiBh
Z2Fpbi4NCg0KVGhlIG9yaWdpbmFsIGNhbGwgdG8gaHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhf
aW5mbyBzaG91bGQgY2FsbCBod21vbl90aGVybWFsX3JlZ2lzdGVyX3NlbnNvcnMsIA0KDQpCdXQg
aW50IHRoZSBsYXN0IGNhbGwgdG8gdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlciwgZGV2
LT5vZl9ub2RlIHdvdWxkIGJlIGNoZWNrZWQuDQoNClRoaXMgd291bGQgY2F1c2UgdGhlIHNlbnNv
ciByZWdpc3RyYXRpb24gdG8gZmFpbCB3aGlsZSBod21vbiBzdGlsbCB3b3JrZWQuDQoNCmh3bW9u
X2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8gPT4gX19od21vbl9kZXZpY2VfcmVnaXN0ZXIgPT4g
aHdtb25fdGhlcm1hbF9yZWdpc3Rlcl9zZW5zb3JzID0+DQoNCmh3bW9uX3RoZXJtYWxfYWRkX3Nl
bnNvciA9PiBkZXZtX3RoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIgPT4gdGhlcm1hbF96
b25lX29mX3NlbnNvcl9yZWdpc3RlciA9Pg0KDQpzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAq
DQp0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50
IHNlbnNvcl9pZCwgdm9pZCAqZGF0YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzICpvcHMpDQp7DQogICAgICAg
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsICpjaGlsZCwgKnNlbnNvcl9ucDsNCiAgICAgICAgc3Ry
dWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6ZCA9IEVSUl9QVFIoLUVOT0RFVik7DQoNCiAgICAg
ICAgbnAgPSBvZl9maW5kX25vZGVfYnlfbmFtZShOVUxMLCAidGhlcm1hbC16b25lcyIpOw0KICAg
ICAgICBpZiAoIW5wKQ0KICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0K
DQogICAgICAgIGlmICghZGV2IHx8ICFkZXYtPm9mX25vZGUpIHsNCiAgICAgICAgICAgICAgICBv
Zl9ub2RlX3B1dChucCk7DQogICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7
DQogICAgICAgIH0NCg0KSSBhbSBhbHNvIGN1cmlvdXMgd2h5IEtpcmt3b29kIFNvQyB3b3JrcyB3
aXRob3V0IHNwZWNpZmljIHBhdGNoLg0KDQpJbiBhbnkgY2FzZSwgaWYgZGV2aWNlIHRyZWUgYmlu
ZGluZyBpcyB1c2VkLCBob3cgY291bGQgd2UgYXNzb2NpYXRlIGRyaXZldGVtcCBzZW5zb3JzIHdp
dGggYSBzcGVjaWZpYyB0aGVybWFsIHpvbmUNCg0KaWYgbm8gY29tcGF0aWJsZSBzdHJpbmcgaXMg
ZGVzY3JpYmVkIGZvciB0aGVzZSBkcml2ZXRlbXAgc2Vuc29ycyBpbiB0aGUgZHRzIGZpbGU/IA0K
DQpUaGF0IGlzIHdoeSBJIGFtIGFkZGluZyBhIGdlbmVyaWMgY29tcGF0aWJsZSBzdHJpbmcgdG8g
bWF0Y2ggYSBwbGF0Zm9ybSBzZW5zb3JzIHdpdGggYSBzcGVjaWZpYyB0aGVybWFsIHpvbmUuDQoN
ClJlZ2FyZHMsDQpQaGluZXgNCg0K
