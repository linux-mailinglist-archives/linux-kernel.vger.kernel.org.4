Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D5643116
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiLETIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiLETIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:08:22 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B739E0B9;
        Mon,  5 Dec 2022 11:08:19 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id c49bb09df78b58ef; Mon, 5 Dec 2022 20:08:18 +0100
Received: from kreacher.localnet (unknown [213.134.188.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5B6622801EA0;
        Mon,  5 Dec 2022 20:08:17 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/5] ACPI: processor: perflib: Drop redundant parentheses
Date:   Mon, 05 Dec 2022 20:04:59 +0100
Message-ID: <3202314.aeNJFYEL58@kreacher>
In-Reply-To: <1836012.tdWV9SEqCh@kreacher>
References: <1836012.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.181
X-CLIENT-HOSTNAME: 213.134.188.181
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeekrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop some redundant parentheses and rearrange some checks using them
in the ACPI processor performance library code for better code clarity.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -202,7 +202,7 @@ static int acpi_processor_get_performanc
 	}
 
 	pct = (union acpi_object *)buffer.pointer;
-	if (!pct || (pct->type != ACPI_TYPE_PACKAGE) || (pct->package.count != 2)) {
+	if (!pct || pct->type != ACPI_TYPE_PACKAGE || pct->package.count != 2) {
 		pr_err("Invalid _PCT data\n");
 		result = -EFAULT;
 		goto end;
@@ -214,9 +214,8 @@ static int acpi_processor_get_performanc
 
 	obj = pct->package.elements[0];
 
-	if ((obj.type != ACPI_TYPE_BUFFER) ||
-	    (obj.buffer.length < sizeof(struct acpi_pct_register)) ||
-	    (obj.buffer.pointer == NULL)) {
+	if (!obj.buffer.pointer || obj.type != ACPI_TYPE_BUFFER ||
+	    obj.buffer.length < sizeof(struct acpi_pct_register)) {
 		pr_err("Invalid _PCT data (control_register)\n");
 		result = -EFAULT;
 		goto end;
@@ -230,9 +229,8 @@ static int acpi_processor_get_performanc
 
 	obj = pct->package.elements[1];
 
-	if ((obj.type != ACPI_TYPE_BUFFER) ||
-	    (obj.buffer.length < sizeof(struct acpi_pct_register)) ||
-	    (obj.buffer.pointer == NULL)) {
+	if (!obj.buffer.pointer || obj.type != ACPI_TYPE_BUFFER ||
+	    obj.buffer.length < sizeof(struct acpi_pct_register)) {
 		pr_err("Invalid _PCT data (status_register)\n");
 		result = -EFAULT;
 		goto end;
@@ -300,7 +298,7 @@ static int acpi_processor_get_performanc
 	}
 
 	pss = buffer.pointer;
-	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
+	if (!pss || pss->type != ACPI_TYPE_PACKAGE) {
 		pr_err("Invalid _PSS data\n");
 		result = -EFAULT;
 		goto end;
@@ -353,7 +351,7 @@ static int acpi_processor_get_performanc
 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
 		 */
 		if (!px->core_frequency ||
-		    ((u32)(px->core_frequency * 1000) != (px->core_frequency * 1000))) {
+		    (u32)(px->core_frequency * 1000) != px->core_frequency * 1000) {
 			pr_err(FW_BUG
 			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
 			       pr->id, px->core_frequency);
@@ -515,7 +513,7 @@ int acpi_processor_get_psd(acpi_handle h
 	}
 
 	psd = buffer.pointer;
-	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
+	if (!psd || psd->type != ACPI_TYPE_PACKAGE) {
 		pr_err("Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;



