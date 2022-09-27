Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB575EC8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiI0QBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiI0QBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F93B71B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29168B81C4D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF19C433D6;
        Tue, 27 Sep 2022 16:01:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2h-00G2pH-0L;
        Tue, 27 Sep 2022 12:02:43 -0400
Message-ID: <20220927160242.688382747@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        <mingo@redhat.com>, Zeng Heng <zengheng4@huawei.com>
Subject: [for-next][PATCH 04/20] rv/dot2K: add static qualifier for local variable
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Heng <zengheng4@huawei.com>

Following Daniel's suggestion, fix similar warning
in template files, which would prevent new monitors
from such warning.

Link: https://lkml.kernel.org/r/20220824034357.2014202-3-zengheng4@huawei.com

Cc: <mingo@redhat.com>
Fixes:	24bce201d798 ("tools/rv: Add dot2k")
Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/dot2k_templates/main_global.c   | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_cpu.c  | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_task.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main_global.c
index f4b712dbc92e..dcd1162dced8 100644
--- a/tools/verification/dot2/dot2k_templates/main_global.c
+++ b/tools/verification/dot2/dot2k_templates/main_global.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
index 4080d1ca3354..8f877e86a22f 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_cpu.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
index 89197175384f..8c2fdb824634 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_task.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_task.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
-- 
2.35.1
