Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497F3729BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjFINkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbjFINkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:40:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE930E4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:40:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL4-00015d-Ra; Fri, 09 Jun 2023 15:39:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL2-006DQJ-Qu; Fri, 09 Jun 2023 15:39:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL2-00CbLD-4K; Fri, 09 Jun 2023 15:39:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v4 2/2] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
Date:   Fri,  9 Jun 2023 15:39:32 +0200
Message-Id: <20230609133932.786117-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
References: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zB+nREgR0ioXCxDriGCn0uNP6oRfU37lV4x5/oeQRjY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkgyuQzE4icrvDwcYxjDRmAz7VThTpOhibkaKy6 A4ADQdh51uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIMrkAAKCRCPgPtYfRL+ TlHyB/985ClvRZpO1/y6Zl5lPwWj9BtW+ksfgSKb4pUlTpvQ0ckxlpeGBDDHp7sGriIenr8/PgX a0ZbnoZH+dMVaaI0aY3oErMFsC1yM35DnhaEm/0+EptMWyETlN6FgW5tgYIONVj9johm+0KBfJr Y/2ASo6bEMXrJpki+R886L2DLVaakLY6No0nq5LqZ+SYE7M6nmEd1LVCMxPZ2DYW1b+u24qs8Gw x+HqUMHjhLki8/EfBt+qb+uv+EWT6U2tFZsmht954IEHLKAcAU+Ln/D/9tAqIywmydtiOGioKOj CTVa+T9fUStKa3b1jrHi7C8+5gv1ND/YZmaXupvyse1Aw5l3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need to handle the FSL variant of 8250 in a special way is also
present without console support. So soften the dependency for
SERIAL_8250_FSL from SERIAL_8250_CONSOLE to SERIAL_8250. To handle
SERIAL_8250=m, the FSL code can be modular, too, thus SERIAL_8250_FSL
becomes tristate.

Compiling 8250_fsl as a module requires adding a module license so this
is added, too. While add it also add a appropriate module description.

As then SERIAL_OF_PLATFORM=y + SERIAL_8250_FSL=m is a valid combination
(if COMPILE_TEST is enabled on a platform that is neither PPC, ARM nor
ARM64), the check in 8250_of.c must be weakened a bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_fsl.c | 3 +++
 drivers/tty/serial/8250/8250_of.c  | 2 +-
 drivers/tty/serial/8250/Kconfig    | 6 +++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 00f46b9a8b09..6af4e1c1210a 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -184,3 +184,6 @@ static struct platform_driver fsl8250_platform_driver = {
 
 module_platform_driver(fsl8250_platform_driver);
 #endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Handling of Freescale specific 8250 variants");
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index c9f6bd7a7038..51329625c48a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -177,7 +177,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		break;
 	}
 
-	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL) &&
+	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
 	    (of_device_is_compatible(np, "fsl,ns16550") ||
 	     of_device_is_compatible(np, "fsl,16550-FIFO64"))) {
 		port->handle_irq = fsl8250_handle_irq;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index cf33e858b0be..ee17cf5c44c6 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -379,9 +379,9 @@ config SERIAL_8250_BCM2835AUX
 	  If unsure, say N.
 
 config SERIAL_8250_FSL
-	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
-	depends on SERIAL_8250_CONSOLE
-	default PPC || ARM || ARM64
+	tristate "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
+	depends on SERIAL_8250
+	default SERIAL_8250 if PPC || ARM || ARM64
 	help
 	  Selecting this option enables a workaround for a break-detection
 	  erratum for Freescale 16550 UARTs in the 8250 driver. It also
-- 
2.39.2

