Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B564293C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiLENVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiLENVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:21:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2401C419
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670246493; x=1701782493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYI9+dQAeNtU/Cg2+gsptBgiX5yh40A4JHayJSrxBPg=;
  b=kQkUrhZDO3Gotf0vdEhaCrH3t9bwkVFSJDx2EFFoaSVx0KzkqjBHwpAq
   kLMdJSGfJckHDE+Rftj8PBjEKLMbalt0QjAlWpPg8TCHMeSDQMAXbmeUJ
   9o6H4l6gBSkR31tTMq/OPuwD6P2G7P+20Tc6ov9ngsqs2PVjm+LE9EVKi
   tKBhpK4Sy1I8yf+VQoVbbP3VBjYHLXzT2NNVU1qNt5xf9Njpi/G4Ic73S
   fOgd2BNtyBPElhFO+GzNVW/9ypGu0DOA8j4//2Lko3bwDngmBEEKNoNNa
   7hkZe0BAjiJTi5tECV77yQrCmY191sjdhjxWdE/zJPun205SxBnt4DRin
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="315046100"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="315046100"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="676583246"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="676583246"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2022 05:21:31 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.1
Date:   Mon,  5 Dec 2022 21:14:11 +0800
Message-Id: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
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

Below iommu/vt-d fix is queued for your fixes branch. It aims to:

- Fix buggy QAT device mask.

Please consider it for the iommu/fixes branch.

Best regards,
Lu Baolu

Jacob Pan (1):
  iommu/vt-d: Fix buggy QAT device mask

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

