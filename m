Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDE6825B9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAaHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAaHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA83D0BC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151167; x=1706687167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNCQujARwuJwXRY5SFqhJMHVKPgrkRp65A0eKgK5PGw=;
  b=SvO+ZmKOnw9gQ7i5GjMxzXKyY5ulk3OkahEpvUhefgWuiGTV4mhck29u
   4gKTQ/vqTtlxH283sVMYwbnDfecmT9WOty7pwA420wW5l9cupkDCErtWa
   s+k+hemcxOj9lLxWYCCXJF+vfSYacBaNgcVJ0zpyPCnZy+J29Th7FEKnN
   +g5SmstE2gvrr4pMMSKADkgzKIvqSuojqhSlXP+jQspBn7YEbgiiFuWpP
   l1r5OMkZuLSqiaVoucmvtBtolkOfI+UwaOqnWJ/wJ7O+eEYPgQDrKag5o
   kxAfqEpFc5+964pvNDIlwSfTiCqLfHwjsvqS2vXcsQzsnFPYBXnueQB82
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736580"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736580"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775506"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775506"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:51 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v6.3
Date:   Tue, 31 Jan 2023 15:37:28 +0800
Message-Id: <20230131073740.378984-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This includes patches queued for v6.3. It includes:

 - Add Intel IOMMU performance monitoring support
 - Set No Execute Enable bit in PASID table entry
 - Cleanups

The whole series is based on v6.2-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.3

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Kan Liang (7):
  iommu/vt-d: Support size of the register set in DRHD
  iommu/vt-d: Retrieve IOMMU perfmon capability information
  iommu/vt-d: Support Enhanced Command Interface
  iommu/vt-d: Add IOMMU perfmon support
  iommu/vt-d: Support cpumask for IOMMU perfmon
  iommu/vt-d: Add IOMMU perfmon overflow handler support
  iommu/vt-d: Enable IOMMU perfmon support

Lu Baolu (5):
  iommu/vt-d: Remove include/linux/intel-svm.h
  iommu/vt-d: Remove unused fields in svm structures
  iommu/vt-d: Remove users from intel_svm_dev
  iommu/vt-d: Remove sva from intel_svm_dev
  iommu/vt-d: Set No Execute Enable bit in PASID table entry

 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 include/linux/intel-svm.h                     |  16 -
 drivers/iommu/intel/iommu.h                   | 113 ++-
 drivers/iommu/intel/perfmon.h                 |  64 ++
 include/acpi/actbl1.h                         |   2 +-
 drivers/iommu/intel/dmar.c                    |  33 +-
 drivers/iommu/intel/iommu.c                   |  60 +-
 drivers/iommu/intel/pasid.c                   |  11 +
 drivers/iommu/intel/perfmon.c                 | 877 ++++++++++++++++++
 drivers/iommu/intel/svm.c                     |  90 +-
 .../sysfs-bus-event_source-devices-iommu      |  37 +
 MAINTAINERS                                   |   1 -
 drivers/iommu/intel/Kconfig                   |  11 +
 drivers/iommu/intel/Makefile                  |   1 +
 15 files changed, 1234 insertions(+), 84 deletions(-)
 delete mode 100644 include/linux/intel-svm.h
 create mode 100644 drivers/iommu/intel/perfmon.h
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu

-- 
2.34.1

