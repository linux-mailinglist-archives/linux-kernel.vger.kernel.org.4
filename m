Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E6F5B9AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIOM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:26:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A84BA75;
        Thu, 15 Sep 2022 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663244785; x=1694780785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RK7KYqg6Sbk+Xr3HVz+LcwJXUc2tdcQGefZVN9jOc3A=;
  b=hgo8ushWmYDQeJvQv/APsl/S8MCuEFEJ6bMdWVoITIgufu8PGLRDTquX
   SS20CAsXX62jwRuZZ5gtR5Qn275XwwDlEym01HDe8mUXGRR2pVwyzt/E3
   ZKhHuKNIS2V1IihCWzw9lPkaXfJ/CLpMNlFpvbNusXaAO8Q0xuCXl2uel
   APDr0Zq3k+DWc+8/u0R66pJrClasD3lGSdgUjFVrWtmVENxerph+IhZTh
   FPIKMBQVnunvEdVEQwE4ZtSqof6uZHN30kucPr7wVqjLfMywhvhQ9uMU8
   GPChwRX3p+DqBZOaQBGJO9taCRUiSmIdtScY18JKw1Cq0L9WT5sSyVEex
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298693701"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="298693701"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="685705654"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf tools: Fixes for mixing per-thread and per-cpu mmaps
Date:   Thu, 15 Sep 2022 15:26:10 +0300
Message-Id: <20220915122612.81738-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi

Here are a couple more small fixes.


Adrian Hunter (2):
      perf record: Fix cpu mask bit setting for mixed mmaps
      libperf evlist: Fix polling of system-wide events

 tools/lib/perf/evlist.c     | 5 +++--
 tools/perf/builtin-record.c | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)


Regards
Adrian
