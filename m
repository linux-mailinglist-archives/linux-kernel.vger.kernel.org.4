Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AF6CC46E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjC1PFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjC1PFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:05:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE4EC49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so7671185wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1680015818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpixAugXoZaAwUVYpLsM7+hqMka5O+Qfwz+XpgeRjTs=;
        b=SwYO599zCOMIb+ah0SxNIpjnaqvUaPRoqNOQOnLbI/08m5dkKLq0vxapCVvHBMfYp3
         y2wPQeJbC9lJ/Xz7WFhvhsJZJvPHgGA7b7fPNOroAu3qVuXFxPYaKiM66TjUbm+DKV2O
         RUDkUkOqJDW+Da43id/Jcrf6ijm5Rz4bvNbQFkguPhq3lXCqduLRCLNC72JfRpgrqm9e
         hj/jMh2PT+ZrDMGa5NXqAg8lb5/vg4pdDNnR/oZIc5ZlB51dx/1GCVrASzZ85bIoYce4
         vqb4y0bjWCN8mi/X6/4EDlXkASNlKIgXFZB+jTo+K45BhB07FJ0OR/v4+Ku3jLH/J8uk
         F6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpixAugXoZaAwUVYpLsM7+hqMka5O+Qfwz+XpgeRjTs=;
        b=jtEPbd5GdthmvdAECApEjFiuTddMFTfuubbJO21i6xzga4LzxBbxPBgPaJyJu9beWr
         NUJarAdPgvoIsDVqy0PUJWHUNX7yNP7LD+mfeEZI3x64UucIdeo4jcLFS7Z0to8EBouY
         JcZydfDWSGHhQATibs48HojP6F1lHWl1+xZA1jE8rq+h02AGoHuRVc15wqy0vlHdcTAY
         2mf9mCX5UGtX2TkKmTq57/FHW0uSKVJp7OSotji2V23sKbUTgR7doOvZpRzDOyuIiM51
         SZuoOrnakFRlsEo2febGC5I8ROoVTYCrnrk6pxXUNoQTLM1FVIioJ4RIIYF+D7aRkIHx
         /0Sw==
X-Gm-Message-State: AO0yUKXHQ8tfcmiRmBEYHBORIlf7jfiuqMYtutboPMYiNjUN7vxLQPmJ
        9f2Inn9JuKeVXuqELixXVBvlkw==
X-Google-Smtp-Source: AK7set/bN893UfIkzTqJL0r2e1oMezo/ssoDSEOpOtBuDCXyf3mu4WIawWcjgm5d3NzpFN2m3luumA==
X-Received: by 2002:a7b:c7c5:0:b0:3ed:809b:79ac with SMTP id z5-20020a7bc7c5000000b003ed809b79acmr12587433wmk.19.1680015817802;
        Tue, 28 Mar 2023 08:03:37 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003ee63fe5203sm17429293wmm.36.2023.03.28.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:03:37 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Date:   Tue, 28 Mar 2023 17:03:33 +0200
Message-Id: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator device in pmbus_data & initialize the same during PMBus
regulator register.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 0ddef2c9ba9b..d93405f1a495 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -3109,9 +3110,13 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 	struct device *dev = data->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				   GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3121,10 +3126,10 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
-					       &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(dev, PTR_ERR(rdev),
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
+							 &config);
+		if (IS_ERR(data->rdevs[i]))
+			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
 					     "Failed to register %s regulator\n",
 					     info->reg_desc[i].name);
 	}

base-commit: 8a863eb1b1162653d133856702e13560f3596b85
-- 
2.39.1

