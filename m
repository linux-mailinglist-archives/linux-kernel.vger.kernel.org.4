Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C571FB09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjFBHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFBHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:33:11 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314131A6;
        Fri,  2 Jun 2023 00:33:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowABnSB0um3lk55d4CQ--.40453S2;
        Fri, 02 Jun 2023 15:33:03 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andy.shevchenko@gmail.com
Cc:     albeu@free.fr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] gpio: ath79: Add missing check for platform_get_irq
Date:   Fri,  2 Jun 2023 15:33:00 +0800
Message-Id: <20230602073300.7536-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnSB0um3lk55d4CQ--.40453S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr17Ar4kZr1xXw1xGw47XFb_yoW3Zrg_Cw
        n7Xw47Gr48CrnIvw12yw1ayFWSyr9rur4kZr4vga1aqr98Z3yDu34Duw4rXr1UWr10yFyD
        Ga4qkrWYyFs3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUGhFxUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing check for platform_get_irq and return error code
if it fails.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Return "girq->parents[0]" instead of "-ENODEV".
---
 drivers/gpio/gpio-ath79.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index aa0a954b8392..31ce2d5c6ba0 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -286,6 +286,8 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 		if (!girq->parents)
 			return -ENOMEM;
 		girq->parents[0] = platform_get_irq(pdev, 0);
+		if (girq->parents[0] < 0)
+			return girq->parents[0];
 		girq->default_type = IRQ_TYPE_NONE;
 		girq->handler = handle_simple_irq;
 	}
-- 
2.25.1

