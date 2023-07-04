Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60974717B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGDMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGDMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:36:17 -0400
X-Greylist: delayed 1193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 05:36:14 PDT
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8ABE7E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:36:14 -0700 (PDT)
Received: from wuxshcsitd00602.xfusion.com (unknown [10.32.132.250])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4QwMF80sf5z9xk0G;
        Tue,  4 Jul 2023 20:15:24 +0800 (CST)
Received: from wuxshcsitd00600.xfusion.com (10.32.133.213) by
 wuxshcsitd00602.xfusion.com (10.32.132.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Jul 2023 20:15:57 +0800
Received: from wuxshcsitd00600.xfusion.com ([fe80::6811:d152:496c:4db9]) by
 wuxshcsitd00600.xfusion.com ([fe80::6811:d152:496c:4db9%6]) with mapi id
 15.01.2507.023; Tue, 4 Jul 2023 20:15:57 +0800
From:   wangjinchao <wangjinchao@xfusion.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
CC:     xulei <stone.xulei@xfusion.com>
Subject: [PATCH] staging: rtl8192u: Fix assignment in if condition
Thread-Topic: [PATCH] staging: rtl8192u: Fix assignment in if condition
Thread-Index: AQHZrmkySezXLmADBkO4wJdvqf1PeQ==
Date:   Tue, 4 Jul 2023 12:15:57 +0000
Message-ID: <ZKP/01ECsgmdBFf2@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: wuxshcsitd00600.xfusion.com (15.01.2507.023)
x-originating-ip: [10.81.18.204]
Content-Type: text/plain; charset="gb2312"
Content-ID: <CCA9E587FFE6854982C83B7CB9B21800@xfusion.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBqdXN0IHBhcnRpY2lwYXRlZCBpbiBPdXRyZWFjaHkgb2YgS2VybmVsTmV3YmllcyBhbmQgZml4
ZWQgb25lIA0KJ0VSUk9SOiBkbyBub3QgdXNlIGFzc2lnbm1lbnQgaW4gaWYgY29uZGl0aW9uJyBp
c3N1ZSByZXBvcnRlZCBieSANCmNoZWNrcGF0Y2gucGwgb24gZHJpdmVycy9zdGFnaW5nL3J0bDgx
OTJ1L2llZWU4MDIxMS9pZWVlODAyMTFfcnguYy4NCg0KU2lnbmVkLW9mZi1ieTogV2FuZyBKaW5j
aGFvIDx3YW5namluY2hhb0B4ZnVzaW9uLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc3RhZ2luZy9ydGw4
MTkydS9pZWVlODAyMTEvaWVlZTgwMjExX3J4LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy9ydGw4MTkydS9pZWVlODAyMTEvaWVlZTgwMjExX3J4LmMgYi9kcml2ZXJzL3N0YWdpbmcv
cnRsODE5MnUvaWVlZTgwMjExL2llZWU4MDIxMV9yeC5jDQppbmRleCBjYTA5MzY3MDA1ZTEuLjUy
ZmY5ZTYyZWMwOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkydS9pZWVlODAy
MTEvaWVlZTgwMjExX3J4LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkydS9pZWVlODAy
MTEvaWVlZTgwMjExX3J4LmMNCkBAIC0xMTIxLDggKzExMjEsOSBAQCBpbnQgaWVlZTgwMjExX3J4
KHN0cnVjdCBpZWVlODAyMTFfZGV2aWNlICppZWVlLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIA0K
IAkvKiBza2I6IGhkciArIChwb3NzaWJseSBmcmFnbWVudGVkLCBwb3NzaWJseSBlbmNyeXB0ZWQp
IHBheWxvYWQgKi8NCiANCisJa2V5aWR4ID0gaWVlZTgwMjExX3J4X2ZyYW1lX2RlY3J5cHQoaWVl
ZSwgc2tiLCBjcnlwdCk7DQogCWlmIChpZWVlLT5ob3N0X2RlY3J5cHQgJiYgKGZjICYgSUVFRTgw
MjExX0ZDVExfV0VQKSAmJg0KLQkgICAgKGtleWlkeCA9IGllZWU4MDIxMV9yeF9mcmFtZV9kZWNy
eXB0KGllZWUsIHNrYiwgY3J5cHQpKSA8IDApIHsNCisJICAgIGtleWlkeCA8IDApIHsNCiAJCW5l
dGRldl9kYmcoaWVlZS0+ZGV2LCAiZGVjcnlwdCBmcmFtZSBlcnJvclxuIik7DQogCQlnb3RvIHJ4
X2Ryb3BwZWQ7DQogCX0NCi0tIA0KMi40MC4wDQoNCg==
