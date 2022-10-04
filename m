Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5665F47AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJDQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJDQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:33:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235B58513;
        Tue,  4 Oct 2022 09:33:09 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e8d3fdc3e6bc692e; Tue, 4 Oct 2022 18:33:08 +0200
Received: from kreacher.localnet (unknown [213.134.189.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6D65F6665F6;
        Tue,  4 Oct 2022 18:33:07 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] ACPI: thermal: Use white space more consistently
Date:   Tue, 04 Oct 2022 18:31:11 +0200
Message-ID: <4774295.31r3eYUQgx@kreacher>
In-Reply-To: <12068304.O9o76ZdvQC@kreacher>
References: <12068304.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.18
X-CLIENT-HOSTNAME: 213.134.189.18
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekledrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrudekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The usage of white space in the ACPI thermal driver is not very
consistent, so improve that a bit.

While at it, add missing braces to if()/else in a few places.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  190 +++++++++++++++++++++++--------------------------
 1 file changed, 92 insertions(+), 98 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -158,7 +158,7 @@ struct acpi_thermal_flags {
 };
 
 struct acpi_thermal {
-	struct acpi_device * device;
+	struct acpi_device *device;
 	acpi_bus_id name;
 	unsigned long temperature;
 	unsigned long last_temperature;
@@ -270,8 +270,7 @@ static int acpi_thermal_trips_update(str
 
 	/* Critical Shutdown */
 	if (flag & ACPI_TRIPS_CRITICAL) {
-		status = acpi_evaluate_integer(tz->device->handle,
-				"_CRT", NULL, &tmp);
+		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
 		tz->trips.critical.temperature = tmp;
 		/*
 		 * Treat freezing temperatures as invalid as well; some
@@ -284,8 +283,7 @@ static int acpi_thermal_trips_update(str
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
-			pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
-				tmp);
+			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
 			tz->trips.critical.flags.valid = 0;
 		} else {
 			tz->trips.critical.flags.valid = 1;
@@ -312,8 +310,7 @@ static int acpi_thermal_trips_update(str
 
 	/* Critical Sleep (optional) */
 	if (flag & ACPI_TRIPS_HOT) {
-		status = acpi_evaluate_integer(tz->device->handle,
-				"_HOT", NULL, &tmp);
+		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
 			tz->trips.hot.flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
@@ -329,7 +326,7 @@ static int acpi_thermal_trips_update(str
 
 	/* Passive (optional) */
 	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
-		(flag == ACPI_TRIPS_INIT)) {
+	    (flag == ACPI_TRIPS_INIT)) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -338,32 +335,31 @@ static int acpi_thermal_trips_update(str
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
-				"_PSV", NULL, &tmp);
+						       "_PSV", NULL, &tmp);
 		}
 
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
 			tz->trips.passive.flags.valid = 0;
-		else {
+		} else {
 			tz->trips.passive.temperature = tmp;
 			tz->trips.passive.flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TC1",
-						NULL, &tmp);
+				status = acpi_evaluate_integer(tz->device->handle,
+							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
 				else
 					tz->trips.passive.tc1 = tmp;
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TC2",
-						NULL, &tmp);
+
+				status = acpi_evaluate_integer(tz->device->handle,
+							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
 				else
 					tz->trips.passive.tc2 = tmp;
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TSP",
-						NULL, &tmp);
+
+				status = acpi_evaluate_integer(tz->device->handle,
+							       "_TSP", NULL, &tmp);
 				if (ACPI_FAILURE(status))
 					tz->trips.passive.flags.valid = 0;
 				else
@@ -374,25 +370,25 @@ static int acpi_thermal_trips_update(str
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
-							NULL, &devices);
+						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
-		}
-		else
+		} else {
 			tz->trips.passive.flags.valid = 1;
+		}
 
 		if (memcmp(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list))) {
+			   sizeof(struct acpi_handle_list))) {
 			memcpy(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list));
+			       sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
 		if (valid != tz->trips.passive.flags.valid)
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
+			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
 	/* Active (optional) */
@@ -404,28 +400,30 @@ static int acpi_thermal_trips_update(str
 			break; /* disable all active trip points */
 
 		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
-			tz->trips.active[i].flags.valid)) {
+		    tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
-							name, NULL, &tmp);
+						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
 				tz->trips.active[i].flags.valid = 0;
 				if (i == 0)
 					break;
