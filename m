Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6368FEE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBIEbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBIEbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9EC41B64;
        Wed,  8 Feb 2023 20:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151276181D;
        Thu,  9 Feb 2023 04:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777AC433A4;
        Thu,  9 Feb 2023 04:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916524;
        bh=6a8IHCccFNXAqRbdKPys5PCrGXhM//ox9j3YLmVPDYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbFOz4zaaTcQ19ymnxXHyCOL2Kx6Md/2lqVLvfsCZy2Y49Mdy2REkslp2kf57ZnJ+
         qY+Ej7GN+1O+l+DhggGB20on1OgfTy4senOqv1+egENUEWASMRYjiMuYt0tDsnc/TG
         d3E+8tjeE8q1Stl0XOpwhSetg8keMws7DDOPUyAYmZi3zptb3pHh8Blo8KAz5OwdSu
         NSHYxYVPh3ZU+D52EP5weulVuLpwCnjsE1hBaeOqNytE7b41gT64BUewuOmwEGqgKI
         JWbLF3DTaZKmaYrDSU0oBMa5UE9OzvftqrH1jYM0girzhUiarxzI3FgOyPD3Mrn90O
         FKOnjUk9VATMQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org, joro@8bytes.org,
        krzysztof.kozlowski+dt@linaro.org, will@kernel.org
Cc:     konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date:   Wed,  8 Feb 2023 20:23:20 -0800
Message-Id: <167591660366.1230100.12722515257767815828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 18:49:28 +0530, Manivannan Sadhasivam wrote:
> Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
> IP. Even though the SoC specfic compatibles were being used in devicetree,
> the compatibles were not added to the arm-smmu-qcom driver. So they end up
> using the generic ARM SMMU-500 driver instead.
> 
> Spotting this discrepancy, the recent arm,smmu bindings change moved these
> SoCs under the non-qcom implementation of the SMMU.
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU node
      commit: af4ab377543853b690cc85b4c46cf976ab560dc2
[3/3] ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU node
      commit: 157178a7912e00a0aa0371dc9041952c1a21d112

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
