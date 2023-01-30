Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9668199F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjA3SsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjA3SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:48:05 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB529157;
        Mon, 30 Jan 2023 10:48:01 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 2e3b141596fad6a6; Mon, 30 Jan 2023 19:47:59 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 11B0525258B8;
        Mon, 30 Jan 2023 19:47:59 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 1/4] thermal: intel: int340x: Assorted minor cleanups
Date:   Mon, 30 Jan 2023 19:42:16 +0100
Message-ID: <3220135.44csPzL39Z@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Improve some inconsistent usage of white space in int340x_thermal_zone.c,
fix up one coding style issue in it (missing braces around an else
branch of a conditional) and while at it replace a !ACPI_FAILURE()
check with an equivalent ACPI_SUCCESS() one.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase
   * Skip trip_cnt update
   * More white space adjustments

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   16 ++++-------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -30,15 +30,16 @@ static int int340x_thermal_get_zone_temp
 			return conv_temp;
 
 		*temp = (unsigned long)conv_temp * 10;
-	} else
+	} else {
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
 		*temp = deci_kelvin_to_millicelsius(tmp);
+	}
 
 	return 0;
 }
 
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int temp)
+					 int trip, int temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
 	acpi_status status;
@@ -46,7 +47,7 @@ static int int340x_thermal_set_trip_temp
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			millicelsius_to_deci_kelvin(temp));
+					    millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -92,7 +93,6 @@ static int int340x_thermal_read_trips(st
 	}
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-
 		ret = thermal_acpi_active_trip_temp(zone_adev, i,
 						    &zone_trips[trip_cnt].temperature);
 		if (ret)
@@ -121,8 +121,7 @@ struct int34x_thermal_zone *int340x_ther
 	acpi_status status;
 	int i, ret;
 
-	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
-				      GFP_KERNEL);
+	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone), GFP_KERNEL);
 	if (!int34x_thermal_zone)
 		return ERR_PTR(-ENOMEM);
 
@@ -139,7 +138,7 @@ struct int34x_thermal_zone *int340x_ther
 		int34x_thermal_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (!ACPI_FAILURE(status)) {
+	if (ACPI_SUCCESS(status)) {
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
 		trip_mask = BIT(trip_cnt) - 1;
 	}
@@ -169,8 +168,7 @@ struct int34x_thermal_zone *int340x_ther
 
 	int34x_thermal_zone->trips = zone_trips;
 
-	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
-								adev->handle);
+	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
 	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),



