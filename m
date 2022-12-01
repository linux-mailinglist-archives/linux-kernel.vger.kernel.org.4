Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBC63EC17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLAJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLAJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:14:17 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699A63D7C;
        Thu,  1 Dec 2022 01:14:13 -0800 (PST)
Received: from SHSend.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by SHSQR01.spreadtrum.com with ESMTPS id 2B19CMd3007268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 1 Dec 2022 17:12:22 +0800 (CST)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from xm13705pcu.spreadtrum.com (10.13.3.189) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 1 Dec 2022 17:12:18 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhenxiong.lai@unisoc.com>, <yuelin.tang@unisoc.com>,
        <gengcixi@gmail.com>
Subject: [PATCH] mmc: sdhci-sprd: remove prefer asynchronous probe
Date:   Thu, 1 Dec 2022 17:11:50 +0800
Message-ID: <20221201091150.3474-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.3.189]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 2B19CMd3007268
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefer asynchronous probe affects the order of device probes.

Fixes: d86472ae8b20 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index b92a408f138d..bf8df727e95e 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -801,7 +801,6 @@ static struct platform_driver sdhci_sprd_driver = {
 	.remove = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_sprd_of_match,
 		.pm = &sdhci_sprd_pm_ops,
 	},
-- 
2.17.1

