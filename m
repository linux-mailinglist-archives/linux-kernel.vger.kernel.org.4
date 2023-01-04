Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3323365CC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjADFZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjADFZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:25:27 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8181658A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:25:26 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h21so26457994qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 21:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgeqi6RRPNuIjdr+16qci9xGfe9jHTKnAUBA+hjYEZ0=;
        b=i+ZpVp3mwT2dg7r2pBy6XLj5KfrohEUpJoq6O8hVqiGvmISCNWCgyBvYhOvbkvaoa+
         5qiXpGkGenGYuxhu2zeoOUvF2PHPgBk707lO27MDyn60VB4ufNR2/P5N7IIrtF5OSGap
         4Sagp9ntb2S1Y17WVR/3IQLHGsBthABGCsCD3PGa7MibJHbwmvJ4h4LbMx0OcgAERHom
         /BAPz3rTSBREIrACwlIYwlAkXTIedssNQFaFtl2TDntb8m3V59YTG4UWu20ISvszMWr0
         epwE+RbT4EkeWBJ214kfPPGJPuSnWeoBqE+On0vi+BUkgqMsLJgCLNatvRuxjln+Td1D
         EhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgeqi6RRPNuIjdr+16qci9xGfe9jHTKnAUBA+hjYEZ0=;
        b=R7AXS1zGHabnCoq9WYKTGHDGW8WUgMEFAdik56axYfxSpxZbsdm/7sEBCmKNE89ggK
         vJQWs4XsJFkbC4CpsoqHhtM8riO1c0LEx5R3b9NJ1tC6Dn0i/kUItCd2NOMyEaRsI15Z
         PYex/Yt2xY0SR7u4JT4X2XWUUL1F9BANGx8bRAPE69olJUQt0o/yc6Zvfgee+kSEBU6f
         IcwSVAyXJlpuiTLet99TYXhVp0u1anumrEimYCr1w0QxbEMVfsvmVVv/xn8IFgpnTG+8
         pYcj51FrHmsTQVEhlq4hl47LhUE799EwSYqY6L7MTPsdTIERmypGi3qBWQHeLy/qLDqc
         /JYA==
X-Gm-Message-State: AFqh2kqIVs4kqlvK/OsngTlCUefv8HRSGRs+CkcYVDhbjqzI3JWff97N
        zSQNRzgvF9NUUODFgROLgG+UVA==
X-Google-Smtp-Source: AMrXdXsFdnvfK2zYz6sa3lAuau2z4Epb/qTRBrCqn6Ond7JrtcwYz5TNx9+t2yVxdNlvPd2wzL5bmQ==
X-Received: by 2002:ac8:6896:0:b0:3ab:6cf1:1e7d with SMTP id m22-20020ac86896000000b003ab6cf11e7dmr63382460qtq.2.1672809925668;
        Tue, 03 Jan 2023 21:25:25 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b003a7e4129f83sm19425602qto.85.2023.01.03.21.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 21:25:25 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH v2 3/3] rtc: m41t80: set xtal load capacitance from DT
Date:   Wed,  4 Jan 2023 05:25:06 +0000
Message-Id: <20230104052506.575619-4-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104052506.575619-1-dennis@sparkcharge.io>
References: <20230104052506.575619-1-dennis@sparkcharge.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for specifying the xtal load capacitance in the DT node for
devices with an Analog Calibration register.

the m41t82 and m41t83 support xtal load capacitance from 3.5 pF to 17.4
pF.

If no xtal load capacitance is specified, the battery-backed register
won't be modified. The hardware defaults to 12.5 pF on reset.

Signed-off-by: Dennis Lambe Jr <dennis@sparkcharge.io>
---
 drivers/rtc/rtc-m41t80.c | 75 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index f963b76e5fc0..85bde7130a4d 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -44,12 +44,17 @@
 #define M41T80_REG_ALARM_MIN	0x0d
 #define M41T80_REG_ALARM_SEC	0x0e
 #define M41T80_REG_FLAGS	0x0f
+#define M41T80_REG_AC		0x12
 #define M41T80_REG_SQW		0x13
 
 #define M41T80_DATETIME_REG_SIZE	(M41T80_REG_YEAR + 1)
 #define M41T80_ALARM_REG_SIZE	\
 	(M41T80_REG_ALARM_SEC + 1 - M41T80_REG_ALARM_MON)
 
