Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8302F7216DB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFDMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFDMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:21:26 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8BB5;
        Sun,  4 Jun 2023 05:21:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 8ec5ac0ee5eac291; Sun, 4 Jun 2023 14:21:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C13BB963C55;
        Sun,  4 Jun 2023 14:21:22 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/7] ACPI: thermal: Move symbol definitions to one place
Date:   Sun, 04 Jun 2023 14:15:20 +0200
Message-ID: <21917932.EfDdHjke4D@kreacher>
In-Reply-To: <2703629.mvXUDI8C0e@kreacher>
References: <2703629.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehm
 ihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move all of the symbol definitions to the initial part of the code so
they all can be found in one place.

While at it, consolidate white space used in there.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
---

v1 -> v2: Added R-by from Michal.

---
 drivers/acpi/thermal.c |   58 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -40,8 +40,35 @@
 #define ACPI_THERMAL_NOTIFY_HOT		0xF1
 #define ACPI_THERMAL_MODE_ACTIVE	0x00
 
-#define ACPI_THERMAL_MAX_ACTIVE	10
-#define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
+#define ACPI_THERMAL_MAX_ACTIVE		10
+#define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
+
+#define ACPI_TRIPS_CRITICAL	BIT(0)
+#define ACPI_TRIPS_HOT		BIT(1)
+#define ACPI_TRIPS_PASSIVE	BIT(2)
+#define ACPI_TRIPS_ACTIVE	BIT(3)
+#define ACPI_TRIPS_DEVICES	BIT(4)
+
+#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
+
+#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
+				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
+				 ACPI_TRIPS_DEVICES)
+
+/*
+ * This exception is thrown out in two cases:
+ * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
+ *   when re-evaluating the AML code.
+ * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
+ *   We need to re-bind the cooling devices of a thermal zone when this occurs.
+ */
+#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str) \
+do { \
+	if (flags != ACPI_TRIPS_INIT) \
+		acpi_handle_info(tz->device->handle, \
+			"ACPI thermal trip point %s changed\n" \
+			"Please report to linux-acpi@vger.kernel.org\n", str); \
+} while (0)
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
@@ -232,33 +259,6 @@ static int acpi_thermal_set_cooling_mode
 	return 0;
 }
 
-#define ACPI_TRIPS_CRITICAL	BIT(0)
-#define ACPI_TRIPS_HOT		BIT(1)
-#define ACPI_TRIPS_PASSIVE	BIT(2)
-#define ACPI_TRIPS_ACTIVE	BIT(3)
-#define ACPI_TRIPS_DEVICES	BIT(4)
-
-#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
-
-#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
-				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
-				 ACPI_TRIPS_DEVICES)
-
-/*
- * This exception is thrown out in two cases:
- * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
- *   when re-evaluating the AML code.
- * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
- *   We need to re-bind the cooling devices of a thermal zone when this occurs.
- */
-#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str)	\
-do {	\
-	if (flags != ACPI_TRIPS_INIT)	\
-		acpi_handle_info(tz->device->handle,	\
-		"ACPI thermal trip point %s changed\n"	\
-		"Please report to linux-acpi@vger.kernel.org\n", str); \
-} while (0)
-
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;



