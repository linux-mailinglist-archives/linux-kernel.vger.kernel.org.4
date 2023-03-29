Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8512C6CF564
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2V3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2V3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:29:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B391991
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:29:41 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f188so2728968ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680125380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3yNkZuxjV5q0QNma+hUnaAvguI9Ie4RgLhWd7LHbVA=;
        b=AImXvj1NQS9c8BamFFYhp04cM70SunPi5pDHllZqHMIu4PZpFwi/1m2QWuUVsTtszG
         jlpiqEph7Zj7mUdW8UztovQ6t2mQbW8YeQAFDgWHcJCZsCdGrLObp/ZstX09+PLzvKgv
         +VML+6Bh1hmcZCdZ1CWnsjiZmToaXWJHkoS4B39yCOLW/lyo2t97+IJz+8NPwHWcSKr7
         ZP+bRiH2AQXS/vyVdIknjlWZXOjKMx8Qeb2+PX7y6OxaJj3MyYwA8lx8FsrKrXziQLZG
         hQ6if1KKoeLTX+VjGvq7HrxciZVLYvcYNF9GIrTUVq7FNbnoyRpqGGUOGO5kS4yqEkh6
         w2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3yNkZuxjV5q0QNma+hUnaAvguI9Ie4RgLhWd7LHbVA=;
        b=hXbg5zWddMVFKvYibHaEJHhwc1XFmSA8k1EBmR0m/jKqBIBaZ7S/pLe4Bxxx200Wwu
         3EGodj6uUBW6yFcj33jEFf3LmcvPvwS633od26U2AWNyFrHCOPUVPhW4+HwtoHPmprkK
         MpW1NWw6vjgRiVboCN+YzYxlM6afoRdel5h97yC66jV1R0gN0tiNACzh7m1axz35fPz5
         KM0Ony+TzgeSfhEHXduVp9J6kbl7d9DwqYEi9IAYixxLFKw37rLFVyLnRX1dA7FHYZoJ
         SvEnBG9MBA2gRX1DH7qo/OC1VjJ3CQ7n8qsOoqYYr6AtgiNqiUieP5qtH3sosr+8md0P
         e8dg==
X-Gm-Message-State: AAQBX9cEW/r/qTiO4Xaz+/EkUsDYUBRVLzOLCEBmxOr6jxVgE8nxFPZN
        pkSAT9qTIVzqupjvf9DekIPOG27/ZH2MVTIp96kdGw==
X-Google-Smtp-Source: AKy350bX//N2Pe5TyFJXCG2bqMqJRp0gtN7CBEweO9QG3wRnDcPzL3DlZZlu4GqCC9Kh42BeFl97vzthCV5oQ0kEaus=
X-Received: by 2002:a05:6902:1549:b0:b77:be38:6406 with SMTP id
 r9-20020a056902154900b00b77be386406mr10732365ybu.9.1680125380407; Wed, 29 Mar
 2023 14:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org> <20230329-topic-adreno_opp-v1-2-24d34ac6f007@linaro.org>
In-Reply-To: <20230329-topic-adreno_opp-v1-2-24d34ac6f007@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Mar 2023 00:29:29 +0300
Message-ID: <CAA8EJprbBHTco078ix5=4OrxFm9cLVi0AbhCRVfr=-O2S0V2CQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: msm8996: Pass VDDMX to gpu in power-domains
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Since power-domains is used for perf_level pm_genpd scaling, it's only
> fitting that we pass a power domain that's actually supposed to be
> scaled (and not only turned on/off) to the GPU. While we don't quite
> support CPR3 yet, the next best thing we can do is pass VDDMX, so that
> we're at least guaranteed a reasonable vote on the memory side of
> things. Do so and leave a note mentioning CPR3 PD should be used here
> instead when support is added.
>
> Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
> Fixes: 3f65d51e9e22 ("arm64: dts: qcom: msm8996: Make GPU node control GPU_GX GDSC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 4661a556772e..4dd37f72e018 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1228,7 +1228,8 @@ gpu: gpu@b00000 {
>                         interconnects = <&bimc MASTER_GRAPHICS_3D &bimc SLAVE_EBI_CH0>;
>                         interconnect-names = "gfx-mem";
>
> -                       power-domains = <&mmcc GPU_GX_GDSC>;
> +                       /* TODO: also scale VDDGFX with CPR3 */
> +                       power-domains = <&rpmpd MSM8996_VDDMX>;
>                         iommus = <&adreno_smmu 0>;
>
>                         nvmem-cells = <&speedbin_efuse>;
> @@ -2254,7 +2255,13 @@ adreno_smmu: iommu@b40000 {
>                                  <&mmcc GPU_AHB_CLK>;
>                         clock-names = "bus", "iface";
>
> -                       power-domains = <&mmcc GPU_GDSC>;
> +                       /*
> +                        * We need both GPU_GDSC and GPU_GX_GDSC to be on, but the
> +                        * power-domains entry under gpu is occupied by the scaled
> +                        * voltage domain. Since GPU_GDSC is a parent of GX_GDSC,
> +                        * we can simply pass GX here to turn them both on!
> +                        */

Ugh. You can pass GX and VDDMX to the gpu. Let me send the patch
supporting that.

> +                       power-domains = <&mmcc GPU_GX_GDSC>;
>                 };
>
>                 venus: video-codec@c00000 {
>
> --
> 2.40.0
>


-- 
With best wishes
Dmitry
