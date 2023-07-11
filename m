Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274674EBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGKKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGKKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:38:28 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218111A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:38:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2b42:575f:41f:104f])
        by albert.telenet-ops.be with bizsmtp
        id KmeP2A0024w94eT06mePsZ; Tue, 11 Jul 2023 12:38:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJAl6-0017MR-5u;
        Tue, 11 Jul 2023 12:38:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJAlC-00Clyk-VC;
        Tue, 11 Jul 2023 12:38:22 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] workqueue: Fix cpu_intensive_thresh_us name in help text
Date:   Tue, 11 Jul 2023 12:38:20 +0200
Message-Id: <5fc042e1d3c5d63b9367a1e1587dcf6b548087ff.1689071768.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists no parameter called "cpu_intensive_threshold_us".
The actual parameter name is "cpu_intensive_thresh_us".

Fixes: 6363845005202148 ("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8371502b4b2e678..5da00849edebafdd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1200,7 +1200,7 @@ config WQ_CPU_INTENSIVE_REPORT
 	help
 	  Say Y here to enable reporting of concurrency-managed per-cpu work
 	  items that hog CPUs for longer than
-	  workqueue.cpu_intensive_threshold_us. Workqueue automatically
+	  workqueue.cpu_intensive_thresh_us. Workqueue automatically
 	  detects and excludes them from concurrency management to prevent
 	  them from stalling other per-cpu work items. Occassional
 	  triggering may not necessarily indicate a problem. Repeated
-- 
2.34.1

