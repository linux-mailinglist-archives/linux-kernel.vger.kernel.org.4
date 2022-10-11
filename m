Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA025FB305
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKNPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJKNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:14:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5D12091;
        Tue, 11 Oct 2022 06:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1B5DB815BD;
        Tue, 11 Oct 2022 13:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6440AC43470;
        Tue, 11 Oct 2022 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665494087;
        bh=3ANqnrUqd9JGLqg1o0XGG2RFcR2wkphMXAousQI0Guc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/wOWr7M5vA2Y/G/CZhOvdAaM0bQzQv7kOnoKEeE3T//EizEkPdEZcWU2on9qj8a+
         iJ99RGOcaE3hFHSOxwhk8UPtIo+AyqKmRhYR8dRKEf2Vo52zzU9XUNbU5luV6o32cU
         1FOfGaHwtKMw/gVdWDhVBPfwIgB0NlCuDPGggL2+j59KipE2vbVkQyQ4S86aJtYW33
         PDPgPvAQmri+XuZfoS6cG4NEgMzyH0rIyC6cNu6NiD4PDLtASi2nC5nTfgAf/8vDsy
         ZNqyMAkPjhk0rXl0DIo+APIcyxvbbT4HdAF9T3gUn0zGYCuZ2rmnn6v8ztemvjNFlm
         z9NKChyMm6SLQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiF5i-0000ed-7k; Tue, 11 Oct 2022 15:14:38 +0200
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
Subject: [PATCH 01/13] phy: qcom-qmp: drop regulator error message
Date:   Tue, 11 Oct 2022 15:14:04 +0200
Message-Id: <20221011131416.2478-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011131416.2478-1-johan+linaro@kernel.org>
References: <20221011131416.2478-1-johan+linaro@kernel.org>
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