+
 				if (act <= 0)
 					break;
+
 				if (i == 1)
-					tz->trips.active[0].temperature =
-						celsius_to_deci_kelvin(act);
+					tz->trips.active[0].temperature = celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->trips.active[i - 1].temperature =
-						(tz->trips.active[i - 2].temperature <
+					tz->trips.active[i-1].temperature =
+						(tz->trips.active[i-2].temperature <
 						celsius_to_deci_kelvin(act) ?
-						tz->trips.active[i - 2].temperature :
+						tz->trips.active[i-2].temperature :
 						celsius_to_deci_kelvin(act));
+
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -434,22 +432,22 @@ static int acpi_thermal_trips_update(str
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid ) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
-						name, NULL, &devices);
+							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
-			}
-			else
+			} else {
 				tz->trips.active[i].flags.valid = 1;
+			}
 
 			if (memcmp(&tz->trips.active[i].devices, &devices,
-					sizeof(struct acpi_handle_list))) {
+				   sizeof(struct acpi_handle_list))) {
 				memcpy(&tz->trips.active[i].devices, &devices,
-					sizeof(struct acpi_handle_list));
+				       sizeof(struct acpi_handle_list));
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
@@ -464,9 +462,9 @@ static int acpi_thermal_trips_update(str
 	if (flag & ACPI_TRIPS_DEVICES) {
 		memset(&devices, 0, sizeof(devices));
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						NULL, &devices);
-		if (ACPI_SUCCESS(status)
-		    && memcmp(&tz->devices, &devices, sizeof(devices))) {
+						 NULL, &devices);
+		if (ACPI_SUCCESS(status) &&
+		    memcmp(&tz->devices, &devices, sizeof(devices))) {
 			tz->devices = devices;
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
@@ -548,8 +546,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].flags.valid; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -572,8 +569,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.critical.temperature,
-				tz->kelvin_offset);
+					tz->trips.critical.temperature,
+					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -582,8 +579,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.hot.temperature,
-				tz->kelvin_offset);
+					tz->trips.hot.temperature,
+					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -592,8 +589,8 @@ static int thermal_get_trip_temp(struct
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.passive.temperature,
-				tz->kelvin_offset);
+					tz->trips.passive.temperature,
+					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -603,8 +600,8 @@ static int thermal_get_trip_temp(struct
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.active[i].temperature,
-				tz->kelvin_offset);
+					tz->trips.active[i].temperature,
+					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
@@ -620,15 +617,15 @@ static int thermal_get_crit_temp(struct
 
 	if (tz->trips.critical.flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.critical.temperature,
-				tz->kelvin_offset);
+					tz->trips.critical.temperature,
+					tz->kelvin_offset);
 		return 0;
 	} else
 		return -EINVAL;
 }
 
 static int thermal_get_trend(struct thermal_zone_device *thermal,
-				int trip, enum thermal_trend *trend)
+			     int trip, enum thermal_trend *trend)
 {
 	struct acpi_thermal *tz = thermal->devdata;
 	enum thermal_trip_type type;
@@ -657,9 +654,8 @@ static int thermal_get_trend(struct ther
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature))
-		+ (tz->trips.passive.tc2
-		* (tz->temperature - tz->trips.passive.temperature));
+	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature)) +
+	    (tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -667,6 +663,7 @@ static int thermal_get_trend(struct ther
 		*trend = THERMAL_TREND_DROPPING;
 	else
 		*trend = THERMAL_TREND_STABLE;
+
 	return 0;
 }
 
@@ -691,8 +688,8 @@ static void acpi_thermal_zone_device_cri
 }
 
 static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
