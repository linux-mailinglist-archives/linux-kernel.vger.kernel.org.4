Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3C5BFB80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIUJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiIUJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82450923CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so4010040wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=Cd78V+hNDtPBQjgKS7E3dkx3SdHiwTUacLcEWR5lWrDKzQ/y5kQuUUblCjmIn2s4R+
         YHORsHemDGnilhFnKZIFRYOuzqdTMW19JeX1UDQZ/5yuFxm5XncX9b8k4QP4lTf/MtzL
         kE6n5I//yo6fl8tguS+MXw7SQ9DBUIHS3iA9Kbhf+Cd20tLJeIfSpokdUKLe0ENXVSBk
         J4rN40J33C74qpSSOeQb3SC2J4nQIhBlCbF1MIK+2EhUeKgvSXcDlc6emC7zyO/zpjI3
         XTV56CtMHNkp6Gb7mVcPRAssM9cJyCBUX7X4UjewNIgPBFHJR5c+eHmuFmAbXnj7HBod
         atEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=hF0GS1+n5/atG1SCuXy6Cv8s8naB8rvODt/H8RAjAVxh1EavFNEqiu0YszVHgIQhfp
         pnAU2awAj72gOc2o7+BORv3Uj+64jemBPw+ovoWjdaKk6dS4Pu3n5EiQbIYAlanJfOFi
         gv3UTJw+19f///JUY3yWPCWwBWBZpryYkuRgp2lzEADS61eofX7//z1p9c8WmiYDZvi4
         HBp285pEM0SL3/vs2URbc7MIs6I5cr+rz/rEc7gcMyNzsLYG3aXCfEkG+sPNNxg6RAz6
         1qmpbis+dk8b6kpz5w9Sxda+GzhHy0zx3GDEVaUP9UVyE/cj2gUE1T531MEphr3O++HE
         nO+Q==
X-Gm-Message-State: ACrzQf3/MXDPNHGgf6AHymHcoGH8wSnzsYufnG9I6rb2cx55TpY/yHDm
        haOUmAu5z557AIE4TgniEGHVng==
X-Google-Smtp-Source: AMsMyM76b+PPLpOyiWJzirLIYSxD8CrJEaBxAd/lp2nYzsLnUNujUsoFlPF7v1Ql1BgMaxOa2tmcIg==
X-Received: by 2002:a05:600c:1c19:b0:3b4:c1cb:d46d with SMTP id j25-20020a05600c1c1900b003b4c1cbd46dmr5225318wms.172.1663753418150;
        Wed, 21 Sep 2022 02:43:38 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Amit Kucheria <amitk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v4 12/30] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:25 +0200
Message-Id: <20220921094244.606948-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4111d99ef50e..277ae300c5b1 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	const struct thermal_trip *trips;
-	int i, ret, irq, ntrips, crit_temp = INT_MAX;
+	int i, ret, irq, crit_temp = INT_MAX;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -296,20 +295,18 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	/* get trip points */
-	trips = of_thermal_get_trip_points(tdev->tz_dev);
-	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
-	if (ntrips > ALERT_CH_NUM) {
-		dev_err(dev, "thermal zone has too many trips\n");
-		return -E2BIG;
-	}
-
 	/* set alert temperatures */
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
-		    trips[i].temperature < crit_temp)
-			crit_temp = trips[i].temperature;
-		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
+	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
+		struct thermal_trip trip;
+
+		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
+		if (ret)
+			return ret;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL &&
+		    trip.temperature < crit_temp)
+			crit_temp = trip.temperature;
+		uniphier_tm_set_alert(tdev, i, trip.temperature);
 		tdev->alert_en[i] = true;
 	}
 	if (crit_temp > CRITICAL_TEMP_LIMIT) {
-- 
2.34.1

