Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C9646FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLHMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:46:05 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D760B7B;
        Thu,  8 Dec 2022 04:46:03 -0800 (PST)
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
Thread-Index: AQHZCqVuBk64DdfxrUS//1lI5X8lq65jOKYwgAAgWoCAAJajoA==
Date:   Thu, 8 Dec 2022 12:42:45 +0000
Message-ID: <f10ae18cb250456c8ad420b0a3e45571@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
 <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
 <17a6782c79a44aada31246ddefe02bfb@baidu.com>
 <CAJZ5v0gXSUdFeHajUcjV-eh3eW1aRoJ8Yvp9J95czQg0cMetTA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXSUdFeHajUcjV-eh3eW1aRoJ8Yvp9J95czQg0cMetTA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.204.59]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbHNvLCB0aGVyZSBpcyBhbiBpbnRlcmZhY2UgZm9yIHN3aXRjaGluZyBjcHVpZGxlIGdvdmVy
bm9ycyBhdCBydW4gdGltZSBhbHJlYWR5LCBzbw0KPiB3aHkgY2FuICd0IGl0IGJlIHVzZWQgdG8g
YWRkcmVzcyB0aGlzIGNhc2U/DQoNCg0KSSB3aWxsIHN0dWR5IHRoaXMgaW50ZXJmYWNlLCB0aGFu
a3MNCg0KLUxpDQo=