-					struct thermal_cooling_device *cdev,
-					bool bind)
+					  struct thermal_cooling_device *cdev,
+					  bool bind)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal->devdata;
@@ -711,22 +708,23 @@ static int acpi_thermal_cooling_device_c
 
 	if (tz->trips.passive.flags.valid) {
 		trip++;
-		for (i = 0; i < tz->trips.passive.devices.count;
-		    i++) {
+		for (i = 0; i < tz->trips.passive.devices.count; i++) {
 			handle = tz->trips.passive.devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
+
 			if (bind)
-				result =
-					thermal_zone_bind_cooling_device
-					(thermal, trip, cdev,
-					 THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
-					 THERMAL_WEIGHT_DEFAULT);
+				result = thermal_zone_bind_cooling_device(
+						thermal, trip, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 			else
 				result =
-					thermal_zone_unbind_cooling_device
-					(thermal, trip, cdev);
+					thermal_zone_unbind_cooling_device(
+						thermal, trip, cdev);
+
 			if (result)
 				goto failed;
 		}
@@ -735,22 +733,24 @@ static int acpi_thermal_cooling_device_c
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips.active[i].flags.valid)
 			break;
+
 		trip++;
-		for (j = 0;
-		    j < tz->trips.active[i].devices.count;
-		    j++) {
+		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
 			handle = tz->trips.active[i].devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
+
 			if (bind)
-				result = thermal_zone_bind_cooling_device
-					(thermal, trip, cdev,
-					 THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
-					 THERMAL_WEIGHT_DEFAULT);
+				result = thermal_zone_bind_cooling_device(
+						thermal, trip, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 			else
-				result = thermal_zone_unbind_cooling_device
-					(thermal, trip, cdev);
+				result = thermal_zone_unbind_cooling_device(
+						thermal, trip, cdev);
+
 			if (result)
 				goto failed;
 		}
@@ -762,14 +762,14 @@ failed:
 
 static int
 acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
-					struct thermal_cooling_device *cdev)
+				 struct thermal_cooling_device *cdev)
 {
 	return acpi_thermal_cooling_device_cb(thermal, cdev, true);
 }
 
 static int
 acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
-					struct thermal_cooling_device *cdev)
+				   struct thermal_cooling_device *cdev)
 {
 	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
 }
@@ -802,20 +802,20 @@ static int acpi_thermal_register_thermal
 	if (tz->trips.passive.flags.valid)
 		trips++;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-			tz->trips.active[i].flags.valid; i++, trips++);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid;
+	     i++, trips++);
 
 	if (tz->trips.passive.flags.valid)
-		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
-						     tz->trips.passive.tsp*100,
-						     tz->polling_frequency*100);
+		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
+								&acpi_thermal_zone_ops, NULL,
+								tz->trips.passive.tsp * 100,
+								tz->polling_frequency * 100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
-						0, tz->polling_frequency*100);
+						     &acpi_thermal_zone_ops, NULL,
+						     0, tz->polling_frequency * 100);
+
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
@@ -881,7 +881,6 @@ static void acpi_thermal_notify(struct a
 {
 	struct acpi_thermal *tz = acpi_driver_data(device);
 
-
 	if (!tz)
 		return;
 
@@ -893,13 +892,13 @@ static void acpi_thermal_notify(struct a
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
 		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
+						dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
 		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
+						dev_name(&device->dev), event, 0);
 		break;
 	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -944,7 +943,6 @@ static int acpi_thermal_get_info(struct
 {
 	int result = 0;
 
-
 	if (!tz)
 		return -EINVAL;
 
@@ -1023,7 +1021,6 @@ static int acpi_thermal_add(struct acpi_
 	int result = 0;
 	struct acpi_thermal *tz = NULL;
 
-
 	if (!device)
 		return -EINVAL;
 
@@ -1099,6 +1096,7 @@ static int acpi_thermal_resume(struct de
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips.active[i].flags.valid)
 			break;
+
 		tz->trips.active[i].flags.enabled = 1;
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
 			result = acpi_bus_update_power(
@@ -1119,7 +1117,6 @@ static int acpi_thermal_resume(struct de
 #endif
 
 static int thermal_act(const struct dmi_system_id *d) {
-
 	if (act == 0) {
 		pr_notice("%s detected: disabling all active thermal trip points\n",
 			  d->ident);
@@ -1128,14 +1125,12 @@ static int thermal_act(const struct dmi_
 	return 0;
 }
 static int thermal_nocrt(const struct dmi_system_id *d) {
-
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
 	nocrt = 1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
-
 	if (tzp == 0) {
 		pr_notice("%s detected: enabling thermal zone polling\n",
 			  d->ident);
@@ -1144,7 +1139,6 @@ static int thermal_tzp(const struct dmi_
 	return 0;
 }
 static int thermal_psv(const struct dmi_system_id *d) {
-
 	if (psv == 0) {
 		pr_notice("%s detected: disabling all passive thermal trip points\n",
 			  d->ident);



