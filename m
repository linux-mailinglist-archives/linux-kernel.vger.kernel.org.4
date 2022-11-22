Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDA633E18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiKVNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiKVNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:50:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABED58BCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:50:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d1so12687021wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdIBdMp3AF8wTlK3ZbNuetiQCTdvpib+4RwLHSff3bA=;
        b=GN/GT8YILFMtDw5idbTOaq2XJbwgf6oXfIo2soaWOry1aPf21P6EDi9ZwKuq37Md8q
         fXZWjBqFPGIoHQCgLx3D6g7uvZgBsyAwPqaA8EcegQe0selfqywQK3anBFfTIrIXSjPn
         phay0RKVim38t/PhkOC4FTtp1FjHen6wo3/0XchM3teFVKRmyjsaWIBxRIcfN2ZuhWFK
         Q8S0ydBjRYfO/XogKok8ci/5BKfcIJOgyL195jvEsbMkUrUoPDhTfGDf4l8TH5lxszTK
         wo063b0zsp1+rZVB3G8B/E8ORIua4lonZHpMASho2r2SfwMDFwfFtEcbkDkEwTjrMsaG
         9NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdIBdMp3AF8wTlK3ZbNuetiQCTdvpib+4RwLHSff3bA=;
        b=eyjQoXog7NDljIMJPD+9cu9QWxH5luDV6Kje+owfB3EGj5RA2v8CNscvWdU9kdVq4U
         ub5pEOBhstdQh0QLNxBptr+hhkztwiU0HrHTaA8878B8Rgc/jyr8SVd32RDGu/EOyHPd
         NyiV1OM7DbxejhzAnLOUW4C1etpiNUXW6W+sWJV3RKsOoJh7PE1dfiDfYOLK40/INiH1
         7/Q/QoxQoBBe62p/7BqTrdWXwGaMhg6IhNUz8udifMWDU/z83EFM/eFQ0XA4g4RKbo2/
         6VqWa8wq/sEypsD3t2/gIJQkySQKAOXaNyfrQgvrqAkHtGqElfat4vDgiatKIhNAHpvY
         kiIg==
X-Gm-Message-State: ANoB5pn96fH84Fnor1CVY0Gb4/9kJ1HdfLbMVxMM5L5vYfBANXU03/1k
        6AZMhP5zARxpugdg8XQllIeOyw==
X-Google-Smtp-Source: AA0mqf6JLUQ/IaYfn1Zp1h227gXTlYdBHzAamG7BuVwGW+EeB1vmBKG5jK/srUats+9tIvhW6WCzZQ==
X-Received: by 2002:a05:6000:12c3:b0:236:8130:56e7 with SMTP id l3-20020a05600012c300b00236813056e7mr13930808wrx.309.1669125019603;
        Tue, 22 Nov 2022 05:50:19 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c465100b003cf483ee8e0sm19947254wmo.24.2022.11.22.05.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:50:19 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org, Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (pmbus/core): Update regulator flag map
Date:   Tue, 22 Nov 2022 14:50:11 +0100
Message-Id: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator flag map for PMBUS status byte & status input.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 52 +++++++++++++++++---------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 20ca26e19db7..08f96e2b4837 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2756,26 +2756,47 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 		.reg = PMBUS_STATUS_VOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
 			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE },
 			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
+			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_REGULATION_OUT },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_IOUT,
 		.reg = PMBUS_STATUS_IOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_WARNING,	 REGULATOR_ERROR_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_POUT_OP_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_TEMP,
 		.reg = PMBUS_STATUS_TEMPERATURE,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ PB_TEMP_OT_WARNING,	 REGULATOR_ERROR_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,	 REGULATOR_ERROR_OVER_TEMP },
+			{ },
+		},
+	}, {
+		.func = -1,
+		.reg = PMBUS_STATUS_BYTE,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_STATUS_IOUT_OC,	 REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_STATUS_VOUT_OV,	 REGULATOR_ERROR_REGULATION_OUT },
+			{ PB_STATUS_VIN_UV,	 REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_STATUS_NONE_ABOVE,  REGULATOR_ERROR_FAIL },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_INPUT,
+		.reg = PMBUS_STATUS_INPUT,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_IIN_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE },
 			{ },
 		},
 	},
@@ -2834,23 +2855,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 		if (status & PB_STATUS_POWER_GOOD_N)
 			*flags |= REGULATOR_ERROR_REGULATION_OUT;
 	}
-	/*
-	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
-	 * defined strictly as fault indicators (not warnings).
-	 */
-	if (status & PB_STATUS_IOUT_OC)
-		*flags |= REGULATOR_ERROR_OVER_CURRENT;
-	if (status & PB_STATUS_VOUT_OV)
-		*flags |= REGULATOR_ERROR_REGULATION_OUT;
-
-	/*
-	 * If we haven't discovered any thermal faults or warnings via
-	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
-	 * a (conservative) best-effort interpretation.
-	 */
-	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
-	    (status & PB_STATUS_TEMPERATURE))
-		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
 
 	return 0;
 }

base-commit: 2c71b3246ec3246522e8cb7c8191dc7a5d62cc70
-- 
2.37.3

