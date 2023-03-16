Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF746BC4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCPDcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:32:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7462132;
        Wed, 15 Mar 2023 20:32:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32G3TN5Z0015493, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32G3TN5Z0015493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 11:29:23 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Mar 2023 11:29:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Mar 2023 11:29:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 11:29:35 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgD//4V8AIAAjaUA
Date:   Thu, 16 Mar 2023 03:29:34 +0000
Message-ID: <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
In-Reply-To: <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.242.6]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <691D2079EBAAAB4DA222C505D7AF5C27@realtek.com>
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

DQpPbiAzLzE2LzIzIDExOjAyLCBHdWVudGVyIFJvZWNrIiA8Z3JvZWNrN0BnbWFpbC5jb20gPG1h
aWx0bzpncm9lY2s3QGdtYWlsLmNvbT4gPG1haWx0bzpncm9lY2s3QGdtYWlsLmNvbSA8bWFpbHRv
Omdyb2VjazdAZ21haWwuY29tPj4gd3JvdGU6DQoNCu+7vw0KPlN1cmUuIEJ1dCB5b3VyIGFyZ3Vt
ZW50IGlzIGluYXBwcm9wcmlhdGU6IFlvdSBjb3VsZCBhcyB3ZWxsIGFyZ3VlIHRoYXQNCj50aGlz
IHN5c3RlbSB3aXRoIGEgc2luZ2xlIGZhbiBzaG91bGQgYnVuZGxlIGFsbCBpdHMgdGhlcm1hbCBz
ZW5zb3JzIGludG8NCj5hIHNpbmdsZSB0aGVybWFsIHpvbmUsIGFuZCB0aGF0IGl0IHNob3VsZCBk
byBzbyBpbiB0aGUgZHJpdmVyKHMpDQo+cHJvdmlkaW5nIHRoZSB0aGVybWFsIHpvbmUgc2Vuc29y
cyB0byB0aGUgdGhlcm1hbCBzdWJzeXN0ZW0uIFRoaXMgZG9lcw0KPm5vdCB0YWtlIGludG8gYWNj
b3VudCB0aGF0IHRoZXJlIG1pZ2h0IGJlIHN5c3RlbXMgd2l0aCBkb3plbnMgKG9yIGh1bmRyZWRz
LA0KPmZvciB0aGF0IG1hdHRlcikgb2YgZHJpdmVzLCBpbiBhIHN5c3RlbSB3aXRoIG11bHRpcGxl
IGRpc2sgdHJheXMgYW5kIGZhbnMNCj5mb3IgZWFjaCBvZiB0aG9zZS4NCg0KPkkgZG9uJ3Qga25v
dyBpZiBhbmQgaG93IHRoZSB0aGVybWFsIHN1YnN5c3RlbSBkZWFscyB3aXRoIHRoZSBzaXR1YXRp
b24NCj5vZiBoYXZpbmcgTiB0aGVybWFsIHpvbmUgc2Vuc29ycyBhbmQgTSA8PCBOIGNvb2xpbmcg
ZGV2aWNlcy4gVGhpcyBpcw0KPmEgZ2VuZXJhbCBwcm9ibGVtLCBub3QgbGltaXRlZCB0byBkaXNr
IGRyaXZlcy4gSnVzdCBhcyB3ZSB3b24ndCBidW5kbGUNCj5tdWx0aXBsZSB0aGVybWFsIHNlbnNv
cnMgb24gYSBtdWx0aS1jaGFubmVsIHRoZXJtYWwgc2Vuc29yIGNoaXAgaW50byBhDQo+c2luZ2xl
IHRoZXJtYWwgem9uZSwgd2Ugd29uJ3QgYnVuZGxlIG11bHRpcGxlIGRpc2sgZHJpdmVzIGludG8g
YSBzaW5nbGUNCj50aGVybWFsIHpvbmUuDQoNCkl0J3MgdHJ1ZSwgdGhlcmUgYXJlIHNldmVyYWwg
ZGlmZmVyZW50IGNvbWJpbmF0aW9ucy4gDQoNCktlZXAgYSBzaW5nbGUgc2Vuc29yIHdpdGggYSBz
aW5nbGUgdGhlcm1hbCBtaWdodCBnaXZlIG1vcmUgZmxleGliaWxpdHkuDQoNCk15IGlkZWEgaXMg
aW5zcGlyZWQgZnJvbSB0aGUgY29tbWVudCBvZiB0aGUgZm9sbG93aW5nIHBhdGNoLi4NCg0KaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvZGV2aWNldHJlZS9tc2c1MzcxODYuaHRtbA0KDQpC
eSB0aGUgY29tbWVudCBpbiB0aGlzIHBhdGNoLCBpdCBzYWlkIHRoYXQgIlRoZXJtYWwgem9uZSB3
b3JrcyBvbmx5IHdpdGggZmlyc3QgZGlza3MiLg0KDQpCdXQgaXQgaGFzIHR3byBoYXJkIGRpc2ss
IGVhY2ggZGVzY3JpYmVzIGEgdGhlcm1hbC1zZW5zb3JzLWNlbGxzLg0KDQogLyogVGhlcm1hbCB6
b25lIHdvcmtzIG9ubHkgd2l0aCBmaXJzdCBkaXNrICovLg0KDQpUaGF0IGlzIHdoeSBJIGFtIHRy
eWluZyB0byBoYWNrIHRoZSBvcmlnaW5hbCB0ZW1wX3JlYWQgY2FsbCBiYWNrIHRvIHN1cHBvcnQg
bXVsdGlwbGUgc2Vuc29ycy4NCg0KQW55d2F5LCBrZWVwIGEgc2luZ2xlIG1hcHBpbmcgbWlnaHQg
YmUgZ29vZCBhbmQgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCg0KPkluIHRoZW9yeSBpdCBz
aG91bGQgd29yayBqdXN0IGxpa2UgZGVzY3JpYmVkIGluIHRoZSBraXJrd29vZCBkZXZpY2V0cmVl
DQo+ZmlsZXMuIElmIHRoYXQgZG9lc24ndCB3b3JrLCB0aGUgcXVlc3Rpb24gaXMgaG93IHRvIGZp
bmQgdGhlIHNhdGEgcG9ydA0KPm5vZGVzIGZyb20gdGhlIGRyaXZldGVtcCBkcml2ZXIuIEkgZG9u
J3QgaGF2ZSBhIHN5c3RlbSB3aXRoIHN1Y2ggbm9kZXMsDQo+c28gSSBoYXZlIG5vIG1lYW5zIHRv
IGZpbmQgb3Iga25vdyB0aGUgYW5zd2VyLg0KDQoNCj5JIGFsc28gZG9uJ3Qga25vdyBob3cgdG8g
YXR0YWNoIG1vcmUgdGhhbiBvbmUgdGhlcm1hbCBzZW5zb3IgdG8gYQ0KPnNpbmdsZSB0aGVybWFs
IHpvbmUsIG9yIGlmIHRoYXQgaXMgZXZlbiBwb3NzaWJsZS4gSWYgaXQgaXNuJ3QsIGl0DQo+aXMg
YSBsaW1pdGF0aW9uIG9mIHRoZSB0aGVybWFsIHN1YnN5c3RlbSwgYW5kIHRyeWluZyB0byBoYWNr
IGFyb3VuZA0KPml0IGluIGEgZHJpdmVyIHByb3ZpZGluZyB0aGVybWFsIHNlbnNvcnMgd291bGQg
YmUgaW5hcHByb3ByaWF0ZS4NCg0KDQpUaGFuayB5b3UgZm9yIHRoaXMgZ3JlYXQgbW9kdWxlIHRv
IG1ha2UgdGhlcm1hbCBhbmQgY29vbGluZyBjb250cm9sIHNpbXBsZXIuDQoNClRoYXQgaXMgd2h5
IEkgYW0gdHJ5aW5nIHRvIGdldCBpdCB3b3JrIHVuZGVyIG91ciBrZXJuZWwgNC4xOSBzaW5jZSBv
dXIgU29DIGN1cnJlbnRseSB3b3JrcyB1bmRlciA0LjE5IG9ubHkuDQoNClNhdGEgcG9ydHMgY2Fu
IGJlIGZvdW5kIHdpdGhvdXQgYW55IGlzc3VlLCBhbmQgdGhlIGNvcnJlc3BvbmRpbmcgaHdtb24g
ZW50cmllcyBjYW4gYmUgZm91bmQsIHN1Y2ggYXMuDQoNCnJvb3RAT3BlbldSVC1LeWxpbjovc3lz
L2NsYXNzL2h3bW9uIyBscyAtYWwNCnRvdGFsIDANCmRyd3hyLXhyLXggICAgMiByb290ICAgICBy
b290ICAgICAgICAgICAgIDAgTWFyIDExIDA4OjEzIC4NCmRyd3hyLXhyLXggICA0MiByb290ICAg
ICByb290ICAgICAgICAgICAgIDAgTWFyIDExIDA4OjEzIC4uDQpscnd4cnd4cnd4ICAgIDEgcm9v
dCAgICAgcm9vdCAgICAgICAgICAgICAwIE1hciAxMSAwODoxMyBod21vbjAgLT4gLi4vLi4vZGV2
aWNlcy9wbGF0Zm9ybS9zb2MvOTgwMDAwMDAuYnVzLzk4MDFiMDAwLnN5c2Nvbi85ODAxYmMwMC5y
dGtfZmFuL2h3bW9uL2h3bW9uMA0KbHJ3eHJ3eHJ3eCAgICAxIHJvb3QgICAgIHJvb3QgICAgICAg
ICAgICAgMCBNYXIgMTEgMDg6MTMgaHdtb24xIC0+IC4uLy4uL2RldmljZXMvcGxhdGZvcm0vc29j
Lzk4MDAwMDAwLmJ1cy85ODAzZjAwMC5zYXRhL2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDowOjA6
MC9od21vbi9od21vbjENCmxyd3hyd3hyd3ggICAgMSByb290ICAgICByb290ICAgICAgICAgICAg
IDAgTWFyIDExIDA4OjEzIGh3bW9uMiAtPiAuLi8uLi9kZXZpY2VzL3BsYXRmb3JtL3NvYy85ODAw
MDAwMC5idXMvOTgwM2YwMDAuc2F0YS9hdGEyL2hvc3QxL3RhcmdldDE6MDowLzE6MDowOjAvaHdt
b24vaHdtb24yDQoNCkFuZCBJIGFkZCB0aGUgcG9ydCBudW1iZXIgaW4gdGhlIG5hbWUgb2YgdGhl
c2UgaHdtb24gZGV2aWNlcyBzbyB0aGF0IEkgY2FuIGRpZmZlcmVudGlhdGUgdGhlbS4NCg0Kcm9v
dEBPcGVuV1JULUt5bGluOi9zeXMvY2xhc3MvaHdtb24jIGNhdCBod21vbjEvbmFtZSBod21vbjEv
dGVtcDFfaW5wdXQNCmRyaXZldGVtcF9wb3J0MA0KNTIwMDANCnJvb3RAT3BlbldSVC1LeWxpbjov
c3lzL2NsYXNzL2h3bW9uIyBjYXQgaHdtb24yL25hbWUgaHdtb24yL3RlbXAxX2lucHV0DQpkcml2
ZXRlbXBfcG9ydDENCjQ5MDAwDQoNCk15IGluaXRpYWwgcHJvYmxlbSBpcyB0aGF0ICJob3cgY291
bGQgSSBhc3NvY2lhdGVkIHRoZXNlIGh3bW9uIGRldmljZXMgd2l0aCB0aGVybWFsIHpvbmVzIj8N
Cg0KQnkgdHJhY2luZyB0aGUgc291cmNlIGNvZGUsIGZpbmRpbmcgdGhhdCBJIHByb2JhYmx5IG5l
ZWQgdG8gcmVnaXN0ZXIgdGhlcm1hbF96b25lIHVzaW5nIGEgcGxhdGZvcm0gZGV2aWNlLg0KDQpI
YWNraW5nIGludG8gdGhlIHRoZXJtYWwgZnJhbWV3b3JrIGlzIG5vdCBhIGdvb2QgdGhpbmcsIHNv
IHRoYXQgaXMgd2h5IEkgaGF2ZSB0aGlzIHBhdGNoIHRvIGhhY2sgeW91ciBkcml2ZXIuDQoNCkFu
eSBiZXR0ZXIgaWRlYSB0byBnZXQgdGhlcm1hbCB6b25lIHdvcmsgd2l0aG91dCByZWdpc3RlciBh
IHBsYXRmb3JtIGRldmljZSBhbmQgdGhlbiByZWdpc3RlcnMgdGhlIHNlbnNvcnMgd2l0aCB0aGVy
bWFsIHpvbmUgYWdhaW4/DQoNClRoYW5rcw0KDQpSZWdhcmRzLA0KUGhpbmV4DQoNCg0KDQo=
