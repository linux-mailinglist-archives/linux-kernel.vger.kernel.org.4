Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE160FFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiJ0R7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiJ0R7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:11 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965F1781D8;
        Thu, 27 Oct 2022 10:59:09 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b6fae047edd6fe09; Thu, 27 Oct 2022 19:59:07 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4761F66D838;
        Thu, 27 Oct 2022 19:59:07 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 08/11] ACPICA: Improve warning message for "invalid ACPI name"
Date:   Thu, 27 Oct 2022 19:55:26 +0200
Message-ID: <1745901.VLH7GnMWUR@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 91bef8bea9cd69c33447ba1bfe2c4273994500fd

Added an underscore instead of an (illegal) *

Link: https://github.com/acpica/acpica/commit/91bef8be
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utstring.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/acpica/utstring.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utstring.c
+++ linux-pm/drivers/acpi/acpica/utstring.c
@@ -145,7 +145,7 @@ void acpi_ut_repair_name(char *name)
 		return;
 	}
 
-	ACPI_COPY_NAMESEG(&original_name, name);
+	ACPI_COPY_NAMESEG(&original_name, &name[0]);
 
 	/* Check each character in the name */
 
@@ -156,10 +156,10 @@ void acpi_ut_repair_name(char *name)
 
 		/*
 		 * Replace a bad character with something printable, yet technically
-		 * still invalid. This prevents any collisions with existing "good"
+		 * "odd". This prevents any collisions with existing "good"
 		 * names in the namespace.
 		 */
-		name[i] = '*';
+		name[i] = '_';
 		found_bad_char = TRUE;
 	}
 
@@ -169,8 +169,8 @@ void acpi_ut_repair_name(char *name)
 
 		if (!acpi_gbl_enable_interpreter_slack) {
 			ACPI_WARNING((AE_INFO,
-				      "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",
-				      original_name, name));
+				      "Invalid character(s) in name (0x%.8X) %p, repaired: [%4.4s]",
+				      original_name, name, &name[0]));
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",



