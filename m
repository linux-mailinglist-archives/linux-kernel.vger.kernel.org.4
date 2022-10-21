Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B5607C91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiJUQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiJUQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:40:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00A28B1B7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so33998887b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2L8dpQwPLEEtV1+N27Ru5/DaXt/OYV1HEOgWR9nKqQ=;
        b=hQEOt5qbhtIciEkifW3aJtfdGkwkMFYThz3+zH4m+l0DZeOwkOHljylI87o4133YIY
         +9qlJoQYYs5X58L9fVYGOUcAW3htdR4wJqVgJegiRWhoDZN6Hw6rLU1Q3Xarnd4Z6B2S
         0Qm/YGHX8i6NhqgYKz1MbFHfMwocZZ13peTo4v5Lo7uK+rU6z8w5PasvDpHbgItoLjy/
         kO/NxxIWM2aQQDZLQNut8OALQcGGq9dp7sd0njpT2gzPLMMoFH/CqGvCCb5bZ8st1noJ
         mGHFYBCd4aJ2Q+Rh1Ul7ceCnhLsZNJJXbbirMkaOkrcUY5VvqDaCqxSFUg1RZviE76DG
         R0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2L8dpQwPLEEtV1+N27Ru5/DaXt/OYV1HEOgWR9nKqQ=;
        b=Koq9v1RXpDRXoxTioJYQPsZJqc7qTzzXDA3HBNReZQwM8+C6nuMMGfVrEwzkP0FUlW
         koHwTqzIeVc8WWFpEawh4/Nb4Wa98XtCb6inBJbwn3ktuu+xGj+z5dz0yohZfxkp1nSg
         6EZezsW9advB+lNMq+juWIB1zkYt3IW/iaFn/O7Qq3kxUXQRyVWSWNwufCiI8hLjD2XD
         GK77llSmxpBGJ1S/8ypFSosuOD6eoKgOoWs7k6CLmlwYGQ13yLISvOXBKOSeSafFOH2m
         iPlXZRXhnO1I/LdGJJ0dOGi1whi6MLxfxiCkqqFfXmkjc7Ow2YAvLpSKWlfCT9VwAMt7
         xYkw==
X-Gm-Message-State: ACrzQf2No7WOT1REHwglItHNrTvSP6gLV3tJZjk1X8Z1liCaVW6w4IVa
        +8FZLXWEiAR+SmdaFeQusCK8vsRM6enu0oRP
X-Google-Smtp-Source: AMsMyM7qrRczE0kSxjQO7MrMYsn4Vq7Fy76rcBbW8wGxpKnFBq1NTfYQXCvfTxYgtyY5kNNK/TDw3Sq2i3AbtMvh
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:105:b0:6bc:fb54:f4da with SMTP
 id o5-20020a056902010500b006bcfb54f4damr17650934ybh.284.1666370275067; Fri,
 21 Oct 2022 09:37:55 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:57 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-42-jthoughton@google.com>
Subject: [RFC PATCH v2 41/47] docs: hugetlb: update hugetlb and userfaultfd
 admin-guides with HGM info
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

This includes information about how UFFD_FEATURE_MINOR_HUGETLBFS_HGM
should be used and when MADV_COLLAPSE should be used with it.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst |  4 ++++
 Documentation/admin-guide/mm/userfaultfd.rst | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 19f27c0d92e0..ca7db15ae768 100644
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
index 83f31919ebb3..19877aaad61b 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -115,6 +115,14 @@ events, except page fault notifications, may be generated:
   areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
   support for shmem virtual memory areas.
 
+- ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` indicates that the kernel supports
+  small-page-aligned regions for ``UFFDIO_CONTINUE`` in HugeTLB-backed
+  virtual memory areas. ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` and
+  ``UFFD_FEATURE_EXACT_ADDRESS`` must both be specified explicitly to enable
+  this behavior. If ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` is specified but
+  ``UFFD_FEATURE_EXACT_ADDRESS`` is not, then ``UFFDIO_API`` will fail with
+  ``EINVAL``.
+
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
 enabled if supported.
@@ -169,7 +177,13 @@ like to do to resolve it:
   the page cache). Userspace has the option of modifying the page's
   contents before resolving the fault. Once the contents are correct
   (modified or not), userspace asks the kernel to map the page and let the
-  faulting thread continue with ``UFFDIO_CONTINUE``.
+  faulting thread continue with ``UFFDIO_CONTINUE``. If this is done at the
+  base-page size in a transparent-hugepage-eligible VMA or in a HugeTLB VMA
+  (requires ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM``), then userspace may want to
+  use ``MADV_COLLAPSE`` when a hugepage is fully populated to inform the kernel
+  that it may be able to collapse the mapping. ``MADV_COLLAPSE`` will may undo
+  the effect of any ``UFFDIO_WRITEPROTECT`` calls on the collapsed address
+  range.
 
 Notes:
 
-- 
2.38.0.135.g90850a2211-goog

