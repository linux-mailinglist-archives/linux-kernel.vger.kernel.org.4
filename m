Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74553615256
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKATck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKATca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40713F30
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA5FB81F67
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E9FC433D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:32:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fq+Y331F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667331144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DPWR+sboZsc62DMK94kFFYGKAdNxLTItuQY8DtG3ug0=;
        b=fq+Y331F3kny36vsfkUI6cwlwLqJ7tNnHVk5httCkDBcRZlQ+ZEFz5rPcZYJIe8bFPQCov
        PSN0Nhqrsk7DSr1RG8QB5aqL56eFA4GoJowspl8PQdZVOsFZA45ITHb3Z4sNKhGD1hrIEe
        tDUC38buBBl2MTn0/HF6SNeVK1+dMVI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a7746c0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 19:32:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: adjust comment to account for removed function
Date:   Tue,  1 Nov 2022 20:32:21 +0100
Message-Id: <20221101193221.54577-1-Jason@zx2c4.com>
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

Since de492c83cae0 ("prandom: remove unused functions"),
get_random_int() no longer exists, so remove its reference from this
comment.

Fixes: de492c83cae0 ("prandom: remove unused functions")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5da120f10a67..bf6144c1de7d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -120,7 +120,7 @@ static void try_to_generate_entropy(void);
  * Wait for the input pool to be seeded and thus guaranteed to supply
  * cryptographically secure random numbers. This applies to: the /dev/urandom
  * device, the get_random_bytes function, and the get_random_{u8,u16,u32,u64,
- * int,long} family of functions. Using any of these functions without first
+ * long} family of functions. Using any of these functions without first
  * calling this function forfeits the guarantee of security.
  *
  * Returns: 0 if the input pool has been seeded.
-- 
2.38.1

