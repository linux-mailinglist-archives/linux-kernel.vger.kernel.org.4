Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD35E5FF2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiJNRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJNRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FB10F2;
        Fri, 14 Oct 2022 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767377; x=1697303377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=teTkEp602ihKMIylodGYkA9Vpz7WieiJ0+obkFaWITU=;
  b=cqypmMsX3tK3mumIoJp2jCAbODalCoklGzzRNQnYbvIM1DBFDqNBX2v/
   9AK2DlAaWeU6jw2niUx36HqGhUaytk2dgU+4X2zYCdtiVyn4avCGwKxwG
   YpjqRcajq6igz1tst/A87rsvsE+cWgS8h95/PbQZJ2k5/F9EItctGEoxS
   GrA4H1VnAj0wqfGAea/ty5dzspRpfAkCM4fB6FisHwtS3/V1SsAk9etZx
   zOENTY0sWMDR8mzaefT4akDdP7/EI/BrMBxZIBJbZQQUSOwFdRR+e2lOX
   oKtkNzgFP0U6FWEqxgzOX2K1rdNd7xbl68F4/1gp3pQ4JiIR/d0sJAA/M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041989"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041989"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696376983"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696376983"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/7] perf test: test_intel_pt.sh: Tidy some alignment
Date:   Fri, 14 Oct 2022 20:09:02 +0300
Message-Id: <20221014170905.64069-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014170905.64069-1-adrian.hunter@intel.com>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy alignment of test function lines to make them more readable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 9c746ff1c4d2..79dde57b561d 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -283,9 +283,9 @@ count_result()
 }
 
 ret=0
-test_system_wide_side_band || ret=$? ; count_result $ret ; ret=0
-test_per_thread "" "" || ret=$? ; count_result $ret ; ret=0
-test_per_thread "k" "(incl. kernel) " || ret=$? ; count_result $ret ; ret=0
+test_system_wide_side_band		|| ret=$? ; count_result $ret ; ret=0
+test_per_thread "" ""			|| ret=$? ; count_result $ret ; ret=0
+test_per_thread "k" "(incl. kernel) "	|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.25.1

