Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6F706106
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEQHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjEQHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:21:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B9A1732;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so11142166b3a.0;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684308107; x=1686900107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B80vxek7q2HaGO3rtU2rvfPIEl0u9nEFM+DmH0FlT7A=;
        b=BCTIKCWw/6osJVCCc1OAl1LNgJJ0rYN/2Pwsr2AzB4rb1mH5o9IrOXnj+DkkRwpExP
         tYjXZnFEHxG+N1JU+JFwRFPTFMBi8IdwxoXFlqi2y2mR6RFSm+Su/R7J/iUR2tlcTyzE
         R2HO68txi5urFGeCTyOH+PWf9q9sjSxeJ+v8AjDSljQauv7Gc7+ZtO4Zx3Z1W/Z/xL9k
         SHRbXPXVbLiCU+Xa6rI+him12Gbgml58w06OlAW02XSodsL4VZwx1/O6Fs4hwSwaK3tg
         8tJRvFEA6Rq2wyfaHyY8sNtvHF4DL/VqCpiC+oSPuKWicUaRD9RpHQRiCulins/ZysG7
         rNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308107; x=1686900107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B80vxek7q2HaGO3rtU2rvfPIEl0u9nEFM+DmH0FlT7A=;
        b=kCxmsHhOq43LKdz2R9xxxauRmEG5MXIsPO0mbUcFb4MGP9ISojuf6SGkxhSVuJxS/1
         ji1NxBA7kQYv0i/sz2/xL8OK1fT4wtLp+X/7XCRHBcPxvMRREYij9rav3IU1yILA3Rhz
         qwRr1k+8eUwSHRZW120tuox3msPLuNulF2Uboo7a7u19/bC1NxHkF2itD4IRZwjPJY+I
         G0sIAinblV8cghTnKSmRt8asxbJRV/b+Xj6EyH7JQB3/rElQsWgA932fDM4sVFNeN5HR
         3lTMIXxEyFAmV3xvOSbLajSpF1H9RgIEEQEVnY9N+q02dzXFQHj7oSb5dSipXcCUGTrw
         hsxQ==
X-Gm-Message-State: AC+VfDzFf2xvq+GwSJaLzpGW5pfNX/YPIoqhO2LeA1OBPtIaiFQU3jv0
        1S/yMN1NXOT+URFpbF/hiuk=
X-Google-Smtp-Source: ACHHUZ5uoSgP/3C0+44Zc8PKo5zrYjUd3iVC6tKwLcOk9hz/so++B/lXhbdJdSrWvN7PSAbkQG9MZA==
X-Received: by 2002:a05:6a21:339a:b0:103:b436:aef7 with SMTP id yy26-20020a056a21339a00b00103b436aef7mr1552935pzb.16.1684308106947;
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id t23-20020a63f357000000b0051f15beba7fsm14529187pgj.67.2023.05.17.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4C19F10627D; Wed, 17 May 2023 14:21:42 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Watchdog Drivers <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ray Lehtiniemi <rayl@mail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Marc Zyngier <maz@kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Sylver Bruneau <sylver.bruneau@googlemail.com>,
        Denis Turischev <denis@compulab.co.il>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 1/2] watchdog: Convert GPL 2.0 notice to SPDX identifier
Date:   Wed, 17 May 2023 14:21:39 +0700
Message-Id: <20230517072140.1086660-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517072140.1086660-1-bagasdotme@gmail.com>
References: <20230517072140.1086660-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7818; i=bagasdotme@gmail.com; h=from:subject; bh=RcIPU9fALev8yCBA1JpNRSVpQA5ngX+nU0c7ueRx6AY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpDc1vrf487Im80VSdqGP1KUC/IPS7VKoB2/fLa6Rui FQdMUvuKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwERmdzIyfJ9l/Dig/lZURtn0 9Zk3Vvfvsf+zOYDpp5UYd8b/2Q2Rmxn+Wd2JnqyrxdPk9zvr9ef9YR6HftzbPXHVt8cL/zV3GG+ fwgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the boilerplate to SPDX license identifier. While at it, also
move SPDX identifier for drivers/watchdog/rtd119x_wdt.c to the top of
file (as in other files).

