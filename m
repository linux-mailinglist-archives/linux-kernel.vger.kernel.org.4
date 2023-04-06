Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469F66D9058
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjDFHTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjDFHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:19:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247F1FD2;
        Thu,  6 Apr 2023 00:19:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3367IR5c8008202, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3367IR5c8008202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 15:18:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Apr 2023 15:18:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Apr 2023 15:18:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 15:18:46 +0800
From:   =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB support
Thread-Topic: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB
 support
Thread-Index: AdloUWFHnoi4nqZjQxCI6ksHRb9dMg==
Date:   Thu, 6 Apr 2023 07:18:46 +0000
Message-ID: <5d644994dd39447cba7ba7027cc856b0@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.137]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGlzIHNlcmllcyBhZGRzIERldmljZSBUcmVlcyBmb3IgdGhlIFJl
YWx0ZWsgUlREMTMxOSBTb0MgYW5kIFJlYWx0ZWsncw0KUHltUGFydGljbGUgRVZCLg0KDQp2MS0t
PnYyOg0KKiBQdXQgc3RyaW5nIGluIGFscGhhYmV0aWNhbCBvcmRlcg0KdjE6DQoqIFJURDEzMTkg
U29DIGFuZCBSZWFsdGVrIFB5bVBhcnRpY2xlIEVWQg0KDQpDYzogUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz4NCkNjOiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCkNj
OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+DQpDYzogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0KQ2M6IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
DQpDYzogbGludXgtcmVhbHRlay1zb2NAbGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCg0KY3kuaHVhbmcgKDIpOg0KICBkdC1iaW5kaW5nczogYXJt
OiByZWFsdGVrOiBBZGQgUmVhbHRlayBQeW0gUGFydGljbGVzIEVWQg0KICBhcm02NDogZHRzOiBy
ZWFsdGVrOiBBZGQgUlREMTMxOSBTb0MgYW5kIFJlYWx0ZWsgUHltIFBhcnRpY2xlcyBFVkINCg0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwgICAgICB8ICAgNiArDQog
YXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL01ha2VmaWxlICAgICAgICAgIHwgICAyICsNCiAu
Li4vYm9vdC9kdHMvcmVhbHRlay9ydGQxMzE5LXB5bXBhcnRpY2xlcy5kdHMgfCAgMjggKysNCiBh
cmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTN4eC5kdHNpICAgICAgfCAzNDYgKysrKysr
KysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCAzODIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTMxOS1weW1wYXJ0
aWNsZXMuZHRzDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRl
ay9ydGQxM3h4LmR0c2kNCg0KLS0NCjIuMzkuMA0K
