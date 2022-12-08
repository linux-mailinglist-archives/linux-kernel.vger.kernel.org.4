Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB9646702
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLHCdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHCdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:33:47 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF5862F9;
        Wed,  7 Dec 2022 18:33:46 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
Thread-Topic: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
Thread-Index: AQHZCqVuBk64DdfxrUS//1lI5X8lq65jOKYw
Date:   Thu, 8 Dec 2022 02:32:15 +0000
Message-ID: <17a6782c79a44aada31246ddefe02bfb@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
 <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
In-Reply-To: <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.204.59]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gQWxsb3cgdXNlciB0byB1bmxvYWQgaXQgaW4gcnVubmluZw0KPiANCj4gSnVzdCBsaWtl
IHRoYXQ/ICBBbmQgY29ycnVwdCB0aGluZ3MgbGVmdCBhbmQgcmlnaHQgd2hpbGUgYXQgaXQ/DQo+
IA0KPiBObyB3YXkuDQo+IA0KPiBBbmQgd2h5IGRvIHlvdSBuZWVkIHRoaXM/DQoNCkNwdWlkbGUt
aGFsdHBvbGwgY2FuIG5vdCBpbXByb3ZlIHBlcmZvcm1hbmNlIGZvciBhbGwgY2FzZXMsIGxpa2Ug
d2hlbiBndWVzdCBoYXMgbXdhaXQsIHVuaXhiZW5jaCBzaG93cyBhIHNtYWxsIHBlcmZvcm1hbmNl
IGRyb3A7IA0KU28gY2hhbmdlIGl0IGFzIG1vZHVsZSwgdXNlciBjYW4gaW5zbW9kIHRoaXMgZHJp
dmVycyBhbmQgcm1tb2QgdGhpcyBkcml2ZXIgYXQgcnVuIHRpbWUNCg0KQW5kIHNvbWUgZG93bnN0
cmVhbSBvcywgY2VudG9zIGFuZCB1YnVudHUgYnVpbGQgaXQgbW9kdWxlDQoNCk9mIGNhdXNlLCBp
dCB3aWxsIGNhdXNlIHBlcmZvcm1hbmNlIGRyb3Agc2luY2UgaXQgaXMgbm90IGluc3RhbGxlZCBi
eSBkZWZhdWx0LCBidXQgdXNlciBpbnNtb2QgdGhpcyBtb2R1bGUsIHRoaXMgcGVyZm9ybWFuY2Ug
Y2FuIHJlc3RvcmUsIHNvIEkgdGhpbmsgdGhpcyBpcyBhY2NlcHRhYmxlDQpJZiB0aGlzIHJlYXNv
bSBpcyBhY2NlcHRhYmxlLCBJIHdpbGwgYWRkIHYzOyBvciBkcm9wIHRoaXMgcGF0Y2guDQoNClRo
YW5rcw0KDQotTGkNCg==
