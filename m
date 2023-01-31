Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2700683569
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAaSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjAaSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:33:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB259246;
        Tue, 31 Jan 2023 10:32:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h12so15092182wrv.10;
        Tue, 31 Jan 2023 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTJjHKIf3m81orcF8fOiteQikppQvalOtFw6A66QW7g=;
        b=nhyG1nm/FdwYnxq3p6E0GJG9a1OBgynk8qIG0Nepp658hnBKUG0k9XIZFBW1Xaj2+z
         u2aBdKVQfxVUJ910sjy2D47bfbQF+Bm9n2WbOomlSOD/2X5kU5OnQEmH/G7saPhQ8J5t
         x+t/cB3t8SSOxjkMLFQV31jdlriRrsYLPTG/rf+3s6O/ONUhVBGgv4zKwqcTy0ZhJhab
         cSHI1YJhGC7FWIOdY76kNmDS5ROS5t54xSaZ0LrI49pxIjYEY/vgi1Wg0vAZ850tsOz0
         1HrzMRkilb3isawVxr7xH1unGcz73o4L9reAkeGCn0x8Z2BBDJj8ndgaoVQ6U6EwtSr3
         BJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTJjHKIf3m81orcF8fOiteQikppQvalOtFw6A66QW7g=;
        b=ycYu/sSwrzC0rb1uE1Wlh7KAHNvfUyPjWTVCT6D+HV2MSxV6JvhtGQ2izC1L8atI64
         dHPtKDbol6AMyT5sRNXQLZK40GAuv5aGRcoNNatBQDELldrmCBePAPN7gTxyK7XJ1ksm
         3XwQcqJthI3XSpHdyYwykIg5LjwjKA9I3JqY0WFs0Qr2k51Hakt1u9pmmnucQ4LRp9oV
         Lm5tuRWDGemOCSvnbM50qsz2BCWtaNXL8mI2+s0J8QIrTa5ZZJ/3K/o0njrl1FWdqLFW
         4mWwPPGinVUmeWPycYlZaTmrVsHDoZgtY+Aix70SKB4949QOqdqTYBz1UZky+su+YxGj
         PDjw==
X-Gm-Message-State: AO0yUKXzIZzIXWPz/firlHvRqzFVM1kDkEmmk0UfQQggijbhUqn0ULx9
        PC/oTnjxDc3ihBzs8nZ4EJE=
X-Google-Smtp-Source: AK7set/9hX7LZ1nfp1vGevDPPk+Y3He/Y8zSmxdY5rcQ8bq1P5TM/fBgPsMNRqw5AALsOAHEsPA4ww==
X-Received: by 2002:adf:ee4d:0:b0:2c2:6541:7afa with SMTP id w13-20020adfee4d000000b002c265417afamr3475859wro.57.1675189948708;
        Tue, 31 Jan 2023 10:32:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm17307311wrs.36.2023.01.31.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:32:28 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Date:   Tue, 31 Jan 2023 19:30:07 +0100
Message-Id: <20230131183008.4451-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131183008.4451-1-virag.david003@gmail.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S5M8763 MFD has no device tree compatible, and since board file
support for it was removed, there's no way to use this MFD. After
removing the remaining code for it from the MFD driver, also remove
support for it in the s5m RTC driver, and all remaining references to
it.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/rtc/rtc-s5m.c            | 82 ++------------------------------
 include/linux/mfd/samsung/core.h |  1 -
 include/linux/mfd/samsung/irq.h  | 50 -------------------
 3 files changed, 3 insertions(+), 130 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 4243fe6d3842..dad294a0ce2a 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -85,7 +85,7 @@ struct s5m_rtc_reg_config {
 	unsigned int write_alarm_udr_mask;
 };
 
