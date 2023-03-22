Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F66C4E23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjCVOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCVOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D967016;
        Wed, 22 Mar 2023 07:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D63CCE1DC9;
        Wed, 22 Mar 2023 14:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A0EC433EF;
        Wed, 22 Mar 2023 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496131;
        bh=VmyZDuXOYEyM80aiPnrY30AW88DT9IrvHWNMBK64nN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyS2h+9gC2nqCkcMME1zAWYa8/zN/FNHSiRvwLXMK1sdjBIATp19UePSaPSqiV31A
         mrKsRHAoZOYT0zATsXxRsLKlbl/LooENpss8XPRXXpRiI55wM+ehVLSia6gqTyGgqC
         fU7b9T44CDO0PDTYHdF8L10Y/tycKiyXVCHw5CeNjFEOUNtX4oHYZ3iEClow5eSTeJ
         L2HUPVKPNwHCpEZYa+93dKvWqWAcNKdtb1a94sP8hFftvKpFLGDwYwZQSGMiHGKS0C
         9aCM2KOmSAhd/m5JGWRFFicCrG08ex0pfojaqFeQEBpKIN23m1ABjjFnbFFvkCE/xO
         a477WldY90hZQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     vladimir.zapolskiy@linaro.org, konrad.dybcio@linaro.org,
        agross@kernel.org, rfoss@kernel.org, bhupesh.linux@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH 0/5] arm64: dts: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Wed, 22 Mar 2023 07:45:01 -0700
Message-Id: <167949631651.1081726.9216178360634534055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
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

On Wed, 22 Mar 2023 00:31:13 +0530, Bhupesh Sharma wrote:
> This patchset enables Crypto Engine support for Qualcomm SoCs like
> SM6115, SM8150, SM8250 and SM8350.
> 
> While at it, also fix the compatible string for BAM DMA engine
> used in sdm845.dtsi
> 
> Note that:
> - SM8250 crypto engine patch utilizes the work already done by myself and
>   Vladimir.
> - SM8350 crypto engine patch utilizes the work already done by Robert.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
      commit: b767d1b40cbca49452d712ca0f4f053dacfc5c45

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
