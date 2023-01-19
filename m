Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C716674273
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjASTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjASTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:11:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9495762;
        Thu, 19 Jan 2023 11:10:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BAA61D57;
        Thu, 19 Jan 2023 19:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61705C433EF;
        Thu, 19 Jan 2023 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155361;
        bh=L96CiyxDqJQ1R3tSGxtY8MIZKLSX74xqYGN6oYu3uJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvwiCEhA4FKeukST+Pm8eh/01rTbHQ19Mcd3hpODmzZ2H76O6lZZ0qzsXVMkTK8Pd
         WffM7EFzIMPUtEQkB8IiS2MyzPDU0r/y9Qcb393Bix5vyGEhd0jAZW4x+MqVSaiJuu
         WmN0Zakt4hsyNtLCebhnns02keHskm3gYg9H+vodk+aEn8tckO713zN7j24IB+Aujy
         c2RPAQCfTLBO/+Yhjk5ixriW5u8XKzfgpymWu1p84qQcM5oVS565p5rMZSzNTP+CTK
         zaXCoTtjKlm1Vtq9ETIPeg6A9vrWiXHVpaunCNEhj06Ul5NrmCZ7ipg3eOzmG/2xSc
         MGWT3q9pDLc9A==
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Lux Aliaga <they@mint.lgbt>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        iommu@lists.linux.dev, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v5 0/4] arm64: dts: qcom: sm6125: Enable APPS SMMU
Date:   Thu, 19 Jan 2023 19:08:40 +0000
Message-Id: <167415032929.2381501.12211116927490999924.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222193254.126925-1-marijn.suijten@somainline.org>
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 20:32:50 +0100, Marijn Suijten wrote:
> Add APPS SMMU to SM6125 dtsi and use it in SDHCI/USB nodes.
> 
> Changes since v4:
> 
> - Use hexadecimal 0x0 for iommu mask;
> - Add sm6125 to the dt-bindings list without clocks, now depending on:
>   https://lore.kernel.org/linux-arm-kernel/20221222092355.74586-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied first patch to will (for-joerg/arm-smmu/bindings), thanks!

[1/4] dt-bindings: arm-smmu: Document smmu-500 binding for SM6125
      https://git.kernel.org/will/c/c940c8787929

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
