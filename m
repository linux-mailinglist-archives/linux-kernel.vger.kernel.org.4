Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9A67DDEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjA0Glu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjA0GkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DED6FD0E;
        Thu, 26 Jan 2023 22:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DiojTRVADjloLtCWTL6Dc10HXLEb/5V358TXJC1Ce0Y=; b=yVc6FwwzyRbpGnojVUB6ikNT2t
        PaWonwmLT0s6IeOa8+wajg2PZbEhgf8fbm6MbRbDKW4JeDQwCZXswMR5Ic0OImqx6Z9Q0h2kA8rxG
        qiEadZYv1/Hm1o+OdxfohmSf40/nhMmtqUh5BTxKn8CHjOaB+MMIEFdBLAirkOazcychLN6kVC3J+
        LbiR1ygSsyDfbaJWgARFea5sggipYgOxWkpDGedJ8Y/jPKsfeUvbgClrkSFTFGuqmtzGvpW7vdxzj
        PwYQT9fRt1Iz1CBPxJ8jnU2KJA7DCKSQ/t3tAP3y6Uw0hCpbJXOKjn1T8G2ZklpfXP67vWHT/axXj
        i3401Tbw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPO-00DM0u-N2; Fri, 27 Jan 2023 06:40:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 27/35] Documentation: spi: correct spelling
Date:   Thu, 26 Jan 2023 22:39:57 -0800
Message-Id: <20230127064005.1558-28-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/spi/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/spi/pxa2xx.rst      |   12 ++++++------
 Documentation/spi/spi-lm70llp.rst |    2 +-
 Documentation/spi/spi-summary.rst |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff -- a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -141,15 +141,15 @@ field. Below is a sample configuration u
 ::
 
   static struct pxa2xx_spi_chip cs8415a_chip_info = {
-	.tx_threshold = 8, /* SSP hardward FIFO threshold */
-	.rx_threshold = 8, /* SSP hardward FIFO threshold */
+	.tx_threshold = 8, /* SSP hardware FIFO threshold */
+	.rx_threshold = 8, /* SSP hardware FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
   };
 
   static struct pxa2xx_spi_chip cs8405a_chip_info = {
-	.tx_threshold = 8, /* SSP hardward FIFO threshold */
-	.rx_threshold = 8, /* SSP hardward FIFO threshold */
+	.tx_threshold = 8, /* SSP hardware FIFO threshold */
+	.rx_threshold = 8, /* SSP hardware FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
   };
@@ -157,7 +157,7 @@ field. Below is a sample configuration u
   static struct spi_board_info streetracer_spi_board_info[] __initdata = {
 	{
 		.modalias = "cs8415a", /* Name of spi_driver for this device */
-		.max_speed_hz = 3686400, /* Run SSP as fast a possbile */
+		.max_speed_hz = 3686400, /* Run SSP as fast a possible */
 		.bus_num = 2, /* Framework bus number */
 		.chip_select = 0, /* Framework chip select */
 		.platform_data = NULL; /* No spi_driver specific config */
@@ -166,7 +166,7 @@ field. Below is a sample configuration u
 	},
 	{
 		.modalias = "cs8405a", /* Name of spi_driver for this device */
-		.max_speed_hz = 3686400, /* Run SSP as fast a possbile */
+		.max_speed_hz = 3686400, /* Run SSP as fast a possible */
 		.bus_num = 2, /* Framework bus number */
 		.chip_select = 1, /* Framework chip select */
 		.controller_data = &cs8405a_chip_info, /* Master chip config */
diff -- a/Documentation/spi/spi-lm70llp.rst b/Documentation/spi/spi-lm70llp.rst
--- a/Documentation/spi/spi-lm70llp.rst
+++ b/Documentation/spi/spi-lm70llp.rst
@@ -57,7 +57,7 @@ devices might share the same SI/SO pin.
 The bitbanger routine in this driver (lm70_txrx) is called back from
 the bound "hwmon/lm70" protocol driver through its sysfs hook, using a
 spi_write_then_read() call.  It performs Mode 0 (SPI/Microwire) bitbanging.
-The lm70 driver then inteprets the resulting digital temperature value
+The lm70 driver then interprets the resulting digital temperature value
 and exports it through sysfs.
 
 A "gotcha": National Semiconductor's LM70 LLP eval board circuit schematic
diff -- a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -105,7 +105,7 @@ find isn't necessarily helpful.  The fou
  - CPHA indicates the clock phase used to sample data; CPHA=0 says
    sample on the leading edge, CPHA=1 means the trailing edge.
 
-   Since the signal needs to stablize before it's sampled, CPHA=0
+   Since the signal needs to stabilize before it's sampled, CPHA=0
    implies that its data is written half a clock before the first
    clock edge.  The chipselect may have made it become available.
 
