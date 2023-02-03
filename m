Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25C68A064
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjBCReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBCReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:34:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25406A428D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:34:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u10so1375658wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1jm23bKqAdfecJUh5x31wqV5kGYV/iMiWQLCUHrEsc=;
        b=e6+R38l+TvNtRO87bY87KBezjqZ31U0a70n58FykqUxAOKc1ezyr2yuIsfsDmizalx
         BgIzuWB04fiqMaOFVLmVHMXvCPIZg5E9si0mtCF6tv5VrQ7VTPEckgRycwN7/DkRJ/lq
         g2EPKJ0XlhlulnT43VcUe3IAWjsGkG96Ubhh1hdjk0N7aGqA+vKjGNUoEZ3T1C5W4Flc
         1vgPZi38m5DhaZmMUg2MrXAjk+wYN6+ZS4EAxkoSC+afQmtbxOJOkmWF98OJ9rk3bwE8
         XB2IOv5ZC6U/w3sMUGVC4+9jAKH4D23ulCEq50YQwKcBO0xEwKQJcfjely+FkSbhhb32
         JM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1jm23bKqAdfecJUh5x31wqV5kGYV/iMiWQLCUHrEsc=;
        b=hiSVtsFrcHnAO6LVDj7WLZ8xK6GGSzKjO1RiK+6xv1MaDoG8ec/GMN+jS7tA47PPRo
         IrLHOTYiAL3yhYG0bIbi37ayp7QGFpkk6lUk+4peujbs8+4j2n3NcXuK/8gwH0LR5OMq
         a7R7bblc468imVRdXkVdbR7hwv610UfqlmHX6UqpzGMrdutcofRBcc5szNR665Siuc5p
         U+R2w7cpB05NTYN7RT1LNaZtZQ9vLfol7yxysEMgvc8cVsYozDew2cBCXsRs25c5rjI9
         dND1AkPV+W5h6W5mNWxSBG/4oBdde/2d3h5u3jJ3UfMv5NUPPeNW3HCCKuD7epDxQ+gi
         uqLw==
X-Gm-Message-State: AO0yUKXS2O9DxncVWXWj+SAipxJxhs16olD8sokY/7L3KOPCzKc3inmL
        9cflsEX0RPLiXT+GDdT6Sn7ntg==
X-Google-Smtp-Source: AK7set9tfPHoO7U53mx0Mp9V9zsU3YDA9rc1kQmm7g4HMUQraodwiUQ0SU4GokuktzEYoC29CP8cQw==
X-Received: by 2002:a7b:ce11:0:b0:3dd:37a5:dc90 with SMTP id m17-20020a7bce11000000b003dd37a5dc90mr10372544wmc.32.1675445639608;
        Fri, 03 Feb 2023 09:33:59 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 11/11] thermal/acpi: Use the thermal framework ACPI API
Date:   Fri,  3 Feb 2023 18:33:31 +0100
Message-Id: <20230203173331.3322089-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
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

From: Daniel Lezcano <daniel.lezcano@kernel.org>

The thermal framework has a set of functions to fill the trip
points. Those functions are already used by the int340x and the quark
Intel's platform.

Reuse these functions in order to consolidate the generic trip points
usage across the thermal ACPI user.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 75 ++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f89236cd4fcd..3c0652a369f0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -259,8 +259,8 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 							      struct thermal_trip *trips,
 							      int *num_trips)
 {
-	acpi_status status = AE_OK;
-	unsigned long long temp;
+	struct thermal_trip trip;
+	int ret;
 
 	/*
 	 * Module parameters disable the critical trip point
@@ -268,14 +268,12 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 	if (crt < 0)
 		goto out;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+	ret = thermal_acpi_trip_crit(tz->device->handle, &trip);
+	if (ret)
 		goto out;
-	}
-
-	if (temp <= 2732) {
-		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", temp);
+	
+	if (trip.temperature <= 0) {
+		pr_info(FW_BUG "Invalid critical threshold (%d)\n", trip.temperature);
 		goto out;
 	}
 
@@ -283,10 +281,7 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_CRITICAL;
+	trips[*num_trips] = trip; /* structure copy */
 
 	if (crt > 0)
 		acpi_thermal_trips_override(&trips[*num_trips], crt * MILLI);
@@ -300,23 +295,18 @@ static struct thermal_trip *acpi_thermal_trips_alloc_hot(struct acpi_thermal *tz
 							 struct thermal_trip *trips,
 							 int *num_trips)
 {
-	acpi_status status;
-	unsigned long long temp;
+	struct thermal_trip trip;
+	int ret;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
+	ret = thermal_acpi_trip_hot(tz->device->handle, &trip);
+	if (ret)
 		goto out;
-	}
 
 	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_HOT;
+	trips[*num_trips] = trip; /* structure copy */
 	
 	(*num_trips)++;
 out:
@@ -327,9 +317,10 @@ static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal
 							     struct thermal_trip *trips,
 							     int *num_trips)
 {
-	struct acpi_handle_list devices;
 	acpi_status status;
-	unsigned long long temp;
+	struct thermal_trip trip;
+	struct acpi_handle_list devices;
+	int ret;
 
 	/*
 	 * Module parameters disable all passive trip points
@@ -337,26 +328,21 @@ static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal
 	if (psv < 0)
 		goto out;
 	
-	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No passive threshold\n");
+	ret = thermal_acpi_trip_psv(tz->device->handle, &trip);
+	if (ret)
 		goto out;
-	}
-
+	
 	status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_debug(tz->device->handle, "No passive device associated\n");
 		goto out;
 	}
-	
+
 	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_PASSIVE;
+	trips[*num_trips] = trip; /* structure copy */	
 	
 	(*num_trips)++;
 out:
@@ -367,10 +353,9 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 							    struct thermal_trip *trips,
 							    int *num_trips)
 {
-	struct acpi_handle_list devices;
 	acpi_status status;
-	unsigned long long temp;
-	int i;
+	struct acpi_handle_list devices;
+	int i, ret;
 
 	/*
 	 * Module parameters disable all active trip points
@@ -379,12 +364,11 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 		return trips;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		struct thermal_trip trip;
 		char name[5];
 
-		sprintf(name, "_AC%d", i);
-
-		status = acpi_evaluate_integer(tz->device->handle, name, NULL, &temp);
-		if (ACPI_FAILURE(status))
+		ret = thermal_acpi_trip_act(tz->device->handle, &trip, i);
+		if (ret)
 			break;
 
 		sprintf(name, "_AL%d", i);
@@ -394,16 +378,13 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 			acpi_handle_info(tz->device->handle, "No _AL%d defined for _AC%d\n", i, i);
 			break;
 		}
-
+		
 		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 		if (!trips)
 			break;
 
-		memset(&trips[*num_trips], 0, sizeof(*trips));
+		trips[*num_trips] = trip; /* structure copy */	
 
-		trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-		trips[*num_trips].type = THERMAL_TRIP_ACTIVE;
-	
 		(*num_trips)++;
 	}
 
-- 
2.34.1

