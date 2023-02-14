Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299C695937
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjBNGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBNGd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:33:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72CC1CAE0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:33:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gd1so3392582pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCGvXOUXhTk4TJX5okZQgwZJzPVMDC7JhiQGwdoouwk=;
        b=ITZn0ZFl5Q+su+hmWuJoIE4xlZAMa44PkeUh6KDU1/NQWakSQL15ZAWkWyqxIM4bGH
         vLvh+euhywOZ8xFb7SuvwwSrO3DAAft7Lq2cgXn9kO6ewq9UQr3U+FHKYECi68CX6ESV
         5ufe62mHJsvUPsKX5QOGUyJVoYoDTsq0vTRmUM8LYW9DPirxzG2j/Ibb5zBei/qQ2nSv
         maUcfktus26rlD5LgFHVq008uqKBmPVejjnHDTEPin4dKRMo+o5oUGxMxzkdDAgBiLGw
         gqzQMLqRjqft0uZfjjAQZlxt0V2YxBXbtEixW+CNP4mSCROKxua8yLPyie4n4tJYTEU/
         MSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCGvXOUXhTk4TJX5okZQgwZJzPVMDC7JhiQGwdoouwk=;
        b=v+xjI1YmNytTIiR2su6NGd3si6jsrGZS8kpxsR0slv2QchtingpB1P8qsm2//mU/Pi
         6pEoro7xIIIbAWRT9WdvFROV4tkU6xf6RDNdYTgIgyM55lCBrnmtN9hewH3BiJzvswTv
         ADxZAhjMcf759kiiDkyfYtX5ePXh7orR9EdajV72Wiyh3tyHR6MVLL7oyFk0vLplk46F
         DPk0C6X7o/YoWjq2Z72EgUeb84rn9K+ERaaTxPrshIWOi9f+KrgvBzCi7U2ysBRB2Rh8
         dtVgSxh4iH5oZzJOXaKvkZzjRhaLRujiY/RNfa8p802AaPB5oZF0EvIjI6ee0MpymNnx
         qurQ==
X-Gm-Message-State: AO0yUKV+9424x1Ijrzg+pzXyMaf2QMgSP5DxRIczeWQDWTP7f+sZiI1c
        h0yeE17Ymzz66fouAhK8BEehEsHaRQM=
X-Google-Smtp-Source: AK7set+195CNjHz66V/yBSmSIksZQ3I+sDnUBDdZkybAI1Kql/Tm8zC/6Jhq+imb+q2sH6VcZmSbNA==
X-Received: by 2002:a05:6a20:7f87:b0:c1:1564:f661 with SMTP id d7-20020a056a207f8700b000c11564f661mr1689698pzj.37.1676356431263;
        Mon, 13 Feb 2023 22:33:51 -0800 (PST)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78e11000000b005813f365afcsm7431869pfr.189.2023.02.13.22.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:33:50 -0800 (PST)
Date:   Tue, 14 Feb 2023 17:33:46 +1100
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: change (struct pi433_tx_cfg)->bit_rate to be
 a u32
Message-ID: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the TODO file and datasheet of pi433, the maximum bit rate for
transmitter is 300kbps when modulation been set to FSK. Hence, the size
should be u32 rather than u16.

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 drivers/staging/pi433/Documentation/pi433.txt | 3 ++-
 drivers/staging/pi433/pi433_if.h              | 2 +-
 drivers/staging/pi433/rf69.c                  | 4 ++--
 drivers/staging/pi433/rf69.h                  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 4a0d34b4ad37..b34d8e9f6d53 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -78,7 +78,8 @@ rf params:
 		Allowed values: 433050000...434790000
 	bit_rate
 		bit rate used for transmission.
-		Allowed values: #####
+		Allowed values when FSK: 1200...300000
+		Allowed values when OOK: 1200...32768
 	dev_frequency
 		frequency deviation in case of FSK.
 		Allowed values: 600...500000
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 25ee0b77a32c..1f8ffaf02d99 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -51,7 +51,7 @@ enum option_on_off {
 #define PI433_TX_CFG_IOCTL_NR	0
 struct pi433_tx_cfg {
 	__u32			frequency;
-	__u16			bit_rate;
+	__u32			bit_rate;
 	__u32			dev_frequency;
 	enum modulation		modulation;
 	enum mod_shaping	mod_shaping;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..0b90ca004dd6 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -185,7 +185,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 	}
 }
 
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
 {
 	int retval;
 	u32 bit_rate_reg;
@@ -201,7 +201,7 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
 	}
 
 	// check input value
-	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
+	if (bit_rate < 1200 || bit_rate > 300000 || (mod == OOK && bit_rate > 32768)) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param\n");
 		return -EINVAL;
 	}
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 78fa0b8bab8b..46a1fb2d5329 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -24,7 +24,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
 int rf69_set_modulation_shaping(struct spi_device *spi,
 				enum mod_shaping mod_shaping);
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
 int rf69_set_deviation(struct spi_device *spi, u32 deviation);
 int rf69_set_frequency(struct spi_device *spi, u32 frequency);
 int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
-- 
2.34.1

