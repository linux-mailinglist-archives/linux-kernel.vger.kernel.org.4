Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C2689181
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBCIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjBCIDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:03:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280DE3AA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:01:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o36so3221711wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHDhUD+71qEiWJNtSvciAjMHwmVmo53j1uhmb0eIIrY=;
        b=l1Rv45CCB/Lnvd14SrwdE3KyJhmwjCK8T9ymCV9vexXSaznRLy1pk8X0wzqzo8XMjP
         9LE+dkfT3dafMc3GCROwWkta68MSVMCV/0lS0kRL0nbWjeVhxzsfk7ogv5m5NRT+2zVQ
         YDoNs5cEjD19B6bTiLZTEPuyQY+HBwz0/Mei90Xkv9aGljMXARi/CN5SfQgkRwpvrADU
         CEVCClwmOxc6Y69iIs5hmY7fJVRVtUmvHZQU5vKx6d8N1helaB+4ncad0oNxZ4mhFP5R
         f6jyNSPgE1li9vDeS6GaT4ZLtG9QFonF5T47PLFkVIMtwLjhv/rjd01s7i2eeFZn7B/b
         EF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHDhUD+71qEiWJNtSvciAjMHwmVmo53j1uhmb0eIIrY=;
        b=a0uYS0gJmTuqkUdjloK5n/lzf8ALQInoM9eb4uPkjdpiOGHyfPYSsjVyN/gMc2AnYN
         MtED+hiCd7sb3bSHr0NFDx2xCk0InqDvpbWfaSpevTUq5MkO0B0hab7+9S9DtejtgL67
         vpOa9fSrsyvL6/61/hz7xkJgGzJYYGBwN5S2RJig8bdN9vaBkp/nnc3DCpYTlHlaCwxm
         qMsDHnX5QXtqWNqz9QbeBKACPLhokZmZx7gN9kDtholQ1QKeyCUhVEdEwFzeXfHXo6Hi
         OQocvQbfeudfG3Kcvv9gTiwTk1L4V3QycT2IMSujuCK78t5JIuo7liAU68AyfmHpL/Xf
         a88Q==
X-Gm-Message-State: AO0yUKXeE5HyVqzI8IfoSRn9hgU/yTGTEGzzmy21xmXMBgxtKZxg2Uxd
        ogf32NlPuHDZ6iEE/YmNfMDoWA==
X-Google-Smtp-Source: AK7set/Oybc4z8/L81CmXmB+w/P0zz9sur8qbagAXk/xMTtQRid0YfgGJvkdzOcjTpc+c+/mSsnV4A==
X-Received: by 2002:a05:600c:4f95:b0:3dc:47f4:a022 with SMTP id n21-20020a05600c4f9500b003dc47f4a022mr3762481wmq.25.1675411299447;
        Fri, 03 Feb 2023 00:01:39 -0800 (PST)
Received: from 1.. ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003dc4aae4739sm6886802wma.27.2023.02.03.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:01:39 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: s/a SPI/an SPI
Date:   Fri,  3 Feb 2023 10:01:36 +0200
Message-Id: <20230203080136.68505-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8364; i=tudor.ambarus@linaro.org; h=from:subject; bh=ZjylBt1sdLZyW4HO90rGzIhsczZHvnd0rmIAF8GGXc4=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBj3L9ggKo9W2c1MyxBoo7OJhGbyrmIuwS4hXz0m Bn9KcOhK7mJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY9y/YAAKCRBLVU9HpY0U 6dhKB/4jF1gsk6sPlKdJohpNPKlf07D6SVQYUCgHC+j/IIQ2DNhhHzomBLCpbbtjX+GrbL74nKa Jk8ma8mLok5VAP7Jcu2a6eJeH85Ro/ILGZWUEbfL+pkiDYWRoQkixF2eNL8bnOSIdA/osGE51ex YPVLNs+3GGFognqlp1xIczbnaGolzORv2EEyslkr4lQc/hMxgWW68qh2yt5TeDyzfRHRzvA+D2g 6Tc2IyX+n6jE5DS0FsbSP3Qe3BCvwvFr8TGcIHEM2IDjb0Ln1FduvHCSDkrKGIqmoWQimljnslM zx8a/fad+3jI9Cs3SzMemJGpydxTFDOzSYxja1NuSvhHPJh0
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
find include/linux/mtd/ -type f -exec sed -i "s/ a SPI/ an SPI/g" {} \;
find drivers/mtd/ -type f -exec sed -i "s/ a SPI/ an SPI/g" {} \;

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/controllers/Kconfig |  2 +-
 drivers/mtd/spi-nor/core.c              | 14 +++++++-------
 drivers/mtd/spi-nor/core.h              |  4 ++--
 drivers/mtd/spi-nor/sfdp.c              |  6 +++---
 include/linux/mtd/spinand.h             | 14 +++++++-------
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index ca45dcd3ffe8..250295c8d85c 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -14,5 +14,5 @@ config SPI_NXP_SPIFI
 	  Enable support for the NXP LPC SPI Flash Interface controller.
 
 	  SPIFI is a specialized controller for connecting serial SPI
