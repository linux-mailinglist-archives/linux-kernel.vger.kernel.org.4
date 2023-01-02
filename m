Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1120C65B61E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjABSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjABSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:01:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB3DD4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:01:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so13786721wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcDgEmHqM7zr2mEB43fsbAcVvNC2pS3Sh8IUVblzWGA=;
        b=UqwIz8lhDmpsYb1/vTcWZSNosu064Qevofdof8dft7EZFSqBHBb56uo6dXOtscUi4n
         eVhIEbcSfn9vEgSCLGqdOe4Lqi7sTEasQIMAv67m4rHwM8RFIT4xILT2Wrq27hizbAEj
         1K01IKAQj0gwS9BUDUlAwTvoPLZm4POIE66Tfi/EH/3q6jBrSd2Qf+sRHj9xv1mmRdj3
         jUs1cUwzpu+cVM9+O/KERQiQlN/1ht22//mO4LsfeYYm3A/9FSv3/i3iM0xm3MgzRzX/
         VVZthMVlsnU7BeUKx2zDlMFjspv1dBJjcr3i5RRrNLQZvAkEgsVq7kkgjfuwlsuddW+m
         veFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcDgEmHqM7zr2mEB43fsbAcVvNC2pS3Sh8IUVblzWGA=;
        b=T3/hA53Mxwi3H70jM66iVopwiYyWlHdnLfMsSCS8J4E5pjIXJJYTtl4LDlEJ4yqd5g
         VhizGdyyEft20Oc3LUg452MDFc73rWotv92o7Zla45nRDEDfP3fXJrDv5SYb8941b20f
         nF1jbb4WeZbrofYYyycDJi4iBnwUJtRVV7yhrW1yKl0IcR/NUc1Jt24h4OqWuvS6bVk1
         0pHSpaZ4GCcBhD3btNAUbgCBoWoRaNrLgEjG9VfTgPu2sLyYciD0JohdEuBrxtHQvJuv
         TGEGZz0h4gtLgcbcMtYjdOC6NQx9NBVK00jzeIU916oV2OKFF+ycrah34aaPOKZt3/gD
         9g8g==
X-Gm-Message-State: AFqh2kogiwVkFkZo5aCBRBZZYqA53npeLmhqUTjuBP0z26HSyZlql6pL
        ufyE7T6JCt0leu6ndwEZJxrGpQ==
X-Google-Smtp-Source: AMrXdXtNXmAH7UccwCRBunl0RRXtdjdr0AISEVsjdHKjjbLehQWy78v4/gIoMzmo4O6bMmAVyW08XA==
X-Received: by 2002:a5d:4601:0:b0:242:63a3:2f20 with SMTP id t1-20020a5d4601000000b0024263a32f20mr32824722wrq.11.1672682483739;
        Mon, 02 Jan 2023 10:01:23 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b0027cb20605e3sm21375588wrs.105.2023.01.02.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 10:01:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 1/3] thermal/acpi: Add ACPI trip point routines
Date:   Mon,  2 Jan 2023 19:01:10 +0100
Message-Id: <20230102180112.1954082-2-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
References: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The ACPI specification describes the trip points, the device tree
bindings as well.

The OF code uses the generic trip point structures.

The ACPI has their own trip points structure and uses the get_trip_*
ops to retrieve them.

We can do the same as the OF code and create a set of ACPI functions
to retrieve a trip point description. Having a common code for ACPI
will help to cleanup the remaining Intel drivers and get rid of the
get_trip_* functions.

These changes add the ACPI thermal calls to retrieve the basic
information we need to be reused in the thermal ACPI and Intel
drivers.

The different ACPI functions have the generic trip point structure
passed as parameter where it is filled.

This structure aims to be the one used by all the thermal drivers and
the thermal framework.

After this series, a couple of Intel drivers and the ACPI thermal
driver will still have their own trip points definition but a new
series on top of this one will finish the conversion to the generic
trip point handling.

