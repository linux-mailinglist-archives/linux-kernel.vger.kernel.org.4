Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E2607C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJUQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJUQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:32:50 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714E27B54B;
        Fri, 21 Oct 2022 09:32:47 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 8B6BF3A1B68;
        Fri, 21 Oct 2022 18:32:45 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 702683A1B67;
        Fri, 21 Oct 2022 18:32:45 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Fri, 21 Oct 2022 18:32:45 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 21 Oct
 2022 18:32:42 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Fri, 21 Oct 2022 18:32:39 +0200
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "Wenchao Chen" <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>
CC:     "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Topic: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Index: AQHY5R8I87uqfAJat0yZdVamAN6Uba4ZAlSQgAAG0mA=
Date:   Fri, 21 Oct 2022 16:32:39 +0000
Message-ID: <0a9cf24cb65d49838c95455bb54ebf10@hyperstone.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <e7858446b9604b59b8270f181a1410ef@hyperstone.com>
In-Reply-To: <e7858446b9604b59b8270f181a1410ef@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.76]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27216.001
X-TMASE-Result: 10-0.600000-10.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4vHkpkyUphL968WQ55HWWYEtferJ/d7Ab5sD
        R/UAI5TzvIsrEBI5TCMTKXmbVigk9M4Cn0fUiJuC4yhsfWHTXOID2ItevgFI0wTWzpCCPenNfSa
        aVTZG9Sumzwm8IjCuXTJPsGAQSaI9EtSw+glyi5+6kMgL3jbYOjWRH7TlULWGhQJewwzLg0cTgt
        4grpaSCstzTAwe+66suOnwzUlQc01ccQ8eam5EfdIFVVzYGjNKnCGS1WQEGtDGr09tQ7Cw/1BIV
        svVu9ABIAcCikR3vq+6QMs2kQAnvozwLzyaw9cgt6uNgfMqbCfgQf7KU0BtDPrXpOUiVupa
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a6d37f3c-93f6-4117-bd58-5122f6534ca7-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBVbmxlc3MgdGhlcmUgaXMgc29tZXRoaW5nIHNwZWNpYWwgLyB3cm9uZyB3aXRoIHNk
aGNpLXNwcmQgKHVubGlrZWx5PyBJdHMganVzdCBhIGZsYWcpIG9yIHlvdXIgZU1NQyAobWF5YmUg
bW9yZSBsaWtlbHk/KSB0aGVuIElkIGV4cGVjdCB0aGlzIG9yIHNpbWlsYXIgcGVyZm9ybWFuY2Ug
ZGVncmFkYXRpb24gZm9yIGFueSBob3N0IGNvbnRyb2xsZXIgYW5kIGVNTUMuDQo+IEkgY2FuIHJl
ZG8gc29tZSBtZWFzdXJlbWVudCBpZiB5b3UgcHJvdmlkZSB5b3VyIHdvcmtsb2FkLg0KPiBCdXQg
SSdkIHNheSBpZiB5b3UgZG9u4oCZdCB3YW50IHRvIHBheSB0aGUgcHJpY2Ugb2YgcmVsaWFibGUg
d3JpdGUgdGhlbiBtYWtlIHN1cmUgdG8gbm90IGlzc3VlIHRoZW0sIGJ5IG5vdCBpc3N1aW5nIEZV
QT8NCj4gTWF5YmUgSSdtIG1pc3VuZGVyc3RhbmRpbmcsIGJ1dCB3aHkgd291bGQgdGhlIGhvc3Qg
Y29udHJvbGxlciBkcml2ZXIgY29udHJvbCBGVUE/DQo+IA0KDQpNYXliZSBvbmUgbW9yZSBwb2lu
dCBvbiB0aGF0OiBDb21wYXJlIHBlcmZvcm1hbmNlIHdpdGggZnVhIGRpc2FibGVkIGJ1dCBjYWNo
ZSBvZmYsIHNob3VsZCBiZSBjb21wYXJhYmxlIHVubGVzcyB0aGVyZSBpcyBhbiBhY3R1YWwgcmVs
aWFibGUgd3JpdGUgcHJvYmxlbS4NCklmIHJlbGlhYmxlIHdyaXRlIGlzIHBlcmZvcm1pbmcgaG9y
cmlibHkgb24gdGhhdCBlTU1DIG1heWJlIGEgcXVpcmsgY291bGQgYmUgdGhvdWdodCBvZi4NCkFu
eXdheSB5b3VyIDEzTUIvcyByYW5kb20gd2l0aCBmdWEsIGlmIGEgcmVsaWFibGUgd3JpdGUgaXMg
YmFzaWNhbGx5IGFsd2F5cyBhY3RpdmUgZm9yIGEgZ2l2ZW4gY2FjaGUgc2l6ZSwNCmRvZXNuJ3Qg
c291bmQgdG90YWxseSB1bnJlYXNvbmFibGUgKG92ZXIgMzAwMCBJT1BTLCBhc3N1bWluZyA0ayB3
cml0ZXMpLg0KDQpIeXBlcnN0b25lIEdtYkggfCBSZWljaGVuYXVzdHIuIDM5YSAgfCA3ODQ2NyBL
b25zdGFuegpNYW5hZ2luZyBEaXJlY3RvcjogRHIuIEphbiBQZXRlciBCZXJucy4KQ29tbWVyY2lh
bCByZWdpc3RlciBvZiBsb2NhbCBjb3VydHM6IEZyZWlidXJnIEhSQjM4MTc4Mg==

