Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85461130E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJ1Nhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiJ1Ngw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00801D8F37;
        Fri, 28 Oct 2022 06:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FDE6288A;
        Fri, 28 Oct 2022 13:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA0DC4315F;
        Fri, 28 Oct 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964209;
        bh=26imd+sl0seyuSbPupXyYoSoRd+tpK1kS727ftQaczA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ja3AI9+js8nh25+LAwo9KFAkyEMR0Cl8XB5NN1K6Jmwtjh3SVEMTo5rJqT3CDQTFf
         7G27I/VoKzt0cBW3Ncht9rwxUwEn3EwuPOze2+jGKC5SnDYhf2dnC/VtW2W0qNixap
         ThJSg8YRC0X9hWYW0Dpetvg8K15QSy1kYLv/memEnmcJea/QvLqBoWPuik1nWNuVF4
         0gULgQTIy9ECITGFOxyXjTHhzpl7mrJvT648adPtwCHobAMFA3uJgPMZTKxbfnRy6V
         vEEqQthhOwHuYnjAHEpOVMFyv6MF1syRxFCpYq+8Czd5j1LzKvxhxpFEg1xZ2soZlP
         AdYQDTXxOTl9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004rD-Fe; Fri, 28 Oct 2022 15:36:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 08/16] phy: qcom-qmp-pcie: use shorter tables identifier
Date:   Fri, 28 Oct 2022 15:35:55 +0200
Message-Id: <20221028133603.18470-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a new helper function that initialises all the
registers in one place, use a shorter name for the configuration-tables
pointer so that it becomes easier to see which table is being processed.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index dd7e72424fc0..791ed7ef0eab 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1820,17 +1820,17 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
-static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
 {
 	void __iomem *serdes = qmp->serdes;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
+	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
 }
 
-static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->tx;
@@ -1838,28 +1838,28 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
 	void __iomem *tx2 = qmp->tx2;
 	void __iomem *rx2 = qmp->rx2;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
-	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
+	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
+	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
 
 	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
-		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
+		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
+		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
 	}
 }
 
-static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
 {
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *pcs_misc = qmp->pcs_misc;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
-	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
+	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
+	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
 }
 
 static int qmp_pcie_init(struct phy *phy)
-- 
2.37.3

