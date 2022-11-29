Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECC63B6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiK2BFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiK2BFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:05:01 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7A19C21;
        Mon, 28 Nov 2022 17:04:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VVxtqnJ_1669683896;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VVxtqnJ_1669683896)
          by smtp.aliyun-inc.com;
          Tue, 29 Nov 2022 09:04:57 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: Remove unneeded semicolon
Date:   Tue, 29 Nov 2022 09:04:55 +0800
Message-Id: <20221129010455.81099-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:409:2-3: Unneeded semicolon
./drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:407:2-3: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3273
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  | 2 +-
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index aa752b80574c..5b80feaad927 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -406,7 +406,7 @@ static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
 			break;
 		usleep_range(100, 200);
-	};
+	}
 
 	if (!timeout)
 		dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 9533e4069ecd..cec4d20963a8 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -404,7 +404,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
 			break;
 
 		usleep_range(10, 20);
-	};
+	}
 
 	/* Notify that AXI bus can not stop here */
 	if (!retries)
-- 
2.20.1.7.g153144c

