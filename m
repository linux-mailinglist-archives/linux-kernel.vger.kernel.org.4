Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACD650DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiLSOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiLSOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD963E2;
        Mon, 19 Dec 2022 06:43:19 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJAR3au006554;
        Mon, 19 Dec 2022 06:43:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=qjeFqVRGcaJW9VdU/Qd2asrXhJGT47ehK3A/cij8eaE=;
 b=HXR1fJYHuv0Kn+vBkMoTItlBJLY9yXd6cohxiEA5eMQ07EQp9HzfgaOM/Yrz1/kUDzh/
 u3Jpov47oPO/D++puR7gHG662uejUGe8785xJf5dYw7fVQm0ODo2KnhppCHTQX4Q/TX9
 dECrGyr0dyiMcqjpj5e9WUE5Ebjd3X7SuASOFKLg7YdVmItM8YvYVcJ7X6CJgkrrDmWR
 sjYAMZ04vDjGS3c++P3v/zilHrX3+wwcowmu5CN1nu1g0eZNt4qa4sBMa1fRzRLc+qzv
 ACbtbWp+3JCOKy9UFK8nnFjglr5gKDa9Z9muJ/+qYTOrSKcawTve88+ISegrzqgVZf/F hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:13 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:11 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id A73973F7079;
        Mon, 19 Dec 2022 06:43:11 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 6/7] spi: cadence: Add Marvell IP modification changes
Date:   Mon, 19 Dec 2022 06:42:53 -0800
Message-ID: <20221219144254.20883-7-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _BllMQlznrPELbW7lqPEphys7WnTNcKt
X-Proofpoint-ORIG-GUID: _BllMQlznrPELbW7lqPEphys7WnTNcKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Marvell IP modification - clock divider,
and PHY config, and IRQ clearing.
Clock divider block is build into Cadence XSPI controller
and is connected directly to 800MHz clock.
As PHY config is not set directly in IP block, driver can
load custom PHY configuration values.
To correctly clear interrupt in Marvell implementation
MSI-X must be cleared too.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
Tested-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/spi/Kconfig            |  12 +++
 drivers/spi/spi-cadence-xspi.c | 172 ++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..42af5943d00a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -251,6 +251,18 @@ config SPI_CADENCE_XSPI
 	  device with a Cadence XSPI controller and want to access the
 	  Flash as an MTD device.
 
