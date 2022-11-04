Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D1619608
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiKDMSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:18:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE8140E0;
        Fri,  4 Nov 2022 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667564306; x=1699100306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmJKv7YP6AIs53/0SXvjf/RKIfnfOZiRasAcOQeVfWU=;
  b=XoMaaY3RM7IZTb/sAuGcrhPjFvtQCK833kAXAsTJNz1J7s1HfxzmADHa
   UUk1JCZeIxNot1kfxkSA4knAcVA2HgelLalNtyj2SdxuwVv3/REc3dW1d
   mFELOK87iSNavj+ppS37cskhLDqd3Aj2DOhOVr7hKr8OuEwjoS7Hu7NOH
   a0MJXHLFE2oPuRDBHq4NiPz/3drL+acYjUUTaAn2UjXf6yslxKOns1mTo
   LV+4kAzCGGoQTgvZ3F7ZiEsGy7tRHH+kYCZ3kwEH6hUcmUWWBsrQAo42d
   4JlOTEBR+ZV0pAdq1tFNzBV89UYh/TP5u7MZriZUuCVFDmtnht43LG/Q8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290341694"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="290341694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760309084"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="760309084"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.118])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf: intel-pt: Add hybrid CPU compatibility test
Date:   Fri,  4 Nov 2022 14:18:02 +0200
Message-Id: <20221104121805.5264-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi

The kernel driver assumes hybrid CPUs will have Intel PT capabilities
that are compatible with the boot CPU. Add a test to check that is the
case.

First 2 patches are preparation.


Adrian Hunter (3):
      perf: intel-pt: Rename intel-pt-pkt-decoder-test.c
      perf: intel-pt: Redefine test_suite
      perf: intel-pt: Add hybrid CPU compatibility test

 tools/perf/arch/x86/include/arch-tests.h           |   1 +
 tools/perf/arch/x86/tests/Build                    |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c             |  15 +-
 ...intel-pt-pkt-decoder-test.c => intel-pt-test.c} | 154 +++++++++++++++++++++
 4 files changed, 169 insertions(+), 3 deletions(-)
 rename tools/perf/arch/x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c} (80%)


Regards
Adrian
