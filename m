Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FD5F47A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJDQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJDQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:33:09 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7775E579;
        Tue,  4 Oct 2022 09:33:07 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 636df6776db0d94c; Tue, 4 Oct 2022 18:33:05 +0200
Received: from kreacher.localnet (unknown [213.134.189.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 79EDA6665F6;
        Tue,  4 Oct 2022 18:33:04 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] ACPI: thermal: Drop some redundant code
Date:   Tue, 04 Oct 2022 18:32:52 +0200
Message-ID: <1831358.tdWV9SEqCh@kreacher>
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

Drop some redundant initialization of local variables, a redundant
return statement and a redundant "else" from the ACPI thermal driver.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -262,7 +262,7 @@ do {	\
 
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	unsigned long long tmp;
 	struct acpi_handle_list devices;
 	int valid = 0;
@@ -620,8 +620,9 @@ static int thermal_get_crit_temp(struct
 					tz->trips.critical.temperature,
 					tz->kelvin_offset);
 		return 0;
-	} else
-		return -EINVAL;
+	}
+
+	return -EINVAL;
 }
 
 static int thermal_get_trend(struct thermal_zone_device *thermal,
@@ -941,7 +942,7 @@ static void acpi_thermal_aml_dependency_
 
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
 {
-	int result = 0;
+	int result;
 
 	if (!tz)
 		return -EINVAL;
@@ -1018,8 +1019,8 @@ static void acpi_thermal_check_fn(struct
 
 static int acpi_thermal_add(struct acpi_device *device)
 {
-	int result = 0;
-	struct acpi_thermal *tz = NULL;
+	struct acpi_thermal *tz;
+	int result;
 
 	if (!device)
 		return -EINVAL;
@@ -1060,7 +1061,7 @@ end:
 
 static int acpi_thermal_remove(struct acpi_device *device)
 {
-	struct acpi_thermal *tz = NULL;
+	struct acpi_thermal *tz;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -1189,7 +1190,7 @@ static const struct dmi_system_id therma
 
 static int __init acpi_thermal_init(void)
 {
-	int result = 0;
+	int result;
 
 	dmi_check_system(thermal_dmi_table);
 
@@ -1216,8 +1217,6 @@ static void __exit acpi_thermal_exit(voi
 {
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 	destroy_workqueue(acpi_thermal_pm_queue);
-
-	return;
 }
 
 module_init(acpi_thermal_init);



