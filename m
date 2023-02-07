Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EF68D61E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjBGMC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBGMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:02:56 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B732527986
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:02:54 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so42458071ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 04:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUOAsciE432PJe210yiCny4CEGbrJ7lZapaVIEaRr+w=;
        b=ITWL5UGOGG4cfCXoJ5Z7UXCSUAmJbxLMRELrvEFu/LthksCcF13yZD0SZH5oATGKrz
         ds4PB9370q1Cmbo7VaacFkdV7qkIERTl0Lx8gor156cgvRKjmhHtn/GVpVCrRSEvLcDe
         sxtf+kDu69U6tE5PfZdL8YVxnnUuxW5frM0/3NomGgHyJYiLbnA0Y3IDqXr/Z/aSDBvv
         XFHBX8pmFzBzIP6ck09odh6tR+azMkBAu3vu1IeBLREqwqQki5+QdaWfYI7EniQcAJTC
         y0w1bO0bF8tIAlMxJ5PztnX7Y8J4v9h/xluG67o+SyRuFF2O18+aKzPJgNEhC3n5QrUK
         xzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUOAsciE432PJe210yiCny4CEGbrJ7lZapaVIEaRr+w=;
        b=QhzMnBKi5fYb9sDMVxT8F6bjapRq9PcK0xp+qKFcGj4IqaTaxUz4K3OOmOzrDDzaCr
         lpu0LqH+NsayOFynuJcdu4BSEiNHZsVWUKOKyo5bAHSNQA4+dAy2hilrpDPoUo2T37WQ
         F2UtPEZatonAFekbUW7o60ezFDlTJl5olJWT0PjOI2JQ5yuU2f9+tregZucdEDJ9EUDa
         mmf3oWaxp4heX8io9Hbk6/OEuhN4Mo29uRqysoVJ7VxC1Hrn2iXk1YabuD4ZLB6K+jyy
         pzDUjAUQa5FJUnq9bmDQ4z3RQJ0gP67idSuc53PRNaJ37FSxsG2HvoxDCBxoymG+PHEp
         KfuQ==
X-Gm-Message-State: AO0yUKXm07JiVOIuYbwWa/xBQpkrfy7OWXuLRchw4GsN78qEcRb1uFft
        Z8351PaMvO6Ov1HZZws4r1xDjg==
X-Google-Smtp-Source: AK7set8Lf30EAxJ/hw1MlBB0SpSeX4I8wncqtS01B0i1V35Yr7C87z9geFhEBW8V0d4lWamhIEzqQA==
X-Received: by 2002:a17:907:72cb:b0:8a9:fff6:5224 with SMTP id du11-20020a17090772cb00b008a9fff65224mr2090327ejc.20.1675771373258;
        Tue, 07 Feb 2023 04:02:53 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906a20500b008710789d85fsm6843934ejy.156.2023.02.07.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:02:52 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] hwmon: (pmbus/core): Generalize pmbus status flag map
Date:   Tue,  7 Feb 2023 13:02:38 +0100
Message-Id: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMBus status flag map(pmbus_regulator_status_flag_map) is moved
outside of the regulator #if block and the associated variable/struct
name updated to reflect as generic PMBus status.

This will make the PMBus status flag map more versatile and easier to
incorporate into different contexts and functions.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 94 ++++++++++++++++----------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..1b70cf3be313 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2692,6 +2692,49 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	return 0;
 }
 
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+struct pmbus_status_assoc {
+	int pflag, rflag;
+};
+
+/* PMBus->regulator bit mappings for a PMBus status register */
+struct pmbus_status_category {
+	int func;
+	int reg;
+	const struct pmbus_status_assoc *bits; /* zero-terminated */
+};
+
+static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[] = {
+	{
+		.func = PMBUS_HAVE_STATUS_VOUT,
+		.reg = PMBUS_STATUS_VOUT,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_IOUT,
+		.reg = PMBUS_STATUS_IOUT,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_TEMP,
+		.reg = PMBUS_STATUS_TEMPERATURE,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ },
+		},
+	},
+};
+
 #if IS_ENABLED(CONFIG_REGULATOR)
 static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 {
@@ -2738,54 +2781,11 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
-/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
-struct pmbus_regulator_status_assoc {
-	int pflag, rflag;
-};
-
-/* PMBus->regulator bit mappings for a PMBus status register */
-struct pmbus_regulator_status_category {
-	int func;
-	int reg;
-	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
-};
-
-static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
-	{
-		.func = PMBUS_HAVE_STATUS_VOUT,
-		.reg = PMBUS_STATUS_VOUT,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
-			{ },
-		},
-	}, {
-		.func = PMBUS_HAVE_STATUS_IOUT,
-		.reg = PMBUS_STATUS_IOUT,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
-			{ },
-		},
-	}, {
-		.func = PMBUS_HAVE_STATUS_TEMP,
-		.reg = PMBUS_STATUS_TEMPERATURE,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
-			{ },
-		},
-	},
-};
-
 static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
 {
 	int i, status;
-	const struct pmbus_regulator_status_category *cat;
-	const struct pmbus_regulator_status_assoc *bit;
+	const struct pmbus_status_category *cat;
+	const struct pmbus_status_assoc *bit;
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2796,8 +2796,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 
 	mutex_lock(&data->update_lock);
 
-	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
-		cat = &pmbus_regulator_flag_map[i];
+	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
+		cat = &pmbus_status_flag_map[i];
 		if (!(func & cat->func))
 			continue;
 

base-commit: 7505dab78f58c953b863753208eeca682e8126ff
-- 
2.39.1

