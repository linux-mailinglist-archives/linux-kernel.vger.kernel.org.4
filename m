Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BC6D86FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjDETh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDEThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:37:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55467685
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:36:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id cf7so43911532ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680723397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNfBESDvbtGTqqyDrKwG3G3l2rlJ3YiUHnXOmDoRd5Y=;
        b=YTl6WeOM+1agoNV7su6DdsFpGJLBPCXDw7mc4qSxDGiZpdCyoFhkxMrKSC8Gxf0sfl
         8g8/xPi5LCBxDzlYwELs6sOqQhUi7qoVPtBvpRg0fTVciYX6ER9Wqwv7mhB12UlvY9ky
         tqfGMmJRksWxSr4uHwjqXHdHdpj0adpoShqUKQOZ0t7Qhw39Ihgft9llYeZBK+9/VrFz
         FcF+IwjidcWzYE62DmBEcfmeDq7iAquYUehh8L4DWlmqW7uFdOszG+oC09dUEwg5OIw5
         D4TYh+P8xb+Bdop+kslUsugH4hQ8vdTBdur2Q6pY63bu5oF73ABgSOKfzvlVN+mS1ksp
         olAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680723397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNfBESDvbtGTqqyDrKwG3G3l2rlJ3YiUHnXOmDoRd5Y=;
        b=Ygqupd2zv2HmQ9VexI4YwXmMqYU5l4SrZRrpEdBh8yyG1sQvesXdxWecyON3tL6tGU
         cjUyvviXJXdCxejhs4dcfjzgWimqBituwWMZDIoEYoOVkv9qqiav36pAAU1y7TE5HctD
         xSTf9lAgQKm+xs4HaZfrSdjH0EpTS9qaXznnJxM6zJCxLIPehfS9oWBzdMRrGKG29EzX
         M+r8VmOUfGykpN8XUNgHcI/N/wRnvLBX+LB3S1YFxq/xRGXjeDak+wQgW6wjZttw714W
         r9TrUqi5kZJ/lTn80iRiSJ3zzXXO6HxHwRXN2DuImcKinazuKvABJk87uFyxMTmefvnz
         sQqw==
X-Gm-Message-State: AAQBX9ex2TOjTNDPvhOD6d2vnCuB6jVl2nLebskMFdr6xywe4DGh2M1g
        yD2IihN/nfe9FSZI+AcjrnsKCJvSFte+k/n589ZvwA==
X-Google-Smtp-Source: AKy350bnPK17WqG71f/LMZeJqEhERzh25R/NeKn5oJ+9/EGEJVl3xV2GhLU8s3FRBfEw9JVjt8Xyc8479sx8AvYA7tg=
X-Received: by 2002:a25:d448:0:b0:b4c:9333:2a2 with SMTP id
 m69-20020a25d448000000b00b4c933302a2mr264956ybf.9.1680723397714; Wed, 05 Apr
 2023 12:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230405191633.1864671-1-bhupesh.sharma@linaro.org> <20230405191633.1864671-3-bhupesh.sharma@linaro.org>
In-Reply-To: <20230405191633.1864671-3-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Apr 2023 22:36:27 +0300
Message-ID: <CAA8EJppfRvc7nJ+AeUjrqfmZ8aLWPma-Ecda-tjOwezqWVueuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 22:19, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Add USB superspeed qmp phy node to dtsi.
>
> Make sure that the various board dts files (which include sm4250.dtsi file)
> continue to work as intended.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
>  .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
>  3 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a1f0622db5a0..75951fd439df 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -242,6 +242,9 @@ &usb {
>  &usb_dwc3 {
>         maximum-speed = "high-speed";
>         dr_mode = "peripheral";
> +
> +       phys = <&usb_hsphy>;
> +       phy-names = "usb2-phy";
>  };
>
>  &usb_hsphy {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 2a51c938bbcb..b2fa565e4816 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -650,6 +650,38 @@ usb_hsphy: phy@1613000 {
>                         status = "disabled";
>                 };
>
> +               usb_qmpphy: phy@1615000 {
> +                       compatible = "qcom,sm6115-qmp-usb3-phy";
> +                       reg = <0x0 0x01615000 0x0 0x200>;
> +                       clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> +                                <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +                                <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +                       clock-names = "cfg_ahb",
> +                                     "ref",
> +                                     "com_aux";
> +                       resets = <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>,
> +                                <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>;
> +                       reset-names = "phy_phy", "phy";
> +                       status = "disabled";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       usb_ssphy: phy@1615200 {
> +                               reg = <0x0 0x01615200 0x0 0x200>,
> +                                     <0x0 0x01615400 0x0 0x200>,
> +                                     <0x0 0x01615c00 0x0 0x400>,
> +                                     <0x0 0x01615600 0x0 0x200>,
> +                                     <0x0 0x01615800 0x0 0x200>,
> +                                     <0x0 0x01615a00 0x0 0x100>;
> +                               #clock-cells = <0>;
> +                               #phy-cells = <0>;
> +                               clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +                               clock-names = "pipe0";
> +                               clock-output-names = "usb3_phy_pipe_clk_src";
> +                       };
> +               };

I can repeat previous message:

Please update this to newer style bindings (see
qcom,sc8280xp-qmp-usb3-uni-phy.yaml).

We are going to switch all QMP PHYs to use a newer style of bindings.
I have started the work to convert existing usecases. As you are
adding a new DT node, please add it in a good shape from the
beginning.


> +
>                 qfprom@1b40000 {
>                         compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>                         reg = <0x0 0x01b40000 0x0 0x7000>;
> @@ -1100,8 +1132,8 @@ usb_dwc3: usb@4e00000 {
>                                 compatible = "snps,dwc3";
>                                 reg = <0x0 0x04e00000 0x0 0xcd00>;
>                                 interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -                               phys = <&usb_hsphy>;
> -                               phy-names = "usb2-phy";
> +                               phys = <&usb_hsphy>, <&usb_ssphy>;
> +                               phy-names = "usb2-phy", "usb3-phy";
>                                 iommus = <&apps_smmu 0x120 0x0>;
>                                 snps,dis_u2_susphy_quirk;
>                                 snps,dis_enblslpm_quirk;
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 10c9d338446c..d60cc024749b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -280,6 +280,9 @@ &usb {
>  &usb_dwc3 {
>         maximum-speed = "high-speed";
>         dr_mode = "peripheral";
> +
> +       phys = <&usb_hsphy>;
> +       phy-names = "usb2-phy";
>  };
>
>  &usb_hsphy {
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
