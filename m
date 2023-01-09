Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EF661C26
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjAIB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjAIB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:58:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3D10072
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229481; x=1704765481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WXohAuzKXOCDLN4oeNIAHB/IpmqKb5YdiBxzFVDKz8k=;
  b=azr3ApXQcpvy04e5gBpN17KupBTFqt+a9R5o7vgIbQN0dagGLJnjhGCp
   pmnLx0JSUDa5ALVf3YLdxXpOYSrwZ55Q9W2DS+g+jtKkJsuO8piV29roi
   YD39f/EHtQqPD1V+tWmkdmHYCDjxxFFQvkUdhn7nDoyvphYKED9b+OP7G
   ll6hd+Q0hsVA0n5KxyQCjISDJy6x7tI0icLDpimZayj9XEMYJZnLXfnO/
   T2afB2TU8D6WbrDCjFpW8KhrT9ConcKJ2eKB99yt8kvj2ZWQClRb1cZsY
   uDUwUbXUKuoHNlrch8WOAkPF9qjvV86TX/V3y4wsPFt73xb7FoV4EShks
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848715"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848715"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867403"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867403"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:45 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
Date:   Mon,  9 Jan 2023 09:49:51 +0800
Message-Id: <20230109014955.147068-1-baolu.lu@linux.intel.com>
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

This is a cleanup series after the merge of commit be51b1d6bbff
("iommu/sva: Refactoring iommu_sva_bind/unbind_device()"). It removes
the unused/duplicate data and code.

Lu Baolu (4):
  iommu/vt-d: Remove include/linux/intel-svm.h
  iommu/vt-d: Remove unused fields in svm structures
  iommu/vt-d: Remove users from intel_svm_dev
  iommu/vt-d: Remove sva from intel_svm_dev

 include/linux/intel-svm.h   | 16 -------
 drivers/iommu/intel/iommu.h | 11 +++--
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/svm.c   | 88 +++++++++++++++----------------------
 MAINTAINERS                 |  1 -
 5 files changed, 41 insertions(+), 76 deletions(-)
 delete mode 100644 include/linux/intel-svm.h

-- 
2.34.1

