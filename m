Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FFB70BBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjEVLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjEVLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:31:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD9E0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755072; x=1716291072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=954JXwPXt2uxmtqFS4OWwF15sXfomT3M7aTOZ9Wr5II=;
  b=E6IEMLFxUuRcNf103mnpjmZMP3KmjuGIaoKuseJiaR6GIN/D4e5gqvEw
   bd4+Q/iLEiTdmbvozmBMivi/dPxbQwKu2HgvZy1/p4nI5TT9He38zFXvl
   Q2z+S22xInE3rC5PqUZNqVrssuVdL8rriKiSlb+gg+Ns/WQa0r1Kw7QdS
   OfICbFvwt4tp+qn1co4AVv0LcvqXbMT542HTIVp6INnsOZHVK/4A5n6TJ
   ZLe2Q8bEfJTugW8NpBKcDHENOi/Hcf3ikVVYfAv/dzhkcedqXE6Hc7gv9
   ZZn8En4n5J/yBP5g38DeE6tQGv+e2BAutc3v6cVIUMdZpUKgvjydy/6Jn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416356773"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416356773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703468275"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703468275"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:31:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/6] tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
Date:   Mon, 22 May 2023 04:30:39 -0700
Message-Id: <20230522113040.2329924-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Sync the new sample type and extension bit for the branch event feature.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rename to PERF_SAMPLE_BRANCH_EVT_CNTRS
- Drop the event ID sample type
- Add extension bit

 tools/include/uapi/linux/perf_event.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 37675437b768..3911cf000e8a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT	= 19, /* save occurrences of events on a branch */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +237,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_EVT_CNTRS	= 1U << PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -1410,6 +1414,7 @@ union perf_mem_data_src {
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
  *      spec: branch speculation info (or 0 if not supported)
+ *       ext: has extension space for extra info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1423,7 +1428,8 @@ struct perf_branch_entry {
 		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:31;
+		ext:1,      /* has extension */
+		reserved:30;
 };
 
 union perf_sample_weight {
-- 
2.35.1

