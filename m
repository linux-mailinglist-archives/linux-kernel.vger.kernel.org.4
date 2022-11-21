Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876FC632F32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKUVqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKUVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:45:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B22BB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:45:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33286147D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0540EC433C1;
        Mon, 21 Nov 2022 21:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669067155;
        bh=wLqFABjJ3uzCRmQ6ciIEyO2/VGvPFJAvl+pC+DOyGz4=;
        h=Date:From:To:Cc:Subject:From;
        b=k/AThiopGeqRS8E2O5eA+N2g0DM0+AEJy5UUR/Sr/EBr91R8zA6+qxuuC2WMStIBL
         2x+Pn9eISyTqzs5ipB/o+KkJ0P01DlT34zM6/AL9vjYBcfH9gFOf1wGRV4zyHcWEh1
         1etnoaaq+lWm5jGcb79iHhvN9C0YR2X8BVDmXryhRmR7B+VLA9+ABg+t4DEJzalevg
         GGpnjbPGBbCsqRhvfN4B867N+l7pWBBRiCbHy2lh4P42ItLcLhiyMupqeQIW43iFZ3
         d+FEIQj9wUebg8ucdKLioLN33Qm9TrKbK60NCNC+eKB4+vlXvDPTAeuknJqa/CnroE
         nHKzLrzowGl6A==
Date:   Mon, 21 Nov 2022 21:45:50 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.2
Message-ID: <20221121214549.GA8910@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 6.2. As per usual, it's mostly
updates to the devicetree bindings, but this time around the introduction of
a generic compatible string for Qualcomm MMU-500 implementations promises an
end to the churn.

Summary in the tag.

Please pull,

Will

--->8


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 4428673bc89b547a35019f0d3bd8821beacf86ef:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2022-11-21 19:21:53 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.2

- Report a warning if we fail to disable the MMU-500 prefetcher

- Usual mass of devicetree binding additions

- Qualcomm SMMU refactoring and generic "qcom,smmu-500" addition

----------------------------------------------------------------
Adam Skladowski (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
      iommu/arm-smmu-qcom: Add SM6115 support

Chen Lin (1):
      iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply

Dmitry Baryshkov (10):
      dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
      dt-bindings: arm-smmu: fix clocks/clock-names schema
      dt-bindings: arm-smmu: add special case for Google Cheza platform
      dt-bindings: arm-smmu: Add generic qcom,smmu-500 bindings
      iommu/arm-smmu-qcom: Move implementation data into match data
      iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create
      iommu/arm-smmu-qcom: provide separate implementation for SDM845-smmu-500
      iommu/arm-smmu-qcom: Merge table from arm-smmu-qcom-debug into match data
      iommu/arm-smmu-qcom: Stop using mmu500 reset for v2 MMUs
      iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match entry

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
      iommu/arm-smmu-qcom: Add SM6350 SMMUv2

Melody Olvera (2):
      dt-bindings: arm-smmu: Add 'compatible' for QDU1000 and QRU1000
      drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation

Richard Acayan (1):
      dt-bindings: iommu: arm-smmu: add sdm670 compatible

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 178 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |  91 -----------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 157 +++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  21 ++-
 5 files changed, 302 insertions(+), 148 deletions(-)
