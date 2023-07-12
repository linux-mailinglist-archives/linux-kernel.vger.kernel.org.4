Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D624075005F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGLHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGLHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:46:45 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5619B6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:46:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnBzeAQ_1689147998;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VnBzeAQ_1689147998)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 15:46:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     chengzhihao1@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] ubifs: Fix some kernel-doc comments
Date:   Wed, 12 Jul 2023 15:46:37 +0800
Message-Id: <20230712074637.129248-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of @time and @flags in ubifs_update_time().

to silence the warnings:
fs/ubifs/file.c:1383: warning: Function parameter or member 'time' not described in 'ubifs_update_time'
fs/ubifs/file.c:1383: warning: Function parameter or member 'flags' not described in 'ubifs_update_time'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5848
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

--change in v2:
According to Zhihao's suggestion, add a more accurate description to @flags.

 fs/ubifs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 436b27d7c58f..860497532555 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1375,6 +1375,9 @@ static inline int mctime_update_needed(const struct inode *inode,
 /**
  * ubifs_update_time - update time of inode.
  * @inode: inode to update
+ * @time:  timespec structure to hold the current time value
+ * @flags: time updating control flag determines updating
+ *	    which time fields of @inode
  *
  * This function updates time of the inode.
  */
-- 
2.20.1.7.g153144c

