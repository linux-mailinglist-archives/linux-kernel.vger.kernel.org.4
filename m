Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E469B428
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBQUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBQUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:16 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474696242D;
        Fri, 17 Feb 2023 12:46:15 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17172b43531so2621898fac.1;
        Fri, 17 Feb 2023 12:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuH69jlg4LfV23Zo8j5+//LYri3/03zc86yy3z3HRPo=;
        b=DmLcMxfbzjZzqTZMuWIs8+AK4rqKvcBJuCywGj9AMlnyjkxy+CdehVCGXkze6fkNgw
         9S8Lky9R/sxUz28fTZ4iAY76JQwCPcY4X0Gir+1zRbAvjWsMkuI+4waGbR02/lGp4HUi
         JihBvoMCdb12Q55+ArzcvCfEwDFF9K14Pn5ZKP70glKl3KdjAfPL4zYS70KzJhxFNM0Y
         Uh7VdAAlktJ9vMRmUT1Am2WYO5jb+ddl9xxSTLOGfTanPsL2CyqqjOy8Nu+xU4CXiF++
         8sHw7jFhadEiL4NAkyh5/pdVKEnwfJ5122N8XDGZ0CoZs1YAPeTZ59b/Ii1kmo/YFwjE
         iDNQ==
X-Gm-Message-State: AO0yUKX2o9iu6a3LfUGkrgK5nxGEV091dB/KNq5BznUGC01ClLJTP3Cm
        gIcESiO2BvzYYng7cYlcgw3I9RA61Q==
X-Google-Smtp-Source: AK7set+isyYpyflbxbJCiAEih0YpIFd70SJdRnFvBD6wlmaafnbW4LGVnQroMpqNqsYOXF5Us/HDQg==
X-Received: by 2002:a05:6870:d287:b0:16e:87e6:4699 with SMTP id d7-20020a056870d28700b0016e87e64699mr3625235oae.55.1676666774060;
        Fri, 17 Feb 2023 12:46:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nx18-20020a056870be9200b0017197602990sm175332oab.11.2023.02.17.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:46:13 -0800 (PST)
Received: (nullmailer pid 1527514 invoked by uid 1000);
        Fri, 17 Feb 2023 20:46:11 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Feb 2023 14:45:40 -0600
Subject: [PATCH 1/3] spi: mpc5xxx-psc: Remove unused platform_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-dt-mpc5xxx-spi-v1-1-3be8602fce1e@kernel.org>
References: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
In-Reply-To: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_data for the MPC5xxx PSC SPI controllers is never used, so
remove it and the resulting code which depends on it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-mpc512x-psc.c | 28 ++++------------------------
 drivers/spi/spi-mpc52xx-psc.c | 39 +++------------------------------------
 2 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 03630359ce70..0b4d49ef84de 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -22,7 +22,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
-#include <linux/fsl_devices.h>
 #include <asm/mpc52xx_psc.h>
 
 enum {
@@ -51,8 +50,6 @@ enum {
 	__ret; })
 
 struct mpc512x_psc_spi {
-	void (*cs_control)(struct spi_device *spi, bool on);
-
 	/* driver internal data */
 	int type;
 	void __iomem *psc;
@@ -128,26 +125,16 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	mps->bits_per_word = cs->bits_per_word;
 
 	if (spi->cs_gpiod) {
-		if (mps->cs_control)
-			/* boardfile override */
-			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
-		else
-			/* gpiolib will deal with the inversion */
-			gpiod_set_value(spi->cs_gpiod, 1);
+		/* gpiolib will deal with the inversion */
+		gpiod_set_value(spi->cs_gpiod, 1);
 	}
 }
 
 static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-
 	if (spi->cs_gpiod) {
-		if (mps->cs_control)
-			/* boardfile override */
-			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-		else
-			/* gpiolib will deal with the inversion */
-			gpiod_set_value(spi->cs_gpiod, 0);
+		/* gpiolib will deal with the inversion */
+		gpiod_set_value(spi->cs_gpiod, 0);
 	}
 }
 
@@ -474,7 +461,6 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 					      u32 size, unsigned int irq)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc512x_psc_spi *mps;
 	struct spi_master *master;
 	int ret;
@@ -490,12 +476,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->type = (int)of_device_get_match_data(dev);
 	mps->irq = irq;
 
-	if (pdata) {
-		mps->cs_control = pdata->cs_control;
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->max_chipselect;
-	}
-
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = mpc512x_psc_spi_setup;
 	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 609311231e64..604868df913c 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/fsl_devices.h>
 #include <linux/slab.h>
 #include <linux/of_irq.h>
 
@@ -28,10 +27,6 @@
 #define MCLK 20000000 /* PSC port MClk in hz */
 
 struct mpc52xx_psc_spi {
-	/* fsl_spi_platform data */
-	void (*cs_control)(struct spi_device *spi, bool on);
-	u32 sysclk;
-
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
 	struct mpc52xx_psc_fifo __iomem *fifo;
@@ -101,17 +96,6 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 		ccr |= (MCLK / 1000000 - 1) & 0xFF;
 	out_be16((u16 __iomem *)&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
-
-	if (mps->cs_control)
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
-}
-
-static void mpc52xx_psc_spi_deactivate_cs(struct spi_device *spi)
-{
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
-
-	if (mps->cs_control)
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 }
 
 #define MPC52xx_PSC_BUFSIZE (MPC52xx_PSC_RFNUM_MASK + 1)
@@ -220,14 +204,9 @@ int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
 		m->actual_length += t->len;
 
 		spi_transfer_delay_exec(t);
-
-		if (cs_change)
-			mpc52xx_psc_spi_deactivate_cs(spi);
 	}
 
 	m->status = status;
-	if (status || !cs_change)
-		mpc52xx_psc_spi_deactivate_cs(spi);
 
 	mpc52xx_psc_spi_transfer_setup(spi, NULL);
 
@@ -269,7 +248,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	int ret;
 
 	/* default sysclk is 512MHz */
-	mclken_div = (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
+	mclken_div = 512000000 / MCLK;
 	ret = mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
 	if (ret)
 		return ret;
@@ -317,7 +296,6 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
 	int ret;
@@ -333,19 +311,8 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
 	mps->irq = irq;
-	if (pdata == NULL) {
-		dev_warn(dev,
-			 "probe called without platform data, no cs_control function will be called\n");
-		mps->cs_control = NULL;
-		mps->sysclk = 0;
-		master->bus_num = bus_num;
-		master->num_chipselect = 255;
-	} else {
-		mps->cs_control = pdata->cs_control;
-		mps->sysclk = pdata->sysclk;
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->max_chipselect;
-	}
+	master->bus_num = bus_num;
+	master->num_chipselect = 255;
 	master->setup = mpc52xx_psc_spi_setup;
 	master->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
 	master->cleanup = mpc52xx_psc_spi_cleanup;

-- 
2.39.1

