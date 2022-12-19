Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043FE651266
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiLSTJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiLSTJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:09:32 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87649767E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:09:31 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id i2so9720043vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgeqi6RRPNuIjdr+16qci9xGfe9jHTKnAUBA+hjYEZ0=;
        b=l9uV4BXDAD5WYzX5RtFj0DSFO7r45JnCM5R+GSwpzQ+MYf3Zs6FnohRanraSbL6T/Y
         MT9Z+hvsCnmMrjTBbY5xIY8MgnbWuO5naHqFIEI/SZktQHpVEiUqT3++aS50N1Wt3EZ5
         t+3RmofXh10aC4uaFWCaEBH8spJVR7cxf0uqbTE9ACtwBC6PjEsM1Vfjg4adJuvnfrkI
         tVZwcoRc0prA066wCuIsA1GKheSOrqEsTJyy7n6F6jA5tf0ma7O900BhgiPVGeZ5jsf6
         1poeqa/1pdT6x32X2YRKI8p6pyhT/1nreegSU5zP7UAizz4tOYoJ2bRBm+0G1yYyu7ap
         DwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgeqi6RRPNuIjdr+16qci9xGfe9jHTKnAUBA+hjYEZ0=;
        b=SqPhkqJHksnwanQgEuXvY1JWCUKtKO57sPc0NfOr1Bb7StyheWPlMgK0alLK76EeLP
         yKaysVUWu5r6trGBPmZlt51JomRf+hjQrhCi/w53Ac0zdM40e6EAWr7h/D/RFmUkS6bp
         gSKoDSGMKP4jEzmt+Qe4hFgfmnVCtwaHrk7YPYB3ttamo37E+Imkx8+MP2rR95fX/9SP
         CkVdFYvXQPVMcZWjTFvcSf4NE6gs/GiLBr0zhYxR7qTXudpid3eBekBl9HXXnE4BlKzI
         +oL2R8Ok+sIel5TykAow3nPyaPNlSK7TKf1idfXBMBHZkGV+sSKwaogo4U8JlB/2K+89
         m/wg==
X-Gm-Message-State: ANoB5plePmni0egtL3Hwpo1Tp7nLSOBwbjj0J1CT84KaQbAujKxyZ+fw
        Frmln6wjWlxR6/r3DOIi+k5bE1fXaAItm2nwN+M=
X-Google-Smtp-Source: AA0mqf7usAKjiXO8JfHSMKtYu24W8DxIyi44hhWI9KnUkd60DnhkFq514c89RQoESrq0dmEfUyZzew==
X-Received: by 2002:a67:f04a:0:b0:3b3:7657:43a1 with SMTP id q10-20020a67f04a000000b003b3765743a1mr17193534vsm.19.1671476970553;
        Mon, 19 Dec 2022 11:09:30 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a249000b006fa9d101775sm7503743qkn.33.2022.12.19.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:09:30 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alexander Bigga <ab@mycable.de>,
        Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH 3/3] rtc: m41t80: set xtal load capacitance from DT
Date:   Mon, 19 Dec 2022 19:09:15 +0000
Message-Id: <20221219190915.3912384-4-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219190915.3912384-1-dennis@sparkcharge.io>
References: <20221219190915.3912384-1-dennis@sparkcharge.io>
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

