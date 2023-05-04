Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8A6F77CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjEDVLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEDVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:11:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0533814923
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:11:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7F61FB;
        Thu,  4 May 2023 14:11:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B81253F67D;
        Thu,  4 May 2023 14:10:59 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@nvidia.com
Cc:     will@kernel.org, schnelle@linux.ibm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu: Make flush queues a proper capability
Date:   Thu,  4 May 2023 22:10:54 +0100
Message-Id: <cover.1683233867.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since it came up in discussion on the default domain series, it seemed
pertinent to dig this idea up, whcih I started a while ago, and finish
it off.

Cheers,
Robin.


Robin Murphy (2):
  iommu: Add a capability for flush queue support
  iommu: Use flush queue capability

 drivers/iommu/amd/iommu.c                   | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
 drivers/iommu/dma-iommu.c                   | 3 ++-
 drivers/iommu/intel/iommu.c                 | 2 +-
 drivers/iommu/iommu.c                       | 3 ++-
 include/linux/iommu.h                       | 6 ++++++
 7 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

