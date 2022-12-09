Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C066E6482E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLINqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLINqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:46:20 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF962E83;
        Fri,  9 Dec 2022 05:46:17 -0800 (PST)
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
Thread-Index: AQHZCkl35vAH2p6SAUK3SxvI0ANPyq5liorA
Date:   Fri, 9 Dec 2022 13:44:39 +0000
Message-ID: <18a9a8b46076468a90c3823fd2c9447e@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
In-Reply-To: <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
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

PiA+IGxhdGVuY3kgb2Ygc29ja3BlcmYgcGluZy1wb25nIGxvY2FsaG9zdCB0ZXN0IGlzIHJlZHVj
ZWQgYnkgbW9yZSAyMCUNCj4gPiB1bml4YmVuY2ggaGFzIDUlIHBlcmZvcm1hbmNlIGltcHJvdmVt
ZW50cyBmb3Igc2luZ2xlIGNvcmUNCj4gPg0KDQpTb3JyeSwgVGhlIHVwcGVyIGRhdGEgYXJlIHdy
b25nIHNpbmNlIHdyb25nIGdvdmVybm9yIGlzIHVzZWQNCg0Kd2hlbiBndWVzdCBoYXMgbXdhaXQs
IGFuZCBoYWx0cG9sbCBkcml2ZXIgaXMgbG9hZGVkIGFuZCBoYWx0cG9sbCBnb3Zlcm5vciBpcyB1
c2VkLg0KDQpvbiBJbnRlbCBjcHUsIHVuaXhiZW5jaCBzY29yZSBhcmUgbmVhcmx5IHNhbWUsIGJ1
dCBzb2NrcGVyZiBoYXMgMjAlIGxvdyBsYXRlbmN5IA0Kb24gQU1EIG1pbGFuIGNwdSwgdGhlIHNv
Y2twZXJmIGxhdGVuY3kgYXJlIHNpbWlsYXIgLCBidXQgdW5peGJlbmNoIHNpbmdsZSBjb3JlIHNj
b3JlIGhhcyAxMCUgbG9zcywgYmVjYXVzZSBBTUQgY3B1IG1heWJlIGhhcyB3ZWFrIHNtdCBjYXBh
YmlsaXR5IA0KDQpSZXBsYWNlIGRlZmF1bHQgaWRsZSB3aXRoIGFyY2ggY3B1IGlkbGUgaGFzIGxp
dHRsZSBlZmZlY3QNCg0KDQpUaGFua3MNCg0KLUxpDQoNCg0KSQ0K
