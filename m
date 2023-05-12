Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0997000D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjELGrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjELGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:47:01 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D11BC5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:46:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ViO5x46_1683874015;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0ViO5x46_1683874015)
          by smtp.aliyun-inc.com;
          Fri, 12 May 2023 14:46:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ogabbay@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] habanalabs: Fix some kernel-doc comments
Date:   Fri, 12 May 2023 14:46:55 +0800
Message-Id: <20230512064655.82246-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the description of @regs_range_array and @regs_range_array_size
to @user_regs_range_array and @user_regs_range_array_size  to silence
the warnings:

drivers/accel/habanalabs/common/security.c:506: warning: Function parameter or member 'user_regs_range_array' not described in 'hl_init_pb_ranges_single_dcore'
drivers/accel/habanalabs/common/security.c:506: warning: Function parameter or member 'user_regs_range_array_size' not described in 'hl_init_pb_ranges_single_dcore'
drivers/accel/habanalabs/common/security.c:506: warning: Excess function parameter 'regs_range_array' description in 'hl_init_pb_ranges_single_dcore'
drivers/accel/habanalabs/common/security.c:506: warning: Excess function parameter 'regs_range_array_size' description in 'hl_init_pb_ranges_single_dcore'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4940
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/accel/habanalabs/common/security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/security.c b/drivers/accel/habanalabs/common/security.c
index 297e6e44fd0c..dc23ff57c91a 100644
--- a/drivers/accel/habanalabs/common/security.c
+++ b/drivers/accel/habanalabs/common/security.c
@@ -495,8 +495,8 @@ int hl_init_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
  * @instance_offset: offset between instances
  * @pb_blocks: blocks array
  * @blocks_array_size: blocks array size
- * @regs_range_array: register range array
- * @regs_range_array_size: register range array size
+ * @user_regs_range_array: register range array
+ * @user_regs_range_array_size: register range array size
  *
  */
 int hl_init_pb_ranges_single_dcore(struct hl_device *hdev, u32 dcore_offset,
-- 
2.20.1.7.g153144c

