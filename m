Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892E5F47AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJDQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJDQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:33:09 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E25E65F;
        Tue,  4 Oct 2022 09:33:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e0dca31dcbf500c5; Tue, 4 Oct 2022 18:33:06 +0200
Received: from kreacher.localnet (unknown [213.134.189.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 139566665FB;
        Tue,  4 Oct 2022 18:33:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] ACPI: thermal: Drop redundant parens from expressions
Date:   Tue, 04 Oct 2022 18:32:08 +0200
Message-ID: <2256715.ElGaqSPkdT@kreacher>
In-Reply-To: <12068304.O9o76ZdvQC@kreacher>
References: <12068304.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.18
X-CLIENT-HOSTNAME: 213.134.189.18
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekledrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrudekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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

Some expressions in the ACPI thermal driver contain redundant
parentheses.  Drop them.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -326,7 +326,7 @@ static int acpi_thermal_trips_update(str
 
 	/* Passive (optional) */
 	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
-	    (flag == ACPI_TRIPS_INIT)) {
+	    flag == ACPI_TRIPS_INIT) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -399,7 +399,7 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
 		    tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
@@ -654,8 +654,8 @@ static int thermal_get_trend(struct ther
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature)) +
-	    (tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature));
+	i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
+	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature);
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;



