Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7F670ECED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbjEXFMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbjEXFL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:11:56 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1774189;
        Tue, 23 May 2023 22:11:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjMkCwD_1684905109;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjMkCwD_1684905109)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 13:11:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] scsi: target: Simplify bool conversion
Date:   Wed, 24 May 2023 13:11:48 +0800
Message-Id: <20230524051148.96937-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/target/target_core_iblock.c:892:30-35: WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5300
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/target/target_core_iblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index e6029ea87e2f..7a27de807902 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -889,7 +889,7 @@ static sense_reason_t iblock_execute_pr_out(struct se_cmd *cmd, u8 sa, u64 key,
 
 		ret = ops->pr_preempt(bdev, key, sa_key,
 				      scsi_pr_type_to_block(type),
-				      sa == PRO_PREEMPT ? false : true);
+				      sa != PRO_PREEMPT);
 		break;
 	case PRO_RELEASE:
 		if (!ops->pr_clear) {
-- 
2.20.1.7.g153144c

