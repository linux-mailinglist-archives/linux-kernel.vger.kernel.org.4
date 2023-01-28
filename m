Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169067F793
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjA1Ldv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1Lds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:33:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CAA271
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:33:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso11083931pjj.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+vbyXEO5ZjGT+93R/0smtSFLyUkyWND86MvhSizTJE=;
        b=nSIjx/E5hZc7SLk8D4Jz/YgjkJJ7uwde0+7TDidW748INJ5hMQ9eWt34STpe6jbwCe
         wHjk8Sl9+HIyY4bIRYkdGTJlACSA8t02WmGwuEQ3J4l+SnRbRKB6hFHPebSz6mUXtuBY
         678AWnKtBNbkPKL/BPsLOdFW3hLIPfbzTCPZrvy4OQMsW4NzfSaRUBhqtNLdhjBybsvh
         DUte4QoDxdlld6NTQN2GnR1Qwt6MffTvnCUwm+P44uBjNASyrnFFz4CQoqM8For4VPHs
         WknIoyAJ++lnTUCRnLlxlBK9SQSvVKcwUY3vmD37hUPHk/zZbUteUVNQz/bH/MmBVV0Q
         Pk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+vbyXEO5ZjGT+93R/0smtSFLyUkyWND86MvhSizTJE=;
        b=jTAwzrAiDE9NwfyA/LX2eoTWQrWNHqSxfP2T2J/zChruMWGBoEHGOHQpDRLr5nG9CO
         Ie6UJrX1QNlOd4H+XzLvwrZKvW0i4HX+xEvK1/SE7F5/BontaPDM1yg4xB/ixXxGufl1
         zc8YzkIURrCBs9Od0S8eRW+eWtTNSp6WFnINzvYGnt53vAc/8dfq8IcbrFY9204nYrRa
         Pw0SovMk/huhDlU1ODrzDKG6ZPGpabj317iBbFLHnNT/fyGkMufMOw84IyiY26asA1oF
         TPgFHeTl23KFhZaK7vcXbeofqY6qfasNTJfxbuV1WIh1NG3SH038EtiOqHuKrBbZYBsY
         WprQ==
X-Gm-Message-State: AFqh2koVPKKu2Y9peB1/IHAlk3dIQdRkix7hnHBc+FWasNhFnj9tZm9a
        xzQj78XJeqQ4aaRixWVgnaY=
X-Google-Smtp-Source: AMrXdXust+O1bkLT1e54NDlo7jlLm8yw9QPmOTn14gd8+7KsCWht7KxIDy2ajF87971shDASiQgW7w==
X-Received: by 2002:a17:902:cccb:b0:192:b927:39d1 with SMTP id z11-20020a170902cccb00b00192b92739d1mr45094625ple.3.1674905627356;
        Sat, 28 Jan 2023 03:33:47 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id j22-20020a170902759600b00194a297cb8esm4345544pll.191.2023.01.28.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 03:33:47 -0800 (PST)
Date:   Sat, 28 Jan 2023 20:33:42 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>
Subject: [PATCHv2] mm/vmalloc: replace BUG_ON to WARN_ON
Message-ID: <20230128113342.GA1164537@min-iamroot>
Reply-To: Y9PntwfqtarxWFUq@hyeyoo
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the coding standards, in the event of an abnormal condition that should not occur under normal circumstances, the kernel should attempt recovery and proceed with execution, rather than halting the machine.
Specifically, in the alloc_vmap_area() function, use WARN_ON() and fail the request instead of using BUG_ON() to halt the machine.

Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/vmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74afa2208558..9f9dba3132c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	int purged = 0;
 	int ret;
 
-	BUG_ON(!size);
-	BUG_ON(offset_in_page(size));
-	BUG_ON(!is_power_of_2(align));
+	if (WARN_ON(!size))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON(offset_in_page(size)))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON(!is_power_of_2(align)))
+		return ERR_PTR(-EINVAL);
 
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
-- 
2.25.1

