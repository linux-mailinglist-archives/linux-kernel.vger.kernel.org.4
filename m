Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209915B8296
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiINICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiINICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:02:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4C5F7CC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663142525; x=1694678525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s3Y1Bf2didyt3l26/eK9LYpYlfDq5DjoV9pm8NtLmGs=;
  b=ZCSIndRgZ3Y7po5On06HCYKr0GNtvv8z0ttsRZTaQfa1QA7ZiwlAl/E2
   HHSQmDecbxnoK7X1IRHRXpsZQuzkXxGp/TL0BymyaJBZBcToJrkhyyQbI
   H5MnHa7/LQN4odYLA78Sm9RU2iWNhPwSZUZBHzvDWDVY7OcL2I2gDQV8K
   6whLVa2wPbRweIWIWHWwDgaew2WQvEnHrsGwwIZerV7ETPk4aYCPMgYjj
   D5Oo5S0/oa1bB5LWl9rITwIagUqL68v7QEVO0fA65VZBVXGoHJqy/9m0d
   2aGVvxjq1WS5n47ySENl2RfMTXdFfoxR9VhJDNbjRXA0sPYbpMLbOgDoH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="295953243"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="295953243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="678942489"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf test: Add tests/shell/lib/waiting.sh
Date:   Wed, 14 Sep 2022 11:01:48 +0300
Message-Id: <20220914080150.5888-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As requested by Namhyung, move functions from test_intel_pt.sh
to tests/shell/lib/waiting.sh, and parameterize timeouts.


Adrian Hunter (2):
      perf test: test_intel_pt.sh: Move helper functions for waiting
      perf test: waiting.sh: Parameterize timeouts

 tools/perf/tests/shell/lib/waiting.sh   | 77 +++++++++++++++++++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh | 68 ++---------------------------
 2 files changed, 81 insertions(+), 64 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/waiting.sh


Regards
Adrian
