Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6183D5BD971
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiITBjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiITBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:39:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE6BBE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:39:33 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWkdB1czMz14QhT;
        Tue, 20 Sep 2022 09:35:26 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:39:30 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <al@alarsen.net>, <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] qnx4: remove orphan qnx4_is_free() declaration
Date:   Tue, 20 Sep 2022 09:39:30 +0800
Message-ID: <20220920013930.776072-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qnx4_is_free() has been removed by
commit 945ffe54bbd5 ("qnx4: remove write support"),
so remove the orphan declaration.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/qnx4/qnx4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/qnx4/qnx4.h b/fs/qnx4/qnx4.h
index 6283705466a4..8b6b10007269 100644
--- a/fs/qnx4/qnx4.h
+++ b/fs/qnx4/qnx4.h
@@ -28,7 +28,6 @@ extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
 
 extern const struct inode_operations qnx4_dir_inode_operations;
 extern const struct file_operations qnx4_dir_operations;
-extern int qnx4_is_free(struct super_block *sb, long block);
 
 static inline struct qnx4_sb_info *qnx4_sb(struct super_block *sb)
 {
-- 
2.25.1

