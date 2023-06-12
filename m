Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8872D48E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbjFLWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjFLWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:40:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E55171B;
        Mon, 12 Jun 2023 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686609635; x=1718145635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GFseFPfxGeHLbuj0pBo1wJue2Km6F13yUcmnrtKmAJw=;
  b=XBplvlLVhiGSRRvEdG44abxUM/3g/mKvHk/nCxOuo8tOqCHxMvBaL2V2
   ffb792qE7Ccvz1dRpdLLmyZIxqfKEfaboNA9E/X74gK8PPg3Mnt7xwfN4
   2KE5PJ+xaRUfrXWiY5rGQ6zgr5s+zXWuVg+oTk+UEvOKA8NirnFMbsB9u
   LpcThcV+jr43Pvjt77aXvDE8ugvvrt/MoXEiuSIm5pfyThmujpwAiElZf
   /M8C8U5Qc4uPdDp8ovVlheJT2bOw5LEQoxRSHL6DGUPZFDjmsb8bm9gAA
   YPxvRJmoFLvw7zbOqQzuYEwU1oI8f9Q1TypvbNmqyCQzMH955wA7kOz1K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347829707"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="347829707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688805721"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688805721"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 15:40:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] TPMI updates for SST
Date:   Mon, 12 Jun 2023 15:40:31 -0700
Message-Id: <20230612224033.2382527-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two fixes. Patches are on top of
review-hans branch of 
 https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86

Since these are unlreased products, I didn't mark for stable.

Srinivas Pandruvada (2):
  platform/x86: ISST: Reset default callback on unregister
  platform/x86: ISST: Fix usage counter

 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.38.1

