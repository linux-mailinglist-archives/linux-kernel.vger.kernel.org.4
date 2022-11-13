Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C5626F26
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKMLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:10:54 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9F83FAEF;
        Sun, 13 Nov 2022 03:10:46 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 19:05:16 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 19:05:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     mchehab@kernel.org, matthias.bgg@gmail.com,
        hverkuil-cisco@xs4all.nl, moudy.ho@mediatek.com, sunke32@huawei.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: mtk-mdp3: add missing call to
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <be6c204.133.18470aa3e15.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCHj+Btz3BjBiIDAA--.63W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAhsE
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNvbXAuYzo4OTI6MS0yMzogV0FSTklORzoKRnVu
Y3Rpb24gImZvcl9lYWNoX2NoaWxkX29mX25vZGUiIHNob3VsZCBoYXZlIG9mX25vZGVfcHV0KCkg
YmVmb3JlCnJldHVybiBhcm91bmQgbGluZSA5MTQuCmRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvbWRwMy9tdGstbWRwMy1jb21wLmM6ODkyOjEtMjM6IFdBUk5JTkc6CkZ1bmN0aW9uICJm
b3JfZWFjaF9jaGlsZF9vZl9ub2RlIiBzaG91bGQgaGF2ZSBvZl9ub2RlX3B1dCgpIGJlZm9yZQpy
ZXR1cm4gYXJvdW5kIGxpbmUgOTIwLgpkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21k
cDMvbXRrLW1kcDMtY29tcC5jOjk1MToxLTIzOiBXQVJOSU5HOgpGdW5jdGlvbiAiZm9yX2VhY2hf
Y2hpbGRfb2Zfbm9kZSIgc2hvdWxkIGhhdmUgb2Zfbm9kZV9wdXQoKSBiZWZvcmUKcmV0dXJuIGFy
b3VuZCBsaW5lIDk5My4KClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdA
amFyaS5jbj4KLS0tCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1k
cDMtY29tcC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXRrLW1kcDMtY29tcC5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9t
ZHAzL210ay1tZHAzLWNvbXAuYwppbmRleCBkM2VhZjg4ODQ0MTIuLjQxNjJmYzczMmYzOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNv
bXAuYworKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMt
Y29tcC5jCkBAIC05MDgsNiArOTA4LDcgQEAgc3RhdGljIGludCBtZHBfY29tcF9zdWJfY3JlYXRl
KHN0cnVjdCBtZHBfZGV2ICptZHApCiAJCWFsaWFzX2lkID0gbWRwX2NvbXBfYWxpYXNfaWRbdHlw
ZV07CiAJCWlkID0gbWRwX2NvbXBfZ2V0X2lkKHR5cGUsIGFsaWFzX2lkKTsKIAkJaWYgKGlkIDwg
MCkgeworCQkJb2Zfbm9kZV9wdXQobm9kZSk7CiAJCQlkZXZfZXJyKGRldiwKIAkJCQkiRmFpbCB0
byBnZXQgc3ViIGNvbXAuIGlkOiB0eXBlICVkIGFsaWFzICVkXG4iLAogCQkJCXR5cGUsIGFsaWFz
X2lkKTsKQEAgLTkxNiw4ICs5MTcsMTAgQEAgc3RhdGljIGludCBtZHBfY29tcF9zdWJfY3JlYXRl
KHN0cnVjdCBtZHBfZGV2ICptZHApCiAJCW1kcF9jb21wX2FsaWFzX2lkW3R5cGVdKys7CiAKIAkJ
Y29tcCA9IG1kcF9jb21wX2NyZWF0ZShtZHAsIG5vZGUsIGlkKTsKLQkJaWYgKElTX0VSUihjb21w
KSkKKwkJaWYgKElTX0VSUihjb21wKSkgeworCQkJb2Zfbm9kZV9wdXQobm9kZSk7CiAJCQlyZXR1
cm4gUFRSX0VSUihjb21wKTsKKwkJfQogCX0KIAogCXJldHVybiAwOwpAQCAtOTg4LDYgKzk5MSw3
IEBAIGludCBtZHBfY29tcF9jb25maWcoc3RydWN0IG1kcF9kZXYgKm1kcCkKIAogCQlwZGV2ID0g
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZShub2RlKTsKIAkJaWYgKCFwZGV2KSB7CisJCQlvZl9ub2Rl
X3B1dChub2RlKTsKIAkJCWRldl93YXJuKGRldiwgImNhbid0IGZpbmQgcGxhdGZvcm0gZGV2aWNl
IG9mIG5vZGU6JXNcbiIsCiAJCQkJIG5vZGUtPm5hbWUpOwogCQkJcmV0dXJuIC1FTk9ERVY7Ci0t
IAoyLjI1LjEK