-/* Register map for S5M8763 and S5M8767 */
+/* Register map for S5M8767 */
 static const struct s5m_rtc_reg_config s5m_rtc_regs = {
 	.regs_count		= 8,
 	.time			= S5M_RTC_SEC,
@@ -236,7 +236,6 @@ static int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
 
 	switch (info->device_type) {
 	case S5M8767X:
-	case S5M8763X:
 		ret = regmap_read(info->regmap, S5M_RTC_STATUS, &val);
 		val &= S5M_ALARM0_STATUS;
 		break;
@@ -299,7 +298,6 @@ static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 
 	data |= info->regs->write_alarm_udr_mask;
 	switch (info->device_type) {
-	case S5M8763X:
 	case S5M8767X:
 		data &= ~S5M_RTC_TIME_EN_MASK;
 		break;
@@ -329,38 +327,6 @@ static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 	return ret;
 }
 
-static void s5m8763_data_to_tm(u8 *data, struct rtc_time *tm)
-{
-	tm->tm_sec = bcd2bin(data[RTC_SEC]);
-	tm->tm_min = bcd2bin(data[RTC_MIN]);
-
-	if (data[RTC_HOUR] & HOUR_12) {
-		tm->tm_hour = bcd2bin(data[RTC_HOUR] & 0x1f);
-		if (data[RTC_HOUR] & HOUR_PM)
-			tm->tm_hour += 12;
-	} else {
-		tm->tm_hour = bcd2bin(data[RTC_HOUR] & 0x3f);
-	}
-
-	tm->tm_wday = data[RTC_WEEKDAY] & 0x07;
-	tm->tm_mday = bcd2bin(data[RTC_DATE]);
-	tm->tm_mon = bcd2bin(data[RTC_MONTH]);
-	tm->tm_year = bcd2bin(data[RTC_YEAR1]) + bcd2bin(data[RTC_YEAR2]) * 100;
-	tm->tm_year -= 1900;
-}
-
-static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
-{
-	data[RTC_SEC] = bin2bcd(tm->tm_sec);
-	data[RTC_MIN] = bin2bcd(tm->tm_min);
-	data[RTC_HOUR] = bin2bcd(tm->tm_hour);
-	data[RTC_WEEKDAY] = tm->tm_wday;
-	data[RTC_DATE] = bin2bcd(tm->tm_mday);
-	data[RTC_MONTH] = bin2bcd(tm->tm_mon);
-	data[RTC_YEAR1] = bin2bcd(tm->tm_year % 100);
-	data[RTC_YEAR2] = bin2bcd((tm->tm_year + 1900) / 100);
-}
-
 static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
@@ -385,10 +351,6 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	switch (info->device_type) {
-	case S5M8763X:
-		s5m8763_data_to_tm(data, tm);
-		break;
-
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -412,9 +374,6 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret = 0;
 
 	switch (info->device_type) {
-	case S5M8763X:
-		s5m8763_tm_to_data(tm, data);
-		break;
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -444,7 +403,6 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s5m_rtc_info *info = dev_get_drvdata(dev);
 	u8 data[RTC_MAX_NUM_TIME_REGS];
-	unsigned int val;
 	int ret, i;
 
 	ret = regmap_bulk_read(info->regmap, info->regs->alarm0, data,
@@ -453,15 +411,6 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 
 	switch (info->device_type) {
-	case S5M8763X:
-		s5m8763_data_to_tm(data, &alrm->time);
-		ret = regmap_read(info->regmap, S5M_ALARM0_CONF, &val);
-		if (ret < 0)
-			return ret;
-
-		alrm->enabled = !!val;
-		break;
-
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -500,10 +449,6 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
-	case S5M8763X:
-		ret = regmap_write(info->regmap, S5M_ALARM0_CONF, 0);
-		break;
-
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -531,7 +476,6 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 {
 	int ret;
 	u8 data[RTC_MAX_NUM_TIME_REGS];
-	u8 alarm0_conf;
 	struct rtc_time tm;
 
 	ret = regmap_bulk_read(info->regmap, info->regs->alarm0, data,
@@ -543,11 +487,6 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
-	case S5M8763X:
-		alarm0_conf = 0x77;
-		ret = regmap_write(info->regmap, S5M_ALARM0_CONF, alarm0_conf);
-		break;
-
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -585,10 +524,6 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 
 	switch (info->device_type) {
-	case S5M8763X:
-		s5m8763_tm_to_data(&alrm->time, data);
-		break;
-
 	case S5M8767X:
 	case S2MPS15X:
 	case S2MPS14X:
@@ -655,7 +590,6 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 	int ret;
 
 	switch (info->device_type) {
-	case S5M8763X:
 	case S5M8767X:
 		/* UDR update time. Default of 7.32 ms is too long. */
 		ret = regmap_update_bits(info->regmap, S5M_RTC_UDR_CON,
@@ -729,11 +663,6 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		info->regs = &s2mps13_rtc_regs;
 		alarm_irq = S2MPS14_IRQ_RTCA0;
 		break;
-	case S5M8763X:
-		regmap_cfg = &s5m_rtc_regmap_config;
-		info->regs = &s5m_rtc_regs;
-		alarm_irq = S5M8763_IRQ_ALARM0;
-		break;
 	case S5M8767X:
 		regmap_cfg = &s5m_rtc_regmap_config;
 		info->regs = &s5m_rtc_regs;
@@ -786,13 +715,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	info->rtc_dev->ops = &s5m_rtc_ops;
 
-	if (info->device_type == S5M8763X) {
-		info->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_0000;
-		info->rtc_dev->range_max = RTC_TIMESTAMP_END_9999;
-	} else {
-		info->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
-		info->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
-	}
+	info->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	info->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
 
 	if (!info->irq) {
 		clear_bit(RTC_FEATURE_ALARM, info->rtc_dev->features);
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 07aae649a86f..a212b9f72bc9 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -36,7 +36,6 @@
 struct gpio_desc;
 
 enum sec_device_type {
-	S5M8763X,
 	S5M8767X,
 	S2MPA01,
 	S2MPS11X,
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index 6cfe4201a106..3fd2775eb9bb 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -194,54 +194,4 @@ enum s5m8767_irq {
 #define S5M8767_IRQ_RTC1S_MASK		(1 << 4)
 #define S5M8767_IRQ_WTSR_MASK		(1 << 5)
 
-enum s5m8763_irq {
-	S5M8763_IRQ_DCINF,
-	S5M8763_IRQ_DCINR,
-	S5M8763_IRQ_JIGF,
-	S5M8763_IRQ_JIGR,
-	S5M8763_IRQ_PWRONF,
-	S5M8763_IRQ_PWRONR,
-
-	S5M8763_IRQ_WTSREVNT,
-	S5M8763_IRQ_SMPLEVNT,
-	S5M8763_IRQ_ALARM1,
-	S5M8763_IRQ_ALARM0,
-
-	S5M8763_IRQ_ONKEY1S,
-	S5M8763_IRQ_TOPOFFR,
-	S5M8763_IRQ_DCINOVPR,
-	S5M8763_IRQ_CHGRSTF,
-	S5M8763_IRQ_DONER,
-	S5M8763_IRQ_CHGFAULT,
-
-	S5M8763_IRQ_LOBAT1,
-	S5M8763_IRQ_LOBAT2,
-
-	S5M8763_IRQ_NR,
-};
-
-#define S5M8763_IRQ_DCINF_MASK		(1 << 2)
-#define S5M8763_IRQ_DCINR_MASK		(1 << 3)
-#define S5M8763_IRQ_JIGF_MASK		(1 << 4)
-#define S5M8763_IRQ_JIGR_MASK		(1 << 5)
-#define S5M8763_IRQ_PWRONF_MASK		(1 << 6)
-#define S5M8763_IRQ_PWRONR_MASK		(1 << 7)
-
-#define S5M8763_IRQ_WTSREVNT_MASK	(1 << 0)
-#define S5M8763_IRQ_SMPLEVNT_MASK	(1 << 1)
-#define S5M8763_IRQ_ALARM1_MASK		(1 << 2)
-#define S5M8763_IRQ_ALARM0_MASK		(1 << 3)
-
-#define S5M8763_IRQ_ONKEY1S_MASK	(1 << 0)
-#define S5M8763_IRQ_TOPOFFR_MASK	(1 << 2)
-#define S5M8763_IRQ_DCINOVPR_MASK	(1 << 3)
-#define S5M8763_IRQ_CHGRSTF_MASK	(1 << 4)
-#define S5M8763_IRQ_DONER_MASK		(1 << 5)
-#define S5M8763_IRQ_CHGFAULT_MASK	(1 << 7)
-
-#define S5M8763_IRQ_LOBAT1_MASK		(1 << 0)
-#define S5M8763_IRQ_LOBAT2_MASK		(1 << 1)
-
-#define S5M8763_ENRAMP                  (1 << 4)
-
 #endif /*  __LINUX_MFD_SEC_IRQ_H */
-- 
2.39.0

