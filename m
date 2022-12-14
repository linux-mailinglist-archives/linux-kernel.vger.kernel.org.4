Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E164C4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiLNIHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiLNIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:07:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C511EAE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bx10so18447341wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvSScxuHlRI0bKk77hVXZre2a8Ky0+wyi62OkXbDKg=;
        b=NDgGwNsaUJ1PgX9iay1BXJXgXFINWdGVempBeKoivktTCLLoAyuyVtxpvX2J0aEEIz
         LZniGOWVou+nmDF33yOkNHFq2rvq2EfxY89n3hbbHOsayoBVyM9xUt93O1tzzyjifQpU
         tFgWks5akwxcLUtDpk0PxE5Ap95o+oNoDYNNh7P59OfqJk0/6OjjHRmzOUOki579kHG4
         U84tPO3Hgd31UwCSw5zpCuPOFzGACnJ7JVhsuxIovIMIsvsa37lgx93go9AORv8ukVTn
         fJ/ltGXJL7Y3QxmhpAdAFAdIlv+kRKYFxPGYRhr5SmvD6QW/NjFaBc6dP/efe72EOkZc
         /GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrvSScxuHlRI0bKk77hVXZre2a8Ky0+wyi62OkXbDKg=;
        b=eMQBAjwtwlreNECZ+lEEw+9Njq2JnBpjthm3302+ngXIjmRhD9beoKh0gTlZxL2I/B
         ur28DAI+FKX4jtAPuYgOosXRCFyiQHKL44sUxwBnKUpLQtpAe8zpt1uReapKeT9kKqj1
         1vmwdbx68SWHs6xU8eOrmfZ6upzrJwIDO7NFqfgGii0DM8wzHQvQtdHdIRZ1ByPJCjiF
         sfGrAf92aEL6zNPPyp9VkgzNx3kbrizKgijtMWIrURkzUcloqf+GrkiZUraI5O4slVXh
         avMde7C08+pA47wzwCDJ0ntAM8yDhXT7LEuKpT7A2K+OL7cXlmRtHSHwlDOkcuYhYSfB
         FT5A==
X-Gm-Message-State: ANoB5pnDosku22OpcBCwMjJmRNyyFJZ8DnMprSD+Hh//pOS7c70J33xh
        NmxuQlCQfUgBrfA3XplRDrNGqQ==
X-Google-Smtp-Source: AA0mqf7F5kkzGdyraNSIkLcf4H2A59Fu/xayosTBykCCAFHTuDuRhWcgNbUhemuzvIJ7gj+rGaxcNQ==
X-Received: by 2002:adf:fb4f:0:b0:236:621a:984c with SMTP id c15-20020adffb4f000000b00236621a984cmr14148584wrs.36.1671005242159;
        Wed, 14 Dec 2022 00:07:22 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d5183000000b002422bc69111sm2500781wrv.9.2022.12.14.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:07:21 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH RESEND v6 1/5] hwmon: (pmbus/core): Add interrupt support
Date:   Wed, 14 Dec 2022 09:07:11 +0100
Message-Id: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement PMBUS irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 10fb17879f8e..6b2e6cf93b19 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -26,7 +26,7 @@ enum pmbus_regs {
 
 	PMBUS_CAPABILITY		= 0x19,
 	PMBUS_QUERY			= 0x1A,
-
+	PMBUS_SMBALERT_MASK		= 0x1B,
 	PMBUS_VOUT_MODE			= 0x20,
 	PMBUS_VOUT_COMMAND		= 0x21,
 	PMBUS_VOUT_TRIM			= 0x22,
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..244fd2597252 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3072,11 +3072,89 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 
 	return 0;
 }
+
+static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+}
+
+static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
+{
+	struct pmbus_data *data = pdata;
+	struct i2c_client *client = to_i2c_client(data->dev);
+	int i, status;
+
+	for (i = 0; i < data->info->pages; i++) {
+
+		mutex_lock(&data->update_lock);
+		status = pmbus_read_status_word(client, i);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return status;
+		}
+
+		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
+			pmbus_clear_fault_page(client, i);
+
+		mutex_unlock(&data->update_lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	int i, j, err, ret, func;
+	u8 mask;
+
+	for (i = 0; i < data->info->pages; i++) {
+		func = data->info->func[i];
+
+		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
+			cat = &pmbus_regulator_flag_map[j];
+			if (!(func & cat->func))
+				continue;
+			mask = 0;
+			for (bit = cat->bits; bit->pflag; bit++)
+				mask |= bit->pflag;
+
+			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
+			if (err)
+				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);
+		}
+
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_CML, 0xff);
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_OTHER, 0xff);
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_MFR_SPECIFIC, 0xff);
+		if (data->info->func[i] & PMBUS_HAVE_FAN12)
+			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_12, 0xff);
+		if (data->info->func[i] & PMBUS_HAVE_FAN34)
+			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_34, 0xff);
+	}
+
+	/* Register notifiers - can fail if IRQ is not given */
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
+			      0, "pmbus-irq", data);
+	if (ret) {
+		dev_warn(dev, "IRQ disabled %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 #else
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	return 0;
 }
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	return 0;
+}
 #endif
 
 static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
@@ -3441,6 +3519,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 	if (ret)
 		return ret;
 
+	if (client->irq > 0) {
+		ret = pmbus_irq_setup(client, data);
+		if (ret)
+			return ret;
+	}
+
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");

base-commit: 364ffd2537c44cb6914ff5669153f4a86fffad29
-- 
2.37.3

