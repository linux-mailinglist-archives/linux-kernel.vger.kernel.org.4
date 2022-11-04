Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474F619609
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiKDMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKDMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:18:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FFF1B1D2;
        Fri,  4 Nov 2022 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667564308; x=1699100308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=038Ltyc23JlGHHbCjNbE/balNw8GDb9uO/6npvDBbiI=;
  b=O9+d8l4YGjmHafWKZ0J5pYo/YfBaaLGmU5AT8h0vafA79gJFPDP4B7/E
   9kJyK+aFrZO7I9hi2Pt4uFJL5cTGGm4ktwRP2ciP2THbjWxkXpmMzeYsQ
   laZrR/VkO578vBF5qgJqKtH38URt0vTyBr3m5rMgTFySELTR6rV6O0sg5
   cGQBlEYIB2JT24ZZBGRep50qY3oXmwuSrVbdV5iJG8VtnmYxgnsfNtx8P
   epgSAYvt0TFddwujvbjThwzpfS0SQ5kXwa/elM96k1XpKxNnQK9a3EnUw
   ujKqc8cKXuGk48LjZVjlrMb1mLHaTE9FieOEZcYEUqgty9LhPAqubPrPN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290341708"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="290341708"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760309104"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="760309104"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.118])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf: intel-pt: Rename intel-pt-pkt-decoder-test.c
Date:   Fri,  4 Nov 2022 14:18:03 +0200
Message-Id: <20221104121805.5264-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104121805.5264-1-adrian.hunter@intel.com>
References: <20221104121805.5264-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding more Intel PT testing, rename
intel-pt-pkt-decoder-test.c to intel-pt-test.c.

Subtests will later be added to intel-pt-test.c.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/Build                                 | 2 +-
 .../x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/arch/x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c} (100%)

diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 70b5bcbc15df..6f4e8636c3bf 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -3,5 +3,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
 perf-y += sample-parsing.o
-perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
+perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
similarity index 100%
rename from tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
rename to tools/perf/arch/x86/tests/intel-pt-test.c
-- 
2.34.1

