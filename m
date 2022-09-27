Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F445EC684
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiI0Ofz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiI0Odu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D661706
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so15314984wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pY49ET3ZIgq2w00tEafAmFrW/5GVD2UTvB8HzlNbQv0=;
        b=ib/zNUVAKz82p+bNEA3qgVm4XJZpOhmkpj/nZ23+VMG+AY8s7CSkX9HrqArJCk/rnv
         1LyQcxexDCAMinJ8CgADSbESXyfSZI6g7z1VFk8A0G2aRotrUuiG9AZqAjjaLMT0ACgk
         iKbG3CqLlR7O8oI2jR61NPQyXMl/zd1G+PZWASsNr5okjsGl+56Ja9nGH8G8OoR8DC6W
         2vlJrEdwdcfz/2Osnvff/VX4uk5k8txLpJyo7e8qNqcXLHnRmKAiY4+A4XH7ojE0frZL
         3UP6H7Vjh3izzpXY64J5x9DmTT0YA21mV/UG9/pbKR5QJldT7Ka7P+lbFXARwhca39Yd
         pBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pY49ET3ZIgq2w00tEafAmFrW/5GVD2UTvB8HzlNbQv0=;
        b=rZw98WoRw9Fok7bM8wYc96Ynr3fymCIoAfG6uwWk8t1uVXuK2gqxuCVy7grFuW3X3k
         chFHiYvyRnLRtIvQGy1WC6LfMNRJ4yQo294cYkVM6fqyih2gGG3G5Ev3tTxO1fe4rxHQ
         W40SFJJQchO5K6OrPxWWcwVxGFdAC3QjW5XE1Y0selYnGcjEA39E+NmooFe97BnHRx8O
         6X/zjKtM5fLR3a8gCVR8r+elQXzWIYFqmttC0gpeHg9wBNtyYMFy8WOkh3LAWmcM3OrB
         jLxZ+9KTG2+CkjCGLkSTtlTrYGC32brgi7W/Pp1Rci3hLP32hBW1HufN0ZSUnoAkcy38
         7stg==
X-Gm-Message-State: ACrzQf3sfB/yLIik08c46HOFBFS5mCkkQTvKSaDLKVXrYPDzU265x9zj
        trEt4J8NMCZ3RJnL9mcwsgs4T2Zf/T258g==
X-Google-Smtp-Source: AMsMyM4LCPkgWZrV5iGJ15xntNVTbssBENqBX+dmfYZU3pkFQYJBazGvKctdSGed0+AA1VxuNwTPDg==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr17179601wri.455.1664289212816;
        Tue, 27 Sep 2022 07:33:32 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Antoine Tenart <atenart@kernel.org>
Subject: [PATCH v6 28/29] thermal/intel/int340x: Replace parameter to simplify
Date:   Tue, 27 Sep 2022 16:32:38 +0200
Message-Id: <20220927143239.376737-29-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

In the process of replacing the get_trip_* ops by the generic trip
points, the current code has an 'override' property to add another
indirection to a different ops.

Rework this approach to prevent this indirection and make the code
ready for the generic trip points conversion.

Actually the get_temp() is different regarding the platform, so it is
pointless to add a new set of ops but just create dynamically the ops
at init time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/int340x_thermal_zone.c    | 33 +++++++++----------
 .../int340x_thermal/int340x_thermal_zone.h    |  4 +--
 .../processor_thermal_device.c                | 10 ++----
 3 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 62c0aa5d0783..66cd50e0b50a 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -18,9 +18,6 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	unsigned long long tmp;
 	acpi_status status;
 
-	if (d->override_ops && d->override_ops->get_temp)
-		return d->override_ops->get_temp(zone, temp);
-
 	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -46,9 +43,6 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
 	struct int34x_thermal_zone *d = zone->devdata;
 	int i;
 
-	if (d->override_ops && d->override_ops->get_trip_temp)
-		return d->override_ops->get_trip_temp(zone, trip, temp);
-
 	if (trip < d->aux_trip_nr)
 		*temp = d->aux_trips[trip];
 	else if (trip == d->crt_trip_id)
