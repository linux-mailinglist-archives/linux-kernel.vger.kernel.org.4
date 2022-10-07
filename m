Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B705F7A30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:00:19 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AF12D3A;
        Fri,  7 Oct 2022 08:00:15 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 685993A175B;
        Fri,  7 Oct 2022 17:00:13 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 588CD3A1756;
        Fri,  7 Oct 2022 17:00:13 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 17:00:13 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 7 Oct 2022
 17:00:12 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Fri, 7 Oct 2022 17:00:09 +0200
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Topic: [PATCH 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Index: AdjZiMURb3moNmapTDOMC5quWhQ63QAtAFmAAAf8AIA=
Date:   Fri, 7 Oct 2022 15:00:09 +0000
Message-ID: <8d6277a6c1c8414a924908085e36ca26@hyperstone.com>
References: <cc0d807fbd2f4001adef8728f957c696@hyperstone.com>
 <CAPDyKFpvsDoLherwwyR5f7oJ0Fdwu6HV0MLgX+DrHkXkQrwbLQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpvsDoLherwwyR5f7oJ0Fdwu6HV0MLgX+DrHkXkQrwbLQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.22]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27188.000
X-TMASE-Result: 10--7.203000-10.000000
X-TMASE-MatchedRID: BFQSNthdAqLUL3YCMmnG4vHkpkyUphL9kYC3rjkUXRIO+Vu0Lo01HwYQ
        A2yc++RYpqXAH7H2REn+UMZCE8h83zF/ZjNXMgkjBe3KRVyu+k1kwkcTpSH1opsoi2XrUn/J+ZL
        5o+vRV7wDpAZ2/B/BlndkDsyT8WoOavP8b9lJtWr6C0ePs7A07RQEL0GGu6SDY9hTeCVAf4BudH
        BuiX/oYBeQR30Ut74RqrR89ANDRzY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 883a19fc-630e-46c5-97c3-da13a4be1491-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZXMsIHRoaXMgaXMgY2VydGFpbmx5IHJlc3RvcmluZyB0aGUgYmVoYXZpb3VyIGFuZCBmaXhp
bmcgYSBidWcuIFRoYW5rcyENCj4gDQo+IEhvd2V2ZXIsIEkgZG8gd29uZGVyIGFib3V0IHdoYXQn
cyB0aGUgcG9pbnQgb2YgdHJ5aW5nIHRvIHN3aXRjaCBiYWNrIHRvIHRoZSBjb3JyZWN0IHBhcnRp
dGlvbiBpZiB0aGUgbW1jX2h3X3Jlc2V0KCkgPiBmYWlsZWQgKHJldHVybmVkIGEgbmVnYXRpdmUg
ZXJyb3IgY29kZSkuIEl0IGxvb2tzIGxpa2UgdGhhdCBzaG91bGRuJ3QgbWF0dGVyLCBpZiB0aGUg
cmVzZXQgZmFpbGVkIHdlIGFyZSBzY3Jld2VkIGFueXdheSwgPiByaWdodD8NCg0KSSBhZ3JlZSB3
aXRoIHlvdSwgdGhlIG9ubHkgcmVhc29uIGZvciBpdCBpcyB0byBrZWVwIGJlaGF2aW9yIGluIGxp
bmUgd2l0aCBlcnIgIT0gLUVPUE5PVFNVUFAsDQpGb3IgdGhlIGNhc2UgdGhhdCBuZWl0aGVyIG9m
IHlvdSByZW1lbWJlcnMgdGhlIG9yaWdpbmFsIGludGVudCwgSSdsbCBzZW5kIGEgdjIuDQoNClJl
Z2FyZHMsDQpDaHJpc3RpYW4NCg0KSHlwZXJzdG9uZSBHbWJIIHwgUmVpY2hlbmF1c3RyLiAzOWEg
IHwgNzg0NjcgS29uc3RhbnoKTWFuYWdpbmcgRGlyZWN0b3I6IERyLiBKYW4gUGV0ZXIgQmVybnMu
CkNvbW1lcmNpYWwgcmVnaXN0ZXIgb2YgbG9jYWwgY291cnRzOiBGcmVpYnVyZyBIUkIzODE3ODI=

