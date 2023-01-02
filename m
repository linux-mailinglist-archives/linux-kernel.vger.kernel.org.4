Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B565B2EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjABNzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:55:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885764D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:54:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so28267257pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 05:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V69V4Ol0d+EfdgZdVpGbY2u6/E3eHruEfebTDFsntaM=;
        b=DqKrQEjJnGDnzOxlpiNng+Re0Q7U3u+AiWhQokxsYdnJe7RsxD496hUEGFKs5HEqfj
         5dLITcCbfGE8FQzAPCQ1eRiW9j7DtvPq3W9mZjqDoqMlAoF0wDT1klSzJFq6PGWSE0zS
         dewlP7rTGZBjEK1Z5saSmvWlOa86divOtwuokICQEqw3RF1JUFs/smCrRWBqTsxCxDOV
         S+6iJ7vxZTzZWJbo6dbqkdCsPQyBVe5t2xHOh0fJ8E6xsa0l/qnGNhpTw72BIwRWMvKR
         uJjKUbqj+FCHpFwHBy9rAn7ELxkXOyIC+3eNF+rm8icFgO3oxwCmGslsfRukV+X7aHKT
         sj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V69V4Ol0d+EfdgZdVpGbY2u6/E3eHruEfebTDFsntaM=;
        b=5CEbVb+nUQvJ0UxUqI7iTnRLGbU3HhYSirJhVn+OzWZ6IlfeoifwAFJ1g+MaeUO8FM
         8M4iIrh3RQPyGg2IvRu6Cqdvg8SBtsvkZgTz0f2qoUkJbae+PI4JcnHT+RkNaYQ7Wncg
         BP4ueYE58hdpWmnah3L4KjWhGxNqZYnNOJ3G1TertspYgbWnGQjlW9ELVWbMTk2roGdQ
         Sb89Ss0FUmBM/j0nnevbfRRbkWP6R0zxNetK+BXeZoCyLrQatTnB4rrVGznTxh92bwa+
         XXCIcSrO6lkZHzPXF5VmaSK7Fx+qRQ7FjwUqO5zLB2Lq3C1WfFtE+nsymFbKMCHPHtOt
         H51w==
X-Gm-Message-State: AFqh2krqHSKzaK2ogJLDmiGph3pHSvpe3JtcWm/EFpP6Lw1COzSoUTWx
        WscZbJqqW0rNMAAubRA+5/k=
X-Google-Smtp-Source: AMrXdXvdF82YIP8Vw0/RocFgBNPHCJ/mbmgC38jZE7Hg1dW6vS+/3aREDspwfVCuZfyBnA1/jR/D5g==
X-Received: by 2002:a17:902:7488:b0:189:e711:170 with SMTP id h8-20020a170902748800b00189e7110170mr44733494pll.64.1672667699346;
        Mon, 02 Jan 2023 05:54:59 -0800 (PST)
Received: from localhost.localdomain ([114.249.235.208])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090302d000b00186b138706fsm20264431plk.13.2023.01.02.05.54.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2023 05:54:58 -0800 (PST)
From:   wlfightup@gmail.com
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wlfightup <wlfightup@gmail.com>
Subject: [PATCH] hugetlbfs: Fixed code style, adding a blank line between functions
Date:   Mon,  2 Jan 2023 21:54:53 +0800
Message-Id: <20230102135453.31609-1-wlfightup@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

From: wlfightup <wlfightup@gmail.com>

The code style must uniform, and the functions cannot be
separated without blank line

Signed-off-by: wlfightup <wlfightup@gmail.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db895230ee7e..4ad2be7f3b83 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3213,6 +3213,7 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 }
+
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
-- 
2.24.3 (Apple Git-128)

