Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54B61E2F2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKFPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKFPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:23:31 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5DDA102C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:23:30 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 23:18:35 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 23:18:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     benh@kernel.crashing.org, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Fix warning comparing pointer to 0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <c31207c.c3.1844d85a6aa.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+FL0GdjB4wBAA--.52W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CzgAFsW
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
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
bWFjaW8tYWRiLmM6MTAzOjEzLTE0OiBXQVJOSU5HIGNvbXBhcmluZyBwb2ludGVyIHRvIDAuCgpT
aWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJp
dmVycy9tYWNpbnRvc2gvbWFjaW8tYWRiLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21hY2ludG9zaC9t
YWNpby1hZGIuYyBiL2RyaXZlcnMvbWFjaW50b3NoL21hY2lvLWFkYi5jCmluZGV4IDliNjNiZDI1
NTFjNi4uMWMxYzM3NWE4MTdkIDEwMDY0NAotLS0gYS9kcml2ZXJzL21hY2ludG9zaC9tYWNpby1h
ZGIuYworKysgYi9kcml2ZXJzL21hY2ludG9zaC9tYWNpby1hZGIuYwpAQCAtMTAwLDcgKzEwMCw3
IEBAIGludCBtYWNpb19pbml0KHZvaWQpCiAJdW5zaWduZWQgaW50IGlycTsKIAogCWFkYnMgPSBv
Zl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCAiYWRiIiwgImNocnAsYWRiMCIpOwotCWlmIChh
ZGJzID09IDApCisJaWYgKGFkYnMpCiAJCXJldHVybiAtRU5YSU87CiAKIAlpZiAob2ZfYWRkcmVz
c190b19yZXNvdXJjZShhZGJzLCAwLCAmcikpIHsKLS0gCjIuMjUuMQo=
