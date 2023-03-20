Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C2E6C2039
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCTSqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCTSpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:45:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC90325E3C;
        Mon, 20 Mar 2023 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679337536; x=1710873536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xBVA+rxKOlHABSAbfGyz1olD1VAK66fbUS7prRd9Bz0=;
  b=SF0wHTuz2JA0/4CI2snHXmJ4cMSu8VVAuGC7CimOeCMeC9eqsKKzeYaK
   UtsEPmnS9/n8kgxiJNAhbnqgvETjr6MwN1UpdmVgpHsNmKCt2FOplitJR
   5cj69YVGt5/sMjZIx3wndYkE2jOjb7vBjHEyPBmfYB6MKFzyWUkb7Yrng
   n02tb4U6RUf23IS1f4snefO/5VcZsIL7SMyw7Q8dSC4+5LNM+mzsooylu
   mwenh1X600bWFrNb0SkKTEsphM2LS+FtqMJWwLAGmpWl4IxVjMDtN9hh7
   Xfq13XugJQ/X8+PtDwvh5he4oQygRG39ygr6igrn9aIfZ98okgF+Rv6mr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322588293"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322588293"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791730815"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="791730815"
Received: from spalihov-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Small updates
Date:   Mon, 20 Mar 2023 20:35:15 +0200
Message-Id: <20230320183517.15099-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 2 small updates for Intel PT.

The first is just a couple of new event type names.

The second is a small change to Intel PT as it relates to
Intel FRED.  The patch is standalone but, for anyone
interested, you can search LKML for FRED to find out more
about Intel FRED implementation.


Adrian Hunter (2):
      perf intel-pt: Add event type names UINTR and UIRET
      perf intel-pt: Add support for new branch instructions ERETS and ERETU

 tools/perf/arch/x86/tests/insn-x86.c                   |  4 ++++
 tools/perf/builtin-script.c                            |  2 +-
 .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 18 ++++++++++++++++++
 .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.h |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)


Regards
Adrian
