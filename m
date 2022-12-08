Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA90646FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLHMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:44:22 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C860B7B;
        Thu,  8 Dec 2022 04:44:19 -0800 (PST)
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
Subject: RE: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with
 arch_cpu_idle
Thread-Topic: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with
 arch_cpu_idle
Thread-Index: AQHZCkl35vAH2p6SAUK3SxvI0ANPyq5jOG4AgAAgUwCAAJTQoA==
Date:   Thu, 8 Dec 2022 12:41:23 +0000
Message-ID: <3fb3526aa012449db95767c6092da8f6@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
 <9e19c594bcf144fbb433fb4cfee54e08@baidu.com>
 <CAJZ5v0jofKbdRbKzLSEMkjQjP1GTcbt7OYqO=0ZYvpt_HwTQTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jofKbdRbKzLSEMkjQjP1GTcbt7OYqO=0ZYvpt_HwTQTg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.204.59]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2022-12-08 20:41:24:190
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gV2hlbiBjcHVpZGxlLWhhbHRwb2xsIGlzIGJ1aWx0IGFzIG1vZHVsZSwNCj4gDQo+
IEJ1dCBpdCBpc24ndCBub3cuDQoNCkNlbnRvcyBpcyBjb21waWxpbmcgaXQgYXMgbW9kdWxlLCBp
dCB3aWxsIGZhaWw7DQpPdGhlciB1c2VyIHdhbnRzIHRvIGNvbXBpbGUgaXQgYXMgbW9kdWxlLCB0
aGV5IHdpbGwgZmFpbCwgDQpTeXpib3QgcmFuZG9tIGNvbmZpZ3VyYXRpb24gYnVpbGRpbmcgd2ls
bCBmYWlsDQoNClVubGVzcyBwcm9oaWJpdCB0byBidWlsZCBpdCBhcyBtb2R1bGUgYXMgYmVsb3c6
DQoNCmNvbmZpZyBIQUxUUE9MTF9DUFVJRExFDQotICAgICAgICB0cmlzdGF0ZSAiSGFsdCBwb2xs
IGNwdWlkbGUgZHJpdmVyIg0KKyAgICAgICAgYm9vbCAiSGFsdCBwb2xsIGNwdWlkbGUgZHJpdmVy
Ig0KICAgICAgICBkZXBlbmRzIG9uIFg4NiAmJiBLVk1fR1VFU1QNCiAgICAgICAgZGVmYXVsdCB5
DQogICAgICAgIGhlbHANCg0KDQp0aGFua3MNCg0KLUxpDQoNCg0K
