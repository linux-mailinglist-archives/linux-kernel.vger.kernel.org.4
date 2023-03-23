Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485C6C7168
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCWT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:56:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7723DA9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:56:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t10so2412494edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679601374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYRlJa6a2No9s6NXBUhNFjPStBEW6jedBGv/pSig1z4=;
        b=Kn1b/aFaavHDgC7YmWZnNxcrxO9CFUOKs9075y4FhoNL1KBFvc3/MIGFyvHy2D/ES6
         sE3/AUJy5PL5ASYw9TVl27izLDpiAvOB7NqmApmTKKcAfdVx6zTPp+NSr3cA3/0PRfuA
         R8g6ufeoYV0i8AmY02U61BkA9yGQ/ZVugNuxVI/8o373ePYg2AKCWCcwwcBlQmFBENak
         rEcEJP/dUpCXWoJc/03Gh6CQ8oSyWZOj6WPy4P39JwCRl5C+pXuIn+OhSdbymmzVgbmL
         HAj4fbDKeFvSQm7E2cAZ7MUmXgYU18Tzj2TYomdWzdiSwenQFRbavbj5qO0ngSLk4EDq
         UDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679601374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYRlJa6a2No9s6NXBUhNFjPStBEW6jedBGv/pSig1z4=;
        b=ivXR4d2v/+F0t9gJ21qIBxVzMXd32mrxVAD6E13My1xvWDuitDpaBvlpDpFExotSa2
         yQHW5iKH2Qs2D9Yv9h45+WvBQJCXFF8AaPkXSXe+sPrVLwbTs4M9PHL0K/enqT8bZux3
         MS2yVDClH4bLNTdatz45uxHSN0UCtNnwWBSv47ABNC5WeEpSwFQWUzLwdAIT1htHKVCh
         8Dfr4R9SpTQsEpterRyTnbblDKw3O+o5YmKkY0BJ0ltH9wezFSfUEWIrZdAEsYEZ0Old
         zwustEYynaYtcDWeIZOI5raC+qcoWvzfQH7JupAGjjBhBHy2hSHBb2VOKnVXXyB5pdCR
         6GLA==
X-Gm-Message-State: AAQBX9eCQKO6HnAmoDoewl1bKizh1xpy5MSuDKFs9t+skVckupiZMHBV
        m0KVhF9gfSiSQiMYiGp1h9ROfpSvnmjdqh+B
X-Google-Smtp-Source: AKy350b2vWNeXZ5OkAFkp6bZZPQE43kxZ8z04Ds5oz4LW4BNgDt/feaRHXQ8XNXKH0n4yZTPPaHPCg==
X-Received: by 2002:aa7:cf86:0:b0:500:2cac:332c with SMTP id z6-20020aa7cf86000000b005002cac332cmr519749edx.25.1679601374293;
        Thu, 23 Mar 2023 12:56:14 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id q18-20020a50c352000000b00501d39f1d2dsm5147384edb.41.2023.03.23.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:56:13 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:56:11 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: most: fix line ending with '(' in dim2/
Message-ID: <ZByu29jb1mE3KOsn@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the function parameters right after the '(' in the function call
line. Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v3:
 - Changed the subject because another patch for 'most/' with the same
   name was causing confusion.

Changes in v2:
 - Changed the description

 drivers/staging/most/dim2/hal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index a5d40b5b138a..6abe3ab2b2cf 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
 		dim2_clear_ctr(ctr_addr);
 }
 
-static void dim2_configure_channel(
-	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
-	u16 packet_length)
+static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
+				   u16 hw_buffer_size, u16 packet_length)
 {
 	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
 	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
-- 
2.34.1