This series depends on the generic trip point added to the thermal
framework and available in the thermal/linux-next branch.

 https://lkml.org/lkml/2022/10/3/456

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/Kconfig        |  13 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_acpi.c | 279 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  16 ++
 4 files changed, 309 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..2c19bccd1223 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -76,6 +76,19 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_ACPI
+	bool
+	prompt "APIs to parse thermal data out of the ACPI tables"
+	depends on ACPI_THERMAL
+	default y
+	help
+	  This options provides helpers to add the support to
+	  read and parse thermal data definitions out of the
+	  ACPI tables blob.
+
+	  Say 'Y' here if you need to build thermal infrastructure
+	  based on ACPI.
+
 config THERMAL_WRITABLE_TRIPS
 	bool "Enable writable trip points"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..60f0dfa9aae2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
+thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
new file mode 100644
index 000000000000..28c629b4d814
--- /dev/null
+++ b/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ * 
+ * ACPI thermal configuration
+ */
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/units.h>
+#include <uapi/linux/thermal.h>
+
+#include "thermal_core.h"
+
+int thermal_acpi_trip_gtsh(struct acpi_device *adev)
+{
+	unsigned long long hyst;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	return (int)(hyst * 100);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_gtsh);
+
+int thermal_acpi_get_tzd(struct acpi_device *adev, struct acpi_handle_list *devices)
+{
+	acpi_status status;
+
+	/*
+	 * _TZD (Thermal zone device): This optional object evaluates
+	 * to a package of device names. Each name corresponds to a
+	 * device in the ACPI namespace that is associated with the
+	 * thermal zone. The temperature reported by the thermal zone
+	 * is roughly correspondent to that of each of the devices.
+	 */
+	status = acpi_evaluate_reference(adev->handle, "_TZD", NULL, devices);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_get_tzd);
+
+int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _TMP (Temperature): This control method returns the thermal zone’s
+	 * current operating temperature. The return value is the current
+	 * temperature of the thermal zone in tenths of degrees Kelvin
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temperature = deci_kelvin_to_millicelsius(temp);
+	
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_get_temp);
+
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _CRT (Critical temperature): This object, when defined under a thermal
+	 * zone, returns the critical temperature at which OSPM must shutdown
+	 * the system. If this object it present under a device, the device’s
+	 * driver evaluates this object to determine the device’s critical cooling
+	 * temperature trip point. This value may then be used by the device’s
+	 * driver to program an internal device temperature sensor trip point
+         */
+	status = acpi_evaluate_integer(adev->handle, "_CRT", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_CRITICAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_crit);
+
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _HOT (Hot Temperature): This optional object, when defined under a
+	 * thermal zone, returns the critical temperature at which OSPM may
+	 * choose to transition the system into the S4 sleeping state. The
+	 * platform vendor should define _HOT to be far enough below _CRT so as
+	 * to allow OSPM enough time to transition the system into the S4
+	 * sleeping state. While dependent on the amount of installed memory,
+	 * on typical platforms OSPM implementations can transition the system
+	 * into the S4 sleeping state in tens of seconds. If this object it 
+	 * present under a device, the device’s driver evaluates this object to
+	 * determine the device’s hot cooling temperature trip point. This value
+	 * may then be used by the device’s driver to program an internal device
+	 * temperature sensor trip point.
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_HOT", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_HOT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_hot);
+
+int thermal_acpi_trip_psv_psl(struct acpi_device *adev, struct acpi_handle_list *devices)
+{
+	acpi_status status;
+
+	/*
+	 * _PSL (Passive List): This object is defined under a thermal zone and
+	 *  evaluates to a list of processor objects to be used for passive cooling
+	 */
+	status = acpi_evaluate_reference(adev->handle, "_PSL", NULL, devices);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv_psl);
+
+int thermal_acpi_trip_psv_tsp(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tsp;
+	
+	/*
+	 * _TSP (Thermal Sampling Period): This object evaluates to a thermal
+	 * sampling period (in tenths of seconds) used by OSPM to implement the
+	 * Passive cooling equation. This value, along with _TC1 and _TC2, will
+	 * enable OSPM to provide the proper hysteresis required by the system
+	 * to accomplish an effective passive cooling policy.
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TSP", NULL, &tsp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return (int)tsp;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv_tsp);
+
+int thermal_acpi_trip_psv_tc1(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tc1;
+
+	/*
+	 * _TC1 (Thermal Constant 1): This object evaluates to the constant _TC1
+	 * for use in the Passive cooling formula
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TC1", NULL, &tc1);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return (int)tc1;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv_tc1);
+
+int thermal_acpi_trip_psv_tc2(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tc2;
+	
+	/*
+	 * _TC2 (Thermal Constant 1): This object evaluates to the constant _TC2
+	 * for use in the Passive cooling formula
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TC2", NULL, &tc2);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return (int)tc2;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv_tc2);
+
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _PSV (Passive): This optional object, if present under a thermal zone,
+	 * evaluates to the temperature at which OSPM must activate passive
+	 * cooling policy
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_PSV", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	/*
+	 * The _PSL, _TSP, _TC1 and _TC2 are required if the _PSV object exists.
+	 * We assume the caller will raise an error if it was able to get the _PSV
+	 * but then fail to get the other objects.
+	 */
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv);
+
+int thermal_acpi_trip_acl(struct acpi_device *adev,
+			  struct acpi_handle_list *devices, int id)
+{
+	acpi_status status;
+	char name[5];	
+
+	/*
+	 * _ALx: This object is defined under a thermal zone and evaluates to a
+	 * list of Active cooling devices to be turned on when the corresponding
+	 * _ACx temperature threshold is exceeded. For example, these devices
+	 * could be fans.
+	 */
+	sprintf(name, "_AL%d", id);
+
+	status = acpi_evaluate_reference(adev->handle, name, NULL, devices);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_acl);
+
+int thermal_acpi_trip_act(struct acpi_device *adev,
+			  struct thermal_trip *trip, int id)
+{
+	acpi_status status;
+	unsigned long long temp;
+	char name[5];	
+
+	/*
+	 * _ACx: This optional object, if present under a thermal zone, returns
+	 * the temperature trip point at which OSPM must start or stop active
+	 * cooling, where x is a value between 0 and 9 that designates multiple
+	 * active cooling levels of the thermal zone. If the Active cooling
+	 * device has one cooling level (that is, “on”) then that cooling level
+	 * must be defined as _AC0. If the cooling device has two levels of
+	 * capability, such as a high fan speed and a low fan speed, then they
+	 * must be defined as _AC0 and _AC1 respectively. The smaller the value
+	 * of x, the greater the cooling strength _ACx represents. In the above
+	 * example, _AC0 represents the greater level of cooling (the faster fan
+	 * speed) and _AC1 represents the lesser level of cooling (the slower
+	 * fan speed). For every _ACx method, there must be a matching _ALx
+	 * object or a corresponding entry in an _ART object’s active cooling
+	 * relationship list.
+	 */
+	sprintf(name, "_AC%d", id);
+
+	status = acpi_evaluate_integer(adev->handle, name, NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_act);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 30353e4b1424..65c1f1aafe02 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,22 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_THERMAL_ACPI
+struct acpi_handle_list;
+int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature);
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_act(struct acpi_device *adev, struct thermal_trip *trip, int id);
+int thermal_acpi_trip_acl(struct acpi_device *adev, struct acpi_handle_list *devices, int id);
+int thermal_acpi_trip_psv_psl(struct acpi_device *adev, struct acpi_handle_list *devices);
+int thermal_acpi_trip_psv_tsp(struct acpi_device *adev);
+int thermal_acpi_trip_psv_tc1(struct acpi_device *adev);
+int thermal_acpi_trip_psv_tc2(struct acpi_device *adev);
+int thermal_acpi_trip_gtsh(struct acpi_device *adev);
+int thermal_acpi_get_tzd(struct acpi_device *adev, struct acpi_handle_list *devices);
+#endif
+
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-- 
2.34.1

