Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECCE6D0657
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjC3NSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjC3NSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:18:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325399;
        Thu, 30 Mar 2023 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680182328; x=1711718328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hoxHQPi0M1yETRVoF+tpUO9FeAawN2oasafgayBxKMA=;
  b=dQ0B0A4uAvcMtHgZfQAVTmBnt+pBDO4zuf2RQc4j4fVx9kQLq+e8iGvI
   Q7ydQT66w5L4peZgutadNcboD27E4YUJ2XHtYhljXkqA11vqTtWcGGuma
   Qwlhf4boy1F0pEt58RO/ItBWd5YPYwy4a9U4/U233GxK5HzCUxMEjLcgl
   TGK1YRBzVI4I6uXEchOaqkmWfUTfhSNrYAf0lZ6Ibhe5NJLBFkUsGK72K
   UwQf45Mo0bmbmZ3t9B/hS+lJALmb+1yR/hDUZsZRpzLfwug0ouTW0kzr9
   /Qfn/+0TgeZ9c0RrGneWHxesfcvrYP8bGFo/lef1UPZ9bkRd9So4O1kf6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427440745"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427440745"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="678185521"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="678185521"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.32.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf top: Add --branch-history option
Date:   Thu, 30 Mar 2023 16:18:31 +0300
Message-Id: <20230330131833.12864-1-adrian.hunter@intel.com>
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

Here are small patches related to option --branch-history.

Note, currently --branch-history is broken due to patch
"perf report: append inlines to non-dwarf callchains" so
that needs to be reverted / fixed beforehand.


Adrian Hunter (2):
      perf top: Add --branch-history option
      perf symbol: Remove unused branch_callstack

 tools/perf/Documentation/perf-top.txt |  4 ++++
 tools/perf/builtin-top.c              | 17 +++++++++++++++++
 tools/perf/util/symbol_conf.h         |  1 -
 3 files changed, 21 insertions(+), 1 deletion(-)


Regards
Adrian
