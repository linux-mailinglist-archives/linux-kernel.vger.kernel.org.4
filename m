Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE35E8921
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiIXH1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiIXH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:27:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CBA24094;
        Sat, 24 Sep 2022 00:26:16 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZL8p75N5zpTrN;
        Sat, 24 Sep 2022 15:23:22 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 15:26:14 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 15:26:14 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>
CC:     <mcgrof@kernel.org>, <chenzhongjin@huawei.com>
Subject: [PATCH -next] module: Remove unused macros module_addr_min/max
Date:   Sat, 24 Sep 2022 15:22:16 +0800
Message-ID: <20220924072216.103876-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused macros reported by [-Wunused-macros].

These macros are introduced to record the bound address of modules.

'80b8bf436990 ("module: Always have struct mod_tree_root")'
This commit has made struct mod_tree_root always exist, which means
we can always referencing mod_tree derectly rather than using this
macro.

So they are useless, remove them for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/module/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..96dcc950da60 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -84,9 +84,6 @@ struct mod_tree_root mod_data_tree __cacheline_aligned = {
 };
 #endif
 
-#define module_addr_min mod_tree.addr_min
-#define module_addr_max mod_tree.addr_max
-
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
 	const s32 *crcs;
-- 
2.17.1

