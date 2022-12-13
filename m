Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21E64AEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiLMEcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLMEcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:32:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD053887
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:32:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso2244695oto.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5abyhkJxMsWPvlXan57YVCVYgciBNCxEPtUf8NJh6IE=;
        b=Z//Fy93HddZkDq6QmktN4k/H0y4n9dLcQjLhpoKKP2Dn275zSFdpioI/7T+QgPebdK
         s/42woLOOGBNo2eLfK0WwBJ/jZwWuaOWRuJJoJQP7GH4jJmXl7ODGNXIuAdachzGMp7N
         BLR9W+ppmVNbo5ygViITgeT8jhObSFjBlO7bgVAg8U34Iqh3v0WofRIhFKL+jZxQx38E
         bTpKrapRDM/RF4vv7U9C37Ms+wK3Nwdu6VKuJklA2Wlw+JcgZEuyzBNF9g1/6SqteT7k
         qH3XN0mKXzANs/NmRRYPcoeD2PkArPfZaNWVglZc0zG/mV4M8hS4D4UIo7kct6h+2wq/
         E2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5abyhkJxMsWPvlXan57YVCVYgciBNCxEPtUf8NJh6IE=;
        b=VEKG8nC6L5zfEHmduxAfu3LGQTiojgCtnuA8Q4D5DGDd0tlKhZJ8ao5IlrVDNzXFAx
         cg1vQCizTfalM2MJtjC45OjR1tpBYVb8UQy4QVqBIkFpKzMFwt1ADqPxU1+N/yQslD4k
         uEIYE7zOrC0KfQ5CMMIqH7rnqYrLtwPJ7fXCi8spWqsVfA4sYLnGa3xELRF6OqMqLEDC
         1HTg/914JJJN5dYlG1klifC3xwszKcjOkC4eVPvgCOuzlDf6+ANV1yXfL+sq9vurbLSY
         TbWqVW4aTKuU1sq3XGsHKiHkhwh2hgxU2ZbtcJ6qs1WzHrk4BAvMGbvrViEvOBnSfSlU
         IkCQ==
X-Gm-Message-State: ANoB5pk31OUsvfbrqYp+srchGl7FK4j1xMavrlkpcdNj+DZB9RyDJEKf
        p45LUoZUngmhoZn8DH5QLmQ=
X-Google-Smtp-Source: AA0mqf6y/NJh0AXnf8a4la62k83h6priTeGEepWAVvcpz8Q66tarPIvEDwtsCEb8cJFZ+VfVVLXCsQ==
X-Received: by 2002:a9d:17e8:0:b0:661:dfeb:f88d with SMTP id j95-20020a9d17e8000000b00661dfebf88dmr8515940otj.20.1670905971432;
        Mon, 12 Dec 2022 20:32:51 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d5784000000b0066ec67bbc7asm788564oth.7.2022.12.12.20.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 20:32:50 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] lib/cpumask: update comment for cpumask_local_spread()
Date:   Mon, 12 Dec 2022 20:32:48 -0800
Message-Id: <20221213043248.2025029-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Now that we have an iterator-based alternative for a very common case
of using cpumask_local_spread for all cpus in a row, it's worth to
mention it in comment to cpumask_local_spread().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---

Hi Tariq, Valentin,

I rebased your iterators patches on top of cpumask_local_spread() rework.
(Rebase is not plain simple.) The result is on bitmap-for-next branch,
and in -next too. 

This patch adds a note on alternative approach in cpumask_local_spread()
comment, as we discussed before.

I'm going to send pull request with cpumask_local_spread() rework by the
end of this week. If you want, I can include your patches in the request.
Otherwise please consider appending this patch to your series.

Thanks,
Yury

 lib/cpumask.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 10aa15715c0d..98291b07c756 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -114,11 +114,29 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  * @i: index number
  * @node: local numa_node
  *
- * This function selects an online CPU according to a numa aware policy;
- * local cpus are returned first, followed by non-local ones, then it
- * wraps around.
+ * Returns an online CPU according to a numa aware policy; local cpus are
+ * returned first, followed by non-local ones, then it wraps around.
  *
- * It's not very efficient, but useful for setup.
+ * For those who want to enumerate all CPUs based on their NUMA distances,
+ * i.e. call this function in a loop, like:
+ *
+ * for (i = 0; i < num_online_cpus(); i++) {
+ *	cpu = cpumask_local_spread();
+ *	do_something(cpu);
+ * }
+ *
+ * There's a better alternative based on for_each()-like iterators:
+ *
+ *	for_each_numa_hop_mask(mask, node) {
+ *		for_each_cpu_andnot(cpu, mask, prev)
+ *			do_something(cpu);
+ *		prev = mask;
+ *	}
+ *
+ * It's simpler and more verbose than above. Complexity of iterator-based
+ * enumeration is O(sched_domains_numa_levels * nr_cpu_ids), while
+ * cpumask_local_spread() when called for each cpu is
+ * O(sched_domains_numa_levels * nr_cpu_ids * log(nr_cpu_ids)).
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-- 
2.34.1

