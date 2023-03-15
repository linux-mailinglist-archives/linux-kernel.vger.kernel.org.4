Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104DA6BB578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjCOODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjCOOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:03:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969488A387;
        Wed, 15 Mar 2023 07:03:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32FE2ehzE032190, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32FE2ehzE032190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 15 Mar 2023 22:02:40 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Mar 2023 22:02:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Mar 2023 22:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 15 Mar 2023 22:02:31 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77StGAgACUUIA=
Date:   Wed, 15 Mar 2023 14:02:31 +0000
Message-ID: <9DA1C2E5-C9EB-48AD-846D-92CC0C434BFE@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <30d2ab9a-c3d1-c9d9-3cc6-02ef7af8981a@kernel.org>
In-Reply-To: <30d2ab9a-c3d1-c9d9-3cc6-02ef7af8981a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.20.168]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED260BB4B9CD21468DBB952A52FD347E@realtek.com>
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

DQoNCk9uIDE1LzAzLzIwMjMgMjE6MTEsICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6a0BrZXJu
ZWwub3JnIDxtYWlsdG86a3J6a0BrZXJuZWwub3JnPj4gd3JvdGU6DQoNCkhpIEtyenlzenRvZiwN
Cg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCj5QbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21h
aW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5IHBlb3BsZQ0KPmFuZCBsaXN0
cyB0byBDQy4gSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xk
ZXINCj5rZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRlZCBlbnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNl
IGJlIHN1cmUgeW91IGJhc2UNCj55b3VyIHBhdGNoZXMgb24gcmVjZW50IExpbnV4IGtlcm5lbC4N
Cg0KSSBhbSB3b3JraW5nIG9uIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9zdGFibGUvbGludXgtc3RhYmxlLmdpdA0KDQpGb3IgbWFzdGVyIGJyYW5jaC4NCg0K
SXMgdGhlcmUgYW55IHVwZGF0ZWQgZ2l0IHJlcG8gdGhhdCBJIHNob3VsZCByZWJhc2UgbXkgcGF0
Y2g/DQoNCg0KPkJpbmRpbmdzIGFyZSBhbHdheXMgc2VwYXJhdGUuDQoNCldvdWxkIHNlcGFyYXRl
IGluIHRoZSBuZXh0IHBhdGNoLg0KDQoNCj5ObyBzdWNoIHZlbmRvciBwcmVmaXguIEFyZSB5b3Ug
c3VyZSB5b3UgYXJlIGRlc2NyaWJpbmcgcmVhbCBoYXJkd2FyZT8NCj5BbHNvIGRldmljZSBzcGVj
aWZpYyBwYXJ0IGxvb2tzIHRvbyBnZW5lcmljLiBXaGF0IGRldmljZSBpcyBpdCBleGFjdGx5Pw0K
DQpJdCdzIGEgZ2VuZXJpYyBwYXRjaCwganVzdCB3YW50IHRvIHN1cHBvcnQgdGhlcm1hbCB6b25l
IHVzaW5nIGEgc2ltcGxlIGRldmljZSB0cmVlLg0KQW55IFNvQyB3aXRoIFNDU0kgaW50ZXJmYWNl
IGFuZCBhdHRhY2hlZCBoYXJkIGRyaXZlcyBjYW4gYmVuZWZpdCB0aGlzIGNoYW5nZS4NCg0KTm9y
bWFsbHkgYSBUSEVSTUFMX09GIHJlcXVpcmUgYSBwbGF0Zm9ybSBkZXZpY2UgdG8gYWRkIGEgdGhl
cm1hbCB6b25lLg0KDQpPcmlnaW5hbCBkcml2ZXRlbXAuYyB3b3JrcyBxdWl0ZSB3ZWxsIGFzIGEg
aHdtb24gZGV2aWNlLCBidXQgbm8gdGhlcm1hbCB6b25lIHN1cHBvcnQuDQoNCk15IHBhdGNoIGp1
c3QgZXh0ZW5kIGl0cyBjYXBhYmlsaXR5IHRvIHN1cHBvcnQgYSBzaW1wbGUgdGhlcm1hbCB6b25l
IGNyZWF0ZWQgd2l0aCB0aGlzIGh3bW9uLg0KDQpUaGlzIGlzIGJpbmQgdG8gYW55IHNwZWNpZmlj
IHZlbmRvciwganVzdCB0byBwcm92aWRlIGFuIGVhc3kgd2F5IHRvIGhhbmRsZSBjb29saW5nIHdo
ZW4gaGFyZCBkcml2ZXMnIHRlbXBlcmF0dXJlIGdldHMgaGlnaC4NCg0KQmVzdCBSZWdhcmRzLA0K
UGhpbmV4DQoNCg0KDQo=
