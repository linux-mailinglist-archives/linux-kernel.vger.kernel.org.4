Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596A6819A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjA3SsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjA3SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:48:05 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51D269C;
        Mon, 30 Jan 2023 10:47:59 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 53872a6aedc49286; Mon, 30 Jan 2023 19:47:58 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 728A425258B8;
        Mon, 30 Jan 2023 19:47:57 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 2/4] thermal: intel: int340x: Rename variable in int340x_thermal_zone_add()
Date:   Mon, 30 Jan 2023 19:43:32 +0100
Message-ID: <10219014.nUPlyArG6x@kreacher>
In-Reply-To: <2133431.irdbgypaU6@kreacher>
References: <2133431.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhu
 gidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename local variables int34x_thermal_zone in int340x_thermal_zone_add()
and int340x_thermal_zone_remove() to int34x_zone which allows a number
of code lines to be shorter and easier to read and adjust some white
space for consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   67 +++++------
 1 file changed, 33 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -113,7 +113,7 @@ static struct thermal_zone_params int340
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
-	struct int34x_thermal_zone *int34x_thermal_zone;
+	struct int34x_thermal_zone *int34x_zone;
 	struct thermal_trip *zone_trips;
 	unsigned long long trip_cnt = 0;
 	unsigned long long hyst;
@@ -121,25 +121,25 @@ struct int34x_thermal_zone *int340x_ther
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
 
@@ -166,48 +166,47 @@ struct int34x_thermal_zone *int340x_ther
 	for (i = 0; i < trip_cnt; ++i)
 		zone_trips[i].hysteresis = hyst;
 
-	int34x_thermal_zone->trips = zone_trips;
+	int34x_zone->trips = zone_trips;
 
-	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
+	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
-						acpi_device_bid(adev),
-						zone_trips, trip_cnt,
-						trip_mask, int34x_thermal_zone,
-						int34x_thermal_zone->ops,
-						&int340x_thermal_params,
-						0, 0);
-	if (IS_ERR(int34x_thermal_zone->zone)) {
-		ret = PTR_ERR(int34x_thermal_zone->zone);
+	int34x_zone->zone = thermal_zone_device_register_with_trips(
+							acpi_device_bid(adev),
+							zone_trips, trip_cnt,
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
 
-void int340x_thermal_zone_remove(struct int34x_thermal_zone
-				 *int34x_thermal_zone)
+void int340x_thermal_zone_remove(struct int34x_thermal_zone *int34x_zone)
 {
-	thermal_zone_device_unregister(int34x_thermal_zone->zone);
-	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->trips);
-	kfree(int34x_thermal_zone->ops);
-	kfree(int34x_thermal_zone);
+	thermal_zone_device_unregister(int34x_zone->zone);
+	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
+	kfree(int34x_zone->trips);
+	kfree(int34x_zone->ops);
+	kfree(int34x_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
 



