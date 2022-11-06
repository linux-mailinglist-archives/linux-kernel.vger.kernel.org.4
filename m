Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA29061E28A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKFORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:17:00 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25741B1DC;
        Sun,  6 Nov 2022 06:16:58 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 22:12:12 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 22:12:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] soc/tegra: cbb: Remove unnecessary print function
 dev_err()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <564ff856.bc.1844d48df8a.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+G8wGdjD4sBAA--.48W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CxQADsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RWxpbWluYXRlIHRoZSBmb2xsb3cgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9kcml2ZXJzL3NvYy90
ZWdyYS9jYmIvdGVncmEtY2JiLmM6MTQyOjMtMTA6IGxpbmUgMTQyIGlzIHJlZHVuZGFudApiZWNh
dXNlIHBsYXRmb3JtX2dldF9pcnEoKSBhbHJlYWR5IHByaW50cyBhbiBlcnJvcgouL2RyaXZlcnMv
c29jL3RlZ3JhL2NiYi90ZWdyYS1jYmIuYzoxNTI6Mi05OiBsaW5lIDE1MiBpcyByZWR1bmRhbnQK
YmVjYXVzZSBwbGF0Zm9ybV9nZXRfaXJxKCkgYWxyZWFkeSBwcmludHMgYW4gZXJyb3IKClNpZ25l
ZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJz
L3NvYy90ZWdyYS9jYmIvdGVncmEtY2JiLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy90ZWdyYS9jYmIvdGVncmEtY2JiLmMg
Yi9kcml2ZXJzL3NvYy90ZWdyYS9jYmIvdGVncmEtY2JiLmMKaW5kZXggZDIwMDkzNzM1M2M3Li4z
M2UyNjEzMDExMzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc29jL3RlZ3JhL2NiYi90ZWdyYS1jYmIu
YworKysgYi9kcml2ZXJzL3NvYy90ZWdyYS9jYmIvdGVncmEtY2JiLmMKQEAgLTEzOSw3ICsxMzks
NiBAQCBpbnQgdGVncmFfY2JiX2dldF9pcnEoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwg
dW5zaWduZWQgaW50ICpub25zZWNfaXJxLAogCWlmIChudW1faW50ciA9PSAyKSB7CiAJCWlycSA9
IHBsYXRmb3JtX2dldF9pcnEocGRldiwgaW5kZXgpOwogCQlpZiAoaXJxIDw9IDApIHsKLQkJCWRl
dl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgbm9uLXNlY3VyZSBJUlE6ICVkXG4iLCBp
cnEpOwogCQkJcmV0dXJuIC1FTk9FTlQ7CiAJCX0KIApAQCAtMTQ5LDcgKzE0OCw2IEBAIGludCB0
ZWdyYV9jYmJfZ2V0X2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCB1bnNpZ25lZCBp
bnQgKm5vbnNlY19pcnEsCiAKIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGluZGV4KTsK
IAlpZiAoaXJxIDw9IDApIHsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBz
ZWN1cmUgSVJROiAlZFxuIiwgaXJxKTsKIAkJcmV0dXJuIC1FTk9FTlQ7CiAJfQogCi0tIAoyLjI1
LjEK
