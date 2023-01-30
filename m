Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992AC6819EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjA3THs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjA3THm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:42 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2333A867;
        Mon, 30 Jan 2023 11:07:36 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id f1e5e01fe10671b7; Mon, 30 Jan 2023 20:07:34 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9535D2528287;
        Mon, 30 Jan 2023 20:07:33 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 3/8] thermal: intel: intel_pch: Rename device operations callbacks
Date:   Mon, 30 Jan 2023 20:00:48 +0100
Message-ID: <2546853.Lt9SDvczpP@kreacher>
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

Because the same device operations callbacks are used for all supported
boards, they are in fact generic, so rename them to reflect that.

Also rename the operations object itself for consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   34 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -118,7 +118,7 @@ static int pch_wpt_add_acpi_psv_trip(str
 }
 #endif
 
-static int pch_wpt_init(struct pch_thermal_device *ptd)
+static int pch_hw_init(struct pch_thermal_device *ptd)
 {
 	int nr_trips = 0;
 	u16 trip_temp;
@@ -164,13 +164,13 @@ read_trips:
 	return nr_trips + pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
 }
 
-static int pch_wpt_get_temp(struct pch_thermal_device *ptd)
+static int pch_get_temp(struct pch_thermal_device *ptd)
 {
 	return GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 }
 
 /* Cool the PCH when it's overheat in .suspend_noirq phase */
-static int pch_wpt_suspend(struct pch_thermal_device *ptd)
+static int pch_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
 	int pch_delay_cnt = 0;
@@ -237,7 +237,7 @@ static int pch_wpt_suspend(struct pch_th
 	return 0;
 }
 
-static int pch_wpt_resume(struct pch_thermal_device *ptd)
+static int pch_resume(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
 
@@ -258,13 +258,11 @@ struct pch_dev_ops {
 	int (*resume)(struct pch_thermal_device *ptd);
 };
 
-
-/* dev ops for Wildcat Point */
-static const struct pch_dev_ops pch_dev_ops_wpt = {
-	.hw_init = pch_wpt_init,
-	.get_temp = pch_wpt_get_temp,
-	.suspend = pch_wpt_suspend,
-	.resume = pch_wpt_resume,
+static const struct pch_dev_ops pch_dev_ops = {
+	.hw_init = pch_hw_init,
+	.get_temp = pch_get_temp,
+	.suspend = pch_suspend,
+	.resume = pch_resume,
 };
 
 static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
@@ -301,31 +299,31 @@ static const struct board_info {
 } board_info[] = {
 	[board_hsw] = {
 		.name = "pch_haswell",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_wpt] = {
 		.name = "pch_wildcat_point",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_skl] = {
 		.name = "pch_skylake",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_cnl] = {
 		.name = "pch_cannonlake",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_cml] = {
 		.name = "pch_cometlake",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_lwb] = {
 		.name = "pch_lewisburg",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 	[board_wbg] = {
 		.name = "pch_wellsburg",
-		.ops = &pch_dev_ops_wpt,
+		.ops = &pch_dev_ops,
 	},
 };
 



