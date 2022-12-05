Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88580643117
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiLETIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLETIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:08:23 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59878E0E9;
        Mon,  5 Dec 2022 11:08:21 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 7ac16176b1bff097; Mon, 5 Dec 2022 20:08:19 +0100
Received: from kreacher.localnet (unknown [213.134.188.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0501A2801EA0;
        Mon,  5 Dec 2022 20:08:18 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/5] ACPI: processor: perflib: Adjust white space
Date:   Mon, 05 Dec 2022 20:03:30 +0100
Message-ID: <13154277.uLZWGnKmhe@kreacher>
In-Reply-To: <1836012.tdWV9SEqCh@kreacher>
References: <1836012.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.181
X-CLIENT-HOSTNAME: 213.134.188.181
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeekrddukedunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
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

Some inconsistent usage of white space in the ACPI processor performance
library code causes that code to be somewhat harder to read that it
would have been otherwise, so adjust the white space in there to
address that.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -142,6 +142,7 @@ int acpi_processor_get_bios_limit(int cp
 	pr = per_cpu(processors, cpu);
 	if (!pr || !pr->performance || !pr->performance->state_count)
 		return -ENODEV;
+
 	*limit = pr->performance->states[pr->performance_platform_limit].
 		core_frequency * 1000;
 	return 0;
@@ -201,8 +202,7 @@ static int acpi_processor_get_performanc
 	}
 
 	pct = (union acpi_object *)buffer.pointer;
-	if (!pct || (pct->type != ACPI_TYPE_PACKAGE)
-	    || (pct->package.count != 2)) {
+	if (!pct || (pct->type != ACPI_TYPE_PACKAGE) || (pct->package.count != 2)) {
 		pr_err("Invalid _PCT data\n");
 		result = -EFAULT;
 		goto end;
@@ -214,9 +214,9 @@ static int acpi_processor_get_performanc
 
 	obj = pct->package.elements[0];
 
-	if ((obj.type != ACPI_TYPE_BUFFER)
-	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
-	    || (obj.buffer.pointer == NULL)) {
+	if ((obj.type != ACPI_TYPE_BUFFER) ||
+	    (obj.buffer.length < sizeof(struct acpi_pct_register)) ||
+	    (obj.buffer.pointer == NULL)) {
 		pr_err("Invalid _PCT data (control_register)\n");
 		result = -EFAULT;
 		goto end;
@@ -230,9 +230,9 @@ static int acpi_processor_get_performanc
 
 	obj = pct->package.elements[1];
 
-	if ((obj.type != ACPI_TYPE_BUFFER)
-	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
-	    || (obj.buffer.pointer == NULL)) {
+	if ((obj.type != ACPI_TYPE_BUFFER) ||
+	    (obj.buffer.length < sizeof(struct acpi_pct_register)) ||
+	    (obj.buffer.pointer == NULL)) {
 		pr_err("Invalid _PCT data (status_register)\n");
 		result = -EFAULT;
 		goto end;
@@ -260,8 +260,8 @@ static void amd_fixup_frequency(struct a
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return;
 
-	if ((boot_cpu_data.x86 == 0x10 && boot_cpu_data.x86_model < 10)
-	    || boot_cpu_data.x86 == 0x11) {
+	if ((boot_cpu_data.x86 == 0x10 && boot_cpu_data.x86_model < 10) ||
+	    boot_cpu_data.x86 == 0x11) {
 		rdmsr(MSR_AMD_PSTATE_DEF_BASE + index, lo, hi);
 		/*
 		 * MSR C001_0064+:
@@ -353,8 +353,7 @@ static int acpi_processor_get_performanc
 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
 		 */
 		if (!px->core_frequency ||
-		    ((u32)(px->core_frequency * 1000) !=
-		     (px->core_frequency * 1000))) {
+		    ((u32)(px->core_frequency * 1000) != (px->core_frequency * 1000))) {
 			pr_err(FW_BUG
 			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
 			       pr->id, px->core_frequency);
@@ -499,7 +498,6 @@ int acpi_processor_notify_smm(struct mod
 
 	return 0;
 }
-
 EXPORT_SYMBOL(acpi_processor_notify_smm);
 
 int acpi_processor_get_psd(acpi_handle handle, struct acpi_psd_package *pdomain)
@@ -532,8 +530,7 @@ int acpi_processor_get_psd(acpi_handle h
 	state.length = sizeof(struct acpi_psd_package);
 	state.pointer = pdomain;
 
-	status = acpi_extract_package(&(psd->package.elements[0]),
-		&format, &state);
+	status = acpi_extract_package(&(psd->package.elements[0]), &format, &state);
 	if (ACPI_FAILURE(status)) {
 		pr_err("Invalid _PSD data\n");
 		result = -EFAULT;
@@ -716,9 +713,8 @@ err_out:
 }
 EXPORT_SYMBOL(acpi_processor_preregister_performance);
 
-int
-acpi_processor_register_performance(struct acpi_processor_performance
-				    *performance, unsigned int cpu)
+int acpi_processor_register_performance(struct acpi_processor_performance
+					*performance, unsigned int cpu)
 {
 	struct acpi_processor *pr;
 
@@ -751,7 +747,6 @@ acpi_processor_register_performance(stru
 	mutex_unlock(&performance_mutex);
 	return 0;
 }
-
 EXPORT_SYMBOL(acpi_processor_register_performance);
 
 void acpi_processor_unregister_performance(unsigned int cpu)
@@ -768,11 +763,11 @@ void acpi_processor_unregister_performan
 
 	if (pr->performance)
 		kfree(pr->performance->states);
+
 	pr->performance = NULL;
 
 	mutex_unlock(&performance_mutex);
 
 	return;
 }
-
 EXPORT_SYMBOL(acpi_processor_unregister_performance);



