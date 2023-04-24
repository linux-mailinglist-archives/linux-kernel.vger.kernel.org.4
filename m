Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599B6EC5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjDXF4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDXFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:55:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1B49E3;
        Sun, 23 Apr 2023 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682315696; x=1713851696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tMJI/saaFHcCMI1QKL7TYLYdtQJfus1WJg0qmpoA4SU=;
  b=agF+xZQtxlaYqhJrqDrXY6OYC0Mn6chcRD6kS/VCH2bnzMSUWU3XVrR3
   slqXYAT9ge9uQmbxbkbJhBzuAqvyfo/HvyvoYc+IoxlHqHpcyakTA3GHX
   1N8V0iJD/IujH8LJtQODNDkzHrZ5GNIF4uPTuVZ2fTuzFvJvQdrLfp1aX
   ZD+TaMolNUe/eXxFScgeEsKcDM7usBy+Soc1nH2rCwnUit3XFCB1AlbUn
   0E7KN3h5mGuHSa8gZ8l+5RhW2FmKThWuVu5HstBo3E/wdPcSvN+6tr4Ri
   p/8WPAD+wWOlju6gC8ISzvrojdDd8/DiVTo2EN4PZr5vP7QzYXbNFKwMy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325972494"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="325972494"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686669239"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="686669239"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.217])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 0/2] perf script: Refine printing of dso offset (dsoff)
Date:   Mon, 24 Apr 2023 08:51:05 +0300
Message-Id: <20230424055107.12105-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a refinement to patches from Changbin Du <changbin.du@huawei.com>
that add dsoff:

	https://lore.kernel.org/linux-perf-users/20230418031825.1262579-1-changbin.du@huawei.com/T/#t


Adrian Hunter (2):
      perf dso: Declare dso const as needed
      perf script: Refine printing of dso offset

 tools/perf/util/dso.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h |  8 +++++---
 tools/perf/util/map.c | 23 +++++++++++++++++++----
 3 files changed, 57 insertions(+), 7 deletions(-)


Regards
Adrian
