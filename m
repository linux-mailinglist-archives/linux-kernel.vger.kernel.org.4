Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A85F1722
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiJAAU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiJAAU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:20:26 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C154C7C188
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:18:38 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4MfSPP4bDPz9sWL;
        Sat,  1 Oct 2022 02:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gusted.xyz; s=MBO0001;
        t=1664583513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Xh1xAiDq0zX3Us9F7oKBDfImjIE8z2VGzXVqXragGU=;
        b=HZBIU2EpQaDmWphqe7ki5hGev5sVVrfr26az+74qFYC1PRj9wS22murYCTph4cs5usaCY1
        phQZAZMYBDGHmFNexcFnmmsrFEtZrNNDglTyyQfw7oXbv5Clywz/MRSGArvlOaFCvYrOjI
        dN3UUNO0pRqNtRCIXZ4VDbTxmaDllNOWUBPL+QAus8Lh3G5ku+oml07kxLsc5HRoh3X3tG
        UgWVPkHTwzGb/8SdnJO35oG0gyM9Nsq/Xhf4tigRZzUtCg1i/4BJ2+E5Gf2xsnA3/DXJCt
        4GLAMYJ4lUmX2N+ebx1xtpPFJBmypbfegw4UcE0Os7Ew3+WXOs9S1UwXG4hCVg==
From:   William Zijl <postmaster@gusted.xyz>
To:     Jason@zx2c4.com
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        William Zijl <postmaster@gusted.xyz>
Subject: [PATCH] Improve comment of get_random_bytes function
Date:   Sat,  1 Oct 2022 02:18:31 +0200
Message-Id: <20221001001831.46355-1-postmaster@gusted.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old comment of this function had a double whitespace and contained
grammatical errors, such as: `the randomness by this function`, `at
least once at any point prior`. This patch replaces those sentenced with
`the randomness of this function`, `at any point prior to this`
respectively.

Signed-off-by: William Zijl <postmaster@gusted.xyz>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 64ee16ffb8b7..e0b1b31789a5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -382,11 +382,11 @@ static void _get_random_bytes(void *buf, size_t len)
 }
 
 /*
- * This function is the exported kernel interface.  It returns some
- * number of good random numbers, suitable for key generation, seeding
- * TCP sequence numbers, etc. In order to ensure that the randomness
- * by this function is okay, the function wait_for_random_bytes()
- * should be called and return 0 at least once at any point prior.
+ * This function is the exported kernel interface. It returns some number
+ * of good random numbers, suitable for key generation, seeding TCP
+ * sequence numbers, etc. In order to ensure that the randomness of this
+ * function is okay, the function wait_for_random_bytes() should be called
+ * and return 0 at least once at any point prior to this.
  */
 void get_random_bytes(void *buf, size_t len)
 {
-- 
2.37.3

