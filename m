Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC471F84A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjFBCId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFBCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:08:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1B13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685671711; x=1717207711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGlNXT/q4/l3CvQLFTPbchlcffVRsXT/d11BWSw/2/o=;
  b=C126j8jtzPiDZ0DvZDd9tSkbCSIgGyUGt9giWRel4p2RIYx8sWdoPXN4
   bMZvVGl8im8UoaqmkxZBpt33Y/q4SxmR3cFJfW8OcfZ7WR/LTPTaeBMSS
   HiPb5wJuMO5TKc8mR0lhitr96dJlPg14fGCHFw16GYEdJDxsNyxzAIOek
   PzbNe7umcqG7fDT88aUeIgkBotbXBjPQfbcpcrMCP2YC89iHVFQE3svZI
   r+0xaX/i1kuRfiz/KNU8EsRoYMyJXNwoHcBi2BZwZAlh/3aoDhgU53UJt
   x/4ULK0k16V31Q8YlXfKEJEw4M068oqdd5hYGkBc8p8oMhiiWoJDkyLmn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="359039371"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="359039371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777457798"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="777457798"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:19 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH v2 0/2] Misc cleanup for iommu/vt-d
Date:   Fri,  2 Jun 2023 10:05:18 +0800
Message-Id: <20230602020520.224465-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes expected.

v1->v2:
1.Change to use check and return for dmar_reenable_qi()
2.Remove WARN_ON of 'table' instead of using BUG_ON
3.Also remove useless WARN_ON of domain id

Thanks for Baolu's suggestion!

Yanfei Xu (2):
  iommu/vt-d: Handle the failure case of dmar_reenable_qi()
  iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()

 drivers/iommu/intel/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

