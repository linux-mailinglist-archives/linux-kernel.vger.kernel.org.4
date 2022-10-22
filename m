Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC86608511
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJVG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJVG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:26:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9753D0D;
        Fri, 21 Oct 2022 23:25:57 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666419912t74p8onm
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:25:11 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: mhDoKBI5A3AQlZDgB68EtJtI5NGdpLJIjOkqQLnGDk55RI7W4oHe+gcAFl935
        5PrlmlKpBlYbgb2tY4BLr4Gt9gBsdXkvcij6uGgcQbJk3MOkEh9Dw4NfK1r2Btxngz+skDk
        bqA8TWdSly+HQd9x8gwF7L+qzyJwlFzze0vwx6AvhDScnlufbQVozClcO8cc8iuJ3HiRFoS
        FTA3XLAg7eySuRa9a5L/6DSwPoj1rCl8ISbPHfzCOaEnAufFT8XqK977UJzCpqGG1kUP9Yj
        4LmPFz1Y7iyFFRHoEDb+CDciTQ5ur0L+dS+l3a+HpbDhioPHfHyU1qOKQaPEfMsjRR07YJA
        Hpco87AuKOamGmHdx62zOs62bT2Gi5XyZRjhFIHFmz5A2Sr8AnBoNAgGFunBw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     adrian.hunter@intel.com, haibo.chen@nxp.com,
        ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:25:05 +0800
Message-Id: <20221022062505.13155-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..004f84764fb7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1453,7 +1453,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 
 		/*
 		 * On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
-		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
+		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let
 		 * the 1st linux configure power/clock for the 2nd Linux.
 		 *
 		 * When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
-- 
2.36.1

