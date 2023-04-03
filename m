Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CED6D4C87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDCPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDCPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:50:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A71211D;
        Mon,  3 Apr 2023 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680536991; x=1712072991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lpndtpDoQ6ntDhYxFuneHaPm1MmrThQtg4Ammg2mcdo=;
  b=Wr/QqZChYbAV2NHidS7uYPmn5vWiAZ98C1BsdsiGt+NhiHRACok9rcan
   BQ9hr9LvTTdBjfoTbwdAKcX2dyKzxGh7qKOHX17AsAlGq2GEeGqxJj+hT
   kgG6fZBalvIcbCXPfdBspQ/SwwGtfGOt6kwhyrriE787nYMf2d6X4A4Nl
   Q1PMzQLNiqq1ZqcSTygb2ov3lB5OOizgX6hCrFsGnE1Qx61Tr2hA2NxcP
   IS4BBYuQdy2FYpfXr+Gioc//ilbzFbNfi5+mJJY5ifbDOGH+tRdIeIYWj
   Vl88pjmAhlLl+e2bwiOG1f+sj4HuDIYX41oaP4SYJjwR73FZJ+FmlXDnj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="339430281"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="339430281"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663243319"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="663243319"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.40.243])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:48:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Two small fixes for stable
Date:   Mon,  3 Apr 2023 18:48:29 +0300
Message-Id: <20230403154831.8651-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 2 small fixes for stable.


Adrian Hunter (2):
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

 tools/perf/util/auxtrace.c                          | 5 ++++-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)


Regards
Adrian
