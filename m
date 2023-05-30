Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2654716774
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjE3PqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjE3PqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:46:05 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D34EC;
        Tue, 30 May 2023 08:46:02 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 6c2c6a71edbb085d; Tue, 30 May 2023 17:46:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 357E18BB094;
        Tue, 30 May 2023 17:46:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 2/5] ACPI: thermal: Drop redundant ACPI_TRIPS_REFRESH_DEVICES symbol
Date:   Tue, 30 May 2023 17:44:21 +0200
Message-ID: <8222291.T7Z3S40VBb@kreacher>
In-Reply-To: <5675481.DvuYhMxLoT@kreacher>
References: <5675481.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehm
 ihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the ACPI_TRIPS_REFRESH_DEVICES symbol which is redundant, because
ACPI_TRIPS_DEVICES can be used directly instead of it without any
drawbacks and rename the ACPI_TRIPS_REFRESH_THRESHOLDS to
ACPI_TRIPS_THRESHOLDS to make the code a bit more consistent.

While at it, fix up some formatting white space used in the symbol
definitions.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -238,12 +238,11 @@ static int acpi_thermal_set_cooling_mode
 #define ACPI_TRIPS_ACTIVE	BIT(3)
 #define ACPI_TRIPS_DEVICES	BIT(4)
 
-#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
-#define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
+#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
 
-#define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT |	\
-			      ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE |	\
-			      ACPI_TRIPS_DEVICES)
+#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
+				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
+				 ACPI_TRIPS_DEVICES)
 
 /*
  * This exception is thrown out in two cases:
@@ -906,13 +905,13 @@ static void acpi_thermal_notify(struct a
 		acpi_queue_thermal_check(tz);
 		break;
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
-		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
+		acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
 		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
-		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
+		acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
 		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						dev_name(&device->dev), event, 0);



