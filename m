Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9F5BBD5B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIRKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiIRKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:03:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BFF9FC0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:03:33 -0700 (PDT)
X-QQ-mid: bizesmtp90t1663495399tfsln7an
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Sep 2022 18:03:18 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: fs34Pe/+C2TRiMqqhKF4AXIaqHle7Mw/nPizJAgtz86EMeJ+GV+Q7ksrPY16M
        c2R9hNFiy/Sr/kU6zCtQAxxmCYa+Grg2mngUjAnmFbCDCGn80GBK02ccB1ASBN5YZiP2dQr
        MnVErtJJQZ54wMM0wI8/PxwpfcljlJ+LT75wHZtcB/9MGBGw5xu6edaz+DnxuqP5C+et3Zn
        jmunWGBmjhsyAy7hC/wwkpLwb7mBVw0sWNHdTQvJRe1rXHxQCLwtIC7zBBcME4RQnhxhxax
        ctGnc/Bi5hgy7cqm0Sm8wZCSjxTt7bOxd+kZAWkWnCfw4mi+nS7kLP+F9QlkMHTKXaWgEtD
        QUVuqLdshFVZGEksCRfvFPXNhRU/rqZDswZn27MdnZip6l2pcT1qWd+BcbhRw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] cxl: fix repeated words in comments
Date:   Sun, 18 Sep 2022 18:03:12 +0800
Message-Id: <20220918100312.26836-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'dont'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/misc/cxl/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 50b0c44bb8d7..6957946a6463 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -920,7 +920,7 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
 	 * Ideally we should do a wmb() here to make sure the changes to the
 	 * PE are visible to the card before we call afu_enable.
 	 * On ppc64 though all mmios are preceded by a 'sync' instruction hence
-	 * we dont dont need one here.
+	 * we dont need one here.
 	 */
 
 	result = cxl_ops->afu_reset(afu);
-- 
2.36.1

