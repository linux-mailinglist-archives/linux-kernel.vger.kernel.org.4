Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BCD619E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiKDRRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiKDRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:16:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC883E09D;
        Fri,  4 Nov 2022 10:16:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v17so5500464plo.1;
        Fri, 04 Nov 2022 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0ErP+orkk4G4ShNSRoAumyTCOdV2yHLSVRR3eTBZqY=;
        b=pnM3I45GlSkO+51EPfO/sMnc4irB4Km6/IANDutMalaLXhM0IbxCwbXK1vNBWmD4Cx
         IaEbe+6qSuyiP+ff+zgSY7A2g6unUQt2J3/kHEciXxbQvFNkLY7qKNeBSfS42DU/Gzm8
         4/hOoI/3YQwf2XbCC5lPNk65PRLQESclwUb5kQeFA2K0dIUhLRQeeAl4oExZrO5jwfSo
         fJd73x2t2uAjgAT0X88cufrQbA+2qnKVn1SqECkojZfFmMtqn3tEc843RIY8b8WgK00r
         BuY+JKPIaY09w6d4/iMfLl99dklAQ4QKx7a6htaodAdv8DjWmfSxoCErE4l28o1XN0sU
         ZtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0ErP+orkk4G4ShNSRoAumyTCOdV2yHLSVRR3eTBZqY=;
        b=pjbhcPRfoak/KUVrwcC6pJp9HzxEFQeZqxbKDGGtzrUryzsHRNFvIANjU3xsBxH4ez
         X5s+4sDCJF/eCrnrTxYf+mE2Ncrbp+IP40EvhMnU803ePfeE+rcsloAiocsGUi4Pnxpd
         8gJyCcL4s6rOr1eBopcDuJVVB45AK4Zs1sffvAWTISer0L80iQP5A86QOiwnCxxt6FFy
         odbmL7Ft1V7R+LlAZBLYEir+IuqK08MFNxQV4RB/GvC4GL1SM9TrkPNLa1MKRsqOPliB
         NNFrl0wcgdDfIXt93YaaOvxSq/incJStLPV9AfSQ+zmjwA15xYF/GzhJd806eBpuX26S
         kKJQ==
X-Gm-Message-State: ACrzQf04cyEkWTMVqy5BXZ7VAZ3CpKomwLfSvBuxiF/Z/zMnhjaVEuKG
        IGlVUsapz73mM/BvMTVwodpDvZR8No4=
X-Google-Smtp-Source: AMsMyM7hdEM7xNTxTC+b/SLA3tmCuWd+pXY/ru1M14fvtoxF7YucqgvNa7u/+yapLO6Ua1M7ev1b+w==
X-Received: by 2002:a17:903:2308:b0:186:f608:c509 with SMTP id d8-20020a170903230800b00186f608c509mr36996999plh.154.1667582204511;
        Fri, 04 Nov 2022 10:16:44 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a450f00b00212c27abcaesm1917655pjg.17.2022.11.04.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:16:44 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 3/3] can: etas_es58x: report the firmware version through ethtool
Date:   Sat,  5 Nov 2022 02:16:04 +0900
Message-Id: <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ES58x devices report below information in their usb product info
string:

  * the firmware version
  * the bootloader version
  * the hardware revision

Report the firmware version through ethtool_drvinfo::fw_version.
Because struct ethtool_drvinfo has no fields to report the boatloader
version nor the hardware revision, continue to print these in the
kernel log (c.f. es58x_get_product_info()).

While doing so, bump up copyright year of each modified files.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es581_4.c    |  5 ++-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 42 ++++++++++++++++++++-
 drivers/net/can/usb/etas_es58x/es58x_core.h |  5 ++-
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  5 ++-
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 1bcdcece5ec7..29c03c8b3f07 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/kernel.h>
@@ -492,7 +492,8 @@ const struct es58x_parameters es581_4_param = {
 	.tx_bulk_max = ES581_4_TX_BULK_MAX,
 	.urb_cmd_header_len = ES581_4_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-	.tx_urb_max = ES58X_TX_URBS_MAX
+	.tx_urb_max = ES58X_TX_URBS_MAX,
+	.prod_info_delim = ',',
 };
 
 const struct es58x_operators es581_4_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 1a17aadfc1dc..72a60f5f92c8 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/ethtool.h>
@@ -1978,7 +1978,47 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
+/**
+ * es58x_get_drvinfo() - Get the driver name and firmware version.
+ * @netdev: CAN network device.
+ * @drvinfo: Driver information.
+ *
+ * Populate @drvinfo with the driver name and the firmware version.
+ */
+static void es58x_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
+	char *prod_info, *start, *end;
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+
+	prod_info = usb_cache_string(es58x_dev->udev, ES58X_PROD_INFO_IDX);
+	if (!prod_info)
+		return;
+
+	/* The firmware prefix is either "FW_V" or "FW:" */
+	start = strstr(prod_info, "FW");
+	if (!start)
+		goto free_prod_info;
+	/* Go to first digit */
+	while (!isdigit(*start)) {
+		start++;
+		if (!*start)
+			goto free_prod_info;
+	}
+	end = strchr(start, es58x_dev->param->prod_info_delim);
+	if (!end || end - start >= sizeof(drvinfo->fw_version))
+		goto free_prod_info;
+
+	strncpy(drvinfo->fw_version, start, end - start);
+
+ free_prod_info:
+	kfree(prod_info);
+}
+
 static const struct ethtool_ops es58x_ethtool_ops = {
+	.get_drvinfo = es58x_get_drvinfo,
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 9a5a616df783..9c2cdb57f34a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef __ES58X_COMMON_H__
@@ -309,6 +309,8 @@ struct es58x_priv {
  * @urb_cmd_header_len: Length of the URB command header.
  * @rx_urb_max: Number of RX URB to be allocated during device probe.
  * @tx_urb_max: Number of TX URB to be allocated during device probe.
+ * @prod_info_delim: delimiter of the different fields in the USB
+ *	product information string.
  */
 struct es58x_parameters {
 	const struct can_bittiming_const *bittiming_const;
@@ -327,6 +329,7 @@ struct es58x_parameters {
 	u8 urb_cmd_header_len;
 	u8 rx_urb_max;
 	u8 tx_urb_max;
+	char prod_info_delim;
 };
 
 /**
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index c97ffa71fd75..aa7a4866f870 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -8,7 +8,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/kernel.h>
@@ -550,7 +550,8 @@ const struct es58x_parameters es58x_fd_param = {
 	.tx_bulk_max = ES58X_FD_TX_BULK_MAX,
 	.urb_cmd_header_len = ES58X_FD_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-	.tx_urb_max = ES58X_TX_URBS_MAX
+	.tx_urb_max = ES58X_TX_URBS_MAX,
+	.prod_info_delim = '-',
 };
 
 const struct es58x_operators es58x_fd_ops = {
-- 
2.37.4

