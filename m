Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E661E30A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKFPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKFPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:33:36 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0619DBC1F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:33:35 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 23:28:44 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 23:28:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     benh@kernel.crashing.org, mpe@ellerman.id.au,
        gregkh@linuxfoundation.org, sohu0106@126.com,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/adb: Fix warning comparing pointer to 0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2ef267c.c4.1844d8ef2d8.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+Gs0mdjLYwBAA--.53W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CzgAIsb
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9tYWNpbnRvc2gv
YWRiLmM6Njc2OjE0LTE1OiBXQVJOSU5HIGNvbXBhcmluZyBwb2ludGVyIHRvIDAuCgpTaWduZWQt
b2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9t
YWNpbnRvc2gvYWRiLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21hY2ludG9zaC9hZGIuYyBiL2RyaXZl
cnMvbWFjaW50b3NoL2FkYi5jCmluZGV4IDFiYmI5Y2EwOGQ0MC4uMDc2MjUzNTk5YmQ0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL21hY2ludG9zaC9hZGIuYworKysgYi9kcml2ZXJzL21hY2ludG9zaC9h
ZGIuYwpAQCAtNjczLDcgKzY3Myw3IEBAIHN0YXRpYyBpbnQgYWRiX29wZW4oc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCWdvdG8gb3V0OwogCX0KIAlzdGF0ZSA9IGtt
YWxsb2Moc2l6ZW9mKHN0cnVjdCBhZGJkZXZfc3RhdGUpLCBHRlBfS0VSTkVMKTsKLQlpZiAoc3Rh
dGUgPT0gMCkgeworCWlmIChzdGF0ZSkgewogCQlyZXQgPSAtRU5PTUVNOwogCQlnb3RvIG91dDsK
IAl9Ci0tIAoyLjI1LjEK
