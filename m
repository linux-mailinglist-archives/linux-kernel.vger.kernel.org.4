Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B663F835
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLAT3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:29:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F3C7D32
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:29:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so6622665ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qJrq6T31sJxCZwbEqlMuOvpG+K/8IjspbhkPV4Km1Q=;
        b=SW4hPI2FWGG5GORQJIKeGvk2XQDV1l97gRAeUy/zp0bPfQG+7YaA27wepYjA1VUz4r
         1Fs5VsvuJXwBT8zLILOuVuMwRBdW62A0rYGCA0xRUNHUpLY0vM+ZqL6mh/jedm2YLJKs
         EALqED0lwsJ3sPhN6JzokkOkIKOjce1luQW+M0cr1orEKw5BQSqF33AWQvuHI2Y0BYyL
         xd2DG7nAxySWAe5Vgh3Vl6Ps4EGSnPZuFnmDjSTVfFtSJKY8K56yQXdDOpyYnppsmect
         Q0wQK7MotT6N6mitUJBeKqgBf/gGlRno7q7ty6IPzihc2i9TL3kmU+lk6WVerTBObG9v
         ti0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qJrq6T31sJxCZwbEqlMuOvpG+K/8IjspbhkPV4Km1Q=;
        b=Z8w2O7i/rI2saXiVQwy9G8glQULRITBndFIIyWboHHpCj8b8xQE58f2RhwsM98E9kr
         TjZb6+PYywqzkM7zpF8GuUY+/0UvpkZsPol/gHIvOfBn6KS5wJdoku6lS7o2zf7f5JSw
         E2o+RwPaz9UtGpgDSbbm6WLbaImU4R8TAqxipa5fRWJ9WUwhMc39z4I+cB0gno9OVtpz
         Y6VuR8q4vTLU9d6EwiwB/MrJZzkBNMVVoiLud/PYidU2qSDiKW1j3QOuIdP5wnQv5uxR
         jajMU4g6VrVhe+N1CNo41UIs+vNo9EUjaJM2UD5FPJGyFIZtzW9YEhveU8B7FCueftmc
         w1Vw==
X-Gm-Message-State: ANoB5pnm2ZdkA5fqqhF0mQ6ppOpMC0GsKk9j5+eIizwuRN5aQMqVQVMU
        4NXTW4foWLL/Z/exW/w39fvtyA==
X-Google-Smtp-Source: AA0mqf7EwjwgFhq93o7jjqG184PyjylC2BYPAldcbmB9lhs2VJLvcPjq0Ietj3jPFwiFUjW5sX68Hw==
X-Received: by 2002:a17:906:ee1:b0:78a:efde:b84a with SMTP id x1-20020a1709060ee100b0078aefdeb84amr57442318eji.744.1669922983691;
        Thu, 01 Dec 2022 11:29:43 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090639cd00b0073022b796a7sm2141380eje.93.2022.12.01.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:29:43 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 1/5] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Date:   Thu,  1 Dec 2022 20:29:35 +0100
Message-Id: <20221201192940.1584012-1-Naresh.Solanki@9elements.com>
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

Add regulator device in pmbus_data & initialize the same during PMBus
regulator register.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..7a23794c0b93 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -3053,6 +3054,11 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				  GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3062,7 +3068,7 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
 					       &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(dev, PTR_ERR(rdev),

base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
-- 
2.37.3

