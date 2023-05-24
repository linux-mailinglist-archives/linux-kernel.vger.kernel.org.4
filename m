Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD4670ED2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbjEXFiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjEXFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:38:00 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC852B3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:37:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjMtB1s_1684906674;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjMtB1s_1684906674)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 13:37:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] freevxfs: Fix some kernel-doc comments
Date:   Wed, 24 May 2023 13:37:53 +0800
Message-Id: <20230524053753.3573-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the description of @retp and @filler, and add the description
of @ctx, to silence the warnings:

fs/freevxfs/vxfs_lookup.c:192: warning: Function parameter or member 'ctx' not described in 'vxfs_readdir'
fs/freevxfs/vxfs_lookup.c:192: warning: Excess function parameter 'retp' description in 'vxfs_readdir'
fs/freevxfs/vxfs_lookup.c:192: warning: Excess function parameter 'filler' description in 'vxfs_readdir'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5301
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/freevxfs/vxfs_lookup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index f04ba2ed1e1a..8dfcd5f1013a 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -176,9 +176,8 @@ vxfs_lookup(struct inode *dip, struct dentry *dp, unsigned int flags)
 
 /**
  * vxfs_readdir - read a directory
- * @fp:		the directory to read
- * @retp:	return buffer
- * @filler:	filldir callback
+ * @fp:    the directory to read
+ * @ctx:   actor to feed the entries to
  *
  * Description:
  *   vxfs_readdir fills @retp with directory entries from @fp
-- 
2.20.1.7.g153144c

