Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761E600FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJQNKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJQNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931062D6;
        Mon, 17 Oct 2022 06:09:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id g130so11999277oia.13;
        Mon, 17 Oct 2022 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSjMfysxR25bu72lEn5VGMegOh4cZTT77Ai7vgMJhXA=;
        b=K+luvcqKpHjgwGaRSNK7+zlrPL8Qig9YXDLLgCw5iAr52QtI1/QFoWRpea4XdYrQbI
         HpVlDJUvjfNCzxg2tiVwgdtic1DNmsyomEDE7oJGW+gMnNV8/uLWEuLvVE1WYNnOzQMa
         xW54ceicn4Sc1KcrFW9eMJ+sD4JXerS0n66Lejj+M8HC72OIapioOcSNbTq/6Al2AdDh
         4WFBwHLrG55ONo+TyFd5QCqIw7FG4rSs9HktHoq7DbTp1Sh/+oWzGwDqHkbI9MZskcYv
         gWuWEI14XY4VqA1OLnDOlmCX8t3uaSLYczgCUjSYmvNz/44PfNtgaNFo15cKpIhPMwlH
         9ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSjMfysxR25bu72lEn5VGMegOh4cZTT77Ai7vgMJhXA=;
        b=X/JCiEi8OvHIH74joXnYCpkVtmdHE2u1SNdvqBoC+QftcFKdsFwQTHiUqlZ6TIhGaL
         iNsNPVlD3V78IOLmVIh88QrJpBfTO4AhnpPnivEXFO8AG4xMkB3Buny9jlinPv7ZSVIa
         i+NmQ0bFwO61f7j1HYfCAjlnU/oPn/mFAabknT1jGBRMBirvpGEn0ydo/wC34nuDuG/g
         Pz/KhaFVCWnh1ldLKYgQbs0E6f316YWLmXNBK8eAh3Mman/4y4qfMYwEShgo8t16IUqK
         fMwzPGFducRHOwgGx1RmuvL5/uufu7T6oi7/LFQ1IfdTza33MTLavpUfu/wx9pFkDv81
         mSbA==
X-Gm-Message-State: ACrzQf2bZW9Dg8r5lw7rjlQtY4hNX+3Dqo41P+nMotUHcG2ANGj2WOCF
        pPTZK7Iv4l4yE65J8ESe7zY=
X-Google-Smtp-Source: AMsMyM56n5g10ZlXjDgc8bA7g/f6qichzUc7G2A5J1Hcjjs2+jXldt0Vvo4VoDXeo3UjORhFu+q/FA==
X-Received: by 2002:a05:6808:1247:b0:351:9b63:b065 with SMTP id o7-20020a056808124700b003519b63b065mr12571516oiv.261.1666012163767;
        Mon, 17 Oct 2022 06:09:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d32-20020a056870d2a000b00132218cb7afsm4788402oae.42.2022.10.17.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 7/9] thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
Date:   Mon, 17 Oct 2022 06:09:08 -0700
Message-Id: <20221017130910.2307118-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
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

Protect access to thermal operations against thermal zone removal by
acquiring the thermal zone device mutex. After acquiring the mutex, check
if the thermal zone device is registered and abort the operation if not.

With this change, we can call __thermal_zone_device_update() instead of
thermal_zone_device_update() from trip_point_temp_store() and from
emul_temp_store(). Similar, we can call __thermal_zone_set_trips() instead
of thermal_zone_set_trips() from trip_point_hyst_store().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c  |  4 +-
 drivers/thermal/thermal_core.h  |  2 +
 drivers/thermal/thermal_sysfs.c | 77 ++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9facd9c5b70f..b8e3b262b2bd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,8 +403,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static void __thermal_zone_device_update(struct thermal_zone_device *tz,
-					 enum thermal_notify_event event)
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event)
 {
 	int count;
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1571917bd3c8..7b51b9a22e7e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -109,6 +109,8 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ec495c7dff03..68607e6070e8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -92,7 +92,15 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		mutex_unlock(&tz->lock);
+		return -ENODEV;
+	}
+
 	result = tz->ops->get_trip_type(tz, trip, &type);
+	mutex_unlock(&tz->lock);
 	if (result)
 		return result;
 
@@ -128,10 +136,17 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (tz->ops->set_trip_temp) {
 		ret = tz->ops->set_trip_temp(tz, trip, temperature);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	if (tz->trips)
@@ -140,18 +155,21 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	ret = tz->ops->get_trip_type(tz, trip, &type);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	return count;
+unlock:
+	mutex_unlock(&tz->lock);
+
+	return ret ? ret : count;
 }
 
 static ssize_t
@@ -168,12 +186,19 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
 
-	if (ret)
-		return ret;
+unlock:
+	mutex_unlock(&tz->lock);
 
-	return sprintf(buf, "%d\n", temperature);
+	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
 
 static ssize_t
@@ -193,6 +218,13 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	/*
 	 * We are not doing any check on the 'temperature' value
 	 * here. The driver implementing 'set_trip_hyst' has to
@@ -201,7 +233,10 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 
 	if (!ret)
-		thermal_zone_set_trips(tz);
+		__thermal_zone_set_trips(tz);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
@@ -220,8 +255,18 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
 
+unlock:
+	mutex_unlock(&tz->lock);
+
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
 
@@ -269,16 +314,24 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (!tz->ops->set_emul_temp) {
-		mutex_lock(&tz->lock);
 		tz->emul_temperature = temperature;
-		mutex_unlock(&tz->lock);
 	} else {
 		ret = tz->ops->set_emul_temp(tz, temperature);
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
-- 
2.36.2

