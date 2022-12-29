Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49960658C48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiL2Lim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiL2Lih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:38:37 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3CBF65
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:38:36 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3e45d25de97so256832707b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzVijDpOmDlJ/TO0wgjRtfeBQOxC0cctQS/eEfP3SpY=;
        b=WhascANlVjl5U5gZFZPJX1JCvzaY0eFSP57cDDpyQWbsemmdB+gKOGNgG9ea0ke1Wo
         INWSY6J4eO1atBRfG7CHK0mNffIF3QX3IiegBrcTUIoNlJhGvCJpzQD8Hd9E/59NaKyR
         E6z/EKVKXOU+DwZsRme7VUyXydyN/i2j+jRHB3cIxlk6iYeIsU934d2wN9H10OBM27bq
         IwFyHbWsFtyoz7IXv+sK0MzmD9O6BQEk+zi5AoTstfJSVX5hHt8lKQkGKdwKB80MhFJM
         N84++q/77POvO4qIxhkcTodWOnIxPNRZ6EQI6I0r88YkSCDMtzVkk7gT4nv8CjQJriC4
         C8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzVijDpOmDlJ/TO0wgjRtfeBQOxC0cctQS/eEfP3SpY=;
        b=Jj3gZzvgvTAE0jRo4p+abXi3eNWxA4zeZ5+9XjmsQ0VFdpUmC4GOnTy1HiyVVzNm1A
         l74lmdsKNwmSNqN11uWsk6tqvrfYPOz12Nxj/Xp6bWaafQvnQ5/ZzgpJs5+B7OJWbUAj
         G86u3J0OltjqfbF9A4kJeIzoPfDSxoCzvGvlv67Eppv+Tcw+T34GI1GTaE86QiNjiuFM
         n+0KTvqAqKmKzOv+OFpjVyA3lH8udVxL1Qx74kiiXmFyh9gzXit+7+2bxNRvuC9GtL/I
         GYaRGVY0w42Unu312iotJzH9KWRPx5cRn6ap10IIsuucK/rJBuXcpsauL8vQBXPjtdAl
         18RA==
X-Gm-Message-State: AFqh2kpif3U1qtt2yU/8ZylZAQw8uroCKBoviItlPBkBE24dbwH8v2HE
        sX+6J/oTr3O1vLr1eT+L92fLQTD0VxLdtp8muD/jcw==
X-Google-Smtp-Source: AMrXdXv9e+eV4tISPHDx2U7r7Ck2jrKmPt6GILLj/sOAVw2uAMBZi0tErVUE4qTF18qsGZPTIq0H1EH0sOHq3nJLvRY=
X-Received: by 2002:a0d:dc86:0:b0:3d5:ecbb:2923 with SMTP id
 f128-20020a0ddc86000000b003d5ecbb2923mr3630692ywe.485.1672313915726; Thu, 29
 Dec 2022 03:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20221229100511.979972-1-konrad.dybcio@linaro.org> <20221229100511.979972-2-konrad.dybcio@linaro.org>
In-Reply-To: <20221229100511.979972-2-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Dec 2022 13:38:24 +0200
Message-ID: <CAA8EJpr2AzT9W44mR4=5QBcmQzsznvO7XROObFGiSv+T3kJznA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8150: Add DISPCC node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 at 12:05, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Years after the SoC support has been added, it's high time for it to
> get dispcc going. Add the node to ensure that.
>
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # Xperia 5
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
> v1 -> v2:
> - Pick up tags
> - Remove required-opps
> - Move power-domains up
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index a0c57fb798d3..c7935f7a2926 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3579,6 +3579,29 @@ camnoc_virt: interconnect@ac00000 {
>                         qcom,bcm-voters = <&apps_bcm_voter>;
>                 };
>
> +               dispcc: clock-controller@af00000 {
> +                       compatible = "qcom,sm8150-dispcc";
> +                       reg = <0 0x0af00000 0 0x10000>;
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>,
> +                                <0>;
> +                       clock-names = "bi_tcxo",
> +                                     "dsi0_phy_pll_out_byteclk",
> +                                     "dsi0_phy_pll_out_dsiclk",
> +                                     "dsi1_phy_pll_out_byteclk",
> +                                     "dsi1_phy_pll_out_dsiclk",
> +                                     "dp_phy_pll_link_clk",
> +                                     "dp_phy_pll_vco_div_clk";
> +                       power-domains = <&rpmhpd SM8150_MMCX>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
> +
>                 pdc: interrupt-controller@b220000 {
>                         compatible = "qcom,sm8150-pdc", "qcom,pdc";
>                         reg = <0 0x0b220000 0 0x400>;
> --
> 2.39.0
>


-- 
With best wishes
Dmitry
