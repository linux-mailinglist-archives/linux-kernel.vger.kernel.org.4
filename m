Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2035EAA45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiIZPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiIZPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:18:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800DA81B28
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so2651092wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=crQJQSZoczKrIegK5IuceoLZkv1wMF3jvS/SHAicAiM=;
        b=a9ZySv9e5P7H8Q1EIEly3YzEJl+KMEPT31kejbP4aANBigxpRxiuylzWaPPEvwLDJM
         IFkclcNjn463vjOjFKn0sMjtL8GAJ+BUOl1RWhIUQFZPOOs+d0JFti0DkDhLkEO5aUVm
         5NbqRF0tCsHH6AiOVwGG8DZFPHE3X2SYh88CVDHNdBPw71nk14HqU5TI4HAfLgnVuW1F
         SVlZDl8pe/3cziRHUvzvnTR3IR6T08mnEUvFqxwHoexuyIb4UqwzOGoK6cBxxcHszjC3
         FJEd7DypxT+cF1hSyVwfRYomN7GfrcAGai7SCa0d5nzost8+UB9RRPq0v/YRKUeCdkkk
         u5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=crQJQSZoczKrIegK5IuceoLZkv1wMF3jvS/SHAicAiM=;
        b=N3Q/yJTR+DRQVt0fQhEy4fHQRPhjxmDngmsNaq2Z0Gvm1fpav3twp5ZVsoJLYwnOsj
         MC3awmsWm2WbFOZAMd8jNJZdzC2ttPSbprE0JV+J5THiOuekSPU9/T3YJi9tAFXdUQIM
         H+gXPcuLrc4HikQz7SoAS1Zew3bMMMaoMUPe4bNPqmN16LXCBCoNRvhQxFz82hIC2M5U
         /tzsqtZ63qWMk4KUSfv44TuPBqxErWNlPAaZSc7R90zB6GmdQgEbZ27UbSgDw3184G6z
         eu4NXkqtH34SueZeVk6qobKrfJWpXyVl3jUOyU99okt87+8PANnJH0PBFUTAHBXy+Wa/
         pyHg==
X-Gm-Message-State: ACrzQf18tz34+DF0y4fZPzSoBmUja7G5q3Dnjf49PKQi1mGl3OFlJ4e4
        mhBsWCwV/fuI8zaNiBGq1oj4Zw==
X-Google-Smtp-Source: AMsMyM7b1QzKLeJ0fdfHUp7z8GwM8yJmEKaC32bF2k1iRaPgeUeVxQoK4D2dSGQbotZphJI98DV7nQ==
X-Received: by 2002:a5d:59a9:0:b0:22b:e6a:4796 with SMTP id p9-20020a5d59a9000000b0022b0e6a4796mr13463925wrr.47.1664201185873;
        Mon, 26 Sep 2022 07:06:25 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 07/30] thermal/of: Remove unused functions
Date:   Mon, 26 Sep 2022 16:05:41 +0200
Message-Id: <20220926140604.4173723-8-daniel.lezcano@linaro.org>
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

Remove the dead code: of_thermal_get_trip_points()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  7 -------
 drivers/thermal/thermal_of.c   | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 879e91a48435..c5990a3fcf8a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -141,8 +141,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #ifdef CONFIG_THERMAL_OF
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
@@ -153,11 +151,6 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return false;
 }
-static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return NULL;
-}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5cce83639085..2f533fc94917 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -54,23 +54,6 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
-/**
- * of_thermal_get_trip_points - function to get access to a globally exported
- *				trip points
- *
- * @tz:	pointer to a thermal zone
- *
- * This function provides a pointer to trip points table
- *
- * Return: pointer to trip points table, NULL otherwise
- */
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return tz->trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

