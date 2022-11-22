Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DD633CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiKVMx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiKVMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:53:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE973135D;
        Tue, 22 Nov 2022 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669121602; x=1700657602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=280AGAGOzlrvJmPaxpe8YTLlFmP2O2jU2sAPWkHWaVg=;
  b=OTfpVJGaWNWjw5R6WpRt4c50O8+N5rEp6mpjLOkty9KCFPwVbikAIIEU
   APDXoxJk/DzPsJu2RfdQNhlSt8cmsMiG5/JPACgS4L2Na+vbIP9od5Azb
   7n6kBvAM+8iuaTy+pnB5ntgVt6xeDjYxghUIHmehOtjHWNySOfRUQ3gV5
   7aXuXH4gqhkxGk7XQ1+bRe+FuG0HvBWeiNHzbDcY4XihJJnb4kObF9rKF
   ajNhU2ReLS9+1f87dnp1Sv7VTo+Jt+sBXtjs6jYoaYYiJLER0BHuLiLjr
   3K5HGMhh/+jbHhRf6voOsNFi3YXnRlKB07Mi8zOKO9mgBbxnF1kaJPyk1
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="184666071"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 05:53:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 05:52:54 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 22 Nov 2022 05:52:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <akpm@linux-foundation.org>
CC:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <broonie@kernel.org>,
        <qyousef@layalina.io>, <arnd@arndb.de>, <atishp@atishpatra.org>,
        <anup@brainfault.org>, <tkhai@ya.ru>, <quic_abhinavk@quicinc.com>,
        <vasily.averin@linux.dev>, <baolin.wang@linux.alibaba.com>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Date:   Tue, 22 Nov 2022 14:52:44 +0200
Message-ID: <20221122125244.175295-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My professional email will change and the microchip one will bounce after
mid-november of 2022.

Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
author mentions, and add an entry in the .mailmap file.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .mailmap                                               |  1 +
 .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
 .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
 .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
 .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
 MAINTAINERS                                            | 10 +++++-----
 drivers/crypto/atmel-ecc.c                             |  4 ++--
 drivers/crypto/atmel-i2c.c                             |  4 ++--
 drivers/crypto/atmel-i2c.h                             |  2 +-
 10 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index fdd7989492fc..f723a29af021 100644
--- a/.mailmap
+++ b/.mailmap
@@ -415,6 +415,7 @@ Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
+Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 0ccaab16dc61..0b7383b3106b 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 5163c51b4547..ee2ffb034325 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
index fcc5adf03cad..3d6ed24b1b00 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 4dd973e341e6..6c57dd6c3a36 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel SPI device
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index 1d493add4053..b0d99bc10535 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Quad Serial Peripheral Interface (QSPI)
 
 maintainers:
-  - Tudor Ambarus <tudor.ambarus@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..b13e67bed48e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13418,7 +13418,7 @@ F:	arch/microblaze/
 
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -13464,7 +13464,7 @@ F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 F:	drivers/media/platform/atmel/microchip-csi2dc.c
 
 MICROCHIP ECC DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
@@ -13559,7 +13559,7 @@ S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
 MICROCHIP NAND DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -13611,7 +13611,7 @@ S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 MICROCHIP SPI DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
@@ -19402,7 +19402,7 @@ F:	drivers/clk/spear/
 F:	drivers/pinctrl/spear/
 
 SPI NOR SUBSYSTEM
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 M:	Pratyush Yadav <pratyush@kernel.org>
 R:	Michael Walle <michael@walle.cc>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 82bf15d49561..dd7b561c4256 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -3,7 +3,7 @@
  * Microchip / Atmel ECC (I2C) driver.
  *
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #include <linux/delay.h>
@@ -411,6 +411,6 @@ static void __exit atmel_ecc_exit(void)
 module_init(atmel_ecc_init);
 module_exit(atmel_ecc_exit);
 
-MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
+MODULE_AUTHOR("Tudor Ambarus");
 MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 81ce09bedda8..55bff1e13142 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -3,7 +3,7 @@
  * Microchip / Atmel ECC (I2C) driver.
  *
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #include <linux/bitrev.h>
@@ -390,6 +390,6 @@ static void __exit atmel_i2c_exit(void)
 module_init(atmel_i2c_init);
 module_exit(atmel_i2c_exit);
 
-MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
+MODULE_AUTHOR("Tudor Ambarus");
 MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 48929efe2a5b..35f7857a7f7c 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017, Microchip Technology Inc.
- * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
+ * Author: Tudor Ambarus
  */
 
 #ifndef __ATMEL_I2C_H__
-- 
2.25.1

