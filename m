Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6504D708D93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjESCAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:00:13 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B733B1;
        Thu, 18 May 2023 19:00:12 -0700 (PDT)
X-UUID: 4f119d6a5f4440ccbdf3eff96ed4a29c-20230519
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:15b1968c-2a15-494c-bc6f-76e4ca7e0b0b,IP:20,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:15b1968c-2a15-494c-bc6f-76e4ca7e0b0b,IP:20,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:c25fa73b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230519095749JEPZGPDY,BulkQuantity:1,Recheck:0,SF:17|19|44|24|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4f119d6a5f4440ccbdf3eff96ed4a29c-20230519
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <lijun01@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1672911445; Fri, 19 May 2023 10:00:04 +0800
From:   lijun <lijun01@kylinos.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, evel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] add a new line after ACPI_STATE_COMMON
Date:   Fri, 19 May 2023 10:00:02 +0800
Message-Id: <20230519020002.1810433-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: lijun <lijun01@kylinos.cn>
Change-Id: Ia3938ed42d2412548f2151f3de9ed6e7b65443af
---
 drivers/acpi/acpica/aclocal.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ea52576f0a2..019eb5eff414 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -564,14 +564,16 @@ ACPI_STATE_COMMON};
  * Update state - used to traverse complex objects such as packages
  */
 struct acpi_update_state {
-	ACPI_STATE_COMMON union acpi_operand_object *object;
+	ACPI_STATE_COMMON
+	union acpi_operand_object *object;
 };
 
 /*
  * Pkg state - used to traverse nested package structures
  */
 struct acpi_pkg_state {
-	ACPI_STATE_COMMON u32 index;
+	ACPI_STATE_COMMON
+	u32 index;
 	union acpi_operand_object *source_object;
 	union acpi_operand_object *dest_object;
 	struct acpi_walk_state *walk_state;
@@ -584,7 +586,8 @@ struct acpi_pkg_state {
  * Allows nesting of these constructs
  */
 struct acpi_control_state {
-	ACPI_STATE_COMMON u16 opcode;
+	ACPI_STATE_COMMON
+	u16 opcode;
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
@@ -595,11 +598,13 @@ struct acpi_control_state {
  * Scope state - current scope during namespace lookups
  */
 struct acpi_scope_state {
-	ACPI_STATE_COMMON struct acpi_namespace_node *node;
+	ACPI_STATE_COMMON
+	struct acpi_namespace_node *node;
 };
 
 struct acpi_pscope_state {
-	ACPI_STATE_COMMON u32 arg_count;	/* Number of fixed arguments */
+	ACPI_STATE_COMMON
+	u32 arg_count;	/* Number of fixed arguments */
 	union acpi_parse_object *op;	/* Current op being parsed */
 	u8 *arg_end;		/* Current argument end */
 	u8 *pkg_end;		/* Current package end */
@@ -611,7 +616,8 @@ struct acpi_pscope_state {
  * states are created when there are nested control methods executing.
  */
 struct acpi_thread_state {
-	ACPI_STATE_COMMON u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
+	ACPI_STATE_COMMON
+	u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
 	struct acpi_walk_state *walk_state_list;	/* Head of list of walk_states for this thread */
 	union acpi_operand_object *acquired_mutex_list;	/* List of all currently acquired mutexes */
 	acpi_thread_id thread_id;	/* Running thread ID */
@@ -645,7 +651,8 @@ struct acpi_global_notify_handler {
  * handler/dispatcher.
  */
 struct acpi_notify_info {
-	ACPI_STATE_COMMON u8 handler_list_id;
+	ACPI_STATE_COMMON
+	u8 handler_list_id;
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *handler_list_head;
 	struct acpi_global_notify_handler *global;
-- 
2.25.1

