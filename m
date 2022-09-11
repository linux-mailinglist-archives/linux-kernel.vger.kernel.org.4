Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE675B4B83
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIKDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIKDvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:51:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3D286EE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 20:51:19 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MQFzb60dGz14QTq;
        Sun, 11 Sep 2022 11:47:23 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 11:51:17 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <ard.biesheuvel@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM64: reloc_test: add __init/__exit annotations to module init/exit funcs
Date:   Sun, 11 Sep 2022 11:47:47 +0800
Message-ID: <20220911034747.132098-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 arch/arm64/kernel/reloc_test_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index e87a2b7f20f6..99f2ffe9fc05 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -48,7 +48,7 @@ static struct {
 	{ "R_AARCH64_PREL16",		relative_data16, (u64)&sym64_rel },
 };
 
-static int reloc_test_init(void)
+static int __init reloc_test_init(void)
 {
 	int i;
 
@@ -67,7 +67,7 @@ static int reloc_test_init(void)
 	return 0;
 }
 
-static void reloc_test_exit(void)
+static void __exit reloc_test_exit(void)
 {
 }
 
-- 
2.17.1

