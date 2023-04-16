Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B406E3B79
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDPTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:14:29 -0400
Received: from st43p00im-zteg10072001.me.com (st43p00im-zteg10072001.me.com [17.58.63.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C82E52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681671939; bh=gXqSiYO6SOxAXqgCT4Fu+9jvh6ULl25oou/uXwN3afI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Uc1ayGrNeFVVX/BRxu1sk9JeALQCbYs0PvNRu+rbzr7t8hSqBtfEuG5WbI7+aSWSh
         KoFUa8AZPlsJg+2xV6FiZZohnq32MS9uCZpoZLszGJMl3KacF5/2KOsmFTXS//OAEj
         AiA9zuYlPD99rliNOOQKnT3+sN3MbAYuTtvM/AEEvbhk+XUfjQ7qJCSjeOYKrcteGr
         lVgvNviYZTMxRR1A6BtI2FnsqONi2GasFV1F+XlUcE357ZodOlDpp7Jrzai+F/B7ye
         ZLEwA/S9Zp9r1Q6Qzbl3sndFeMS3YGHfsyBNcJhDPdiIaMMYzAn3MttsU+XLvLpyVE
         RTh2u7HZVcCeg==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id DE573B410A5;
        Sun, 16 Apr 2023 19:05:37 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     patrice.chotard@foss.st.com, Alain Volmat <avolmat@me.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/st: remove stih415/stih416 and stid127 platforms support
Date:   Sun, 16 Apr 2023 21:05:01 +0200
Message-Id: <20230416190501.18737-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WFf52kYDmZ8xvINeI_WXuvXB7zFqapoI
X-Proofpoint-ORIG-GUID: WFf52kYDmZ8xvINeI_WXuvXB7zFqapoI
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for the already no more supported stih415 and stih416
platforms.  Remove as well the stid127 platform which never made it
up to the kernel.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
Patch previously sent via serie: https://lore.kernel.org/all/20230209091659.1409-4-avolmat@me.com/

 drivers/irqchip/irq-st.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 1b83512b29c6..819a12297b58 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -15,10 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define STIH415_SYSCFG_642		0x0a8
-#define STIH416_SYSCFG_7543		0x87c
 #define STIH407_SYSCFG_5102		0x198
-#define STID127_SYSCFG_734		0x088
 
 #define ST_A9_IRQ_MASK			0x001FFFFF
 #define ST_A9_IRQ_MAX_CHANS		2
@@ -44,22 +41,10 @@ struct st_irq_syscfg {
 };
 
 static const struct of_device_id st_irq_syscfg_match[] = {
-	{
-		.compatible = "st,stih415-irq-syscfg",
-		.data = (void *)STIH415_SYSCFG_642,
-	},
-	{
-		.compatible = "st,stih416-irq-syscfg",
-		.data = (void *)STIH416_SYSCFG_7543,
-	},
 	{
 		.compatible = "st,stih407-irq-syscfg",
 		.data = (void *)STIH407_SYSCFG_5102,
 	},
-	{
-		.compatible = "st,stid127-irq-syscfg",
-		.data = (void *)STID127_SYSCFG_734,
-	},
 	{}
 };
 
-- 
2.34.1

