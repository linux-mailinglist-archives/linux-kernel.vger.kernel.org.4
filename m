Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3E65366D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiLUSjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiLUSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:39:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C126A92
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:39:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay40so11804267wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tdfq1utjuYGywu1rGDiKFUqkvIDtVkRzBeIHYHR/to=;
        b=sxJncKU9fpwrCVcLW+BmIgDu4EOidsj3Uri3LlvygYszdp8sCT07h8r1NoJtUiQWj4
         oSh3lRrCtWpRqlwfNMI1qGWaw6m6YN9xwD0+uIUwBkDsk2rlEb3umIMEOiz7KgL1nEp9
         21+PzACBSCsG35NG4YD5zqMhxWOuh3dey5xjZptrhmvRzeBvlWliUzsfC716hgLeuvbM
         yVQo7o4lAVsgAEYY+1Dy8rHbOjitPaclxAblgbgIkNL6IcYNj6Z5miT9rixpgNwbzYyi
         YkQipHyWDqYcHIB8xd3kXIbH6A5NPAgJtkHwVNIY/2IzWiJQr8ft64maQ3jsCcxYFSf5
         wECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Tdfq1utjuYGywu1rGDiKFUqkvIDtVkRzBeIHYHR/to=;
        b=wX9DrBRZqaLPOmI8t0BkqG3Zs7fcPVeFIn+2oQ++zsfU4xqwhvo7/EcdPbm6eelF6P
         PR+2H8HiIasmpcNE2MSn4mDqJOAR2nkjrwbu52gyxH7KJDRdXBQi9iyYOi1C5ZlcVH+b
         0coR4Jn/0NB2N5NEJwlhq7EFb9BDUs6QiAEUIUhgetWpBiWHMrT23a8/kDNhK4xkhG6r
         qBv0GmEqfXeNLz48TjJf/srA4gutqENfhagLDUNfbtVdH06UcWSMyftPjlcByNZJPY0a
         zBMlsE1bXulcGi+KAMU7G19Yc9HINgH2LVL6H/relxaAq9VkB2k0YKio2dUde1OoN7xL
         nEAA==
X-Gm-Message-State: AFqh2kosMgel4cprdPmxCI4Y3J9sfOd6+pxW4OQXUks6Be9kd2Ne9j5I
        uSGMUzxUMr8qE/DZzazv32EO0w==
X-Google-Smtp-Source: AMrXdXvUqmEeFyA/hCVl+BYEbvYTn3El9tNVBANMSabgaOVSgNIczt43vkKhbtp7qHvEjv3LgX1g3w==
X-Received: by 2002:a05:600c:1e8c:b0:3d6:2952:679b with SMTP id be12-20020a05600c1e8c00b003d62952679bmr2409002wmb.34.1671647942061;
        Wed, 21 Dec 2022 10:39:02 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b00236883f2f5csm16055360wrm.94.2022.12.21.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:39:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH] thermal/acpi: Add ACPI trip point routines
Date:   Wed, 21 Dec 2022 19:38:39 +0100
Message-Id: <20221221183840.2352014-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It does not depend on any material.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/Kconfig        |  13 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_acpi.c | 267 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  16 ++
 4 files changed, 297 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..e57011be7009 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -76,6 +76,19 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_ACPI
+	bool
+	prompt "APIs to parse thermal data out of the ACPI tables"
+	depends on ACPI
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
index 000000000000..4e18073f8817
--- /dev/null
+++ b/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,267 @@
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
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e2797f314d99..67608a3a62d3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,22 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_ACPI
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
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
-- 
2.34.1