@@ -79,9 +73,6 @@ static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
 	struct int34x_thermal_zone *d = zone->devdata;
 	int i;
 
-	if (d->override_ops && d->override_ops->get_trip_type)
-		return d->override_ops->get_trip_type(zone, trip, type);
-
 	if (trip < d->aux_trip_nr)
 		*type = THERMAL_TRIP_PASSIVE;
 	else if (trip == d->crt_trip_id)
@@ -112,9 +103,6 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 	acpi_status status;
 	char name[10];
 
-	if (d->override_ops && d->override_ops->set_trip_temp)
-		return d->override_ops->set_trip_temp(zone, trip, temp);
-
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
 			millicelsius_to_deci_kelvin(temp));
@@ -134,9 +122,6 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 	acpi_status status;
 	unsigned long long hyst;
 
-	if (d->override_ops && d->override_ops->get_trip_hyst)
-		return d->override_ops->get_trip_hyst(zone, trip, temp);
-
 	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
 	if (ACPI_FAILURE(status))
 		*temp = 0;
@@ -217,7 +202,7 @@ static struct thermal_zone_params int340x_thermal_params = {
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
-				struct thermal_zone_device_ops *override_ops)
+						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
 	struct int34x_thermal_zone *int34x_thermal_zone;
 	acpi_status status;
@@ -231,8 +216,17 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		return ERR_PTR(-ENOMEM);
 
 	int34x_thermal_zone->adev = adev;
-	int34x_thermal_zone->override_ops = override_ops;
 
+	int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
+					   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
+	if (!int34x_thermal_zone->ops) {
+		ret = -ENOMEM;
+		goto err_ops_alloc;
+	}
+
+	if (get_temp)
+		int34x_thermal_zone->ops->get_temp = get_temp;
+	
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
 	if (ACPI_FAILURE(status))
 		trip_cnt = 0;
@@ -262,7 +256,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						acpi_device_bid(adev),
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
-						&int340x_thermal_zone_ops,
+						int34x_thermal_zone->ops,
 						&int340x_thermal_params,
 						0, 0);
 	if (IS_ERR(int34x_thermal_zone->zone)) {
@@ -281,6 +275,8 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
 err_trip_alloc:
+	kfree(int34x_thermal_zone->ops);
+err_ops_alloc:
 	kfree(int34x_thermal_zone);
 	return ERR_PTR(ret);
 }
@@ -292,6 +288,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
+	kfree(int34x_thermal_zone->ops);
 	kfree(int34x_thermal_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index 3b4971df1b33..e28ab1ba5e06 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -29,13 +29,13 @@ struct int34x_thermal_zone {
 	int hot_temp;
 	int hot_trip_id;
 	struct thermal_zone_device *zone;
-	struct thermal_zone_device_ops *override_ops;
+	struct thermal_zone_device_ops *ops;
 	void *priv_data;
 	struct acpi_lpat_conversion_table *lpat_table;
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
-				struct thermal_zone_device_ops *override_ops);
+				int (*get_temp) (struct thermal_zone_device *, int *));
 void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a8d98f1bd6c6..317703027ce9 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -207,10 +207,6 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return ret;
 }
 
-static struct thermal_zone_device_ops proc_thermal_local_ops = {
-	.get_temp       = proc_thermal_get_zone_temp,
-};
-
 static int proc_thermal_read_ppcc(struct proc_thermal_device *proc_priv)
 {
 	int i;
@@ -285,7 +281,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned long long tmp;
-	struct thermal_zone_device_ops *ops = NULL;
+	int (*get_temp) (struct thermal_zone_device *, int *) = NULL;
 	int ret;
 
 	adev = ACPI_COMPANION(dev);
@@ -304,10 +300,10 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 		/* there is no _TMP method, add local method */
 		stored_tjmax = get_tjmax();
 		if (stored_tjmax > 0)
-			ops = &proc_thermal_local_ops;
+			get_temp = proc_thermal_get_zone_temp;
 	}
 
-	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
+	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, get_temp);
 	if (IS_ERR(proc_priv->int340x_zone)) {
 		return PTR_ERR(proc_priv->int340x_zone);
 	} else
-- 
2.34.1

