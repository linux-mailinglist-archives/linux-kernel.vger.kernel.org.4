Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401275BA8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIPJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiIPJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:02:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A6A5C7D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:02:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y136so20641924pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GuU2pOxqDir4XWvb8qQFObrygULAVzSWxyyQn1U+Iug=;
        b=oJkCn7DMmUCvHzIdm+8jLaXSWFF61rfy6KJRpVM5UX1O1tpJxXmofpE92k5q8GcE0r
         C3hCohKhwl4JlvEhCR24b1Bppm1tcfId3qQTxHtmQiSsfcZaKUhv10rSo5HaPrnuIxDg
         JR30/P7i5DWInGeWbcjeLPqMtbT/lIcBBTpS1G2I4j47tW43EikSVSJ/+P7x9pKxihmV
         wH+5WQaDn3TfR62GlKo5gBNkT5ZKeuCwbMWL7BVYdLFS9LeQBcZI+iV/nX3xu4xm1fNy
         c4nzBYWuJFf9QHKFyD8ugGWacUmfsTFhel9YS7wseDJj1mW6lxHAeR93qeoEasWz5Nwk
         LxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GuU2pOxqDir4XWvb8qQFObrygULAVzSWxyyQn1U+Iug=;
        b=bvoxndm5+8lIUhF0ikM88hZtiGrmB2byU+TRBYy9lrweDdTO4d5RBY39ifmArZXdir
         QynBlzx3PYowy9mljrgPmwQV024x2o93sy1elpm/iP5P3EHYOC3SAIyWtkkBsxRS7TL/
         xtNEknBsF8OcLBDPCOqUEWW2wPUUZJ3KZis12Ll2ftG/OAcDtnpnhlpU7AQ15bf4HO6M
         gFmjnPML2JIKVIH1s/pPS66vgWxqSs+Pcsqtl7DlY2HRWi56S7SpcysVAzQ/htc52DXW
         Z/86ayiOb2l9zYsgwVEh/pM84FSrnMwMsMkjbHw++G8atevru4UogNgN24bCPHe6kOIX
         RPEg==
X-Gm-Message-State: ACrzQf1ndUZNsS9mAxsn8eSAfRiGTwIw06mQSg8UBm3VvDL9hKYiasml
        Tjw9fsfAyZe6XpATY5JoF0o=
X-Google-Smtp-Source: AMsMyM4P3ac3kCAYhw85FybDQxp5GKDBigdAXw8LDxcVhxvRZTdA0vhejowHOjS9tYwm1sRZIeq0TQ==
X-Received: by 2002:a63:441b:0:b0:439:103b:25a4 with SMTP id r27-20020a63441b000000b00439103b25a4mr3516588pga.487.1663318938314;
        Fri, 16 Sep 2022 02:02:18 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 17-20020a17090a035100b002001c9bf22esm1019713pjf.8.2022.09.16.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:02:17 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH] mm/page_table_check: Fix typos
Date:   Fri, 16 Sep 2022 17:04:34 +0800
Message-Id: <20220916090434.701194-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/page_table_check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e2062748791a..ecec2c7c8f44 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -53,7 +53,7 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
 }
 
 /*
- * An enty is removed from the page table, decrement the counters for that page
+ * An entry is removed from the page table, decrement the counters for that page
  * verify that it is of correct type and counters do not become negative.
  */
 static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
@@ -86,7 +86,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 }
 
 /*
- * A new enty is added to the page table, increment the counters for that page
+ * A new entry is added to the page table, increment the counters for that page
  * verify that it is of correct type and is not being mapped with a different
  * type to a different process.
  */
-- 
2.37.1

