Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71362D259
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiKQEdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiKQEc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:32:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B43FB92
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:32:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q194-20020a632acb000000b00476fda6a1d2so590897pgq.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPfz7WPanVmO6P7mkMngEyHk/rMaAEiwNpFse5O+tqM=;
        b=HdydIX0CXLjX9PAqV1oTIzt4lJrdlYjImWI83DE6XPrdkzdC72019HweIQ+6F8Fi80
         8cYlXC6SzbRByJB4mewKXX/Tf7yItRXOhReUDd2eGOWREo2YpjLhXhUjQpL8/FN1eJJB
         /HymzCDDV1iOnw7d2RM/TexsCCVXilvQzqlFMo0XxB+pvgT0uBkEBMMjmvVfuV3jCzVz
         Xj4A7tpJeGGiZKbmhWPydEeJiqDHbTkMT5IFTAw+5UcEmunZsUvXri1Y88kzoNqMvb3K
         1/lwFMwX3E1G//+M56+9A3BIeS7cmsadgatjb7bTD6O9uh+FtSfAxmq6baRnJjCFL+vr
         pVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPfz7WPanVmO6P7mkMngEyHk/rMaAEiwNpFse5O+tqM=;
        b=Es4Nt2ZFG0TSYtukmJaOSmDoz7dFzAw9PnFndEEdKE7laYYW2gY9Shy1ZSBjAf/nF9
         Tmd2UEfXrrzXJLZP6QXfyye3c/Q9qnYQWIlPhginMwejaoJ08OGU1+cFe+XpVPqauVsC
         4CqbqXDVIzfMnwOdNwIgfyARDNOxx8l1KKQzVIKJkjLOukxYqcOkua7GaUQ9zef0JpRS
         C2WjKFsS6RbqXP3FuSB6zGodBcJISL1JBbrC8oILGhHCnot2Lv71505gc3qCcZT4JQ19
         xwp2fGabxgehds0xrwYrh9GXXh/16Kus2VqkpFtEj67iCT5HS2U131tNZBOiA7zV6KMc
         5BdA==
X-Gm-Message-State: ANoB5plAN/K6A8DxtZ1E7cO9TUBBlG4XHGHst4fdKD5fjZW8Ra8XnwKR
        r/0zzKs4M8qzDcXE/a0puBA4iE6ooXQIhY6E
X-Google-Smtp-Source: AA0mqf5vh871tskpgsVs2JR/F2/2RLJ8ASmrrXij8/N5i5PbB9GmDPDU7IO8m0LjuspVCKlF+DlO0FLjUvJ9oBdQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:542:0:b0:56c:45db:4481 with SMTP id
 63-20020a620542000000b0056c45db4481mr1167664pff.86.1668659575076; Wed, 16 Nov
 2022 20:32:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 04:32:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221117043247.133294-1-yosryahmed@google.com>
Subject: [PATCH] proc/meminfo: fix spacing in SecPageTables
From:   Yosry Ahmed <yosryahmed@google.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sean Christopherson <seanjc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SecPageTables has a tab after it instead of a space, this can break
fragile parsers that depend on spaces after the stat names.

Fixes: ebc97a ("mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

The commit this fixes is in 6.1, so I hope this can also land in 6.1.

---
 fs/proc/meminfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 5101131e6047..440960110a42 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -115,7 +115,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #endif
 	show_val_kb(m, "PageTables:     ",
 		    global_node_page_state(NR_PAGETABLE));
-	show_val_kb(m, "SecPageTables:	",
+	show_val_kb(m, "SecPageTables:  ",
 		    global_node_page_state(NR_SECONDARY_PAGETABLE));
 
 	show_val_kb(m, "NFS_Unstable:   ", 0);
-- 
2.38.1.431.g37b22c650d-goog

