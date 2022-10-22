Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727CF6084B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJVFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVFrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:47:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826C2B2E19;
        Fri, 21 Oct 2022 22:47:09 -0700 (PDT)
X-QQ-mid: bizesmtp81t1666417623t4c9k6ul
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:47:01 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ8YXbgxPQK+BNlZpO6l86oZdcdpHZRs461LCUqtJbUBQFqK/a3Sw
        Sp0nEp+9a5eVSY0XsWUJxnnyM4+22iqcQ//vSMiz7MVR3Iynu1xCPeDET4hDIHfKwPiIDXM
        lpdBrrQtgi9uHfwzmpId7oCo5GkzLcIbgoteJsXNjaM3ClvGGfkUTFkPjN4zZ9DwUx6Ap3N
        bMSslkhqrnY2XBdUlhoBXYpxJbgbvenVPT8JZmWUoR+X1nC/Y0qzvoomD7084T3BdHJcXIg
        sFoPu9INUs5ZLHLBLKJBhWr7vPP28l10G9XmJgiumdS4LZNLtY17I1X3x4ygBRexfPcUOGy
        fLzzf8Vd+Q92QwpnRlgYdpCdwsCLu1DEE0wh+VfbsW2ZoHG9kA=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tsbogend@alpha.franken.de, fancer.lancer@gmail.com,
        tglx@linutronix.de, maz@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/irqchip: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:46:55 +0800
Message-Id: <20221022054655.36496-1-wangjianli@cdjrlc.com>
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
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..53daac318ccd 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -490,7 +490,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
-- 
2.36.1

