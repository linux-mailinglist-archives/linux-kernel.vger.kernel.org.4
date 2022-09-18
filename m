Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1D5BBB30
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIRC4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 22:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 22:56:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C2286DF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:56:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so14635370pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mz3vNDOhI7Pm93UhnnvR3AdQZEEFOAFJRb7IIBsCEd4=;
        b=eY9lq5n8/BZ7b1Y4Djt7y0FJqCWYaq8Ax6gVXkFXsR5MDMWibeL2fIV1jwY9QYa7SM
         wt3AJ61uNaz/9JeWCA/l5icdp7ABH2Zue7EQgIgeMy3Yx8wOEvWTvDfMpmaLLNI8Rc5v
         f3JkARPm8075PKkP+8uQYa9+IMsdstwkKSwizSXGo5qfQWEronhaNHIc549XzBhUfGKB
         wAmhkn6AnHhUiDBbVJmOm1bB/BEJx6yBq9oStjzCQ5PoNe2w80c2nx7SAcTo8tsJ9vpP
         vaeuiGuERxCgIlMrlb08bIpmYns2dgJ+szd/ykfRifMZnROkBW4Zqw75PsWdKtwUZB++
         iVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mz3vNDOhI7Pm93UhnnvR3AdQZEEFOAFJRb7IIBsCEd4=;
        b=Ir0ZkKSjICjJxrsRloPkSWCbM2ABedmcERcIjFR74vFxDBwdgaLMQZSUWOKN7sBSBA
         MUBMHT/UGSICVCi7ELfegoepYSG+lZmbUv5ecYuADdvgrEMNUxFCi/HipfqQmGdh9QYm
         D3zedKklYsdJsKKqvZE7AsHH527Ljk2zsaBNFZwzg22pTYkSsdc4gBMCH89ASP337SKE
         /lgVbp59irqGSO8D5OQG9UPXki4AILLKOTGnJ/ux8qAtUSrHifxl2q2K0VgJkriS+947
         wyDqBLLG13gcjkhRUtRbc3qOulinz0ElQlVaSY0IWxNAEmYgYglxQ5b9JLV20Exx747Q
         iu9w==
X-Gm-Message-State: ACrzQf1MCosqqzBTrHfYh8UruxBRIUD0fpt74fLEeKihMG/Wqic8ntJS
        RkmrRQay2h5DAETVSEwJzWw=
X-Google-Smtp-Source: AMsMyM4hp45U6qFgKrWPXvDK9VxEh0oawQDzOJVUCm6zt3oTjbB9K9jBT64i7Mik/lFdPwKv07tUVw==
X-Received: by 2002:a63:134e:0:b0:439:8ff9:53b1 with SMTP id 14-20020a63134e000000b004398ff953b1mr10855695pgt.119.1663469807854;
        Sat, 17 Sep 2022 19:56:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b00172951ddb12sm17565980pll.42.2022.09.17.19.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 19:56:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     ran.xiaokai@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: update comments for rmqueue()
Date:   Sun, 18 Sep 2022 02:56:40 +0000
Message-Id: <20220918025640.208586-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
stored on the per-cpu lists"), the per-cpu page allocators (PCP) is not
only for order-0 pages. Update the comments.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..bed7570e0746 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3815,7 +3815,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 }
 
 /*
- * Allocate a page from the given zone. Use pcplists for order-0 allocations.
+ * Allocate a page from the given zone.
+ * Use pcplists for THP or "cheap" high-order allocations.
  */
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
-- 
2.15.2


