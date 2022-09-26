Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30845EAA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiIZPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiIZPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:20:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E083BC6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:07:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so10390488wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jLn+zEfCM4URHe7bMSEwNlD2QENA2eAivlgbUdbannc=;
        b=vy8LnAcjLNAJXlYC+r09WeuqmkA8ME0wkQKu4x4sPawq0JQfhl0zn6UWYCiPfBQAkW
         1bCKK3cnwhlKnjsHfiQ8V34Fpb94cFTBeZjyeBHlW21VaFiYibwEavmbkuwDomEDIizm
         qBUXTuIhtW0P3Ded4ubdLH2ajONfv0SbaUpy5DPwHA8urpJ8eo7kkwMopMsjun0jCYdI
         77DtSViTnDdu/Im3SadmA/9bUGUHZc8j5I/d0nfGVbGN4EJaiTeLqEBmmXfAb3Jm6YmQ
         xy5vCprMrPGXyNlrJDTlZe0cy1BphP6z5WGbPe/z1kYhBtI+TRxRzjhp6aF6/v9mdugi
         KsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jLn+zEfCM4URHe7bMSEwNlD2QENA2eAivlgbUdbannc=;
        b=0itHM2GIW+ZzG50KAMEo+0u0ZfZ/tu0PvyLjEHNjOvUO+NiZ20ltBCwgqAPhurs9m7
         hHzYnArfz4zgEpfeHPq34tFcAYpevUUycg8AvJrH5wLIcB+E+aUTJjkiWPUxPsD4kz2H
         qRFro6G0N5DSeWAIUOmezJJP+zz2R//PgNFIQfKwZhcBue5uEKzXQOg98CesS/k9Wq4q
         4b7+1SLz9sdaQF3csmqK0Gzr1hx8sHq05Y3V24cE0frf//d1/WBrpVj8QPkFvGIOFqRs
         U2kvbsyWeX1cxu4mSGmZPflKIvBrYvSkZ9vjSiHBj8s2MnfUf3OTCeUHuL3m8HRV8/op
         rcng==
X-Gm-Message-State: ACrzQf2TO2tqA5RIJuREDlyVT+yTzp3hgzCZFrziYpqK0oNn3ImYBwby
        DgNT5NQo/AT52jZofMixY7dLMg==
X-Google-Smtp-Source: AMsMyM4s5sa3BH++/KEIOI4jOeHvCqwZ06qzpF8BCexacl1uVT2OHoNbUvPwkoLE5XIDGAyogOpRUA==
X-Received: by 2002:adf:cd10:0:b0:22c:a109:f51d with SMTP id w16-20020adfcd10000000b0022ca109f51dmr4463755wrm.238.1664201224762;
        Mon, 26 Sep 2022 07:07:04 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:07:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v5 30/30] thermal/drivers/intel: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:06:04 +0200
Message-Id: <20220926140604.4173723-31-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 ++++++++++---------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index a0e234fce71a..e7c3b78d959c 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -53,6 +53,7 @@ struct zone_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
+	struct thermal_trip		*trips;
 	struct cpumask			cpumask;
 };
 
@@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return -EINVAL;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-			     int trip, int *temp)
-{
-	struct zone_device *zonedev = tzd->devdata;
-	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
-	int ret;
-
-	if (trip >= MAX_NUMBER_OF_TRIPS)
-		return -EINVAL;
-
-	if (trip) {
-		mask = THERM_MASK_THRESHOLD1;
-		shift = THERM_SHIFT_THRESHOLD1;
-	} else {
-		mask = THERM_MASK_THRESHOLD0;
-		shift = THERM_SHIFT_THRESHOLD0;
-	}
-
-	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &eax, &edx);
-	if (ret < 0)
-		return ret;
-
-	thres_reg_value = (eax & mask) >> shift;
-	if (thres_reg_value)
-		*temp = zonedev->tj_max - thres_reg_value * 1000;
-	else
-		*temp = THERMAL_TEMP_INVALID;
-	pr_debug("sys_get_trip_temp %d\n", *temp);
-
-	return 0;
-}
-
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
@@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 			l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type = THERMAL_TRIP_PASSIVE;
-	return 0;
-}
-
 /* Thermal zone callback registry */
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
 	return 0;
 }
 
+static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
+{
+	struct thermal_trip *trips;
+	unsigned long thres_reg_value;
+	u32 mask, shift, eax, edx;
+	int ret, i;
+
+	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
+	if (!trips)
+		return ERR_PTR(-ENOMEM);
+	
+	for (i = 0; i < num_trips; i++) {
+
+		if (i) {
+			mask = THERM_MASK_THRESHOLD1;
+			shift = THERM_SHIFT_THRESHOLD1;
+		} else {
+			mask = THERM_MASK_THRESHOLD0;
+			shift = THERM_SHIFT_THRESHOLD0;
+		}
+
+		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				   &eax, &edx);
+		if (ret < 0) {
+			kfree(trips);
+			return ERR_PTR(ret);
+		}
+
+		thres_reg_value = (eax & mask) >> shift;
+
+		trips[i].temperature = thres_reg_value ?
+			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
+
+		trips[i].type = THERMAL_TRIP_PASSIVE;
+		
+		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
+			 __func__, cpu, i, trips[i].temperature);
+	}
+
+	return trips;
+}
+
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int id = topology_logical_die_id(cpu);
@@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!zonedev)
 		return -ENOMEM;
 
+	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
+	if (IS_ERR(zonedev->trips)) {
+		err = PTR_ERR(zonedev->trips);
+		goto out_kfree_zonedev;
+	}
+	
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tj_max = tj_max;
-	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
-			thres_count,
+	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
+			zonedev->trips, thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
-		kfree(zonedev);
-		return err;
+		goto out_kfree_trips;
 	}
 	err = thermal_zone_device_enable(zonedev->tzone);
-	if (err) {
-		thermal_zone_device_unregister(zonedev->tzone);
-		kfree(zonedev);
-		return err;
-	}
+	if (err)
+		goto out_unregister_tz;
+
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
 	      zonedev->msr_pkg_therm_high);
@@ -379,7 +382,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
 	raw_spin_unlock_irq(&pkg_temp_lock);
-	return 0;
+
+out_unregister_tz:	
+	thermal_zone_device_unregister(zonedev->tzone);
+out_kfree_trips:
+	kfree(zonedev->trips);
+out_kfree_zonedev:
+	kfree(zonedev);
+	return err;
 }
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
@@ -463,8 +473,10 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
-	if (lastcpu)
+	if (lastcpu) {
+		kfree(zonedev->trips);
 		kfree(zonedev);
+	}
 	return 0;
 }
 
-- 
2.34.1

