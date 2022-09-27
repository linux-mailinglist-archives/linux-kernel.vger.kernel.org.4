Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E135EC66C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiI0Ody (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiI0OdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB55E565
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:32:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o5so6685155wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=crQJQSZoczKrIegK5IuceoLZkv1wMF3jvS/SHAicAiM=;
        b=OuQsL3pDYRFRu268TdjouYmQ6dYjwwHZRA/DIm+j3Zmflz0C8v+c5V6Su2p4GnRr3R
         gwgOkTNyEzNZ4rnA5aehGI1txt7R0SKz5ltIgYNwCbVLjobKD8nnWIX1WR66eBFfT2xE
         7ngSSTBE+RVygDjjZWSGlfhZdMF7X588r5R4hk5wpy8HUthohlytKUNatsDXHK9ojHpQ
         E7Cejz3Iu0joDqa8ZpETUDYuOoSvOlJPJ/FGwOTUwkcnmR/JJSQINk39nPA/9hf1iSWB
         1OCAK8c3jBMQQSCSFFqDxLLZTmVlCt1FXhvJXP60366GThV/cRW3+q8czS9rYjq96B+s
         zawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=crQJQSZoczKrIegK5IuceoLZkv1wMF3jvS/SHAicAiM=;
        b=Pv9vyNKcY6rXmXb0MyPgbdw+5csKL6za5klOxQtbKw6v7Yr2nJrjSNVuULldi4by4h
         auQSBAIYtHFfW2flz8w3Eqb4ceD4/NCfxT4w0c9lojWnItn2+SPe87P4UITBHI+ItIw+
         Exrjmh6e+/wyjx6TU848Pfplli1VxLcLDiSEBAoVMHx18rOYGUkB4HXadZbTNYuidfGe
         YBnS3qC7limiglWtRagNg0KY8Y62S5QjYeBfgbtrxfDlqRl61UhxowlbJtqPDqrz1DUB
         GxKjoj1vMOJmGZsF9j8CNS7/MTKpmwFlJSczkSM/y+RlQ6apuEBxIMXKO9eCHdE6fedT
         7TpQ==
X-Gm-Message-State: ACrzQf1UoXi2mwjaV1cTpe4DkjIrR5b7XL6tCk78Q/a8xSKZ37W0B5b+
        gDAtGslF1nhZr9dEw3APwXhh1A==
X-Google-Smtp-Source: AMsMyM6pgUT5nG6k57AwnjF7dnYftJoyE6iCZo0T7TU/1blF9iLyAegr/FDZeEbIDrtOtJkWKAYHQA==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:cd with SMTP id 11-20020a05600c020b00b003b486ff00cdmr3008488wmi.35.1664289178423;
        Tue, 27 Sep 2022 07:32:58 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:32:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 06/29] thermal/of: Remove unused functions
Date:   Tue, 27 Sep 2022 16:32:16 +0200
Message-Id: <20220927143239.376737-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

