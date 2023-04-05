Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F646D7E90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbjDEOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjDEODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:39 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1E525B;
        Wed,  5 Apr 2023 07:01:46 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 6bc4c385f572d997; Wed, 5 Apr 2023 16:01:24 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CA9B11B4EA6F;
        Wed,  5 Apr 2023 16:01:23 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/32] ACPICA: acpisrc: Add missing tables to astable
Date:   Wed, 05 Apr 2023 15:35:31 +0200
Message-ID: <3256109.44csPzL39Z@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pedro Falcato <pedro.falcato@gmail.com>

ACPICA commit d4a2c93198cdd9c6f4a83798345851fee96d5ca5

Also renames struct acpi_data_table_mapping's struct to
struct acpi_data_table_mapping, just so conversion goes smoothly.

Link: https://github.com/acpica/acpica/commit/d4a2c931
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evrgnini.c | 4 ++--
 drivers/acpi/acpica/exregion.c | 4 ++--
 include/acpi/actypes.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index ca4ba6b351fe..792d1a5f0052 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -430,7 +430,7 @@ acpi_ev_data_table_region_setup(acpi_handle handle,
 {
 	union acpi_operand_object *region_desc =
 	    (union acpi_operand_object *)handle;
-	struct acpi_data_table_space_context *local_region_context;
+	struct acpi_data_table_mapping *local_region_context;
 
 	ACPI_FUNCTION_TRACE(ev_data_table_region_setup);
 
@@ -445,7 +445,7 @@ acpi_ev_data_table_region_setup(acpi_handle handle,
 	/* Create a new context */
 
 	local_region_context =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_data_table_space_context));
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_data_table_mapping));
 	if (!(local_region_context)) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 4ff35852c0b3..6d4a4cc14850 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -509,12 +509,12 @@ acpi_ex_data_table_space_handler(u32 function,
 				 u64 *value,
 				 void *handler_context, void *region_context)
 {
-	struct acpi_data_table_space_context *mapping;
+	struct acpi_data_table_mapping *mapping;
 	char *pointer;
 
 	ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
 
-	mapping = (struct acpi_data_table_space_context *) region_context;
+	mapping = (struct acpi_data_table_mapping *) region_context;
 	pointer = ACPI_CAST_PTR(char, mapping->pointer) +
 	    (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 95e4f56f9754..46878cbb7d39 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1240,7 +1240,7 @@ struct acpi_mem_space_context {
 	struct acpi_mem_mapping *first_mm;
 };
 
-struct acpi_data_table_space_context {
+struct acpi_data_table_mapping {
 	void *pointer;
 };
 
-- 
2.35.3




