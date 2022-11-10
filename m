Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FC624AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKJTaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKJT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:29:59 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594292C113;
        Thu, 10 Nov 2022 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1668108598; x=1699644598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BdtJ+jq12ZYImS0lAnLPF8RUp/DP2w7e41M3o8ldH1Y=;
  b=Ljt6nGuIm/PWMRDpezb+BOxT8Uy+bncmXgtMTWenikXfjwMcWkTuKNCs
   41OrUvSviictu9PCqFPRv0nIAUoHw1nPpntyRW9RhISYKEGlCO9e3lxNC
   QpNfYd+xU3P9xB4/j6a/xlM2df437Mn03ORGEKVT5LAJmaOF1ujat9OhI
   s=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:29:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 57B2282BC9;
        Thu, 10 Nov 2022 19:29:56 +0000 (UTC)
Received: from EX19D035UWB004.ant.amazon.com (10.13.138.104) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 10 Nov 2022 19:29:54 +0000
Received: from dev-dsk-grecojay-2b-e6934ae5.us-west-2.amazon.com
 (10.43.161.14) by EX19D035UWB004.ant.amazon.com (10.13.138.104) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20; Thu, 10 Nov 2022
 19:29:54 +0000
From:   Jay Greco <grecojay@amazon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jorcrous@amazon.com>, Jay Greco <grecojay@amazon.com>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iio: imu: inv_icm42600: Add support for icm42631
Date:   Thu, 10 Nov 2022 19:29:32 +0000
Message-ID: <20221110192933.13616-2-grecojay@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221110192933.13616-1-grecojay@amazon.com>
References: <20221110192933.13616-1-grecojay@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.14]
X-ClientProxiedBy: EX13D17UWB004.ant.amazon.com (10.43.161.132) To
 EX19D035UWB004.ant.amazon.com (10.13.138.104)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required WHOAMI and device_id definitions to support the
icm42631.

Signed-off-by: Jay Greco <grecojay@amazon.com>
---

(no changes since v1)

 drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3d91469beccb..0e290c807b0f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -22,6 +22,7 @@ enum inv_icm42600_chip {
 	INV_CHIP_ICM42602,
 	INV_CHIP_ICM42605,
 	INV_CHIP_ICM42622,
+	INV_CHIP_ICM42631,
 	INV_CHIP_NB,
 };
 
@@ -303,6 +304,7 @@ struct inv_icm42600_state {
 #define INV_ICM42600_WHOAMI_ICM42602			0x41
 #define INV_ICM42600_WHOAMI_ICM42605			0x42
 #define INV_ICM42600_WHOAMI_ICM42622			0x46
+#define INV_ICM42600_WHOAMI_ICM42631			0x5C
 
 /* User bank 1 (MSB 0x10) */
 #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..12952739f749 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -87,6 +87,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 		.name = "icm42622",
 		.conf = &inv_icm42600_default_conf,
 	},
+	[INV_CHIP_ICM42631] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42631,
+		.name = "icm42631",
+		.conf = &inv_icm42600_default_conf,
+	},
 };
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index d4a692b838d0..38c36a655167 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -84,6 +84,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42631",
+		.data = (void *)INV_CHIP_ICM42631,
 	},
 	{}
 };
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index e6305e5fa975..6a85c12d38bd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -80,6 +80,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42631",
+		.data = (void *)INV_CHIP_ICM42631,
 	},
 	{}
 };
-- 
2.37.1

