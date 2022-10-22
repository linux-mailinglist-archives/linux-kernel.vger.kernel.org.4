Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED31608506
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJVGW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJVGWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:22:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335D242CAF;
        Fri, 21 Oct 2022 23:22:50 -0700 (PDT)
X-QQ-mid: bizesmtp79t1666419765t0w816vz
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:22:44 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: acNVAc66Bsw5l5oW+aZveYyqqh8IIWEBaYX8s2ZMUPD+BYkoC/xJfywW+/33l
        c2Y0ov+AliUjwL4kU7y3EniKVRR6ZlHyFe4M/dnE4ahKY+22yfI0Z5ObHH6962h5A4/a698
        ADfmj+iDPVQykuneMxeVNFoCd3YRpFCqMU4I8QnD7Uq8iP5/cU/p/RqwZlgZ2TCrgh/xvOX
        FGT6c6BARQgJzjivo1cyQb5wro1+/zNtbxaifOy2YK4TMEoWrRpb/ShmxYlb+6mr3BshcOK
        vdh8yzv+JGIQFQcCZH/iVlsb7DKJJmZwImA84IAPQ4S0hddBFUFC9LyO2ETc6ImofysOfp4
        sni9GstTvEO9C/LC1JLJHvEs3X5QhehOfDgtwudD0cthNmey8Y=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:22:37 +0800
Message-Id: <20221022062237.10333-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 581614196a84..7f00d7d7e35e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		 * is just about to roll over.
 		 *
 		 * We do this whole thing under spinlock and only if the
-		 * command hasn't already completed (indicating the the irq
+		 * command hasn't already completed (indicating the irq
 		 * already ran so we don't want the timeout).
 		 */
 		spin_lock_irqsave(&host->irq_lock, irqflags);
-- 
2.36.1

