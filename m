Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978E1633164
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKVAg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiKVAgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:36:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7447CC6BDC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077414; x=1700613414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qe9a910lp3C11Os5WJ3iUPlb1nBOGDw3/m+ycILoXGQ=;
  b=KsEshicKOKEnfWHGTalQIgo0CkPmiDaRW7yO2fwtsy6Kve5D31B3HdRx
   QedNRLNYie+b2KsphlOP9Vl2tu2HGeOdPhmxgSck3WQS2GrPpllPHUqjP
   46B0QLU4vnjPBrtEWa6xuM8IrMEx54TOLibHlOy6uy7mtZj9rqGXTcY3B
   WwYFbZy3gyii6OqIuy9nkyrv5Ex42OrmVsblmW+7O6lV7dSGmmKfMo13R
   IsOGDbP+HbZ2J8ub3CStWnwrpy4kTaYgc1nKJAQ7HSjJ2pj/+dC1mDztf
   T3pgTP5TuETrw0m7UEscYP6VSeC3xZxseMLv8NOJkdicEA6YmgQSxLWio
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315516470"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315516470"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018413"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018413"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:36:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for Linux v6.2
Date:   Tue, 22 Nov 2022 08:29:42 +0800
Message-Id: <20221122002949.148140-1-baolu.lu@linux.intel.com>
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

This includes patches queued for v6.2. It includes:

 - Add blocking domain support
 - Cleanups

The whole series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.2

Please consider them for next.

Best regards,
Baolu

Lu Baolu (7):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Add device_block_translation() helper
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Rename iommu_disable_dev_iotlb()
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 ++--
 drivers/iommu/intel/iommu.c | 169 ++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 94 deletions(-)

-- 
2.34.1

