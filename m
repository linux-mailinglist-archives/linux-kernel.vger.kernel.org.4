Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CDE5EF027
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiI2IRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiI2IRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:17:10 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 01:17:07 PDT
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1766E1323C0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:17:06 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCXX+u1UjVjEGSsDg--.38603S2;
        Thu, 29 Sep 2022 16:09:25 +0800 (CST)
Received: from centos7.localdomain (unknown [117.121.60.17])
        by mail (Coremail) with SMTP id AQAAfwA3qxYQUzVjME8AAA--.348S3;
        Thu, 29 Sep 2022 16:10:56 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] irqchip/gicv3: fix typos in comments
Date:   Wed, 28 Sep 2022 10:39:27 +0800
Message-Id: <1664332767-6909-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwA3qxYQUzVjME8AAA--.348S3
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xr1DtFy5Xw13Ar17Ar1rXrb_yoWxuwb_u3
        yUuFZrWF1Syr13Kw13Cr4avr95tw4kWa1kZFWSyF9Yq3y0q347uFWaqrn8JF4rGF48JFyx
        urZ0yrySyrWfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in comments.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 262658f..34d5856 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -978,7 +978,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 	u32 ctlr = readl_relaxed(ptr + GICR_CTLR);
 
-	/* Boot-time cleanip */
+	/* Boot-time cleanup */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
 		u64 val;
 
-- 
1.8.3.1

