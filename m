Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5A6891BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjBCIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:12:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411974227
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:11:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bt17so856951wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXImJehkHmVrflAioylicgNvRG4OK8yL8E8nhyrNcio=;
        b=KR3Un9j3FCaNcxdBJWjn1sr6+3aaWXqfLlt8ADdhO+TPz8l52WysBqQyZLBB9P4w2H
         +PkaOr88ozoY63IJm+d5FgZx7Tw+r11ynr13WYGXl7rlqs1LCfNlWFzaVAvVS2Tie6Ea
         0Y2xfQR7sqoJ59EePZSn8bxHOITFiAVR7QYGV3s5NZxOghQYIx4iJl3LrcAi2A4dFdXZ
         DPwaQpwgQdmI28ewaNEOOV8u6zgP4LfrrWikJs0wMIEN4n6jb7q9mw3N8hUVl6X0VFxa
         E9f34LfFsczXUDJ3uzaQymgZjN+bONYjyJkAaatb53bxBV2b/i8a4eaC1QsZoWQjZK4U
         y/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXImJehkHmVrflAioylicgNvRG4OK8yL8E8nhyrNcio=;
        b=WforUAc6OTvrCS7ZsSJuQiVfy3KsAk5RlnLb//pfG0AW57U8nEFfPQ6tzUIz/qrf/d
         3K+JJew0ZdKQ/aa7f54IjZgpqDRKQa6WpqDzWfXXjqO8SGhNlmtiDup3HuSuDcbp4zDs
         VRQybbCQsnP60kvRX0r1Klz9jCYkKWPwPQzgwBW2HKW3icUbR94t49cYcjNMDJFO7+Vt
         zFjsZFK+9FtS2F/R5wNz1kjXdF0i3nk3KqsdAI4OdDqXtjAzBmVcE/h6R5+aGiKoyuaP
         d6yP4bmE1wmd8dqtuOjRc4zKhPr6zGNkyjUKfIfo3WAjQUJtMGQ4TpW3RFhoW19tQkaH
         TNTQ==
X-Gm-Message-State: AO0yUKXFVKvDiJwK2K+XnK5+vfXMHAivQHa+MEWRM5X9vuRLQ+90qh2o
        jYfPFliysQ3zCYTLGWvMcfVKU9qQEUnA9HAIwuo=
X-Google-Smtp-Source: AK7set/SSfXjv6AbBAQOciCB4PzhL/5954BMzPlaXtmSlgl3EWma6XNoFlwhkO03eiUclN+xPbHYjQ==
X-Received: by 2002:a5d:6501:0:b0:2bf:d0a1:e407 with SMTP id x1-20020a5d6501000000b002bfd0a1e407mr7816237wru.22.1675411881701;
        Fri, 03 Feb 2023 00:11:21 -0800 (PST)
Received: from 1.. ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b002bfd462d13asm1391455wrb.18.2023.02.03.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:11:21 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] spi: s/a SPI/an SPI
Date:   Fri,  3 Feb 2023 10:11:19 +0200
Message-Id: <20230203081119.69872-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10412; i=tudor.ambarus@linaro.org; h=from:subject; bh=ZVorV0Xwyz8oZ8fXfi3RFiZM/5b7/X3lyRBDmUcOPnI=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBj3MGmz7rhtAfVZlakbz24i30BbKD5UXDho/YJM UreIZ4q1MaJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY9zBpgAKCRBLVU9HpY0U 6Ta4B/94dn+9/DTm+PHxgEz2unwsGLOgiBPDwdCPB3HDjBS7a8wo5pn6YAeU2iX66vhiTtyHKgl 6zIDlPJ4q8t59k4cSb6KZDKVKws+Vjc96SuRHDaJR8ENlPBqKysiFAqiC1n5bIsI3DG/PT02cSe I7xmIQifvz2MNuKMltQFJnzsY3uj+Q2CXqg09tsOmDabYmhKTrtqz6DvL/0ElCjDbZlalx6kDQh /1sPhqImV87WQoZCB2cWXL0YHL+Ynw2MIqVizzXgwOYcdgSdtdMC16QNCfcS/vfYJanX9lONbKJ tDdSy0Rz0IfEVHj8Uzu2ZDo3BRiEA2t4734YCgWgBZwtU4YZ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deciding factor for when a/an should be used is the sound
that begins the word which follows these indefinite articles,
rather than the letter which does. Use "an SPI". (SPI begins
with the consonant letter S, but the S is pronounced with its
letter name, "es.")