-	  Flash. Enable this option if you have a device with a SPIFI
+	  Flash. Enable this option if you have a device with an SPIFI
 	  controller and want to access the Flash as a mtd device.
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 22cb18b6c941..875fe7a8b1cb 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1137,7 +1137,7 @@ int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 
 /**
  * spi_nor_div_by_erase_size() - calculate remainder and update new dividend
- * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * @erase:	pointer to a structure that describes an SPI NOR erase type
  * @dividend:	dividend value
  * @remainder:	pointer to u32 remainder (will be updated)
  *
@@ -1158,7 +1158,7 @@ static u64 spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
  *				    which the address fits is expected to be
  *				    provided.
  * @map:	the erase map of the SPI NOR
- * @region:	pointer to a structure that describes a SPI NOR erase region
+ * @region:	pointer to a structure that describes an SPI NOR erase region
  * @addr:	offset in the serial flash memory
  * @len:	number of bytes to erase
  *
@@ -1216,7 +1216,7 @@ static u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
 
 /**
  * spi_nor_region_next() - get the next spi nor region
- * @region:	pointer to a structure that describes a SPI NOR erase region
+ * @region:	pointer to a structure that describes an SPI NOR erase region
  *
  * Return: the next spi nor region or NULL if last region.
  */
@@ -1259,8 +1259,8 @@ spi_nor_find_erase_region(const struct spi_nor_erase_map *map, u64 addr)
 
 /**
  * spi_nor_init_erase_cmd() - initialize an erase command
- * @region:	pointer to a structure that describes a SPI NOR erase region
- * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * @region:	pointer to a structure that describes an SPI NOR erase region
+ * @erase:	pointer to a structure that describes an SPI NOR erase type
  *
  * Return: the pointer to the allocated erase command, ERR_PTR(-errno)
  *	   otherwise.
@@ -2010,8 +2010,8 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 }
 
 /**
- * spi_nor_set_erase_type() - set a SPI NOR erase type
- * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * spi_nor_set_erase_type() - set an SPI NOR erase type
+ * @erase:	pointer to a structure that describes an SPI NOR erase type
  * @size:	the size of the sector/block erased by the erase type
  * @opcode:	the SPI command op code to erase the sector/block
  */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 25423225c29d..39dde1cc1092 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -189,7 +189,7 @@ enum spi_nor_pp_command_index {
 };
 
 /**
- * struct spi_nor_erase_type - Structure to describe a SPI NOR erase type
+ * struct spi_nor_erase_type - Structure to describe an SPI NOR erase type
  * @size:		the size of the sector/block erased by the erase type.
  *			JEDEC JESD216B imposes erase sizes to be a power of 2.
  * @size_shift:		@size is a power of 2, the shift is stored in
@@ -228,7 +228,7 @@ struct spi_nor_erase_command {
 };
 
 /**
- * struct spi_nor_erase_region - Structure to describe a SPI NOR erase region
+ * struct spi_nor_erase_region - Structure to describe an SPI NOR erase region
  * @offset:		the offset in the data array of erase region start.
  *			LSB bits are used as a bitmask encoding flags to
  *			determine if this region is overlaid, if this region is
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 298ab5e53a8c..39fd535416f0 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -304,7 +304,7 @@ static const struct sfdp_bfpt_erase sfdp_bfpt_erases[] = {
 
 /**
  * spi_nor_set_erase_settings_from_bfpt() - set erase type settings from BFPT
- * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * @erase:	pointer to a structure that describes an SPI NOR erase type
  * @size:	the size of the sector/block erased by the erase type
  * @opcode:	the SPI command op code to erase the sector/block
  * @i:		erase type index as sorted in the Basic Flash Parameter Table
@@ -775,8 +775,8 @@ static void spi_nor_region_mark_overlay(struct spi_nor_erase_region *region)
 
 /**
  * spi_nor_region_check_overlay() - set overlay bit when the region is overlaid
- * @region:	pointer to a structure that describes a SPI NOR erase region
- * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * @region:	pointer to a structure that describes an SPI NOR erase region
+ * @erase:	pointer to a structure that describes an SPI NOR erase type
  * @erase_type:	erase type bitmask
  */
 static void
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6d3392a7edc6..2564de8b6ed3 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -231,8 +231,8 @@ struct spinand_devid {
 
 /**
  * struct manufacurer_ops - SPI NAND manufacturer specific operations
- * @init: initialize a SPI NAND device
- * @cleanup: cleanup a SPI NAND device
+ * @init: initialize an SPI NAND device
+ * @cleanup: cleanup an SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
  * NAND chips coming from this vendor can be initialized properly.
@@ -293,7 +293,7 @@ struct spinand_op_variants {
 	}
 
 /**
- * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
+ * spinand_ecc_info - description of the on-die ECC implemented by an SPI NAND
  *		      chip
  * @get_status: get the ECC status. Should return a positive number encoding
  *		the number of corrected bitflips if correction was possible or
@@ -462,7 +462,7 @@ static inline struct spinand_device *mtd_to_spinand(struct mtd_info *mtd)
 }
 
 /**
- * spinand_to_mtd() - Get the MTD device embedded in a SPI NAND device
+ * spinand_to_mtd() - Get the MTD device embedded in an SPI NAND device
  * @spinand: SPI NAND device
  *
  * Return: the MTD device embedded in @spinand.
@@ -484,7 +484,7 @@ static inline struct spinand_device *nand_to_spinand(struct nand_device *nand)
 }
 
 /**
- * spinand_to_nand() - Get the NAND device embedded in a SPI NAND object
+ * spinand_to_nand() - Get the NAND device embedded in an SPI NAND object
  * @spinand: SPI NAND device
  *
  * Return: the NAND device embedded in @spinand.
@@ -496,11 +496,11 @@ spinand_to_nand(struct spinand_device *spinand)
 }
 
 /**
- * spinand_set_of_node - Attach a DT node to a SPI NAND device
+ * spinand_set_of_node - Attach a DT node to an SPI NAND device
  * @spinand: SPI NAND device
  * @np: DT node
  *
- * Attach a DT node to a SPI NAND device.
+ * Attach a DT node to an SPI NAND device.
  */
 static inline void spinand_set_of_node(struct spinand_device *spinand,
 				       struct device_node *np)
-- 
2.34.1

