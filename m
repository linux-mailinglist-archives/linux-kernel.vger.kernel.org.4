Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC95BD970
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiITBhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiITBhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:37:24 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A9B49B56;
        Mon, 19 Sep 2022 18:37:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0A5ED1E80D1C;
        Tue, 20 Sep 2022 09:34:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x1KCLMsn8TXq; Tue, 20 Sep 2022 09:34:14 +0800 (CST)
Received: from nfschina.com.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4D3771E80D17;
        Tue, 20 Sep 2022 09:34:14 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou nan <zhounan@nfschina.com>
Subject: [PATCH v2] md: Fix spelling mistake in comments of r5l_log
Date:   Mon, 19 Sep 2022 21:36:45 -0400
Message-Id: <20220920013645.84917-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou nan <zhounan@nfschina.com>

Fix spelling of dones't in comments.

Signed-off-by: Zhou nan <zhounan@nfschina.com>
---
v2:
- Modify the title
- Modify the name of sender
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index f4e1cc1ece43..683fd4adde17 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -125,7 +125,7 @@ struct r5l_log {
 					 * reclaimed.  if it's 0, reclaim spaces
 					 * used by io_units which are in
 					 * IO_UNIT_STRIPE_END state (eg, reclaim
-					 * dones't wait for specific io_unit
+					 * doesn't wait for specific io_unit
 					 * switching to IO_UNIT_STRIPE_END
 					 * state) */
 	wait_queue_head_t iounit_wait;
-- 
2.27.0

