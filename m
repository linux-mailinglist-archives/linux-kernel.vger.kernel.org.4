Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE67A288
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjAXTT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjAXTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:19:16 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412F4ED00;
        Tue, 24 Jan 2023 11:19:13 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 899c60219e9c5128; Tue, 24 Jan 2023 20:19:12 +0100
Received: from kreacher.localnet (unknown [213.134.189.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7D39D7A644A;
        Tue, 24 Jan 2023 20:19:11 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/6] thermal: intel: int340x: Rename variable in int340x_thermal_zone_add()
Date:   Tue, 24 Jan 2023 20:14:52 +0100
Message-ID: <2152349.irdbgypaU6@kreacher>
In-Reply-To: <12159228.O9o76ZdvQC@kreacher>
References: <12159228.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.30
X-CLIENT-HOSTNAME: 213.134.189.30
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekledrfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrfedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename local variable int34x_thermal_zone in int340x_thermal_zone_add()
to int34x_zone which allows a number of code lines to become shorter and
easier to read and adjust some white space for consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   69 +++++------
 1 file changed, 34 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -118,82 +118,81 @@ static struct thermal_zone_params int340
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
-	struct int34x_thermal_zone *int34x_thermal_zone;
+	struct int34x_thermal_zone *int34x_zone;
 	unsigned long long trip_cnt = 0;
 	int trip_mask = 0;
 	acpi_status status;
 	int i, ret;
 
-	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone), GFP_KERNEL);
-	if (!int34x_thermal_zone)
+	int34x_zone = kzalloc(sizeof(*int34x_zone), GFP_KERNEL);
+	if (!int34x_zone)
 		return ERR_PTR(-ENOMEM);
 
-	int34x_thermal_zone->adev = adev;
+	int34x_zone->adev = adev;
 
-	int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
-					   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
-	if (!int34x_thermal_zone->ops) {
+	int34x_zone->ops = kmemdup(&int340x_thermal_zone_ops,
+				   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
+	if (!int34x_zone->ops) {
 		ret = -ENOMEM;
 		goto err_ops_alloc;
 	}
 
 	if (get_temp)
-		int34x_thermal_zone->ops->get_temp = get_temp;
+		int34x_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
 	if (ACPI_SUCCESS(status)) {
-		int34x_thermal_zone->aux_trip_nr = trip_cnt;
+		int34x_zone->aux_trip_nr = trip_cnt;
 		trip_mask = BIT(trip_cnt) - 1;
 	}
 
 	trip_cnt += INT340X_THERMAL_MAX_TRIP_COUNT;
 
-	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) * trip_cnt,
-					     GFP_KERNEL);
-	if (!int34x_thermal_zone->trips) {
+	int34x_zone->trips = kzalloc(sizeof(*int34x_zone->trips) * trip_cnt, GFP_KERNEL);
+	if (!int34x_zone->trips) {
 		ret = -ENOMEM;
 		goto err_trips_alloc;
 	}
 
-	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
+	trip_cnt = int340x_thermal_read_trips(int34x_zone);
 
 	for (i = 0; i < trip_cnt; ++i)
-		int340x_thermal_get_global_hyst(adev, &int34x_thermal_zone->trips[i].hysteresis);
+		int340x_thermal_get_global_hyst(adev, &int34x_zone->trips[i].hysteresis);
 
-	for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
-		int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
-		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
+	for (i = 0; i < int34x_zone->aux_trip_nr; i++) {
+		int34x_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
+		int34x_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
 	}
 
-	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
+	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
-						acpi_device_bid(adev),
-						int34x_thermal_zone->trips,
-						trip_cnt,
-						trip_mask, int34x_thermal_zone,
-						int34x_thermal_zone->ops,
-						&int340x_thermal_params,
-						0, 0);
-	if (IS_ERR(int34x_thermal_zone->zone)) {
-		ret = PTR_ERR(int34x_thermal_zone->zone);
+	int34x_zone->zone = thermal_zone_device_register_with_trips(
+							acpi_device_bid(adev),
+							int34x_zone->trips,
+							trip_cnt,
+							trip_mask, int34x_zone,
+							int34x_zone->ops,
+							&int340x_thermal_params,
+							0, 0);
+	if (IS_ERR(int34x_zone->zone)) {
+		ret = PTR_ERR(int34x_zone->zone);
 		goto err_thermal_zone;
 	}
-	ret = thermal_zone_device_enable(int34x_thermal_zone->zone);
+	ret = thermal_zone_device_enable(int34x_zone->zone);
 	if (ret)
 		goto err_enable;
 
-	return int34x_thermal_zone;
+	return int34x_zone;
 
 err_enable:
-	thermal_zone_device_unregister(int34x_thermal_zone->zone);
+	thermal_zone_device_unregister(int34x_zone->zone);
 err_thermal_zone:
-	kfree(int34x_thermal_zone->trips);
-	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
+	kfree(int34x_zone->trips);
+	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
 err_trips_alloc:
-	kfree(int34x_thermal_zone->ops);
+	kfree(int34x_zone->ops);
 err_ops_alloc:
-	kfree(int34x_thermal_zone);
+	kfree(int34x_zone);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_add);



