Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD8679BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjAXOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjAXOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:30:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0574615C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E4A61299
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D8CC433D2;
        Tue, 24 Jan 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674570604;
        bh=PHhA2thK99LDK7KgFn8m6wG4a/0PBj3xWHjyopgvXng=;
        h=Date:From:To:Cc:Subject:From;
        b=pF1DuxX/DyIX/oQWzTMDkA1U5+mrtHEhsjFiHgeClJt4FB+w+aAlRQsEStR27GSfe
         2vgIqWZyBMU5QhhGYHAdWlK03K82YapJ+zjw2UXMsaXoIVFZLHhjbNc1+7Vqrp/PAB
         9kmVfx4Vs5RJs01Q0ylD5W9cDv1Yfroqxdk3G2CBolLtgDNLRUnsURqWE/zJ0WMoSE
         M4FduDVA0dTcuzKTizntStT4UbqmbZnPDteeLs+FAAGXK/ap9m7dskCtbJhltafaJx
         AJ6+RR0gTSK3s3+rmigSv1N0qDC0fOThiHqh9zDpZ6ZGOVxzHpmSNKm5KHvkshx/kA
         Nf8XH+1mH94SQ==
Date:   Tue, 24 Jan 2023 14:29:59 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL v2] iommu/arm-smmu: Updates for 6.3
Message-ID: <20230124142957.GA26873@willie-the-truck>
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

This is an updated version of the pull request I previously sent here:

https://lore.kernel.org/r/20230120161527.GA22266@willie-the-truck

The branch is now based on your iommu/fixes branch rather than the
arm-smmu-fixes tag. I've also picked up an additional DT bindings patch
which came in since last time.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 142e821f68cf5da79ce722cb9c1323afae30e185:

  iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe() (2023-01-13 13:46:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 8a24401701aa67c3bf8daa56c54d7bd1d6e69c23:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-01-24 11:45:41 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.3

- Device-tree binding updates:
  * Cater for three power domains on SM6375
  * Document existing compatible strings for Qualcomm SoCs
  * Tighten up clocks description for platform-specific compatible strings

- Enable Qualcomm workarounds for some additional platforms that need them

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P

Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500

Krzysztof Kozlowski (1):
      dt-bindings: arm-smmu: disallow clocks when not used

Luca Weiss (1):
      dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible

Manivannan Sadhasivam (1):
      dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65

Marijn Suijten (2):
      dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
      iommu/arm-smmu-qcom: Add SM8150 DPU compatible

Martin Botka (1):
      dt-bindings: arm-smmu: Document smmu-500 binding for SM6125

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 66 +++++++++++++++++++---
 .../devicetree/bindings/iommu/qcom,iommu.txt       |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  2 +
 3 files changed, 60 insertions(+), 9 deletions(-)