+config SPI_CADENCE_MRVL_XSPI
+	tristate "Marvell mods for XSPI controller"
+	depends on SPI_CADENCE_XSPI
+
+	help
+	  Enable support for Marvell XSPI modifications
+
+	  During implementation of Cadence XSPI core Marvell
+	  has added some additional features like clock divider,
+	  PHY config support or non-memory SPI capabilities.
+	  Enable that option if you want to enable these features.
+
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 719c2f3b4771..c73faf6b0546 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -193,6 +193,46 @@
 #define CDNS_XSPI_POLL_TIMEOUT_US	1000
 #define CDNS_XSPI_POLL_DELAY_US	10
 
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+/* clock config register */
+#define CDNS_XSPI_CLK_CTRL_AUX_REG	0x2020
+#define CDNS_XSPI_CLK_ENABLE		BIT(0)
+#define CDNS_XSPI_CLK_DIV		GENMASK(4, 1)
+
+/* Clock macros */
+#define CDNS_XSPI_CLOCK_IO_HZ 800000000
+#define CDNS_XSPI_CLOCK_DIVIDED(div) ((CDNS_XSPI_CLOCK_IO_HZ) / (div))
+
+/*PHY default values*/
+#define REGS_DLL_PHY_CTRL		0x00000707
+#define CTB_RFILE_PHY_CTRL		0x00004000
+#define RFILE_PHY_TSEL			0x00000000
+#define RFILE_PHY_DQ_TIMING		0x00000101
+#define RFILE_PHY_DQS_TIMING		0x00700404
+#define RFILE_PHY_GATE_LPBK_CTRL	0x00200030
+#define RFILE_PHY_DLL_MASTER_CTRL	0x00800000
+#define RFILE_PHY_DLL_SLAVE_CTRL	0x0000ff01
+
+/*PHY config rtegisters*/
+#define CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL		0x1034
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL			0x0080
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL			0x0084
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING		0x0000
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING		0x0004
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL	0x0008
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL	0x000c
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL	0x0010
+#define CDNS_XSPI_DATASLICE_RFILE_PHY_DLL_OBS_REG_0		0x001c
+
+#define CDNS_XSPI_DLL_RST_N BIT(24)
+#define CDNS_XSPI_DLL_LOCK  BIT(0)
+
+/* MSI-X clear interrupt register */
+#define CDNS_XSPI_SPIX_INTR_AUX				0x2000
+#define CDNS_MSIX_CLEAR_IRQ					0x01
+
+#endif
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -238,6 +278,106 @@ struct cdns_xspi_dev {
 	enum cdns_xspi_sdma_size read_size;
 };
 
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+
+#define MRVL_DEFAULT_CLK 25000000
+
+const int cdns_xspi_clk_div_list[] = {
+	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
+	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
+	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
+	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
+	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
+	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
+	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
+	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
+	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
+	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
+	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
+	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
+	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
+	128,	//0xD = Divide by 128. SPI clock is 6.25 MHz.
+	-1	//End of list
+};
+
+static bool cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_cntrl = readl(cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	u32 dll_lock;
+
+	/*Reset DLL*/
+	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
+	writel(dll_cntrl, cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	/*Wait for DLL lock*/
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+		CDNS_XSPI_INTR_STATUS_REG,
+		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
+}
+
+//Static confiuration of PHY
+static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
+{
+	writel(REGS_DLL_PHY_CTRL,
+		cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	writel(CTB_RFILE_PHY_CTRL,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
+	writel(RFILE_PHY_TSEL,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
+	writel(RFILE_PHY_DQ_TIMING,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
+	writel(RFILE_PHY_DQS_TIMING,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
+	writel(RFILE_PHY_GATE_LPBK_CTRL,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
+	writel(RFILE_PHY_DLL_MASTER_CTRL,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
+	writel(RFILE_PHY_DLL_SLAVE_CTRL,
+		cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
+
+	return cdns_xspi_reset_dll(cdns_xspi);
+}
+
+// Find max avalible clock
+static bool cdns_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi, int requested_clk)
+{
+	int i = 0;
+	int clk_val;
+	u32 clk_reg;
+	bool update_clk = false;
+
+	while (cdns_xspi_clk_div_list[i] > 0) {
+		clk_val = CDNS_XSPI_CLOCK_DIVIDED(cdns_xspi_clk_div_list[i]);
+		if (clk_val <= requested_clk)
+			break;
+		i++;
+	}
+
+	if (cdns_xspi_clk_div_list[i] == -1) {
+		dev_info(cdns_xspi->dev, "Unable to find clock divider for CLK: %d - setting 6.25MHz\n",
+		       requested_clk);
+		i = 0x0D;
+	} else {
+		dev_dbg(cdns_xspi->dev, "Found clk div: %d, clk val: %d\n",
+			cdns_xspi_clk_div_list[i],
+			CDNS_XSPI_CLOCK_DIVIDED(cdns_xspi_clk_div_list[i]));
+	}
+
+	clk_reg = readl(cdns_xspi->auxbase + CDNS_XSPI_CLK_CTRL_AUX_REG);
+
+	if (FIELD_GET(CDNS_XSPI_CLK_DIV, clk_reg) != i) {
+		clk_reg = FIELD_PREP(CDNS_XSPI_CLK_DIV, i);
+		clk_reg |= CDNS_XSPI_CLK_ENABLE;
+		update_clk = true;
+	}
+
+	if (update_clk)
+		writel(clk_reg, cdns_xspi->auxbase + CDNS_XSPI_CLK_CTRL_AUX_REG);
+
+	return update_clk;
+}
+#endif
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -328,6 +468,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 		return -EIO;
 	}
 
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
 	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
 	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
 	cdns_xspi_set_interrupts(cdns_xspi, false);
@@ -534,6 +677,10 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != mem->spi->chip_select)
 		cdns_xspi->cur_cs = mem->spi->chip_select;
 
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+	cdns_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
+#endif
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -574,6 +721,10 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+	writel(CDNS_MSIX_CLEAR_IRQ, cdns_xspi->auxbase + CDNS_XSPI_SPIX_INTR_AUX);
+#endif
+
 	if (irq_status &
 	    (CDNS_XSPI_SDMA_ERROR | CDNS_XSPI_SDMA_TRIGGER |
 	     CDNS_XSPI_STIG_DONE)) {
@@ -654,6 +805,18 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+static int cdns_xspi_setup(struct spi_device *spi_dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
+
+	cdns_xspi_setup_clock(cdns_xspi, spi_dev->max_speed_hz);
+
+	return 0;
+}
+#endif
+
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -673,6 +836,9 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	master->mem_ops = &cadence_xspi_mem_ops;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = -1;
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+	master->setup = cdns_xspi_setup;
+#endif
 
 	platform_set_drvdata(pdev, master);
 
@@ -720,8 +886,12 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	cdns_xspi_print_phy_config(cdns_xspi);
+#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
+	cdns_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
+	cdns_xspi_configure_phy(cdns_xspi);
+#endif
 
+	cdns_xspi_print_phy_config(cdns_xspi);
 	ret = cdns_xspi_controller_init(cdns_xspi);
 	if (ret) {
 		dev_err(dev, "Failed to initialize controller\n");
-- 
2.17.1

