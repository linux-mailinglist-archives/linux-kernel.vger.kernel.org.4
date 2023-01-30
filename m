Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8426819E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjA3THf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjA3THc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:32 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA933800F;
        Mon, 30 Jan 2023 11:07:29 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 9fd19c7a651f5ead; Mon, 30 Jan 2023 20:07:28 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 851A12528287;
        Mon, 30 Jan 2023 20:07:27 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 7/8] thermal: intel: intel_pch: Rename board ID symbols
Date:   Mon, 30 Jan 2023 20:04:55 +0100
Message-ID: <2144306.Icojqenx9y@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
References: <1751684.VLH7GnMWUR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use capitals in the names of the board ID symbols and add the PCH_
prefix to each of them for consistency.

Also rename the board_ids enum accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -135,38 +135,38 @@ static struct thermal_zone_device_ops tz
 	.critical = pch_critical,
 };
 
-enum board_ids {
-	board_hsw,
-	board_wpt,
-	board_skl,
-	board_cnl,
-	board_cml,
-	board_lwb,
-	board_wbg,
+enum pch_board_ids {
+	PCH_BOARD_HSW = 0,
+	PCH_BOARD_WPT,
+	PCH_BOARD_SKL,
+	PCH_BOARD_CNL,
+	PCH_BOARD_CML,
+	PCH_BOARD_LWB,
+	PCH_BOARD_WBG,
 };
 
 static const struct board_info {
 	const char *name;
 } board_info[] = {
-	[board_hsw] = {
+	[PCH_BOARD_HSW] = {
 		.name = "pch_haswell",
 	},
-	[board_wpt] = {
+	[PCH_BOARD_WPT] = {
 		.name = "pch_wildcat_point",
 	},
-	[board_skl] = {
+	[PCH_BOARD_SKL] = {
 		.name = "pch_skylake",
 	},
-	[board_cnl] = {
+	[PCH_BOARD_CNL] = {
 		.name = "pch_cannonlake",
 	},
-	[board_cml] = {
+	[PCH_BOARD_CML] = {
 		.name = "pch_cometlake",
 	},
-	[board_lwb] = {
+	[PCH_BOARD_LWB] = {
 		.name = "pch_lewisburg",
 	},
-	[board_wbg] = {
+	[PCH_BOARD_WBG] = {
 		.name = "pch_wellsburg",
 	},
 };
@@ -174,7 +174,7 @@ static const struct board_info {
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
-	enum board_ids board_id = id->driver_data;
+	enum pch_board_ids board_id = id->driver_data;
 	const struct board_info *bi = &board_info[board_id];
 	struct pch_thermal_device *ptd;
 	u16 trip_temp;
@@ -372,27 +372,27 @@ static int intel_pch_thermal_resume(stru
 
 static const struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_1),
-		.driver_data = board_hsw, },
+		.driver_data = PCH_BOARD_HSW, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_2),
-		.driver_data = board_hsw, },
+		.driver_data = PCH_BOARD_HSW, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT),
-		.driver_data = board_wpt, },
+		.driver_data = PCH_BOARD_WPT, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL),
-		.driver_data = board_skl, },
+		.driver_data = PCH_BOARD_SKL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
-		.driver_data = board_skl, },
+		.driver_data = PCH_BOARD_SKL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL),
-		.driver_data = board_cnl, },
+		.driver_data = PCH_BOARD_CNL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
-		.driver_data = board_cnl, },
+		.driver_data = PCH_BOARD_CNL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_LP),
-		.driver_data = board_cnl, },
+		.driver_data = PCH_BOARD_CNL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CML_H),
-		.driver_data = board_cml, },
+		.driver_data = PCH_BOARD_CML, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
-		.driver_data = board_lwb, },
+		.driver_data = PCH_BOARD_LWB, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WBG),
-		.driver_data = board_wbg, },
+		.driver_data = PCH_BOARD_WBG, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);



