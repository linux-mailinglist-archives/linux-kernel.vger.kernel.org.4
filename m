Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CA5F1D38
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJAPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJAPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:36:35 -0400
X-Greylist: delayed 55078 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Oct 2022 08:36:34 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BB04054A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 08:36:34 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4MfrmZ3Y2Zz9sPl;
        Sat,  1 Oct 2022 17:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gusted.xyz; s=MBO0001;
        t=1664638590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zsAL+KaCaJ9QIBz8qy6a98ic0sy43+TZXupgpE9e03I=;
        b=qgxWHBqCXPD0bV7DzH2My5n8NgOSERvC7yAh6hnbKfV4yaLYo9D7hw7ZIMQ7OM3qpiY+4v
        HVIAGC5hdudT25lHSA/8APgM/7WoqMrStBvZDDxCRyvrY+kVTIF16MXf55GveG1tbAZIB7
        e7Bgwz2khvitc7rMIXDCH7gU5Wears7S3cumO4lZPiC7+4QDjNCJH2+5pEl6tXk3M9IeXh
        MOWb0eD6GQ1ZDDebyW3S0E19mhsVWldtqJjJQw0R9IxUy1jzP1qJptjMZittYivyUvscwj
        1DbZ3hMBFuhwX4UYe5q05ML9PWY0E8Ok/mjQ252cWDAYEzEKqOq+T5N825Ww7A==
From:   William Zijl <postmaster@gusted.xyz>
To:     Jason@zx2c4.com
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        William Zijl <postmaster@gusted.xyz>
Subject: [PATCH v2] Improve comment of get_random_bytes function
Date:   Sat,  1 Oct 2022 17:36:21 +0200
Message-Id: <20221001153621.56067-1-postmaster@gusted.xyz>
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

Hi all,

The old comment of this function had a double whitespace and contained
grammatical errors, such as: `the randomness by this function`, `at
least once at any point prior`. Replace those sentences with `the
randomness returned by this function`, `at any point prior to this`
respectively.

Thanks,
Gusted

Signed-off-by: William Zijl <postmaster@gusted.xyz>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index fdf15f5c87dd..dd976008136b 100644
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
+ * sequence numbers, etc. In order to ensure that the randomness returned
+ * by this function is okay, the function wait_for_random_bytes() should be
+ * called and return 0 at least once at any point prior to this.
  */
 void get_random_bytes(void *buf, size_t len)
 {
-- 
2.37.3

