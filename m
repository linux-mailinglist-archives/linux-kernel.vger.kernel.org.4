Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA79623CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiKJH3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiKJH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:29:10 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC82332061;
        Wed,  9 Nov 2022 23:29:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 261A11E80D74;
        Thu, 10 Nov 2022 15:26:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uKJeQaodD6Q2; Thu, 10 Nov 2022 15:26:31 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D5AC71E80D6D;
        Thu, 10 Nov 2022 15:26:30 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] mmc: mtk-sd: fix two spelling mistakes in comment
Date:   Thu, 10 Nov 2022 15:28:19 +0800
Message-Id: <20221110072819.11530-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spelling mistake fix : "alreay" -> "already"
		       "checksume" -> "checksum"

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index df941438aef5..a10aca76dfb3 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -735,7 +735,7 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 		else
 			bd[j].bd_info &= ~BDMA_DESC_EOL;
 
-		/* checksume need to clear first */
+		/* checksum need to clear first */
 		bd[j].bd_info &= ~BDMA_DESC_CHECKSUM;
 		bd[j].bd_info |= msdc_dma_calcs((u8 *)(&bd[j]), 16) << 8;
 	}
@@ -1212,7 +1212,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 		     !host->hs400_tuning))
 			/*
 			 * should not clear fifo/interrupt as the tune data
-			 * may have alreay come when cmd19/cmd21 gets response
+			 * may have already come when cmd19/cmd21 gets response
 			 * CRC error.
 			 */
 			msdc_reset_hw(host);
-- 
2.11.0

