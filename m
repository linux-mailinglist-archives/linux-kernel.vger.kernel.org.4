Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B464F5BDDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiITGvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiITGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:51:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDF543E8;
        Mon, 19 Sep 2022 23:51:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u132so1858354pfc.6;
        Mon, 19 Sep 2022 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x5WDaYjfTujjxBwXecsmwJZGZt1UTrVVS5ttWoE+VSE=;
        b=nG2CxL5KDT3hMaYRKJAshXAevxBi6ZO0OV8FCz8G0jGzL5cCpBT5FfGHkypfFeh//P
         fC52ZFD2amD4+5xKMaXKRxhQWQLR+FzrmqCZFScPz70tuNw/vV7SDIlXkPTN1kvO/2nJ
         /C8nHr+L/QD3Cc79dKhmShbQAkTIgjqMyRR6Ys+Zx+Ls2jOoG5K81p5HBzk30+qaYTWz
         d28vM3iW3BHETx73URWrKdqBTDf3menl3LivZN/9sysd48adC3qb9g4H/BTj7JmovEWL
         XLjyg0AJBEZui2WUpzPrH2/RsfQ6cMxOHGwt2pgmMyuvZXqklEDhlL6WFOhfzI+ymmzo
         l35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x5WDaYjfTujjxBwXecsmwJZGZt1UTrVVS5ttWoE+VSE=;
        b=lYk8eAz6GlYTc5zF1geNHXOirk8C6SqaQLgiOzNatV3Yqm367eLjMFn8VTG0CqYdAO
         hBjflpcboqNT7kZP4jqDTziOgje+NFMBGmdfYmG3fZ58vSVcM4G8xYZtNo9AJHLIEg8H
         ZrEwlHzRn9boeo+H9KQHq4ym5C3Nlcr/zxGPFr6BkLWbK8rfr5O10ZF2AyvO6KnR9Zxp
         gbtA6dv5RJA1dfa+Ug/9wZtzVJRU/tOZvOT57YwdWTyrm6zntbHYoOyefkdaGHpXQAVd
         JhrTAg9F7i4B+XuyiEYhBuVIwRRCvJZTQee8IEGzcA/HesGRdaFMj5DPX3T0GPKIDdDR
         wJVQ==
X-Gm-Message-State: ACrzQf2Wa+xdu95vecf7Kn93IHeRJJpSBloEDpK/yZbvuJspcca7pPQ2
        yIxxgLjfoBl6RxxosYhsL44=
X-Google-Smtp-Source: AMsMyM5LstHcdpNuKoJGXe53gx97VB4xcvezTGSCTUxAf8/y7H39SbFjy19YT271OAlJPlOi+2ulEA==
X-Received: by 2002:a63:193:0:b0:43a:346c:166f with SMTP id 141-20020a630193000000b0043a346c166fmr5156529pgb.284.1663656678985;
        Mon, 19 Sep 2022 23:51:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s21-20020a63d055000000b0041a6638b357sm658983pgi.72.2022.09.19.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:51:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     tony@atomide.com
Cc:     khilman@kernel.org, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ARM: OMAP2+: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:51:13 +0000
Message-Id: <20220920065113.215685-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value amx3_common_init() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/arm/mach-omap2/pm33xx-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index bf0d25fd2cea..4b29d8323ffc 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -105,8 +105,6 @@ static int amx3_common_init(int (*idle)(u32 wfi_flags))
 
 static int am33xx_suspend_init(int (*idle)(u32 wfi_flags))
 {
-	int ret;
-
 	gfx_l4ls_clkdm = clkdm_lookup("gfx_l4ls_gfx_clkdm");
 
 	if (!gfx_l4ls_clkdm) {
@@ -114,9 +112,7 @@ static int am33xx_suspend_init(int (*idle)(u32 wfi_flags))
 		return -ENODEV;
 	}
 
-	ret = amx3_common_init(idle);
-
-	return ret;
+	return amx3_common_init(idle);
 }
 
 static int am43xx_suspend_init(int (*idle)(u32 wfi_flags))
-- 
2.25.1
