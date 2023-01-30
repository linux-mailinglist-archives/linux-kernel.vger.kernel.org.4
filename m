Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1ED6819F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjA3TID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjA3TH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:57 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FB3A87D;
        Mon, 30 Jan 2023 11:07:39 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 08df841c7d46ca66; Mon, 30 Jan 2023 20:07:37 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B6C6D2528287;
        Mon, 30 Jan 2023 20:07:36 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 1/8] thermal: intel: intel_pch: Make pch_wpt_add_acpi_psv_trip() return int
Date:   Mon, 30 Jan 2023 19:58:32 +0100
Message-ID: <1941501.usQuhbGJ8B@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
References: <1751684.VLH7GnMWUR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify pch_wpt_add_acpi_psv_trip() to return an int value instead of
using a return pointer for that.

While at it, drop an excessive empty code line.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -90,34 +90,31 @@ struct pch_thermal_device {
 };
 
 #ifdef CONFIG_ACPI
-
 /*
  * On some platforms, there is a companion ACPI device, which adds
  * passive trip temperature using _PSV method. There is no specific
  * passive temperature setting in MMIO interface of this PCI device.
  */
-static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
-				      int *nr_trips)
+static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
 {
 	struct acpi_device *adev;
 	int temp;
 
 	adev = ACPI_COMPANION(&ptd->pdev->dev);
 	if (!adev)
-		return;
+		return 0;
 
 	if (thermal_acpi_passive_trip_temp(adev, &temp) || temp <= 0)
-		return;
+		return 0;
 
-	ptd->trips[*nr_trips].type = THERMAL_TRIP_PASSIVE;
-	ptd->trips[*nr_trips].temperature = temp;
-	++(*nr_trips);
+	ptd->trips[trip].type = THERMAL_TRIP_PASSIVE;
+	ptd->trips[trip].temperature = temp;
+	return 1;
 }
 #else
-static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
-				      int *nr_trips)
+static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
 {
-
+	return 0;
 }
 #endif
 
@@ -167,7 +164,7 @@ read_trips:
 		++(*nr_trips);
 	}
 
-	pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
+	*nr_trips += pch_wpt_add_acpi_psv_trip(ptd, *nr_trips);
 
 	return 0;
 }



