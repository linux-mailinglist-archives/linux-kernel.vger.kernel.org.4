Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19AF5EA92B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiIZOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiIZOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:54:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D893209
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198491; x=1695734491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l33uKlRVnUDCKGSfBJTiII0eIXph9lfvKj0L97VJdbk=;
  b=ed+DoUGVJwk1RhbUPsAA7kYA5ikfuuzPG18J6vOcsOzDqI38EqVj1Dtl
   1Z9RJ9HFOxzU1F/cmDXwUfsmwfKHPm3y/qSne4NTPvjGXep28WqwL+USq
   hI8VT7zgMZRU9K191t/aywNufqo1OaBMZTApTjMd4BjEa/cFlER+rY5rq
   JPxSpkNtW68oBUJbOb+welLx80ksignR3gI97XuSA0agbUmbZFjG3gXgg
   OopKJ2EUqK8OVIfCW/B7GypJDOwwzui9n7/bkOEfI48Yw6YU3D1X4b+wp
   HuIHe7sOpV+KTpamIAOSa6S9t79vM/uhMNRRFloacW9GlXkOOuh63X3xQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280750279"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="280750279"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525645"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525645"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Date:   Mon, 26 Sep 2022 21:15:23 +0800
Message-Id: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This is a resent pull request. It's based on v6.0-rc7. The original pull
request was posted here:

https://lore.kernel.org/linux-iommu/20220923004206.3630441-1-baolu.lu@linux.intel.com/

Please pull.

Best regards,
Baolu


Lu Baolu (5):
  iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
  iommu/vt-d: Decouple PASID & PRI enabling from SVA
  iommu/vt-d: Remove pasid_set_eafe()
  iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
  iommu/vt-d: Avoid unnecessary global DMA cache invalidation

Yi Liu (1):
  iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

 drivers/iommu/intel/iommu.h         |  7 ++-
 drivers/iommu/intel/cap_audit.c     |  4 +-
 drivers/iommu/intel/iommu.c         | 87 ++++++++---------------------
 drivers/iommu/intel/irq_remapping.c |  6 +-
 drivers/iommu/intel/pasid.c         | 12 +---
 drivers/iommu/intel/svm.c           | 62 +++-----------------
 drivers/iommu/intel/Kconfig         |  5 +-
 7 files changed, 45 insertions(+), 138 deletions(-)

-- 
2.34.1

