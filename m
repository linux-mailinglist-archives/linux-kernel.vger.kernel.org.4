Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E06705417
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjEPQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEPQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:26 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70087134
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55d2e87048cso205840817b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255164; x=1686847164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tlt94OaDFj/ZPE0ZO+qPKHDjqmrvLyTlpCpvY+Yp/8=;
        b=KgRz9ZygaysakM45E2aeQy6Z2DT7UQhYmbkwTrDEtDRBwiRNJ35O4+ZI1T5c9yXorr
         9uprslbLq3XDu+47l1yO7bS9LHQXU4dH+96CRjuY0F335XohNM4ZrWs4/DeOuapS9vQB
         vIjR1eez9wbL35MXR5DbnGfQalTwyw0o+sIwSrsG6eNQjd3c+gi440d1awO7k3FbdgbG
         f6RaYuGklMq/Hwy+8OZNG+orcKwe4I0xi52JFAUkTx4+9NL3VpQ4eav1ODh2Ez1/3bMR
         KewsK9il5iiBYgMvOU75io3a0tHC9NLNe1bCIaY7e40wzIh3hnaXDg8KMLYmdCpEiPPF
         v3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255164; x=1686847164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tlt94OaDFj/ZPE0ZO+qPKHDjqmrvLyTlpCpvY+Yp/8=;
        b=U9jLoWsfVnf5Mga9QBKVTCLuZAneJ86veV/G9sx1v4v8Dsi6WJzMURwjLbw9lPTG6F
         8dWXnIZuojJZnbKLEqWM0P9MSDC4YbgKb4ibODZX9JOFqUZo9O5e3QAeuqzlVu95Osf9
         Q8HfzxPCd8xoo8sYiFJ3wASBbRgbKztMOgnSa+AJpxJ8Oppxx7YVfEPioJr+kanBL7Wi
         D9mjZHUqe+pLO63vzQUfEymNnQOiYao4Td9kYswIZvM+KTERl+hRxYNyZPBBdcExTIAx
         t4qRbcFHjeU894ICh37kBmoi234rgNZ3fZaM/4SLdkUwiEfNm+2QxSZRkQpqw/4ejaZ7
         Ug+Q==
X-Gm-Message-State: AC+VfDz/NZnla7eC9l3a8/mUONgkOJ/6R0q8XSPsHZP2kPr1nA4YhX3p
        0G2Pld3gwKivYb/CVhW+H3JoC6sUlDrSLZQpdfyDHA==
X-Google-Smtp-Source: ACHHUZ4mmJtwKkLjDQeoqGQG6jQ/Y1c9GvB1EOKt0pluOwZJgkSgm/apT/cIYLDsmH+PXxZbg6tthKN+REeqPnno1Qc=
X-Received: by 2002:a81:48c6:0:b0:55a:3ce9:dc3d with SMTP id
 v189-20020a8148c6000000b0055a3ce9dc3dmr35407967ywa.13.1684255164629; Tue, 16
 May 2023 09:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 19:39:13 +0300
Message-ID: <CAA8EJpoTgseo3j_5Ab7cQs3ZZZymALpRqpuWGPyKpTEbXR-Cqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 16:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
> thus skip pcie_1_phy_aux_clk input clock to GCC.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index ccc58e6b45bd..e7a2bc5d788b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -385,6 +385,38 @@ vreg_l3g_1p2: ldo3 {
>         };
>  };
>
> +&gcc {
> +       clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> +                <&pcie0_phy>,
> +                <&pcie1_phy>,
> +                <0>,
> +                <&ufs_mem_phy 0>,
> +                <&ufs_mem_phy 1>,
> +                <&ufs_mem_phy 2>,
> +                <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> +};

Is there any reason to disable the PCIe1 PHY AUX clock here? I mean,
the PCIe1 is still enabled in the hardware.

> +
> +&pcie_1_phy_aux_clk {
> +       status = "disabled";
> +};
> +
> +&pcie0 {
> +       wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +       perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +
> +       pinctrl-0 = <&pcie0_default_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&pcie0_phy {
> +       vdda-phy-supply = <&vreg_l1e_0p88>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
