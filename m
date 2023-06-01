Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B271949E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjFAHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFAHmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:42:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C801B0;
        Thu,  1 Jun 2023 00:41:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3517eqx17005447, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3517eqx17005447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 15:40:52 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 1 Jun 2023 15:41:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 15:41:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 15:41:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Minjie Du <duminjie@vivo.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] drivers: fix the parameter bin reference preceded by free
Thread-Topic: [PATCH v1] drivers: fix the parameter bin reference preceded by
 free
Thread-Index: AQHZlFoEAnA/cNUtV0e2xvXQ6x93g691jvsw
Date:   Thu, 1 Jun 2023 07:41:05 +0000
Message-ID: <ef245c4f59f8419da9011d1b3d522e6e@realtek.com>
References: <20230601072322.486-1-duminjie@vivo.com>
In-Reply-To: <20230601072322.486-1-duminjie@vivo.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWluamllIER1IDxkdW1p
bmppZUB2aXZvLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMSwgMjAyMyAzOjIzIFBNDQo+
IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGt2YWxvQGtlcm5lbC5vcmcN
Cj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTWluamllIER1IDxkdW1pbmppZUB2aXZvLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYxXSBkcml2ZXJzOiBmaXggdGhlIHBhcmFtZXRlciBiaW4gcmVmZXJlbmNlIHByZWNlZGVk
IGJ5IGZyZWUNCg0Kc3ViamVjdCBwcmVmaXggc2hvdWxkIGJlICJ3aWZpOiBydHc4OTogZml4IC4u
LiAiDQoNCj4gDQo+IFdlIGFzc2lnbiB0aGUgdmFyaWFibGUgYmluIHRvIE5VTEwsDQo+IGZpeCB2
YXJpYWJsZSBiaW4gcmVmZXJlbmNlIHByZWNlZGVkIGJ5IGZyZWUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNaW5qaWUgRHUgPGR1bWluamllQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZGVidWcuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9kZWJ1Zy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OS9kZWJ1Zy5jDQo+IGluZGV4IDZmNDE4ZjE0ZWMzZi4uNDU0MWI0ZDQ4ZTY5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2RlYnVnLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9kZWJ1Zy5jDQo+IEBAIC0yOTgyLDYg
KzI5ODIsNyBAQCBzdGF0aWMgdTggKnJ0dzg5X2hleDJiaW5fdXNlcihzdHJ1Y3QgcnR3ODlfZGV2
ICpydHdkZXYsDQo+ICAgICAgICAgaWYgKGhleDJiaW4oYmluLCBidWYsIG51bSkpIHsNCj4gICAg
ICAgICAgICAgICAgIHJ0dzg5X2luZm8ocnR3ZGV2LCAidmFsaWQgZm9ybWF0OiBIMUgySDMuLi5c
biIpOw0KPiAgICAgICAgICAgICAgICAga2ZyZWUoYmluKTsNCj4gKyAgICAgICAgICAgICAgIGJp
biA9IE5VTEw7DQo+ICAgICAgICAgICAgICAgICBlcnIgPSAtRUlOVkFMOw0KPiAgICAgICAgIH0N
Cg0KDQpEbyB5b3UgbWVldCByZWFsIHByb2JsZW0/IG9yIGNvZGUgY2hlY2tlciBmaW5kcyB0aGlz
PyANCg0KV2hlbiAnZXJyJyBpcyBzZXQsIHdlIGRvbid0IHRvdWNoICdiaW4nIGFueW1vcmUuIA0K
DQpQaW5nLUtlDQoNCg==
