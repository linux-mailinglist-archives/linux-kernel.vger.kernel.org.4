Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074EF614562
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKAIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKAIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:00:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6D15A30
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:00:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so35238164ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pc6N2WByL4QbQgv5GSMhUl4Mp2rKnUKtiN0a3NdGTvE=;
        b=aHr1p4OQXdVzHTsMzGg/N6wuF7Ng/8iG0ouhvHE40v2qKRkB5lRhiAheuZ4x3Illc9
         6rh2hgjNlUlfvh/GpasNTdTokvBEwFrKNzs/scNKXBZ8dsWlns+Sufo2AXjRiInj1mub
         EeC5RZG4+a4LS/MEfPhiOYKsFUTwi1sPOQeOMT7X0nKGqKnDGbttqy2C4yjBq3t1iBch
         LdSkvGMriQ8j++A7gV6o1oulxAz7xy70MjymC6Sux5Y8K1j4n0n+a30+/VUGFrWN3Q8f
         pYeb9YwFJpOhwV1VX4uCsHYtXeCY5MBnH2aBY36pR7bNfe6875gBAx++0w4eVg8pyy5u
         EEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pc6N2WByL4QbQgv5GSMhUl4Mp2rKnUKtiN0a3NdGTvE=;
        b=RnA2h5kaImMiglpu4VRxPHLWNxJ+6Y8dK1Tkt/F2/I4KaaOdAp8TWTMzBuAU5aJXEq
         5ZDyUXaDtsBkYbBIYSWM0tI9cgeYfdB53DbHebhEPTwzQsNkyd8Xy6peUND5tlO85Lp7
         vpD0XivXrr4TbchWsVkN/n9shQl27QodKf2qfTI5AlFJHgXoQcM9tCaZzP6I/g5TQyzK
         7sJ2NBjfQa7hJ0lotitxoel/MCktr4DG7gJXtNYquImFkfSrtvbOyBH42si0CmDDvmHQ
         5VvlxBk788vS5Nz7c/OZ28NM3pcBiMcu9UK5HxFP2pU8viRhLwXXUz3hmpxfYpYpTyMl
         BWow==
X-Gm-Message-State: ACrzQf3PyrhxVsJUkOh3d+f5imO7z2wQ6Yp342/CNkzHRJZiC/PmlJnK
        3EAAx5I2UFOnLxMWJaio3gg=
X-Google-Smtp-Source: AMsMyM4+Bb6FpE6sTTOsuP3xH6vg859ohvm9bRplJONNq3jOS67+jOO4IQv/O8ESB6xLTlbnE9ullw==
X-Received: by 2002:a17:907:7f07:b0:779:7f94:d259 with SMTP id qf7-20020a1709077f0700b007797f94d259mr17460230ejc.525.1667289617745;
        Tue, 01 Nov 2022 01:00:17 -0700 (PDT)
Received: from rdm ([137.63.146.164])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b00783f32d7eaesm3836965ejy.164.2022.11.01.01.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:00:17 -0700 (PDT)
Date:   Tue, 1 Nov 2022 11:00:06 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [RESEND PATCH v2] staging: most: dim2: hal: aligning function
 parameters
Message-ID: <20221101080006.GA63438@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Linux Kernel Coding Style, lines should not end with a '('
Fix-issue reported by checkpatch.pl script.

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---

Changes in v2:
    1.Resending this patch because it was sent multiple times earlier.No
      functional changes.

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
2.25.1

