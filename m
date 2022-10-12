Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B785FC1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJLIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:23:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11CFD07;
        Wed, 12 Oct 2022 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665562990; x=1697098990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ODCeXk/FkSN3DcOV8Y4uSYo9quiLtI2deHqNWSIpJ9Q=;
  b=ckCpDaoDDVMc6mVNjpmhkCcEviQZth0bWQwq1Orqbqk7A/uafEMHkHEi
   le5u/wetEBMUjUBs7yXE/4egQuUr38cJ+xQ4TR7YcsQ1hBcl9kZKiUeHD
   MA6SErUmK/uujDhvHN30Vn0RXCw1rmp1TkFXteJP/8vyjlaVw3UkiWQw7
   jmleORmRzHh5qisRnmHcbNrlqsJH5AXTvBLBQd1ePAh75DzmwR7ieHs11
   n6LyZUE4D8l8QPZnc7c5JH2XZ7fga6FjQjhCHfU3lT86Ir7ahrIK59qii
   9ggu3dv1S9PF+QrexGocewX803cemLueL+utfqggzM8JQVk+BLUJbrbmh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="303472949"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="303472949"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:23:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="955665493"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="955665493"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:23:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Fix system_wide dummy event for hybrid
Date:   Wed, 12 Oct 2022 11:22:57 +0300
Message-Id: <20221012082259.22394-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a couple of minor Intel PT fixes.


Adrian Hunter (2):
      perf intel-pt: Fix segfault in intel_pt_print_info() with uClibc
      perf intel-pt: Fix system_wide dummy event for hybrid

 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 tools/perf/util/intel-pt.c          | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)


Regards
Adrian