Cc: Ray Lehtiniemi <rayl@mail.com>,
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Deepak Saxena <dsaxena@plexity.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>
Cc: Denis Turischev <denis@compulab.co.il>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/watchdog/ep93xx_wdt.c     | 5 +----
 drivers/watchdog/m54xx_wdt.c      | 4 +---
 drivers/watchdog/max63xx_wdt.c    | 5 +----
 drivers/watchdog/moxart_wdt.c     | 4 +---
 drivers/watchdog/octeon-wdt-nmi.S | 5 +----
 drivers/watchdog/orion_wdt.c      | 4 +---
 drivers/watchdog/rtd119x_wdt.c    | 2 +-
 drivers/watchdog/sbc_fitpc2_wdt.c | 4 +---
 drivers/watchdog/ts4800_wdt.c     | 4 +---
 drivers/watchdog/ts72xx_wdt.c     | 4 +---
 10 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 38e26f160b9a57..59dfd7f6bf0ba1 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Watchdog driver for Cirrus Logic EP93xx family of devices.
  *
@@ -11,10 +12,6 @@
  * Copyright (c) 2012 H Hartley Sweeten <hsweeten@visionengravers.com>
  *	Convert to a platform device and use the watchdog framework API
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This watchdog fires after 250msec, which is a too short interval
  * for us to rely on the user space daemon alone. So we ping the
  * wdt each ~200msec and eventually stop doing it if the user space
diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index f388a769dbd33d..062ea3e6497e52 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * drivers/watchdog/m54xx_wdt.c
  *
@@ -11,9 +12,6 @@
  *  Copyright 2004 (c) MontaVista, Software, Inc.
  *  Based on sa1100 driver, Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
  *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e1541cfae0d89..21935f9620e463 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * drivers/char/watchdog/max63xx_wdt.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This driver assumes the watchdog pins are memory mapped (as it is
  * the case for the Arcom Zeus). Should it be connected over GPIOs or
  * another interface, some abstraction will have to be introduced.
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 6340a1f5f471b2..b7b1da3c932ded 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * MOXA ART SoCs watchdog driver.
  *
@@ -5,9 +6,6 @@
  *
  * Jonas Jensen <jonas.jensen@gmail.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/octeon-wdt-nmi.S b/drivers/watchdog/octeon-wdt-nmi.S
index 97f6eb7b5a8e04..e308cc74392018 100644
--- a/drivers/watchdog/octeon-wdt-nmi.S
+++ b/drivers/watchdog/octeon-wdt-nmi.S
@@ -1,8 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2007-2017 Cavium, Inc.
  */
 #include <asm/asm.h>
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 5ec2dd8fd5fa3d..1fe583e8a95b2e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * drivers/watchdog/orion_wdt.c
  *
@@ -5,9 +6,6 @@
  *
  * Author: Sylver Bruneau <sylver.bruneau@googlemail.com>
  *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 95c8d7abce42e6..984905695dde51 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Realtek RTD129x watchdog
  *
  * Copyright (c) 2017 Andreas Färber
  *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index 13db71e165836e..b8eb8d5ca1af0c 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Watchdog driver for SBC-FITPC2 board
  *
@@ -5,9 +6,6 @@
  *
  * Adapted from the IXP2000 watchdog driver by Deepak Saxena.
  *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME " WATCHDOG: " fmt
diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 0ea554c7cda579..0099403f49922f 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Watchdog driver for TS-4800 based boards
  *
  * Copyright (c) 2015 - Savoir-faire Linux
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index bf918f5fa13175..3d57670befe1ce 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Watchdog driver for Technologic Systems TS-72xx based SBCs
  * (TS-7200, TS-7250 and TS-7260). These boards have external
@@ -8,9 +9,6 @@
  *
  * This driver is based on ep93xx_wdt and wm831x_wdt drivers.
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/platform_device.h>
-- 
An old man doll... just what I always wanted! - Clara

