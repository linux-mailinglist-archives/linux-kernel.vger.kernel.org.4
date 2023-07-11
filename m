Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DF74FAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGKWKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGKWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:10:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD01705;
        Tue, 11 Jul 2023 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689113401; x=1720649401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unLhgZdc1Wz+RdhYe9QyjJ10LglWZpGdhA/Duk3Ky10=;
  b=YR07f7c/2js05xF2doPH64F4JG7mLLKmntMn+nAMxDKL752L8sF0f+Pt
   1l1krw+2sHv++VA4RqZBx2fSDInjxfS5cvHEf6P0WukAiz1MUMuB59Ivk
   3wTZi+mydVK0aHxgNCQ0CmtN3aeaf+2KC4phobPmu24adcqCzQDOVcobX
   jdUBcjmGVKymeZupc8kypzMhT+XWm0RKlXAb6lvs36uNPNV+rZIZ+zqYI
   y9aXlWuTvZCTcW7dS2/L0ZoMLS0nQ791KCCJiEGpk4AaCQYRgJVQ9TvVI
   c7Rv/9f399PyFvBXIJDvVXAaChFAnZc8ZmD0PHG3ub8ITvuhPb0Vitmfu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345058979"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="345058979"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786795075"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="786795075"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 15:10:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] TPMI control and debugfs support
Date:   Tue, 11 Jul 2023 15:09:46 -0700
Message-Id: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch provides interface to read feature status. This is
generic patch to be used by other feature drivers.

The second patch add support for debugfs. Debugfs also display
feature status using the first patch

Srinivas Pandruvada (3):
  platform/x86/intel/tpmi: Read feature control status
  platform/x86/intel/tpmi: Add debugfs interface
  doc: TPMI: Add debugfs documentation

 Documentation/ABI/testing/debugfs-tpmi |  31 ++
 MAINTAINERS                            |   1 +
 drivers/platform/x86/intel/tpmi.c      | 414 ++++++++++++++++++++++++-
 include/linux/intel_tpmi.h             |   2 +
 4 files changed, 441 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-tpmi

-- 
2.40.1

