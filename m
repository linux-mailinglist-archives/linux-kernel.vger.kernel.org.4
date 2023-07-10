Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2C74DC60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGJRYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjGJRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196318B;
        Mon, 10 Jul 2023 10:23:42 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b5c09e78fc3b864e; Mon, 10 Jul 2023 19:23:40 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6F417660DCF;
        Mon, 10 Jul 2023 19:23:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 02/14] ACPICA: Modify ACPI_STATE_COMMON
Date:   Mon, 10 Jul 2023 19:12:13 +0200
Message-ID: <2297329.ElGaqSPkdT@kreacher>
In-Reply-To: <5698695.DvuYhMxLoT@kreacher>
References: <5698695.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Guo <guodongtai@kylinos.cn>

ACPICA commit 0a43d3521582b5234f69e8bb535e83325387525a

Avoid trailing semicolons in macro, and it's not readable to put macro ACPI_STATE_COMMON and other
variables in the same line.
So modify the macro and just put it in a single line.

Link: https://github.com/acpica/acpica/commit/0a43d352
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 12d4a024f029..75a81b6c1a16 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -560,25 +560,28 @@ struct acpi_field_info {
 	u8                              descriptor_type; /* To differentiate various internal objs */\
 	u8                              flags; \
 	u16                             value; \
-	u16                             state;
+	u16                             state
 
 	/* There are 2 bytes available here until the next natural alignment boundary */
 
 struct acpi_common_state {
-ACPI_STATE_COMMON};
+	ACPI_STATE_COMMON;
+};
 
 /*
  * Update state - used to traverse complex objects such as packages
  */
 struct acpi_update_state {
-	ACPI_STATE_COMMON union acpi_operand_object *object;
+	ACPI_STATE_COMMON;
+	union acpi_operand_object *object;
 };
 
 /*
  * Pkg state - used to traverse nested package structures
  */
 struct acpi_pkg_state {
-	ACPI_STATE_COMMON u32 index;
+	ACPI_STATE_COMMON;
+	u32 index;
 	union acpi_operand_object *source_object;
 	union acpi_operand_object *dest_object;
 	struct acpi_walk_state *walk_state;
@@ -591,7 +594,8 @@ struct acpi_pkg_state {
  * Allows nesting of these constructs
  */
 struct acpi_control_state {
-	ACPI_STATE_COMMON u16 opcode;
+	ACPI_STATE_COMMON;
+	u16 opcode;
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
@@ -602,11 +606,13 @@ struct acpi_control_state {
  * Scope state - current scope during namespace lookups
  */
 struct acpi_scope_state {
-	ACPI_STATE_COMMON struct acpi_namespace_node *node;
+	ACPI_STATE_COMMON;
+	struct acpi_namespace_node *node;
 };
 
 struct acpi_pscope_state {
-	ACPI_STATE_COMMON u32 arg_count;	/* Number of fixed arguments */
+	ACPI_STATE_COMMON;
+	u32 arg_count;		/* Number of fixed arguments */
 	union acpi_parse_object *op;	/* Current op being parsed */
 	u8 *arg_end;		/* Current argument end */
 	u8 *pkg_end;		/* Current package end */
@@ -618,7 +624,8 @@ struct acpi_pscope_state {
  * states are created when there are nested control methods executing.
  */
 struct acpi_thread_state {
-	ACPI_STATE_COMMON u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
+	ACPI_STATE_COMMON;
+	u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
 	struct acpi_walk_state *walk_state_list;	/* Head of list of walk_states for this thread */
 	union acpi_operand_object *acquired_mutex_list;	/* List of all currently acquired mutexes */
 	acpi_thread_id thread_id;	/* Running thread ID */
@@ -629,8 +636,8 @@ struct acpi_thread_state {
  * AML arguments
  */
 struct acpi_result_values {
-	ACPI_STATE_COMMON
-	    union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
+	ACPI_STATE_COMMON;
+	union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
 };
 
 typedef
@@ -652,7 +659,8 @@ struct acpi_global_notify_handler {
  * handler/dispatcher.
  */
 struct acpi_notify_info {
-	ACPI_STATE_COMMON u8 handler_list_id;
+	ACPI_STATE_COMMON;
+	u8 handler_list_id;
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *handler_list_head;
 	struct acpi_global_notify_handler *global;
-- 
2.35.3




