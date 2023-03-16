Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394226BD234
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCPOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCPOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:18:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799E132C4;
        Thu, 16 Mar 2023 07:18:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32GEHMCR0007934, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32GEHMCR0007934
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 22:17:22 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 22:17:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 16 Mar 2023 22:17:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 22:17:34 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgD//4V8AIAAjaUA//+VWgCAAK9BgIAAA6MA///XXIAAEq5YAA==
Date:   Thu, 16 Mar 2023 14:17:34 +0000
Message-ID: <4BC6E9A7-13A6-429F-A586-AC60DC505838@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
 <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
 <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
 <8c835412-f78f-570d-30a5-24f4c02a8438@roeck-us.net>
In-Reply-To: <8c835412-f78f-570d-30a5-24f4c02a8438@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.20.168]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <841BEF0DB358FE4A99776CCE4EB6D67D@realtek.com>
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

DQoNCk9uIDMvMTYvMjMgMjI6NDgsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQoNCg0KPlRoYXQgbmVl
ZHMgdG8gYmUgaW4gdGhlIGh3bW9uIGNvcmUuIFdlIGNhbiBub3QgY2hhbmdlIHRoZSBkZXZpY2Ug
cG9pbnRlcg0KPnBhc3NlZCB0byBod21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvKCkgYmVj
YXVzZSB0aGF0IGRldGVybWluZXMgdGhlDQo+bGlmZXRpbWUgb2YgdGhlIGh3bW9uIGRldmljZS4N
Cg0KDQo+R3VlbnRlcg0KDQpEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSBiZWxvdz8NCg0KT3Ig
aXMgaXQgcmVhc29uYWJsZSB0aGF0IHdlIGp1c3QgbWF0Y2ggYSBzcGVjaWZpYyBjb21wYXRpYmxl
IHN0cmluZyBhbmQgYXNzaWduIHRoZSBkZXZpY2Ugbm9kZSB0byB0aGUgb3JpZ2luYWwgZGV2LT5w
YXJlbnQgdXNlZCBpbiBkcml2ZXRlbXBfYWRkIGZ1bmN0aW9uID8NCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHdtb24vaHdtb24uYyBiL2RyaXZlcnMvaHdtb24vaHdtb24uYw0KaW5kZXggMzNlZGI1
YzAyZjdkLi5hNzZiZWVhZGEzM2UgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2h3bW9uL2h3bW9uLmMN
CisrKyBiL2RyaXZlcnMvaHdtb24vaHdtb24uYw0KQEAgLTc1Nyw2ICs3NTcsNyBAQCBfX2h3bW9u
X2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsIHZv
aWQgKmRydmRhdGEsDQogICAgICAgIHN0cnVjdCBod21vbl9kZXZpY2UgKmh3ZGV2Ow0KICAgICAg
ICBjb25zdCBjaGFyICpsYWJlbDsNCiAgICAgICAgc3RydWN0IGRldmljZSAqaGRldjsNCisgICAg
ICAgc3RydWN0IGRldmljZSAqdGVkdiA9IGRldjsNCiAgICAgICAgaW50IGksIGVyciwgaWQ7DQoN
CiAgICAgICAgLyogQ29tcGxhaW4gYWJvdXQgaW52YWxpZCBjaGFyYWN0ZXJzIGluIGh3bW9uIG5h
bWUgYXR0cmlidXRlICovDQpAQCAtODI2LDcgKzgyNyw5IEBAIF9faHdtb25fZGV2aWNlX3JlZ2lz
dGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqbmFtZSwgdm9pZCAqZHJ2ZGF0YSwN
CiAgICAgICAgaHdkZXYtPm5hbWUgPSBuYW1lOw0KICAgICAgICBoZGV2LT5jbGFzcyA9ICZod21v
bl9jbGFzczsNCiAgICAgICAgaGRldi0+cGFyZW50ID0gZGV2Ow0KLSAgICAgICBoZGV2LT5vZl9u
b2RlID0gZGV2ID8gZGV2LT5vZl9ub2RlIDogTlVMTDsNCisgICAgICAgd2hpbGUoIXRkZXYtPm9m
X25vZGUpDQorICAgICAgICAgICAgICAgdGRldiA9IHRkZXYtPnBhcmVudDsNCisgICAgICAgaGRl
di0+b2Zfbm9kZSA9IHRkZXYgPyB0ZGV2LT5vZl9ub2RlIDogTlVMTDsNCiAgICAgICAgaHdkZXYt
PmNoaXAgPSBjaGlwOw0KICAgICAgICBkZXZfc2V0X2RydmRhdGEoaGRldiwgZHJ2ZGF0YSk7DQpA
QCAtODM4LDcgKzg0MSw3IEBAIF9faHdtb25fZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Ug
KmRldiwgY29uc3QgY2hhciAqbmFtZSwgdm9pZCAqZHJ2ZGF0YSwNCg0KICAgICAgICBJTklUX0xJ
U1RfSEVBRCgmaHdkZXYtPnR6ZGF0YSk7DQoNCi0gICAgICAgaWYgKGRldiAmJiBkZXYtPm9mX25v
ZGUgJiYgY2hpcCAmJiBjaGlwLT5vcHMtPnJlYWQgJiYNCisgICAgICAgaWYgKHRkZXYgJiYgdGRl
di0+b2Zfbm9kZSAmJiBjaGlwICYmIGNoaXAtPm9wcy0+cmVhZCAmJg0KICAgICAgICAgICAgY2hp
cC0+aW5mb1swXS0+dHlwZSA9PSBod21vbl9jaGlwICYmDQogICAgICAgICAgICAoY2hpcC0+aW5m
b1swXS0+Y29uZmlnWzBdICYgSFdNT05fQ19SRUdJU1RFUl9UWikpIHsNCiAgICAgICAgICAgICAg
ICBlcnIgPSBod21vbl90aGVybWFsX3JlZ2lzdGVyX3NlbnNvcnMoaGRldik7DQoNClJlZ2FyZHMs
DQpQaGluZXgNCg0KDQo=
