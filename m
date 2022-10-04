Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C85F4827
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJDRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:18:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E83DF3C;
        Tue,  4 Oct 2022 10:18:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso9105637pjk.1;
        Tue, 04 Oct 2022 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=HFaRNpa9mLJ2TOOR7zZ2VVb33Q/fohWmntwZFXz/4Es=;
        b=mDNEHi4Rr6c4btJInZ4XwVYxo1fQdVCWjzBgULu1Ts0ZfRMiYO5s+F3+Cb8CQXooNm
         1BveFCRiZf2KTqcQV7DoTcALPmb1pWSDEEn223O7gMVMC6SVG1V8jRgvOCJGWHZuxH8I
         Vl+SvfcvT5BRn8Lrh4wotIHIBbABlbNJdlblzpgbOscM0jxPUnKRqO7KRTgrXaFc9P0n
         cbiwLDKMZpOB7jrFHy7peUaj+mCourjLZLrpQquxGVp+DgXPNaq1nrsrkjFzd1gXa/jd
         PbJjRs3DW9LJ1apBXZK7nGEyc0zM269QawF4eHlyzn5mCttFMHJV2wcWQ40PlDiIZajN
         WM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=HFaRNpa9mLJ2TOOR7zZ2VVb33Q/fohWmntwZFXz/4Es=;
        b=2R1dnfAr6BILfYj//pIkxTcJHhLZHpamqXC5V0BwmFZql3wK09DIsICiaEe5nypw1R
         vdookq4RZmJg19GP1KxJfqK5kaQ4ZusADYEwU6jYFADPM2E/tOmi5BJ9Ata4Ps/+wcow
         NnWKmKQj/MxwBrEldrJFxTdqLewRvFfeoc3L9nnW+lIORdGVAugmQ6ai2eumTPWdpDHY
         qXTtqrrtzmMnsWHa7cgGL858OMO9olJtjlyCiEeixrmmYCuXgfns5hVYJqTJIQFUOyhL
         5pOg5mowB3SIZWe2r3cv2gdHTXOpwdk15nzbjr4Kgrk1Zm+v9UT/5tyCMVDfqXa/1L/Y
         SR1w==
X-Gm-Message-State: ACrzQf0x0v5NzScMzMEr5b2aFkVWxnjTB0PfCCcPNyWQlQmg41LyL4TD
        D9gScP9m3DShq09dYDHe366stiaxp/U2EA==
X-Google-Smtp-Source: AMsMyM5/9K/9ohfATX2qANNK1fyZfXxZduQliyakxT8GlQFIXpcKB5RTrXiXHzVCyiR0Z2QjaDycAw==
X-Received: by 2002:a17:903:18b:b0:176:afb8:b4ab with SMTP id z11-20020a170903018b00b00176afb8b4abmr28490642plg.80.1664903927580;
        Tue, 04 Oct 2022 10:18:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001728ac8af94sm9164260plh.248.2022.10.04.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:18:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/core: Fix parameter check when setting trip point temperatures
Date:   Tue,  4 Oct 2022 10:18:43 -0700
Message-Id: <20221004171843.2737200-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9326167058e8a ("thermal/core: Move set_trip_temp ops to the sysfs
code") changed the parameter check in trip_point_temp_store() from

	if (!tz->ops->set_trip_temp)

to
	if (!tz->ops->set_trip_temp && !tz->trips)

That means the condition will pass if either tz->ops->set_trip_temp
or tz->trips is not NULL. Subsequently, access to tz->trips is
checked again, but tz->ops->set_trip_temp is called unconditionally.
This will result in a crash if the set_trip_temp callback is not set.
Add check if tz->ops->set_trip_temp is NULL before trying to call it.

Fixes: 9326167058e8a ("thermal/core: Move set_trip_temp ops to the sysfs code")
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 78c5841bdfae..ec495c7dff03 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -128,9 +128,11 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	ret = tz->ops->set_trip_temp(tz, trip, temperature);
-	if (ret)
-		return ret;
+	if (tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip, temperature);
+		if (ret)
+			return ret;
+	}
 
 	if (tz->trips)
 		tz->trips[trip].temperature = temperature;
-- 
2.36.2

