Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469227263A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjFGPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjFGPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:03:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719411FF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:03:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-662b85f4640so146604b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150192; x=1688742192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Msfw3FZTKqUZwLFrkysjS96Cdf9AFaQ0r06ieq0j1EI=;
        b=ae8/YKfoLrOaxVyfBu/iJH3C6PAtvFYaQurwvNiYf1D9kRVaGAfUs0+4s1rxmS0/f1
         QAWo9JqKmCam0wf0B/CDYNnWcMId90CBErwYs1nGzPp6KLjyfu/699sLJqpmxt44Ju2j
         y3EvTLYYI9qZZKAJEawMh9XwfYCBcNYwTt/kJGrhTlbB+GTP+xgjgi3dW9JE74V1jvPM
         rktd/zKC2Ndwf0oe7MKoP0os2CLh4V3jyJRzSrZNZftsDfqNwp1+siCwC2y1pw4Nn3Bh
         I/ZlWvthFgDf27Ix00KcIyLDulsUnkl4rWRBXM1+FZIOMt/KRPwxvapLDLA0E/0P60z6
         R2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150192; x=1688742192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msfw3FZTKqUZwLFrkysjS96Cdf9AFaQ0r06ieq0j1EI=;
        b=TO3zJ7cVBz0ItF300BrMDwFdrN12vbLRc/doY5BC/GT17r5KTCR4tsmAhFsioe/Fvv
         K7BcOHwDiU3rCOEbFAWTQuIoYt8VXDQfG4hRe6ugZCE/44AKP49JdKIhbAE9nhZlyIUZ
         6Oei7N+Sr4vSCN04yR+fE7rHPxUlN63t4Ago1enpskkH33gx5/RP7w0v9BqkwVsklhbe
         rkg9XBhEJR74kHywNUAn/Iauc7F2inA07h6pi/9midTWaLjduAgultfktgTLZ76wQLkD
         184wLYW3k3UZ7DVn6RR7EdxYlXGY2UjDHzl0SEf277MbIXFfom+OHkqH0cOuPVmIVUlM
         +lbA==
X-Gm-Message-State: AC+VfDxG0JaNZ1z7sxHmE1xkqV+iNJmJrRvKiduyxp0Zkgug+mp/1Dls
        qWu1QVQElGYHVRDnm3fCcZw=
X-Google-Smtp-Source: ACHHUZ5zTs8y/Itlfgfy+8u0sBdZokuQYGHRt7t3asqdPwB0slrZgugbMII/lgbtqzi09ALnSjxDnQ==
X-Received: by 2002:a17:903:234c:b0:1ae:1659:bfe2 with SMTP id c12-20020a170903234c00b001ae1659bfe2mr2531711plh.34.1686150191792;
        Wed, 07 Jun 2023 08:03:11 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id ld6-20020a170902fac600b001b04c2023e3sm10569143plb.218.2023.06.07.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:03:11 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:33:07 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: rtl8192e: Remove DRV_NAME definition in
 rtllib_debug.h
Message-ID: <41c6c24e703eedf6fb4febcf4cc7ef180af1db58.1686149467.git.yogi.kernel@gmail.com>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro DRV_NAME is defined twice within the driver, once in
"rtl_core.h" and again in "rtllib_debug.h". The definition in
"rtllib_debug.h" overrides the definition in "rtl_core.h", resulting in
warnings during compilation. This patch removes the redundant definition in
"rtllib_debug.h" to avoid the warnings.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v2: No changes.
---
 drivers/staging/rtl8192e/rtllib_debug.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
index f6b23defe225..ab8bd5fc4ca0 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -9,11 +9,6 @@
 
 #include <linux/bits.h>
 
-/* Allow files to override DRV_NAME */
-#ifndef DRV_NAME
-#define DRV_NAME "rtllib_92e"
-#endif
-
 extern u32 rt_global_debug_component;
 
 /* These are the defines for rt_global_debug_component */
-- 
2.25.1