Used sed to do the replacement:
find include/linux/spi/ -type f -exec sed -i "s/ a SPI/ an SPI/g" {} \;
find drivers/spi/ -type f -exec sed -i "s/ a SPI/ an SPI/g" {} \;

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/Kconfig           |  8 ++++----
 drivers/spi/spi-mem.c         | 10 +++++-----
 drivers/spi/spi-mpc52xx-psc.c |  2 +-
 drivers/spi/spi.c             |  4 ++--
 include/linux/spi/spi-mem.h   | 18 +++++++++---------
 include/linux/spi/spi.h       |  8 ++++----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 87fc2bd16b72..76a2476d90fb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -77,7 +77,7 @@ config SPI_ALTERA_DFL
 	help
 	  This is a Device Feature List (DFL) bus driver for the
 	  Altera SPI master controller.  The SPI master is connected
-	  to a SPI slave to Avalon bridge in a Intel MAX BMC.
+	  to an SPI slave to Avalon bridge in a Intel MAX BMC.
 
 config SPI_AR934X
 	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
@@ -631,7 +631,7 @@ config SPI_MTK_SNFI
 	help
 	  This enables support for SPI-NAND mode on the MediaTek NAND
 	  Flash Interface found on MediaTek ARM SoCs. This controller
-	  is implemented as a SPI-MEM controller with pipelined ECC
+	  is implemented as an SPI-MEM controller with pipelined ECC
 	  capcability.
 
 config SPI_WPCM_FIU
@@ -764,7 +764,7 @@ config SPI_PXA2XX
 	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
-	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
+	  This enables using a PXA2xx or Sodaville SSP port as an SPI master
 	  controller. The driver can be configured to use any SSP port and
 	  additional documentation can be found a Documentation/spi/pxa2xx.rst.
 
@@ -1150,7 +1150,7 @@ config SPI_MUX
 	select MULTIPLEXER
 	help
 	  This adds support for SPI multiplexers. Each SPI mux will be
-	  accessible as a SPI controller, the devices behind the mux will appear
+	  accessible as an SPI controller, the devices behind the mux will appear
 	  to be chip selects on this controller. It is still necessary to
 	  select one or more specific mux-controller drivers.
 
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 0c79193d9697..cfd1c4fff606 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -438,7 +438,7 @@ const char *spi_mem_get_name(struct spi_mem *mem)
 EXPORT_SYMBOL_GPL(spi_mem_get_name);
 
 /**
- * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
+ * spi_mem_adjust_op_size() - Adjust the data size of an SPI mem operation to
  *			      match controller limitations
  * @mem: the SPI memory
  * @op: the operation to adjust
@@ -886,11 +886,11 @@ static void spi_mem_shutdown(struct spi_device *spi)
 }
 
 /**
- * spi_mem_driver_register_with_owner() - Register a SPI memory driver
+ * spi_mem_driver_register_with_owner() - Register an SPI memory driver
  * @memdrv: the SPI memory driver to register
  * @owner: the owner of this driver
  *
- * Registers a SPI memory driver.
+ * Registers an SPI memory driver.
  *
  * Return: 0 in case of success, a negative error core otherwise.
  */
