Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB895B4F57
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIKODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIKODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807CE3340C;
        Sun, 11 Sep 2022 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B58C9B80B55;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405ABC433B5;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=k9SpcPU5DzUUP01/cKJ1szMTaQhD2tLr4OvnVCKvrMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vtz1d4VXTN2xj+RhI0AYuygL6SK2bDDdtZnl1cBkoOvq27mb+kWuldMXDpzjjLqtN
         LmSqSXOBOB5L1TpdByMSGBrCZ6tKvi7nZZZtDr5r0PvBtVv8ip53DdYlQOJeMJSpmk
         dsbYKBbyhqYrcCXSKF0K7s7Vh+gYN20DcYSmgyhHTfzCFWah3rGc7amcO6VHK7dzms
         hZdzeRb9G5l5NlQ9oSVZ8Au8bGtu6CoZlo70/DCx8ZfSn5TxOS1lGsjIqN80OqSieZ
         68GIKbFcKfzPBNLCFNpx6cMJpBqEQDtuxGlH6NnGtqi0aPITfuBvxGaXRixZPzd+bn
         McxYuTmTj+WdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wa-JZ; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] USB: serial: ftdi_sio: drop redundant chip type comments
Date:   Sun, 11 Sep 2022 16:02:06 +0200
Message-Id: <20220911140216.30481-3-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop redundant chip type comments.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3757931284cb..4b432707d75b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -61,7 +61,6 @@ enum ftdi_chip_type {
 
 struct ftdi_private {
 	enum ftdi_chip_type chip_type;
-				/* type of device, either SIO or FT8U232AM */
 	int baud_base;		/* baud base clock for divisor setting */
 	int custom_divisor;	/* custom_divisor kludge, this is for
 				   baud_base (different from what goes to the
@@ -1318,7 +1317,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	if (!baud)
 		baud = 9600;
 	switch (priv->chip_type) {
-	case SIO: /* SIO chip */
+	case SIO:
 		switch (baud) {
 		case 300: div_value = ftdi_sio_b300; break;
 		case 600: div_value = ftdi_sio_b600; break;
@@ -1339,7 +1338,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_okay = 0;
 		}
 		break;
-	case FT8U232AM: /* 8U232AM chip */
+	case FT8U232AM:
 		if (baud <= 3000000) {
 			div_value = ftdi_232am_baud_to_divisor(baud);
 		} else {
@@ -1349,10 +1348,10 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			div_okay = 0;
 		}
 		break;
-	case FT232BM: /* FT232BM chip */
-	case FT2232C: /* FT2232C chip */
-	case FT232RL: /* FT232RL chip */
-	case FTX:     /* FT-X series */
+	case FT232BM:
+	case FT2232C:
+	case FT232RL:
+	case FTX:
 		if (baud <= 3000000) {
 			u16 product_id = le16_to_cpu(
 				port->serial->dev->descriptor.idProduct);
@@ -1372,9 +1371,9 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			baud = 9600;
 		}
 		break;
-	case FT2232H: /* FT2232H chip */
-	case FT4232H: /* FT4232H chip */
-	case FT232H:  /* FT232H chip */
+	case FT2232H:
+	case FT4232H:
+	case FT232H:
 		if ((baud <= 12000000) && (baud >= 1200)) {
 			div_value = ftdi_2232h_baud_to_divisor(baud);
 		} else if (baud < 1200) {
@@ -1386,7 +1385,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			baud = 9600;
 		}
 		break;
-	} /* priv->chip_type */
+	}
 
 	if (div_okay) {
 		dev_dbg(dev, "%s - Baud rate set to %d (divisor 0x%lX) on chip %s\n",
-- 
2.35.1