+#define M41T80_AC_MIN		 3500
+#define M41T80_AC_MAX		17375
+#define M41T80_AC_DEFAULT	12500
+
 #define M41T80_SQW_MAX_FREQ	32768
 
 #define M41T80_SEC_ST		BIT(7)	/* ST: Stop Bit */
@@ -68,6 +73,7 @@
 #define M41T80_FEATURE_SQ	BIT(2)	/* Squarewave feature */
 #define M41T80_FEATURE_WD	BIT(3)	/* Extra watchdog resolution */
 #define M41T80_FEATURE_SQ_ALT	BIT(4)	/* RSx bits are in reg 4 */
+#define M41T80_FEATURE_AC	BIT(5) /* Analog calibration */
 
 static const struct i2c_device_id m41t80_id[] = {
 	{ "m41t62", M41T80_FEATURE_SQ | M41T80_FEATURE_SQ_ALT },
@@ -75,8 +81,10 @@ static const struct i2c_device_id m41t80_id[] = {
 	{ "m41t80", M41T80_FEATURE_SQ },
 	{ "m41t81", M41T80_FEATURE_HT | M41T80_FEATURE_SQ},
 	{ "m41t81s", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
-	{ "m41t82", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
-	{ "m41t83", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
+	{ "m41t82", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ
+		    | M41T80_FEATURE_AC },
+	{ "m41t83", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ
+		    | M41T80_FEATURE_AC },
 	{ "m41st84", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
 	{ "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
 	{ "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
@@ -108,11 +116,13 @@ static const __maybe_unused struct of_device_id m41t80_of_match[] = {
 	},
 	{
 		.compatible = "st,m41t82",
-		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ
+				 | M41T80_FEATURE_AC)
 	},
 	{
 		.compatible = "st,m41t83",
-		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ
+				 | M41T80_FEATURE_AC)
 	},
 	{
 		.compatible = "st,m41t84",
@@ -405,6 +415,54 @@ static const struct rtc_class_ops m41t80_rtc_ops = {
 	.alarm_irq_enable = m41t80_alarm_irq_enable,
 };
 
+static u8 to_sign_magnitude_u8(int n)
+{
+	if (n < 0)
+		return 0x80 | -n;
+	return n;
+}
+
+static int m41t80_encode_ac(int quartz_load)
+{
+	if (quartz_load < M41T80_AC_MIN || quartz_load > M41T80_AC_MAX)
+		return -EINVAL;
+
+	/*
+	 * register representation is the per-capacitor offset from its default
+	 * value in units of 1/4 pF, in sign-magnitude form.
+	 */
+	return to_sign_magnitude_u8((quartz_load - M41T80_AC_DEFAULT) / 125);
+}
+
+static int m41t80_set_ac(struct m41t80_data *m41t80_data, int quartz_load)
+{
+	struct i2c_client *client = m41t80_data->client;
+	struct device *dev = &client->dev;
+	int ret;
+	int ac;
+
+	if (!(m41t80_data->features & M41T80_FEATURE_AC)) {
+		dev_err(dev, "analog calibration requested but not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	ac = m41t80_encode_ac(quartz_load);
+	if (ac < 0) {
+		dev_err(dev, "quartz load %d fF out of range\n",
+			quartz_load);
+		return ac;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, M41T80_REG_AC, ac);
+	if (ret < 0) {
+		dev_err(dev, "Can't set AC register\n");
+		return ret;
+	}
+
+	dev_info(dev, "quartz load set to %d fF (AC=0x%x)\n", quartz_load, ac);
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int m41t80_suspend(struct device *dev)
 {
@@ -883,6 +941,7 @@ static int m41t80_probe(struct i2c_client *client)
 	struct rtc_time tm;
 	struct m41t80_data *m41t80_data = NULL;
 	bool wakeup_source = false;
+	u32 quartz_load = M41T80_AC_DEFAULT;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -912,6 +971,14 @@ static int m41t80_probe(struct i2c_client *client)
 	if (IS_ENABLED(CONFIG_OF)) {
 		wakeup_source = of_property_read_bool(client->dev.of_node,
 						      "wakeup-source");
+
+		rc = of_property_read_u32(client->dev.of_node,
+					  "quartz-load-femtofarads",
+					  &quartz_load);
+		if (!rc)
+			m41t80_set_ac(m41t80_data, quartz_load);
+		else if (rc != -EINVAL)
+			dev_err(&client->dev, "quartz-load-femtofarads property value is missing or invalid\n");
 	}
 
 	if (client->irq > 0) {
-- 
2.25.1

