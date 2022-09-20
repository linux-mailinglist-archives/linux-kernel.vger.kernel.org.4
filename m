Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC535BDE87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiITHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiITHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB461107;
        Tue, 20 Sep 2022 00:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDFAFB8257A;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2839C4FF07;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=eguzelNkWbY6y8/Ed+NE/WQQJvZhJ3BmpfHcj567dng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJ20mgbpoeS0rn4vbauimQ7nJ08aGNvp8BWyWzPC9yNEBwgqZ+yxZ7j631nMcAiKg
         +YSTzdDzdFeJJFe9R9Yvy4WmhB2AkXCTYGnV2H1rMgRqF2zTmEaIhvXBPjp8F/A826
         ukbDquJD+pawlGFuB0o7baz48X/n2iSGu0XDxn9vRT05wWPnaobvs+jC7Mn+Y2rCB2
         vxLw6G3v1Rq9YMdZRF3fcr58jQuB/9Coa09KrFZ8GPJkaOs2WnF7NVdp7hE+jtsmHU
         iBhMoX2pZDtYZJuK72vkRMaFW8UbFGe5yLqyMTY/7bcYe7obZr2zAj5JvhX0QRPdWz
         ltsc+W+bsCQUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005RC-DW; Tue, 20 Sep 2022 09:39:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 13/17] phy: qcom-qmp-pcie-msm8996: rename nlanes config
Date:   Tue, 20 Sep 2022 09:38:22 +0200
Message-Id: <20220920073826.20811-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nlanes configuration parameter is really the number of PHYs provided
by this QMP block on MSM8996. Rename it accordingly.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index e261837aee32..0f8e739936ab 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -186,8 +186,8 @@ static const struct qmp_phy_init_tbl msm8996_pcie_pcs_tbl[] = {
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* number of lanes provided by phy */
-	int nlanes;
+	/* number of PHYs provided by this block */
+	int num_phys;
 
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
@@ -318,7 +318,7 @@ static const char * const qmp_phy_vreg_l[] = {
 };
 
 static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
-	.nlanes			= 3,
+	.num_phys		= 3,
 
 	.serdes_tbl		= msm8996_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8996_pcie_serdes_tbl),
@@ -861,7 +861,7 @@ static int qmp_pcie_msm8996_probe(struct platform_device *pdev)
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
 
-	expected_phys = cfg->nlanes;
+	expected_phys = cfg->num_phys;
 
 	mutex_init(&qmp->phy_mutex);
 
-- 
2.35.1

