Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A319C608030
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJUUsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJUUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:48:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1110325B;
        Fri, 21 Oct 2022 13:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88EF0B82C93;
        Fri, 21 Oct 2022 20:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB98C433D6;
        Fri, 21 Oct 2022 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385284;
        bh=sImKum7oEep3cYmCOrO6DWellkWXtDPSgIr68K6eOxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OalA7aIicYy8W0nbbsU27atvDiby6ElCY+ahuGe6DUFLyXQjmLa8OBZq6Mqbsks2G
         8lp9dPSUbz8wSnzIJrKP7eadoM4O6Cqcgj5FORXm235eZd1X3CUGPPDeS+rK4OuWiO
         s07h+L/qKZw0TIKn4v9D/DkLOQ5Z1cbHydcW7wI2bsTej0kvgtT6Qa9Fv204w7rpIT
         LclcXaCMdxg5Tc5e4zb31bDlSduzNqoaiJZiQnMJW1eg9nXn3ak2jU9DnpHgcNqXFt
         iPQ1Y2uutrzp5PMPauFz3uVS5c7+aYRcEMoQQv0XJ3+o05uSnZ6kFwAFIDmBVhKQKk
         6VB8daL94vM7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 13/21] usb: gadget: remove s3c24xx drivers
Date:   Fri, 21 Oct 2022 22:27:46 +0200
Message-Id: <20221021203329.4143397-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The s3c24xx platform is gone, so both the udc and hsudc drivers
can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig                |   25 -
 drivers/usb/gadget/udc/Makefile               |    2 -
 drivers/usb/gadget/udc/s3c-hsudc.c            | 1319 -----------
 drivers/usb/gadget/udc/s3c2410_udc.c          | 1980 -----------------
 drivers/usb/gadget/udc/s3c2410_udc.h          |   99 -
 drivers/usb/gadget/udc/s3c2410_udc_regs.h     |  146 --
 include/linux/platform_data/s3c-hsudc.h       |   33 -
 include/linux/platform_data/usb-s3c2410_udc.h |   33 -
 8 files changed, 3637 deletions(-)
 delete mode 100644 drivers/usb/gadget/udc/s3c-hsudc.c
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc.c
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc.h
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc_regs.h
 delete mode 100644 include/linux/platform_data/s3c-hsudc.h
 delete mode 100644 include/linux/platform_data/usb-s3c2410_udc.h

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 82fe0c72b496..a96163f70a8c 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -218,31 +218,6 @@ config USB_PXA27X
 	   dynamically linked module called "pxa27x_udc" and force all
 	   gadget drivers to also be dynamically linked.
 
-config USB_S3C2410
-	tristate "S3C2410 USB Device Controller"
-	depends on ARCH_S3C24XX
-	help
-	  Samsung's S3C2410 is an ARM-4 processor with an integrated
-	  full speed USB 1.1 device controller.  It has 4 configurable
-	  endpoints, as well as endpoint zero (for control transfers).
-
-	  This driver has been tested on the S3C2410, S3C2412, and
-	  S3C2440 processors.
-
-config USB_S3C2410_DEBUG
-	bool "S3C2410 udc debug messages"
-	depends on USB_S3C2410
-
-config USB_S3C_HSUDC
-	tristate "S3C2416, S3C2443 and S3C2450 USB Device Controller"
-	depends on ARCH_S3C24XX
-	help
-	  Samsung's S3C2416, S3C2443 and S3C2450 is an ARM9 based SoC
-	  integrated with dual speed USB 2.0 device controller. It has
-	  8 endpoints, as well as endpoint zero.
-
-	  This driver has been tested on S3C2416 and S3C2450 processors.
-
 config USB_MV_UDC
 	tristate "Marvell USB2.0 Device Controller"
 	depends on HAS_DMA
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 12f9e4c9eb0c..a05db5ea376c 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_USB_PXA25X)	+= pxa25x_udc.o
 obj-$(CONFIG_USB_PXA27X)	+= pxa27x_udc.o
 obj-$(CONFIG_USB_GOKU)		+= goku_udc.o
 obj-$(CONFIG_USB_OMAP)		+= omap_udc.o
-obj-$(CONFIG_USB_S3C2410)	+= s3c2410_udc.o
 obj-$(CONFIG_USB_AT91)		+= at91_udc.o
 obj-$(CONFIG_USB_ATMEL_USBA)	+= atmel_usba_udc.o
 obj-$(CONFIG_USB_BCM63XX_UDC)	+= bcm63xx_udc.o
@@ -28,7 +27,6 @@ obj-$(CONFIG_USB_M66592)	+= m66592-udc.o
 obj-$(CONFIG_USB_R8A66597)	+= r8a66597-udc.o
 obj-$(CONFIG_USB_RENESAS_USB3)	+= renesas_usb3.o
 obj-$(CONFIG_USB_FSL_QE)	+= fsl_qe_udc.o
-obj-$(CONFIG_USB_S3C_HSUDC)	+= s3c-hsudc.o
 obj-$(CONFIG_USB_LPC32XX)	+= lpc32xx_udc.o
 obj-$(CONFIG_USB_EG20T)		+= pch_udc.o
 obj-$(CONFIG_USB_MV_UDC)	+= mv_udc.o
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
deleted file mode 100644
index 4b7eb7701470..000000000000
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
deleted file mode 100644
index 8c57b191e52b..000000000000
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.h b/drivers/usb/gadget/udc/s3c2410_udc.h
deleted file mode 100644
index cdbf202e5ee8..000000000000
diff --git a/drivers/usb/gadget/udc/s3c2410_udc_regs.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
deleted file mode 100644
index d8d2eeaca088..000000000000
diff --git a/include/linux/platform_data/s3c-hsudc.h b/include/linux/platform_data/s3c-hsudc.h
deleted file mode 100644
index a170939832d5..000000000000
diff --git a/include/linux/platform_data/usb-s3c2410_udc.h b/include/linux/platform_data/usb-s3c2410_udc.h
deleted file mode 100644
index c0fbe1fe3426..000000000000
-- 
2.29.2

