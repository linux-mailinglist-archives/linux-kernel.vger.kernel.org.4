Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E346872AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBBBBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBBBBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:01:17 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E35CE7A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:01:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaiLIr6_1675299672;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VaiLIr6_1675299672)
          by smtp.aliyun-inc.com;
          Thu, 02 Feb 2023 09:01:13 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] f2fs: Remove unneeded semicolon
Date:   Thu,  2 Feb 2023 09:01:11 +0800
Message-Id: <20230202010111.69078-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./fs/f2fs/checkpoint.c:1485:55-56: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3925
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b1b39c17f2d8..b7ef8cd10b10 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1482,7 +1482,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i + CURSEG_HOT_DATA);
 
-		ckpt->cur_data_segno[i] = cpu_to_le32(curseg->segno);;
+		ckpt->cur_data_segno[i] = cpu_to_le32(curseg->segno);
 		ckpt->cur_data_blkoff[i] = cpu_to_le16(curseg->next_blkoff);
 		ckpt->alloc_type[i + CURSEG_HOT_DATA] = curseg->alloc_type;
 	}
-- 
2.20.1.7.g153144c

