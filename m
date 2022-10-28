Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1161131E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJ1Nij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJ1Nhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:37:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB91DA370;
        Fri, 28 Oct 2022 06:37:36 -0700 (PDT)
X-QQ-mid: bizesmtp82t1666964235tlkb12mm
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:37:13 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: NCCf6GxSCjuVsq5lLPL6sMZ1PmfhaGLPyUxDp4tsj6Dlwl6Ooqy8u0b07YwUu
        HI24qdD9qIKY1otsG7sSlyMs0es1rGZL5V0cV0jdl6FfEs5/O+rbGw2jzFFM3VMSrJqaBet
        mMMhrvFjAA2i9b7NlJU9KF44TQUgs5MhZ9QOz+9pPchVOwa3ZWi1rlt3Y2exfnXPhymmboJ
        NmRe0vXuc/Wc4y09CfzSKYJJgK3gixgzHYG9TwT/Y8KLbCenAbV53O8b/yuXDCr6sSDCGG6
        WVWckb8EoPUC8ZTaERmIYn8bzvr5BujDp7rJ9OfBA22NIsAs1TcFuQez6ZzdHqN+kY2xe/0
        9jaqFzjZDu+4Fh38oqZWIybFYF362+IHSo3i69PryHqyAI1vv7sovO9CVX92Q==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     fthain@linux-m68k.org, schmitzmic@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: NCR5380: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:37:08 +0800
Message-Id: <20221028133708.60030-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/NCR5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index dece7d9eb4d3..ca85bddb582b 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -858,7 +858,7 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
  * latency, but a bus reset will reset chip logic. Checking for parity error
  * is unnecessary because that interrupt is never enabled. A Loss of BSY
  * condition will clear DMA Mode. We can tell when this occurs because the
- * the Busy Monitor interrupt is enabled together with DMA Mode.
+ * Busy Monitor interrupt is enabled together with DMA Mode.
  */
 
 static irqreturn_t __maybe_unused NCR5380_intr(int irq, void *dev_id)
-- 
2.36.1

