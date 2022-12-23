Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA74654DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiLWJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:02:25 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C473413F1D;
        Fri, 23 Dec 2022 01:02:24 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 096AF1E80D9F;
        Fri, 23 Dec 2022 16:57:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M1yD8bPgDfRs; Fri, 23 Dec 2022 16:57:11 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 39D851E80D96;
        Fri, 23 Dec 2022 16:57:11 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel.nfschina.com@lists.nfsmail.com,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] drivers/acpi:remove unnecessary (void*) conversions
Date:   Fri, 23 Dec 2022 17:02:15 +0800
Message-Id: <20221223090215.8704-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void * type pointer does not need to be cast.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4556c86c3465..3be86d2f9098 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -150,7 +150,7 @@ static void lapic_timer_check_state(int state, struct acpi_processor *pr,
 
 static void __lapic_timer_propagate_broadcast(void *arg)
 {
-	struct acpi_processor *pr = (struct acpi_processor *) arg;
+	struct acpi_processor *pr = arg;
 
 	if (pr->power.timer_broadcast_on_state < INT_MAX)
 		tick_broadcast_enable();
-- 
2.18.2

