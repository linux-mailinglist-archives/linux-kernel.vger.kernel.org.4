Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD385BDD94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiITGq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiITGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:46:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5853D3B;
        Mon, 19 Sep 2022 23:46:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 9so1814816pfz.12;
        Mon, 19 Sep 2022 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vkTFnfbmIR3qwyo/CUT31Fe4BhBU2kMVaByFkU7+mmo=;
        b=Xpyb/ZLXc5x/of0UagrB8IiP1JVm37WZ/NYb4yLemjk2zKq4uRxPv0IHxE1RYxJXJE
         +j1D6K+XKnf7ua+ux06ZzsJlsZEsdc8g9F5Sa8lNL6M2nAMQ6udh3P3/PBk9H7N3jLwb
         zAKlEz9pD2jIfM8nVifW6oov+38+hIEKHrcP4XpETGe44E887hFoB9EbAGr//6HQb/lm
         ZUctankBwUxFvUikhxMNJi7XRwqWtOfiC1BZ3EuLT/XZwlo4HU5yfh+6FxRDKs5ycDOG
         Qttn7ETgosa5Cq3hkL+PRjE+SQ1am8kN4CdZ7TVrg0z7FKEwreNXQ42r+cBkzFUHXFGZ
         9lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vkTFnfbmIR3qwyo/CUT31Fe4BhBU2kMVaByFkU7+mmo=;
        b=m6Lo+PLdYcuIKrogQBYKuoulAgjM2MhM5Y+K4Y2yVz9osCERlTTq5vEBEWSwRNi78W
         2qhfnSbGNOoDngYiAlS4zeoD+t3nphV7t+AQpatXk5kOU8h0ZZCWHlINBtTRu8gAz/Zo
         06QsB0hqnXF9E2KJoV5IawCPkbVV4S82RUNCX2IneIg0VjFivCNvQ/n+DADBO1TeoK1K
         aXagB8aBK1gsvIebfHNzJEL34p6knuQxy1uSxdkKtpVivlxVvuAoNDp+gsMDrgarl8U+
         3zPgvj7R1e/67iNRtcSsjexGatLujYZ+TkwZNyJhhDImxeibs2UK5afdkaWuXV3PO0jP
         8S+A==
X-Gm-Message-State: ACrzQf2Xz1tn+nm6vcaWvaBpaSX+kr6HHIrDzbDGKcbn1e71UCiTW8Vv
        hjCxrq5yruW3PuLAhctxlUyeYHraomU=
X-Google-Smtp-Source: AMsMyM7tpo4/lpe8xbYYLCxTjK6FI4HdBFZsdF60Z4Xv5/Vv1yyQxc6Dt8+lkFx1ALem2zZVSTQ5fw==
X-Received: by 2002:a63:5d18:0:b0:439:61d0:7487 with SMTP id r24-20020a635d18000000b0043961d07487mr18828899pgb.268.1663656412876;
        Mon, 19 Sep 2022 23:46:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id cv20-20020a17090afd1400b001fb1de10a4dsm610572pjb.33.2022.09.19.23.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:46:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mmc: rtsx_usb_sdmmc: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:46:48 +0000
Message-Id: <20220920064648.215375-1-ye.xingchen@zte.com.cn>
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

Return the value rtsx_usb_send_cmd() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 5fe4528e296e..5798aee06653 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1042,7 +1042,6 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
 		unsigned char timing, bool *ddr_mode)
 {
 	struct rtsx_ucr *ucr = host->ucr;
-	int err;
 
 	*ddr_mode = false;
 
@@ -1097,9 +1096,7 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
 		break;
 	}
 
-	err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
-
-	return err;
+	return rtsx_usb_send_cmd(ucr, MODE_C, 100);
 }
 
 static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.25.1
