Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208B750A63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGLOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjGLOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D31BFE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=LjKyZDNCeruQmd
        q7kZ8trdaaJZuig1WH4icoHMee+yM=; b=K3CWOyMwCyhHBt62QCOmES0SlKPlof
        ytfXoz8AjiyQnOzHUmjE9/9VZucXNHWfIATPztVMg4XYHR3VS7giTpr/1UkUXKsN
        Lxt0Sj1vdWam9lpMe5jhvwLDFUT4srVVVY9hccJebO1neyEW+wUTB6dY9/9n9NzT
        IfX8aYbfzo0kWEqNxp6bc3WizOguCh0KsLYEKTRIJEhNRVK8maco60r5OneMIHJM
        WmDpVzyYLU+3WmE+wGOE4MexYrS8gCUxNw7RARrJgLqFMUamM+fnkgFcwAQIFEOg
        dNu/1MQ3ZbFxHOnWUcfXgQSQN740aUKWng9pabMc2SZHqMx6b/8CSdWg==
Received: (qmail 1636517 invoked from network); 12 Jul 2023 16:01:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 16:01:17 +0200
X-UD-Smtp-Session: l3s3148p1@L7dBpkoACuAujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: renesas_sdhi: remove outdated indentation
Date:   Wed, 12 Jul 2023 16:01:15 +0200
Message-Id: <20230712140116.18718-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using tabs to make a structure initialization more readable is not
considered helpful. Remove the final appearance from this driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

My eyes always stumble over this...

 drivers/mmc/host/renesas_sdhi_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2d5ef9c37d76..10dbdb4abc93 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -983,12 +983,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	}
 
-	host->write16_hook	= renesas_sdhi_write16_hook;
-	host->clk_enable	= renesas_sdhi_clk_enable;
-	host->clk_disable	= renesas_sdhi_clk_disable;
-	host->set_clock		= renesas_sdhi_set_clock;
-	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
-	host->dma_ops		= dma_ops;
+	host->write16_hook = renesas_sdhi_write16_hook;
+	host->clk_enable = renesas_sdhi_clk_enable;
+	host->clk_disable = renesas_sdhi_clk_disable;
+	host->set_clock = renesas_sdhi_set_clock;
+	host->multi_io_quirk = renesas_sdhi_multi_io_quirk;
+	host->dma_ops = dma_ops;
 
 	if (sdhi_has_quirk(priv, hs400_disabled))
 		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-- 
2.30.2

