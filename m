Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F866F4DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjEBX4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEBX4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:56:10 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D4A2680
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:56:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b60018e71so2629559b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683071769; x=1685663769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdKcEQmaaWLxe2HiTbkU80Vf3btOicSKEWhjrrEdCro=;
        b=SyzGjzNi7EHG5k8wDd+xH8eat2wyOdXHzClWS8H2God9fXzYy212Ey1RaqjNMwN4Oc
         vVHPKzhXrxRkWS4Kujnd8ypMX5ysqjrCg5HHCG11NHP4r/2QAaTYWXTbzHJ2xUwpwIsK
         /+AJr9RGPEuBMB1QRpTr7nsgF2phaCsxeZl1+5ocMSHMtT/T6eIsVMZPqOjAR8Gtkvdg
         UAntmTtInu0WrqCro+B2cLss2JHJMmSoG8EMdw2CvO7O4yKKzmM0qjZM1Hhn5m55oI/W
         ugGV+tk1LHPfdCp5eaUjuXQivIGZXMdJzipjaOXDytwjViO2PMbdYNti4ea5xxYc/rsL
         U3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071769; x=1685663769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdKcEQmaaWLxe2HiTbkU80Vf3btOicSKEWhjrrEdCro=;
        b=fA4/8EgpOUqIhBK95j+gwpKQqv0wS9jIY9Zmkp3N51W2qnfpaQbJE0jQRE/dq4Znpo
         30E53mjwrPceu4nObrNMgAA1XbfNAWJhGpK78pRFVk5RnX3s5OJCRNnYFOIRDeXobdMS
         ND0FGOq1PsA7J/7fxXY+RQxLNKf7eulD/vo1mm6A3ONe3s5bfOp52dCFk/rGuDfHbaq5
         TpqyqG+DOAvYbhU9+VXY37VeOcJQS1/5NNnFz+pI2MnK1oRDcYAuAiYVQV/nmA83prLh
         vIiiChDS3xW1NaTzpSB/mqvFuEzesEIwFvAaFmXIKddml5X82HV68LbUj/0OoDjqPcof
         d6Sg==
X-Gm-Message-State: AC+VfDw2S3fzoYwC9vH7hs03+GF/AQMadWz5By1xNMYNSIBXwvgDPey6
        gFwNwT8nSrwyerC7MdQbbiiOZkIaNJL8AGAzTg==
X-Google-Smtp-Source: ACHHUZ4uGtyigwr4nUSi3otC5a7lX2METWY1283Yc+awcEh00aN0uIMJwvcd5ZBL+DarH6qtHL28xEqjZBOaZg2lxw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:d52:b0:63d:3f94:8c3a with
 SMTP id n18-20020a056a000d5200b0063d3f948c3amr4655714pfv.6.1683071769151;
 Tue, 02 May 2023 16:56:09 -0700 (PDT)
Date:   Tue,  2 May 2023 23:56:03 +0000
In-Reply-To: <cover.1683069252.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1683069252.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <f15f57def8e69cf288f0646f819b784fe15fabe2.1683069252.git.ackerleytng@google.com>
Subject: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit in
 page cache
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        jhubbard@nvidia.com
Cc:     vannapurve@google.com, erdemaktas@google.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fallocate() is called twice on the same offset in the file, the
second fallocate() should succeed.

page_cache_next_miss() always advances index before returning, so even
on a page cache hit, the check would set present to false.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ecfdfb2529a3..f640cff1bbce 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -845,10 +844,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		if (filemap_has_folio(mapping, index)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
-- 
2.40.1.495.gc816e09b53d-goog

