Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F8699580
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBPNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBPNQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:16:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CF3B851
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553402; x=1708089402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MybL6PZvO8vl1RhV9+iwIm6F1rZbvNks5EmjDZ1/Cx8=;
  b=VuaVnbKqcANlAPso2FJgVrsJ2wrFut5KYjvGlzzwj/lai8JVUYj9Ah/h
   jUYPgcWVAsqe55CjAI7qzusavzysoB9IH2fe/dy2UnucgD5RD7eEEmfEk
   VPTPYuytWLmogdAriQlNBSh3hO0yVt0qMPoDutSmptDgJQzM0AVVEVhQ9
   0JcpEfRwTjGF9iRthiaOLbK+hnN6xt9Jx6mB/vOdKJrN22Fo+MxH6Gm09
   KBVC5fQBj+VcV0Ka53DkmPHZYrvE+xbvkdL04U3a4habWspmB8LQbFW3H
   w4/gcT/NZqrt/8hyoIQt5Wlwkdc1jatZ2x1yaq9w8LEkKdi4yJBLrVwBP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883289"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674908"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674908"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:40 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
Date:   Thu, 16 Feb 2023 21:08:12 +0800
Message-Id: <20230216130816.151824-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Below iommu/vt-d fixes are queued for your fixes branch.

- Two performance optimizations
- Fix PASID directory pointer coherency
- Fix missed rollbacks in error path

Please consider it for the iommu/fixes branch.

Best regards,
Lu Baolu

Jacob Pan (2):
  iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
  iommu/vt-d: Fix PASID directory pointer coherency

Lu Baolu (1):
  iommu/vt-d: Fix error handling in sva enable/disable paths

Tina Zhang (1):
  iommu/vt-d: Allow to use flush-queue when first level is default

 drivers/iommu/intel/iommu.c | 26 ++++++++++++++++++++------
 drivers/iommu/intel/pasid.c |  7 +++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.34.1

