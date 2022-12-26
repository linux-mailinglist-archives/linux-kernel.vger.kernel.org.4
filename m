Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04335655F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 03:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLZC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 21:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 21:57:46 -0500
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Dec 2022 18:57:44 PST
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E982DF0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 18:57:44 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EE94A1A009D7;
        Mon, 26 Dec 2022 10:51:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfs.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4sXjzyAQy7Ok; Mon, 26 Dec 2022 10:51:58 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C6E2C1A00856;
        Mon, 26 Dec 2022 10:51:57 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     inuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] drivers/misc/ocxl/context.c : eliminate unnecessary type conversions
Date:   Mon, 26 Dec 2022 10:51:45 +0800
Message-Id: <20221226025145.4363-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 9eb0d93b01c6..d6e081812300 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(ocxl_context_alloc);
  */
 static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
 {
-	struct ocxl_context *ctx = (struct ocxl_context *) data;
+	struct ocxl_context *ctx = data;
 
 	mutex_lock(&ctx->xsl_error_lock);
 	ctx->xsl_error.addr = addr;
-- 
2.18.2

