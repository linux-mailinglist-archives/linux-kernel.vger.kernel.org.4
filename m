Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39B625721
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiKKJnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiKKJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79B77E65;
        Fri, 11 Nov 2022 01:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20940CE2651;
        Fri, 11 Nov 2022 09:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5888DC433B5;
        Fri, 11 Nov 2022 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159796;
        bh=8YG8lt72rO1Cs+V80J6Go1x/JXY6d0vosuLh08p4JvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5jHfJUzbt3T6B3evWEbe7XBmR3i3yHG507NsBMsKamKI4dQu51FmTFke4ymx831l
         eqzxRpr6QOMOH0RN8Cy8A87r2ejEwC5IyF/CtZTUXhMj9SXm6bvaPW+Y7QoTUKd0zN
         TV7ACvzoaBfbbvD4ioCrB26gtGFGKHnmOgkOt91usj/Yvz53aKzOb4gYxi4Y90rEOu
         59j9CJ5qsJPb3ZDgJ7yj4AE8RCDsYWTnBMe0KOaS7w0KLqTkKpqYjga+6yMhN6Hui1
         O3N1HDKdplQnhKHVbwt5vczUdLOc0hsxRkZPGbDATJ6PxDH+uNvEi4E6lwCng3NZIx
         GoXaR7YUF9rcw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQYi-00030b-Ep; Fri, 11 Nov 2022 10:42:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] phy: qcom-qmp: drop unused type header
Date:   Fri, 11 Nov 2022 10:42:37 +0100
Message-Id: <20221111094239.11547-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111094239.11547-1-johan+linaro@kernel.org>
References: <20221111094239.11547-1-johan+linaro@kernel.org>
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

The PHY type defines are no longer used in the PCIe, UFS and USB QMP
drivers so drop the corresponding include.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 --
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 --
 4 files changed, 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index ff198d846fd2..a088477e274f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -20,8 +20,6 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/phy/phy.h>
-
 #include "phy-qcom-qmp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 111716e25b17..328708a09c37 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -23,8 +23,6 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/phy/phy.h>
-
 #include "phy-qcom-qmp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 189103d1bd18..318eea35b972 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -20,8 +20,6 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/phy/phy.h>
-
 #include "phy-qcom-qmp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 9b1f8c9d0eb8..8b111b7087b9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -20,8 +20,6 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/phy/phy.h>
-
 #include "phy-qcom-qmp.h"
 
 /* QPHY_SW_RESET bit */
-- 
2.37.4

