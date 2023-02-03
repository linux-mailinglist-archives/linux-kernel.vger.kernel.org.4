Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C3468A0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBCRvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjBCRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:51:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7462713
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:51:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z11so5953560ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImiRnspQldFz7aUHwWWQjNaQE6HDsbMFrGvzaxyK5ic=;
        b=TsvIRqby7Oz8eG1DHfd++shiHsmPHIh06ieKcJEAFrbgyAN3mVLH1IZrTA7AtgxtJC
         m85VH4bkWFZVKrlBC3Ml39ZbV0PQvUS9hbNeett0FCjNZ4uVnFrX6cb9JQ2C+d8Vdr+Q
         Yvyx9iUO6tH3apNERAoefugBdBieK1HWn3/IM2duyWtxe3DAYRRm5N/B0THNk7jLjuOR
         H4nAdZIpHTGeuOmZP9DTnvWgmT3RAW0/yl93pRC6sGfoMBs0VX/KSb7m3+dtuZidxQY6
         TBWsJ1jl4ti7WGYPWJGGHvT/NbqqsR+mOSMPfOvbSVhugLPuOZuGd1fCkkYUc6kGEJRb
         7s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImiRnspQldFz7aUHwWWQjNaQE6HDsbMFrGvzaxyK5ic=;
        b=KuhrOOKMnHSFbV+wZWK8n+70I/ArR0VQ8m9rfHIJFRlD6eg8xMa6qdK9NQ9Zhr3T/Y
         WSteuGHkgqTNdNeNZsRPYzMtJjdDYj61QbEYK109PdRrWZfYiSqOyUJScnxnGDbgYgpu
         sjm7COXeb8dkgqy/h9Pox8kfN3MqkxjTFIFOCZUEDj1HvXTgktx7Qyq/G5KHQ+AXLJKP
         tpMRY8Dvbmq9xqvp99ulLKqCfeDj2W+RFmfO6p0mWxUQKxYE1ip9Ts/XVTnbX56nXXoW
         iqMx7rRkBsEVMBoKdpa+rdi+jpbqrwywQLDEUeImtVl3SokMs21G2JK80AZXV8fmuTWS
         Tx1g==
X-Gm-Message-State: AO0yUKU8+XaDYKcfsiYGYepT36rwXt7gxBaiRciRqil2EBdL8Os25lwG
        i/u/ckxhzEYw4HpAcIfOOWu19Skay7HoMO+L
X-Google-Smtp-Source: AK7set8RI7/bZaiWiY+urOoui2skD17ohS1mniNKim4E/nPMVoW4Tf6Fcg1z01bcc37njrrl3uogXA==
X-Received: by 2002:a5d:5949:0:b0:2bf:9582:1378 with SMTP id e9-20020a5d5949000000b002bf95821378mr9589419wri.37.1675446277891;
        Fri, 03 Feb 2023 09:44:37 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/11] thermal/acpi: Optimize get_trip_points()
Date:   Fri,  3 Feb 2023 18:44:23 +0100
Message-Id: <20230203174429.3375691-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function has two purposes. Initialize the trip points by reading
the ACPI table and then doing a check trip points exists.

This check will go through all the trip points and at the end if a
valid trip point is found, the parsing is considered valid.

Instead of checking all the trip points, exit when a valid trip point
is found.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 903f0e3d95f5..c4fd583fbf5c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -461,23 +461,20 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	int i, ret;
 
+	ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 	if (ret)
 		return ret;
 
-	valid = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips[i].flags.valid)
+			return 0;
+	}
 
-	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->trips[i].flags.valid;
+	pr_warn(FW_BUG "No valid trip found\n");
 
-	if (!valid) {
-		pr_warn(FW_BUG "No valid trip found\n");
-		return -ENODEV;
-	}
-	return 0;
+	return -ENODEV;
 }
 
 /* sys I/F for generic thermal sysfs support */
-- 
2.34.1

