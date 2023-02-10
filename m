Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300B4691B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBJJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjBJJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:34:08 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB059E6C;
        Fri, 10 Feb 2023 01:34:05 -0800 (PST)
X-QQ-mid: bizesmtp87t1676021563tehi0iwo
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Feb 2023 17:32:26 +0800 (CST)
X-QQ-SSF: 01200000000000C0D000000A0000000
X-QQ-FEAT: C46Rb8GPIEdQkAjuNEvzzL3Rs0nKkvh/PcSoaaqidTxeCkENSHSVqCDnM9GB/
        XAuUnNnX4kQV3OC0mUVFEpblsXhHzLEmK3en5iTOceN0yf7sbHWJ6w6xugHFjWIDMc7R2r3
        AjCdrD12AYijXVStARs9gE2mfuIrn4RfXlDpWudrH8dSp1b9a+oMcBTtOpH6RVO+KDD2h3H
        wwkU1T4J27HPy1R5+re0qwyEyVByxzDNwPSU0tgyvWU4QseHWHezWCnhK3QJVtxL2cboTeA
        B6XobgH1FIh1gVU2SK6auor/aNNvOwIj5E6CG7wmGDDtg4Tf98pJCjpfe9A0HGq3jOox+lv
        ZmgAJi1bfAW++rLB5zXV0IAZ9gSBV33mVMwextL5L4cCXHXmSM=
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Elliott <elliott@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Date:   Fri, 10 Feb 2023 17:32:24 +0800
Message-Id: <20230210093224.689990-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_MTD_M25P80 that was removed in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

 arch/arm/configs/axm55xx_defconfig     | 2 +-
 arch/arm/configs/davinci_all_defconfig | 1 -
 arch/arm/configs/dove_defconfig        | 1 -
 arch/arm/configs/keystone_defconfig    | 1 -
 arch/arm/configs/mvebu_v5_defconfig    | 1 -
 arch/arm/configs/mxs_defconfig         | 1 -
 arch/arm/configs/pxa_defconfig         | 1 -
 arch/arm/configs/qcom_defconfig        | 1 -
 arch/arm/configs/socfpga_defconfig     | 1 -
 9 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index bfbaa2df3be5..936aecbdc129 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -85,7 +85,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 821d966c95a5..cb7a03bce291 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -63,7 +63,6 @@ CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
 CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
 CONFIG_MTD_SPI_NOR=m
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index ff37f46c82fb..3f90b4b241a9 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -43,7 +43,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 4a5b9adbf2a1..36692143dd3d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -118,7 +118,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 2467afd32146..26c5724c409d 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -63,7 +63,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index feb38a94c1a7..0eeef6402952 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -45,7 +45,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 0a0f12df40b5..851a817b52c0 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -130,7 +130,6 @@ CONFIG_MTD_ROM=m
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
 CONFIG_MTD_ONENAND=m
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index b41716c1ec64..fd5581edc310 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -63,7 +63,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 70739e09d0f4..9591af0441dd 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -41,7 +41,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
-- 
2.25.1

