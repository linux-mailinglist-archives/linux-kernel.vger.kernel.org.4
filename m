Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9F5FC1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJLIQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJLIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947316A4A9;
        Wed, 12 Oct 2022 01:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E80E61476;
        Wed, 12 Oct 2022 08:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A324C4347C;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=qqFp8pkcuDFPDWzKz8wdA3yND9yZMIZ+qVeRKRDBlv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhBw2fHjSK88bKwYYllfsycap5QPqPs4i/7FxqaXNiQF+l1W48DncKN4kewB48+Gp
         B6g6qwUJkArQ8Ot56nNwzXoYAUZlRcs0zAMFysBMcdWIGAbaR8Fgk8WE4dwN1RQN5S
         GqusJsf/WhyVe8pWh3xlntvD9qmR8e0zohwff2RduFzzf+u12B2UUxSdBitjUzWTx+
         58u66g93bBCQsXDwdy29/YwysGQXEwhN/8YtAkR7lelVlb0if6jO+hv+wMFmGkW0Lm
         0q6LUgNE1kEkvU8djIZ2xitJE4nSHBJ6OzEP1cACY4xY0G9EMmVuCEFv/9SnmAPV+B
         wTmMGswTAkAMg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu2-0004oM-8E; Wed, 12 Oct 2022 10:15:46 +0200
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
Subject: [PATCH v2 01/14] phy: qcom-qmp: drop regulator error message
Date:   Wed, 12 Oct 2022 10:12:28 +0200
Message-Id: <20221012081241.18273-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012081241.18273-1-johan+linaro@kernel.org>
References: <20221012081241.18273-1-johan+linaro@kernel.org>
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

Regulator core already logs an error message in case requesting a
regulator fails so drop the mostly redundant error message from probe.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 3 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 3 +--
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 3 +--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b434e2ee640..998c8f80ccd8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2816,8 +2816,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 
 	ret = qmp_combo_vreg_init(dev, cfg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to get regulator supplies\n");
+		return ret;
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 5fdd85a1dc3e..45c0e2958bf6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -869,8 +869,7 @@ static int qmp_pcie_msm8996_probe(struct platform_device *pdev)
 
 	ret = qmp_pcie_msm8996_vreg_init(dev, cfg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to get regulator supplies\n");
+		return ret;
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 30838ae8f027..dc7f8ba413b9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2445,8 +2445,7 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 	ret = qmp_pcie_vreg_init(dev, cfg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to get regulator supplies\n");
+		return ret;
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index e28c45ab74ea..566365fbfe1a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1210,8 +1210,7 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 
 	ret = qmp_ufs_vreg_init(dev, cfg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to get regulator supplies\n");
+		return ret;
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0b13fb6cb59..a0b97fd5d0a5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2746,8 +2746,7 @@ static int qmp_usb_probe(struct platform_device *pdev)
 
 	ret = qmp_usb_vreg_init(dev, cfg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to get regulator supplies\n");
+		return ret;
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
-- 
2.35.1

