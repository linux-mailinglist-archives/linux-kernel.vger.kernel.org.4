Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA7715A21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE3J2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjE3J2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:28:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF500E42
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685438865; x=1716974865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fwDm9P8i3dM03v8xT2BAJA6dpEcFw/nhuLb3OjYlrjA=;
  b=d6PHBbyHb5qmReTyHnSRtOQNTau3DF4tAej5ulrGuAqG+doCgwc9QMHf
   xcWlR7yRDeZFp5wcMD5LvPOLZb7ZDX7VjSUmwHwYGlpfL4G2aI2Sd0sN8
   0taw9TVzJfZ+zFGUQmBmXsau5886L/M9qrB4SoD2ZtkxqnpxIKe9noIh7
   tIjEjpfn8raYUHHb5B5d0C6j5jyeD+Vw9RtNrnunrzZVpktqdRDo1fnoI
   F2NrFoXlrIke4lwWO+HneCfDhtVben1Ktwd/D2SgHozDMAg5vecVcK2gV
   ozgc+8qLPiWHvbTnx0Si+5/SX2/54TKJ22XBQCv5NL6U7T6xB6u6JMXoq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344365153"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344365153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="818720131"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="818720131"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:42 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH 0/2] Misc cleanup for iommu/vt-d
Date:   Tue, 30 May 2023 17:25:01 +0800
Message-Id: <20230530092503.152926-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes expected.

Yanfei Xu (2):
  iommu/vt-d: Remove the dead code in init_iommu_hw()
  iommu/vt-d: Use BUG_ON to check NULL value of 'table'

 drivers/iommu/intel/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.34.1

