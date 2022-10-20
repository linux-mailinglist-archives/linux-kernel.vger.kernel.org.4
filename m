Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0E606085
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJTMqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJTMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:46:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D813728A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:46:13 -0700 (PDT)
X-QQ-mid: bizesmtp77t1666269966t2ph7l8p
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 20 Oct 2022 20:46:05 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: CR3LFp2JE4n3wKWEGhhSOS78JpreIWjEU1iqJkTp4hiKIKS0t1lBQycjl1ZjP
        M3QqOXq/swM64D31itcmgKG/tR1qy7XFb3jf1y6c95gqTxKUYLTIWgYNVxULCWMMq3Ah2+t
        tEFr9eGbArIciEk3ed9niEdcmjD1AlPKa1AW5XwIDkB1xk9eI1cINcxgpx/EUywcM91x++3
        1N/RUG4BF+bttWX0O88BmDdktRGfWjsT/03ZEjbVGZjvg+vGYg3yxlqZTvkqt2IlQtH2LYM
        eeUGQuJvhPARfPujGlY+QEd1P/OBFpHLaadhQ1lgiQQiqmnl8ho/Bx+5TTpUNsGBAHw+R6m
        EE5GsvP58s9IkTPL7YZ8aTygBbVy4SOeYppOuXhEhwEjY54rGA=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] arm/mach-ux500: fix repeated words in comments
Date:   Thu, 20 Oct 2022 20:45:58 +0800
Message-Id: <20221020124558.38060-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/arm/mach-ux500/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index ff9c375e4277..505161bb8855 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -124,7 +124,7 @@ bool prcmu_pending_irq(void)
 }
 
 /*
- * This function checks if the specified cpu is in in WFI. It's usage
+ * This function checks if the specified cpu is in WFI. It's usage
  * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
  * function. Of course passing smp_processor_id() to this function will
  * always return false...
-- 
2.36.1

