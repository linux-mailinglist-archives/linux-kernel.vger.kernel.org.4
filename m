Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177C63B6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiK2BAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK2BAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:00:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7022B1A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3606152C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3506FC433D6;
        Tue, 29 Nov 2022 01:00:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d6vD+P62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669683632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3fv7avGP9IREw3uqpx7u89NucRv2BFRBNZFkMy1LeMc=;
        b=d6vD+P62r2yowdW+CzNaiP+H+FE8cpGTFfrhZclnKZgUmF0Et35NEwDV7HnS1wizWSmGWx
        zJk1Y+eNizITsWbCkzu9z9wDN12Mrix2NcMO+RPncTnJ6jTF4cIdLWM/6JIbYovllmaVf/
        VGTOunUNESOdQeoT8fm8tZLLkIQIlFs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 267157dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Nov 2022 01:00:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: remove extraneous period in comment
Date:   Tue, 29 Nov 2022 02:00:23 +0100
Message-Id: <20221129010023.376537-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a trivial typo fix.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a2a18bd3d7d7..ce12e7ab0d69 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1239,7 +1239,7 @@ struct entropy_timer_state {
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
  * CPU, the timer activity will be touching the stack of the CPU that is
- * generating entropy..
+ * generating entropy.
  *
  * Note that we don't re-arm the timer in the timer itself - we are
  * happy to be scheduled away, since that just makes the load more
-- 
2.38.1

