Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F5722474
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjFELUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFELUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:20:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5ACD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:20:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68GL-0003m7-1F; Mon, 05 Jun 2023 13:20:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68GK-005G7T-8j; Mon, 05 Jun 2023 13:20:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68GJ-00BNMc-Ds; Mon, 05 Jun 2023 13:20:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Li Yang <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] bus: fsl-mc: fsl-mc-allocator: Drop a write-only variable
Date:   Mon,  5 Jun 2023 13:20:25 +0200
Message-Id: <20230605112025.80061-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605112025.80061-1-u.kleine-koenig@pengutronix.de>
References: <20230605112025.80061-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IJ00ftvoF4KpMt+khd8bCZwZpgR9G0ts4hygng4azwM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkfcT4WOdhDVRk82cH1JiPa87MycoeYk+kNi8KX hO55xgDPV+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZH3E+AAKCRCPgPtYfRL+ TtacB/9pYQ7zT/pzgXzmjlgkrclwA0SUlDmxRZhyXuHopzL43YsNN0ekTUxUmjB5l8MoOhcSREA o9vD8BUzEItIiFH6txPxpdVbS2YR+fiaP/RCLPkw/r+uD6uWpKzC9CxVXlANT4j4sAS3/qlAyO4 yf+7orgi1UR5UMc8t4Gs/WbT57kDUvwcWuosck6sV+5VO9GRkAQS5njM5juh/M3ZoYk0OElC17n 6MkyVbHjAmcwTOnThYLepum7fNDPd8fHP5Ccb5AtHwmjMkDuP4OQid+uXS8yKcrn5p35b5NALZZ Y8wynVd/IAd6xk3T1BRTViqDHyNeZ/uln4p3pOHpotavHKSM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a clang compiler warning:

   drivers/bus/fsl-mc/fsl-mc-allocator.c:565:6: warning: variable 'free_count' set but not used [-Wunused-but-set-variable]
           int free_count = 0;

Fixes: d8e026a44919 ("staging: fsl-mc: remove some superfluous WARN_ONs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 991273f956ce..b5e8c021fa1f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -563,12 +563,9 @@ static void fsl_mc_cleanup_resource_pool(struct fsl_mc_device *mc_bus_dev,
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_resource_pool *res_pool =
 					&mc_bus->resource_pools[pool_type];
-	int free_count = 0;
 
-	list_for_each_entry_safe(resource, next, &res_pool->free_list, node) {
-		free_count++;
+	list_for_each_entry_safe(resource, next, &res_pool->free_list, node)
 		devm_kfree(&mc_bus_dev->dev, resource);
-	}
 }
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
-- 
2.39.2

