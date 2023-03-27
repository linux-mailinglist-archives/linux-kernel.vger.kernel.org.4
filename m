Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321FC6CA49A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjC0MwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjC0MwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2C1707;
        Mon, 27 Mar 2023 05:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAF1611FA;
        Mon, 27 Mar 2023 12:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E1BC433A7;
        Mon, 27 Mar 2023 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679921534;
        bh=uXMl4znz9rDkGOg9wXv6N3U/XB47gfPq6lCrD968Q8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePLD3gEkrffn2dATRctLOLxZ5FzXetJV9cqkNd+/B3SjL5XSNgrbyG4CO5D28s9Hh
         6gG3VhikX1UdaanrEsRUvRNbshZkv3FM9YOWQfCIsgJtLvQRhmIFDMg206Ihyg4LPR
         CyXggpU7JmX8Td0BZkmeWXdC+etwsgX5CvBHjOMefdKRrZi/DIZFmFC+Bc5/v+g3YV
         cdzyvmAcVFs3ZCUa/T9GqSRXKN83cMQA9EYeKGPD4vVaF4mpJQ9Jlw4yPvwTs/Nkuw
         HIdpJU9NOzPP568+S1mAc6/2eiQT4/N01iWZw7dhkpDuET/aO6IVCgPtuv7BrqLt7S
         3Xiv7B/I1gcvg==
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Clean up Adreno SMMU bindings
Date:   Mon, 27 Mar 2023 13:52:00 +0100
Message-Id: <167991667600.1301690.1905229622201713080.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
References: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 17:44:15 +0100, Konrad Dybcio wrote:
> v2 -> v3:
> - Pick up acks
> - Fix the "arm,smmu-500" typo in bindings (Rob)
> - use b4
> 
> v2: https://lore.kernel.org/lkml/3aa78b15-8e6c-9657-0d08-0d0452d51fbe@linaro.org/T/#md7074966fdcbbd884baf62153f726bec54b2e819
> 
> [...]

Applied bindings changes to will (for-joerg/arm-smmu/bindings), thanks!

[1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible for MMU500 adreno SMMUs
      https://git.kernel.org/will/c/5c3686616b18
[2/6] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
      https://git.kernel.org/will/c/16d1646871fb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
