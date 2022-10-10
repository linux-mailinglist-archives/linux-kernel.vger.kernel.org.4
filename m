Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F85F9736
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJJDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJJDlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:41:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487827CD4;
        Sun,  9 Oct 2022 20:41:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29A3fbBQ017544;
        Sun, 9 Oct 2022 22:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665373297;
        bh=cs0TPifxs4xJXLOJNSL1O0T4pkZwMuaDp3ydO8jVaDI=;
        h=From:To:CC:Subject:Date;
        b=uNCOHG5qh5X6M+VQckOgihuARHdzhiUQ4wwlJhpqRIy1m7yV/uQJkYd49H5mzM/Qo
         YzfH70y5cf0/+pvmC/d7Kk4F3UEKoAsRrV7sPz67+ACKpgMmzci5oWCxm6XWdDcI6n
         v74h3LQrRm9qIMlNCxb5vqDfm3KMt7RMP/KfIYTU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29A3fbMm094178
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Oct 2022 22:41:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 9 Oct
 2022 22:41:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 9 Oct 2022 22:41:37 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29A3fYfc009427;
        Sun, 9 Oct 2022 22:41:35 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>
CC:     <j-keerthy@ti.com>, <bb@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal: k3_j72xx_bandgap: Fix the debug print message
Date:   Mon, 10 Oct 2022 09:11:26 +0530
Message-ID: <20221010034126.3550-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug print message to check the workaround applicability is inverted.
Fix the same.

Fixes: ffcb2fc86eb7 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
Reported-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 16b6bcf1bf4f..c073b1023bbe 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -439,7 +439,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		workaround_needed = false;
 
 	dev_dbg(bgp->dev, "Work around %sneeded\n",
-		workaround_needed ? "not " : "");
+		workaround_needed ? "" : "not ");
 
 	if (!workaround_needed)
 		init_table(5, ref_table, golden_factors);
-- 
2.17.1

