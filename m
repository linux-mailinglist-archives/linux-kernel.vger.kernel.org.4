Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C86A0641
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjBWK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjBWK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:29:52 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E348E17;
        Thu, 23 Feb 2023 02:29:47 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31NATclh084077;
        Thu, 23 Feb 2023 04:29:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677148178;
        bh=Q8GJl/fgAcjey4n22O9Ch7hREn+twWwwTxgnS4FAqiw=;
        h=From:To:CC:Subject:Date;
        b=nI0CTf+RWKfRoNHbXiVom9BuofM5/2N13kd88gfOuDGllciqfzvlkMwxJtelTBF55
         8jY+smXR5NaARXvtSZXZyNbYj/XNv8pmwgeDlY2qrSbW8AtCnM8eUfyHcnujuhVndL
         Mby60LvtJnXLxbVlaUHYOQbPK+8qsgOyzTXEuVsI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31NATcrM028638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Feb 2023 04:29:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Feb 2023 04:29:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Feb 2023 04:29:37 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31NATalK028770;
        Thu, 23 Feb 2023 04:29:37 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        <linux-spi@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-sn-f-ospi: fix white spaces and improve code formatting
Date:   Thu, 23 Feb 2023 15:59:18 +0530
Message-ID: <20230223102918.985376-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")

Allignment issues in all the macro definitions of this driver have been
fixed for better asthetics

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-sn-f-ospi.c | 170 ++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 348c6e1edd38..6bd0d4945aa0 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -16,96 +16,96 @@
 #include <linux/spi/spi-mem.h>
 
 /* Registers */
