Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F369B6DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBRAbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBRAbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:31:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DB6B303
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5366c22f138so12022157b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=meim6QzwmgVJzeI2+Wk1IxU1uXO2GoWG7kArQ5zE/oE=;
        b=jBDVTyUiFjSinjlesXO7Wsr29fC05xWRfrl7nAZ2Vi6vctWsz/7+NsXy6Dx9zE02oD
         Zi9rU6CuILwSQ9MmYCjyB8BnkobSNAXN9wk5uSKN5uHSYEobIzebiBr+QJLAoe2BO2h7
         BvQ5nLWnyJ34pOp7tHtrWAltvM5a5A6wWV9ntVMJs7Np7CHhXIh92iq7fs97WdSGdx7k
         chX9KZzHAChL7Krh0NrLbnAxcDgyvNutktvSzeK5qogN04D9EfgapHMPtcUexRrTONeu
         Lv9LpAtAQc7gW1fQL5eLIT4qqKfM5pCyZOYdI8D3vWXHR6ii/aIgrxnOVziUFMcqw1D2
         IOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meim6QzwmgVJzeI2+Wk1IxU1uXO2GoWG7kArQ5zE/oE=;
        b=r9kBBNbu5C7zF9kg9HlCbryiCKEMfgSmCMiS9p17srDDiOLXWw0JCWMaaBm7HkUcEk
         JiEqsGuNuPcyjI7wVqhebUTmNuHCTpzR3AGF6SoDMlrtBApOC+H+tzgm+4Y0Ym/PG8X1
         3hl7nWSwToKJYOR7ip6ybr/o4nQReZP1LDPK9SlsD9d5mo4V0/d5AoI8RMKczKbnaOHB
         /ypS+HKWaQIHQM2NCklGtC0XA8/+HmemPYX9EGKp9a5Tq/dGIj932jlWXUSCmR8oYtyG
         Lx0IVyk6bVGldLk4t3e57vMocycQhE9P1DiH19J5BKynT9Ge5yLp7wAy+MLQx9b8DWv/
         IEqw==
X-Gm-Message-State: AO0yUKVLfGWNzaR72MBJRWN42cQ5keEcpIq6yFdv6Nj879acuYCCCJh5
        5XlX+hv58eiAg+mwVZHuOJUZomf1QNpkhM7+
X-Google-Smtp-Source: AK7set8GEY/pRGyIuQeSw27GrNwKq4LLQxkMXSq0msXVI/vUEuxHEPRagJyvSuTMY/SNITKnNSR3i2I9F+YeDJM+
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:144:0:b0:91c:90b6:f48a with SMTP id
 c4-20020a5b0144000000b0091c90b6f48amr1373069ybp.580.1676680164340; Fri, 17
 Feb 2023 16:29:24 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:13 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-41-jthoughton@google.com>
Subject: [PATCH v2 40/46] docs: hugetlb: update hugetlb and userfaultfd
 admin-guides with HGM info
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include information about how MADV_SPLIT should be used to enable
high-granularity UFFDIO_CONTINUE operations, and include information
about how MADV_COLLAPSE should be used to collapse the mappings at the
end.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index a969a2c742b2..c6eaef785609 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -454,6 +454,10 @@ errno set to EINVAL or exclude hugetlb pages that extend beyond the length if
 not hugepage aligned.  For example, munmap(2) will fail if memory is backed by
 a hugetlb page and the length is smaller than the hugepage size.
 
+It is possible for users to map HugeTLB pages at a higher granularity than
+normal using HugeTLB high-granularity mapping (HGM). For example, when using 1G
+pages on x86, a user could map that page with 4K PTEs, 2M PMDs, a combination of
+the two. See Documentation/admin-guide/mm/userfaultfd.rst.
 
 Examples
 ========
diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 83f31919ebb3..cc496a307ea2 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -169,7 +169,13 @@ like to do to resolve it:
   the page cache). Userspace has the option of modifying the page's
   contents before resolving the fault. Once the contents are correct
   (modified or not), userspace asks the kernel to map the page and let the
-  faulting thread continue with ``UFFDIO_CONTINUE``.
+  faulting thread continue with ``UFFDIO_CONTINUE``. If this is done at the
+  base-page size in a transparent-hugepage-eligible VMA or in a HugeTLB VMA
+  (requires ``MADV_SPLIT``), then userspace may want to use
+  ``MADV_COLLAPSE`` when a hugepage is fully populated to inform the kernel
+  that it may be able to collapse the mapping. ``MADV_COLLAPSE`` will undo
+  the effect of any ``UFFDIO_WRITEPROTECT`` calls on the collapsed address
+  range.
 
 Notes:
 
-- 
2.39.2.637.g21b0678d19-goog

