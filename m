Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A656D9057
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjDFHTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjDFHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:19:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A9B76BA;
        Thu,  6 Apr 2023 00:19:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3367IVe14010477, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3367IVe14010477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 15:18:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Apr 2023 15:18:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Apr 2023 15:18:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 15:18:49 +0800
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
Subject: [PATCH v2 1/2] dt-bindings: arm: realtek: Add Realtek Pym Particles EVB
Thread-Topic: [PATCH v2 1/2] dt-bindings: arm: realtek: Add Realtek Pym
 Particles EVB
Thread-Index: AdloU4/GDmEWulC4QJGLhzkiNceBNg==
Date:   Thu, 6 Apr 2023 07:18:49 +0000
Message-ID: <cc3c64023eb847ed86554971de2dbf39@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.137]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

RGVmaW5lIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIFJlYWx0ZWsgUlREMTMxOSBQeW0gUGFydGlj
bGVzIGV2YWwgYm9hcmQuDQoNClNpZ25lZC1vZmYtYnk6IGN5Lmh1YW5nIDxjeS5odWFuZ0ByZWFs
dGVrLmNvbT4NCi0tLQ0KIHYxLS0+djI6DQogKiBQdXQgc3RyaW5nIGluIGFscGhhYmV0aWNhbCBv
cmRlcg0KIFYxOg0KICogUlREMTMxOSBTb0MgYW5kIFJlYWx0ZWsgUHltUGFydGljbGUgRVZCDQoN
CiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbCB8IDYg
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0KaW5kZXggZGRk
OWE4NTA5OWU5Li44ZDRlOTJlOWViNGIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwNCkBAIC01NSw2ICs1NSwxMiBAQCBwcm9w
ZXJ0aWVzOg0KICAgICAgICAgICAgICAgLSByZWFsdGVrLG1qb2xuaXIgIyBSZWFsdGVrIE1qb2xu
aXIgRVZCDQogICAgICAgICAgIC0gY29uc3Q6IHJlYWx0ZWsscnRkMTYxOQ0KDQorICAgICAgIyBS
VEQxMzE5IFNvQyBiYXNlZCBib2FyZHMNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgICAtIGVu
dW06DQorICAgICAgICAgICAgICAtIHJlYWx0ZWsscHltLXBhcnRpY2xlcyAjIFJlYWx0ZWsgUHlt
LXBhcnRpY2xlcyBFVkINCisgICAgICAgICAgLSBjb25zdDogcmVhbHRlayxydGQxMzE5DQorDQog
YWRkaXRpb25hbFByb3BlcnRpZXM6IHRydWUNCg0KIC4uLg0KLS0NCjIuMzkuMA0K