-#define OSPI_PROT_CTL_INDIR			0x00
-#define   OSPI_PROT_MODE_DATA_MASK		GENMASK(31, 30)
-#define   OSPI_PROT_MODE_ALT_MASK		GENMASK(29, 28)
-#define   OSPI_PROT_MODE_ADDR_MASK		GENMASK(27, 26)
-#define   OSPI_PROT_MODE_CODE_MASK		GENMASK(25, 24)
-#define     OSPI_PROT_MODE_SINGLE		0
-#define     OSPI_PROT_MODE_DUAL			1
-#define     OSPI_PROT_MODE_QUAD			2
-#define     OSPI_PROT_MODE_OCTAL		3
-#define   OSPI_PROT_DATA_RATE_DATA		BIT(23)
-#define   OSPI_PROT_DATA_RATE_ALT		BIT(22)
-#define   OSPI_PROT_DATA_RATE_ADDR		BIT(21)
-#define   OSPI_PROT_DATA_RATE_CODE		BIT(20)
-#define     OSPI_PROT_SDR			0
-#define     OSPI_PROT_DDR			1
-#define   OSPI_PROT_BIT_POS_DATA		BIT(19)
-#define   OSPI_PROT_BIT_POS_ALT			BIT(18)
-#define   OSPI_PROT_BIT_POS_ADDR		BIT(17)
-#define   OSPI_PROT_BIT_POS_CODE		BIT(16)
-#define   OSPI_PROT_SAMP_EDGE			BIT(12)
-#define   OSPI_PROT_DATA_UNIT_MASK		GENMASK(11, 10)
-#define     OSPI_PROT_DATA_UNIT_1B		0
-#define     OSPI_PROT_DATA_UNIT_2B		1
-#define     OSPI_PROT_DATA_UNIT_4B		3
-#define   OSPI_PROT_TRANS_DIR_WRITE		BIT(9)
-#define   OSPI_PROT_DATA_EN			BIT(8)
-#define   OSPI_PROT_ALT_SIZE_MASK		GENMASK(7, 5)
-#define   OSPI_PROT_ADDR_SIZE_MASK		GENMASK(4, 2)
-#define   OSPI_PROT_CODE_SIZE_MASK		GENMASK(1, 0)
-
-#define OSPI_CLK_CTL				0x10
-#define   OSPI_CLK_CTL_BOOT_INT_CLK_EN		BIT(16)
-#define   OSPI_CLK_CTL_PHA			BIT(12)
-#define     OSPI_CLK_CTL_PHA_180		0
-#define     OSPI_CLK_CTL_PHA_90			1
-#define   OSPI_CLK_CTL_DIV			GENMASK(9, 8)
-#define     OSPI_CLK_CTL_DIV_1			0
-#define     OSPI_CLK_CTL_DIV_2			1
-#define     OSPI_CLK_CTL_DIV_4			2
-#define     OSPI_CLK_CTL_DIV_8			3
-#define   OSPI_CLK_CTL_INT_CLK_EN		BIT(0)
-
-#define OSPI_CS_CTL1				0x14
-#define OSPI_CS_CTL2				0x18
-#define OSPI_SSEL				0x20
-#define OSPI_CMD_IDX_INDIR			0x40
-#define OSPI_ADDR				0x50
-#define OSPI_ALT_INDIR				0x60
-#define OSPI_DMY_INDIR				0x70
-#define OSPI_DAT				0x80
-#define OSPI_DAT_SWP_INDIR			0x90
-
-#define OSPI_DAT_SIZE_INDIR			0xA0
-#define   OSPI_DAT_SIZE_EN			BIT(15)
-#define   OSPI_DAT_SIZE_MASK			GENMASK(10, 0)
-#define   OSPI_DAT_SIZE_MAX			(OSPI_DAT_SIZE_MASK + 1)
-
-#define OSPI_TRANS_CTL				0xC0
-#define   OSPI_TRANS_CTL_STOP_REQ		BIT(1)	/* RW1AC */
-#define   OSPI_TRANS_CTL_START_REQ		BIT(0)	/* RW1AC */
-
-#define OSPI_ACC_MODE				0xC4
-#define   OSPI_ACC_MODE_BOOT_DISABLE		BIT(0)
-
-#define OSPI_SWRST				0xD0
-#define   OSPI_SWRST_INDIR_WRITE_FIFO		BIT(9)	/* RW1AC */
-#define   OSPI_SWRST_INDIR_READ_FIFO		BIT(8)	/* RW1AC */
-
-#define OSPI_STAT				0xE0
-#define   OSPI_STAT_IS_AXI_WRITING		BIT(10)
-#define   OSPI_STAT_IS_AXI_READING		BIT(9)
-#define   OSPI_STAT_IS_SPI_INT_CLK_STOP		BIT(4)
-#define   OSPI_STAT_IS_SPI_IDLE			BIT(3)
-
-#define OSPI_IRQ				0xF0
-#define   OSPI_IRQ_CS_DEASSERT			BIT(8)
-#define   OSPI_IRQ_WRITE_BUF_READY		BIT(2)
-#define   OSPI_IRQ_READ_BUF_READY		BIT(1)
-#define   OSPI_IRQ_CS_TRANS_COMP		BIT(0)
-#define   OSPI_IRQ_ALL				\
+#define	OSPI_PROT_CTL_INDIR			0x00
+#define	OSPI_PROT_MODE_DATA_MASK		GENMASK(31, 30)
+#define	OSPI_PROT_MODE_ALT_MASK			GENMASK(29, 28)
+#define	OSPI_PROT_MODE_ADDR_MASK		GENMASK(27, 26)
+#define	OSPI_PROT_MODE_CODE_MASK		GENMASK(25, 24)
+#define	OSPI_PROT_MODE_SINGLE			0
+#define	OSPI_PROT_MODE_DUAL			1
+#define	OSPI_PROT_MODE_QUAD			2
+#define	OSPI_PROT_MODE_OCTAL			3
+#define	OSPI_PROT_DATA_RATE_DATA		BIT(23)
+#define	OSPI_PROT_DATA_RATE_ALT			BIT(22)
+#define	OSPI_PROT_DATA_RATE_ADDR		BIT(21)
+#define	OSPI_PROT_DATA_RATE_CODE		BIT(20)
+#define	OSPI_PROT_SDR				0
+#define	OSPI_PROT_DDR				1
+#define	OSPI_PROT_BIT_POS_DATA			BIT(19)
+#define	OSPI_PROT_BIT_POS_ALT			BIT(18)
+#define	OSPI_PROT_BIT_POS_ADDR			BIT(17)
+#define	OSPI_PROT_BIT_POS_CODE			BIT(16)
+#define	OSPI_PROT_SAMP_EDGE			BIT(12)
+#define	OSPI_PROT_DATA_UNIT_MASK		GENMASK(11, 10)
+#define	OSPI_PROT_DATA_UNIT_1B			0
+#define	OSPI_PROT_DATA_UNIT_2B			1
+#define	OSPI_PROT_DATA_UNIT_4B			3
+#define	OSPI_PROT_TRANS_DIR_WRITE		BIT(9)
+#define	OSPI_PROT_DATA_EN			BIT(8)
+#define	OSPI_PROT_ALT_SIZE_MASK			GENMASK(7, 5)
+#define	OSPI_PROT_ADDR_SIZE_MASK		GENMASK(4, 2)
+#define	OSPI_PROT_CODE_SIZE_MASK		GENMASK(1, 0)
+
+#define	OSPI_CLK_CTL				0x10
+#define	OSPI_CLK_CTL_BOOT_INT_CLK_EN		BIT(16)
+#define	OSPI_CLK_CTL_PHA			BIT(12)
+#define	OSPI_CLK_CTL_PHA_180			0
+#define	OSPI_CLK_CTL_PHA_90			1
+#define	OSPI_CLK_CTL_DIV			GENMASK(9, 8)
+#define	OSPI_CLK_CTL_DIV_1			0
+#define	OSPI_CLK_CTL_DIV_2			1
+#define	OSPI_CLK_CTL_DIV_4			2
+#define	OSPI_CLK_CTL_DIV_8			3
+#define	OSPI_CLK_CTL_INT_CLK_EN			BIT(0)
+
+#define	OSPI_CS_CTL1				0x14
+#define	OSPI_CS_CTL2				0x18
+#define	OSPI_SSEL				0x20
+#define	OSPI_CMD_IDX_INDIR			0x40
+#define	OSPI_ADDR				0x50
+#define	OSPI_ALT_INDIR				0x60
+#define	OSPI_DMY_INDIR				0x70
+#define	OSPI_DAT				0x80
+#define	OSPI_DAT_SWP_INDIR			0x90
+
+#define	OSPI_DAT_SIZE_INDIR			0xA0
+#define	OSPI_DAT_SIZE_EN			BIT(15)
+#define	OSPI_DAT_SIZE_MASK			GENMASK(10, 0)
+#define	OSPI_DAT_SIZE_MAX			(OSPI_DAT_SIZE_MASK + 1)
+
+#define	OSPI_TRANS_CTL				0xC0
+#define	OSPI_TRANS_CTL_STOP_REQ			BIT(1)	/* RW1AC */
+#define	OSPI_TRANS_CTL_START_REQ		BIT(0)	/* RW1AC */
+
+#define	OSPI_ACC_MODE				0xC4
+#define	OSPI_ACC_MODE_BOOT_DISABLE		BIT(0)
+
+#define	OSPI_SWRST				0xD0
+#define	OSPI_SWRST_INDIR_WRITE_FIFO		BIT(9)	/* RW1AC */
+#define	OSPI_SWRST_INDIR_READ_FIFO		BIT(8)	/* RW1AC */
+
+#define	OSPI_STAT				0xE0
+#define	OSPI_STAT_IS_AXI_WRITING		BIT(10)
+#define	OSPI_STAT_IS_AXI_READING		BIT(9)
+#define	OSPI_STAT_IS_SPI_INT_CLK_STOP		BIT(4)
+#define	OSPI_STAT_IS_SPI_IDLE			BIT(3)
+
+#define	OSPI_IRQ				0xF0
+#define	OSPI_IRQ_CS_DEASSERT			BIT(8)
+#define	OSPI_IRQ_WRITE_BUF_READY		BIT(2)
+#define	OSPI_IRQ_READ_BUF_READY			BIT(1)
+#define	OSPI_IRQ_CS_TRANS_COMP			BIT(0)
+#define	OSPI_IRQ_ALL				\
 		(OSPI_IRQ_CS_DEASSERT | OSPI_IRQ_WRITE_BUF_READY \
 		 | OSPI_IRQ_READ_BUF_READY | OSPI_IRQ_CS_TRANS_COMP)
 
-#define OSPI_IRQ_STAT_EN			0xF4
-#define OSPI_IRQ_SIG_EN				0xF8
+#define	OSPI_IRQ_STAT_EN			0xF4
+#define	OSPI_IRQ_SIG_EN				0xF8
 
 /* Parameters */
-#define OSPI_NUM_CS				4
-#define OSPI_DUMMY_CYCLE_MAX			255
-#define OSPI_WAIT_MAX_MSEC			100
+#define	OSPI_NUM_CS				4
+#define	OSPI_DUMMY_CYCLE_MAX			255
+#define	OSPI_WAIT_MAX_MSEC			100
 
 struct f_ospi {
 	void __iomem *base;
-- 
2.25.1

