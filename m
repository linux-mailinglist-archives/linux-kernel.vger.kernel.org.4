Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A39708E70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjESDr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESDry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:47:54 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0759183;
        Thu, 18 May 2023 20:47:51 -0700 (PDT)
X-UUID: db552eac63e74346acb950bb270ce840-20230519
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e8bff93f-6c4d-476a-9c4c-5a3306c8d5a1,IP:20,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-INFO: VERSION:1.1.22,REQID:e8bff93f-6c4d-476a-9c4c-5a3306c8d5a1,IP:20,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-20
X-CID-META: VersionHash:120426c,CLOUDID:1c0a58c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:2305191142541VNJAY6F,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: db552eac63e74346acb950bb270ce840-20230519
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <lijun01@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1480332580; Fri, 19 May 2023 11:47:39 +0800
From:   lijun <lijun01@kylinos.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, evel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: add a new line after ACPI_STATE_COMMON
Date:   Fri, 19 May 2023 11:47:36 +0800
Message-Id: <20230519034736.3006661-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when i read here ,the "ACPI_STATE_COMMON" before the "u8", I feel confused,
"ACPI_STATE_COMMON" and "u8" in a same line ，just looks cleaner,
but causing poor readability.

Signed-off-by: lijun <lijun01@kylinos.cn>
---
 drivers/acpi/acpica/aclocal.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 12d4a024f029..439b7bca4d75 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -571,14 +571,16 @@ ACPI_STATE_COMMON};
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
@@ -591,7 +593,8 @@ struct acpi_pkg_state {
  * Allows nesting of these constructs
  */
 struct acpi_control_state {
-	ACPI_STATE_COMMON u16 opcode;
+	ACPI_STATE_COMMON
+	u16 opcode;
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
@@ -602,11 +605,13 @@ struct acpi_control_state {
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
@@ -618,7 +623,8 @@ struct acpi_pscope_state {
  * states are created when there are nested control methods executing.
  */
 struct acpi_thread_state {
-	ACPI_STATE_COMMON u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
+	ACPI_STATE_COMMON
+	u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
 	struct acpi_walk_state *walk_state_list;	/* Head of list of walk_states for this thread */
 	union acpi_operand_object *acquired_mutex_list;	/* List of all currently acquired mutexes */
 	acpi_thread_id thread_id;	/* Running thread ID */
@@ -652,7 +658,8 @@ struct acpi_global_notify_handler {
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