@@ -907,10 +907,10 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *memdrv,
 EXPORT_SYMBOL_GPL(spi_mem_driver_register_with_owner);
 
 /**
- * spi_mem_driver_unregister() - Unregister a SPI memory driver
+ * spi_mem_driver_unregister() - Unregister an SPI memory driver
  * @memdrv: the SPI memory driver to unregister
  *
- * Unregisters a SPI memory driver.
+ * Unregisters an SPI memory driver.
  */
 void spi_mem_driver_unregister(struct spi_mem_driver *memdrv)
 {
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 609311231e64..30015b6bffc4 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -285,7 +285,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	out_8(&fifo->rfcntl, 0);
 	out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
 
-	/* Configure 8bit codec mode as a SPI master and use EOF flags */
+	/* Configure 8bit codec mode as an SPI master and use EOF flags */
 	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
 	out_be32(&psc->sicr, 0x0180C800);
 	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 21a8c3a8eee4..cfadfd4772a9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -470,7 +470,7 @@ struct bus_type spi_bus_type = {
 EXPORT_SYMBOL_GPL(spi_bus_type);
 
 /**
- * __spi_register_driver - register a SPI driver
+ * __spi_register_driver - register an SPI driver
  * @owner: owner module of the driver to register
  * @sdrv: the driver to register
  * Context: can sleep
@@ -3255,7 +3255,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
  *	spi_alloc_slave()
  * Context: can sleep
  *
- * Register a SPI device as with spi_register_controller() which will
+ * Register an SPI device as with spi_register_controller() which will
  * automatically be unregistered and freed.
  *
  * Return: zero on success, else a negative error code.
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 8e984d75f5b6..2a9a8a7893ac 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -56,7 +56,7 @@
 #define SPI_MEM_OP_NO_DATA	{ }
 
 /**
- * enum spi_mem_data_dir - describes the direction of a SPI memory data
+ * enum spi_mem_data_dir - describes the direction of an SPI memory data
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
@@ -69,7 +69,7 @@ enum spi_mem_data_dir {
 };
 
 /**
- * struct spi_mem_op - describes a SPI memory operation
+ * struct spi_mem_op - describes an SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
  *		sent MSB-first.
  * @cmd.buswidth: number of IO lines used to transmit the command
@@ -182,7 +182,7 @@ struct spi_mem_dirmap_desc {
 };
 
 /**
- * struct spi_mem - describes a SPI memory device
+ * struct spi_mem - describes an SPI memory device
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
@@ -200,7 +200,7 @@ struct spi_mem {
 };
 
 /**
- * struct spi_mem_set_drvdata() - attach driver private data to a SPI mem
+ * struct spi_mem_set_drvdata() - attach driver private data to an SPI mem
  *				  device
  * @mem: memory device
  * @data: data to attach to the memory device
@@ -211,7 +211,7 @@ static inline void spi_mem_set_drvdata(struct spi_mem *mem, void *data)
 }
 
 /**
- * struct spi_mem_get_drvdata() - get driver private data attached to a SPI mem
+ * struct spi_mem_get_drvdata() - get driver private data attached to an SPI mem
  *				  device
  * @mem: memory device
  *
@@ -228,7 +228,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
- * @exec_op: execute a SPI memory operation
+ * @exec_op: execute an SPI memory operation
  * @get_name: get a custom name for the SPI mem device from the controller.
  *	      This might be needed if the controller driver has been ported
  *	      to use the SPI mem layer and a custom name is used to keep
@@ -302,10 +302,10 @@ struct spi_controller_mem_caps {
 
 /**
  * struct spi_mem_driver - SPI memory driver
- * @spidrv: inherit from a SPI driver
- * @probe: probe a SPI memory. Usually where detection/initialization takes
+ * @spidrv: inherit from an SPI driver
+ * @probe: probe an SPI memory. Usually where detection/initialization takes
  *	   place
- * @remove: remove a SPI memory
+ * @remove: remove an SPI memory
  * @shutdown: take appropriate action when the system is shutdown
  *
  * This is just a thin wrapper around a spi_driver. The core takes care of
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9b23a1d0dd0d..0f7ba154e15b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -299,7 +299,7 @@ struct spi_message;
  *	field of this structure.
  *
  * This represents the kind of device driver that uses SPI messages to
- * interact with the hardware at the other end of a SPI link.  It's called
+ * interact with the hardware at the other end of an SPI link.  It's called
  * a "protocol" driver because it works through messages rather than talking
  * directly to SPI hardware (which is what the underlying SPI controller
  * driver does to pass those messages).  These protocols are defined in the
@@ -343,7 +343,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
 	__spi_register_driver(THIS_MODULE, driver)
 
 /**
- * module_spi_driver() - Helper macro for registering a SPI driver
+ * module_spi_driver() - Helper macro for registering an SPI driver
  * @__spi_driver: spi_driver struct
  *
  * Helper macro for SPI drivers which do not do anything special in module
@@ -859,7 +859,7 @@ int acpi_spi_count_resources(struct acpi_device *adev);
 #endif
 
 /*
- * SPI resource management while processing a SPI message
+ * SPI resource management while processing an SPI message
  */
 
 typedef void (*spi_res_release_t)(struct spi_controller *ctlr,
@@ -1474,7 +1474,7 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  */
 
 /**
- * struct spi_board_info - board-specific template for a SPI device
+ * struct spi_board_info - board-specific template for an SPI device
  * @modalias: Initializes spi_device.modalias; identifies the driver.
  * @platform_data: Initializes spi_device.platform_data; the particular
  *	data stored there is driver-specific.
-- 
2.34.1

