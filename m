Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA205F1A9D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJAHbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJAHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:31:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA5F162A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:31:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-356abb37122so30806567b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0/eJ7QJkXI7y12UmqcvdF6FlJTCqXn+IS4AWsPp/waI=;
        b=kH06CULsYz2RlWbPTqXqIOCM1NrkJU/6zqM0znGrAOdrJKya9v5fDD9EwVtINgUl47
         T12WoOX2Y3h4qZyeXf5cyvqxaMyXy5guBf4QPHr8qtatULu/Pq+chyGxJn8s2NMxQRIs
         fayK4Yqb7ptANPp0UxcZjotaKFsgllpp62s6dHsoNkPdaInqeDAS6IbSCiAYg6naQuxl
         pnZLiUyzS5hB6FFRTEY1xnziDLSLBaJSWvrqJ+IoFu30W516ZgoojsgyGD0jBjqskF5r
         Ld2vaI0QbEAjtJ96c/sIiTliCXfwYNhzJLZeStjPIYBuGPHqmJdQzAzrWtGV5K2B8d8p
         jyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0/eJ7QJkXI7y12UmqcvdF6FlJTCqXn+IS4AWsPp/waI=;
        b=tmIkf69XSthrDilfG6JafC4wQu1VtVCPBR//GyZy8GMMdN1bl/uHITDffSsYvnfCOo
         pV50eTVGdufJefwijUt2IMZ3JF/vysRwzmq/gFH5icV299hd2XHpTIyYciIEEnTGwWUB
         wp0wouIty5LNpgCxfJo5vmw+wTgzt1OuUOTYC1naX7UKSD3yiMFuovBQhPIi+0KQNIjH
         y/ap4kdWkTmZb3ZPV3LVjOfv0Bp7WKwcZHdtMM3CK7TZ2j57NiSo6fxKUEwYRlH0ZTHu
         nVPBVSLjPlLykGoxB15bhWmzcwGeP1K773oOu45JPcagnEJq2qwPZeXnRk0PaPXxak/v
         QFFw==
X-Gm-Message-State: ACrzQf2KeHe4b3UvU7k95+FRQLmLwiJjze8m3wiaOLfTDuuPq1Jjff/h
        GBioGGRO6jY/mxIW5ndYf25DiQ4in3cHBcCpR5JY+w==
X-Google-Smtp-Source: AMsMyM6dPJE4iEVzV4DLkohN4DVvcHhtO/P7dyLkEetjj9OWKnctEKoW7oq6zImTHNRfUdifnOrTPFhcaCWvEcbJk/I=
X-Received: by 2002:a81:1e0d:0:b0:33b:fb67:9895 with SMTP id
 e13-20020a811e0d000000b0033bfb679895mr11490186ywe.188.1664609459329; Sat, 01
 Oct 2022 00:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030656.29365-1-quic_molvera@quicinc.com> <20221001030656.29365-18-quic_molvera@quicinc.com>
In-Reply-To: <20221001030656.29365-18-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:30:48 +0300
Message-ID: <CAA8EJprRmmwQ2+b6zgfqLWYuL-2dv2JK-iNGG8xdWUEb1xh2Aw@mail.gmail.com>
Subject: Re: [PATCH 17/19] arm64: dts: qcom: qdru1000: Add I2C nodes for QUP
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:09, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add I2C nodes to the QUP along with pinconf for these nodes.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 365 +++++++++++++++++++++++++
>  1 file changed, 365 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> index c105bc15995b..40d7cc4c1f3d 100644
> --- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> @@ -302,6 +302,132 @@ uart7: serial@99c000 {
>                                 #size-cells = <0>;
>                                 status = "disabled";
>                         };
> +
> +                       i2c1: i2c@984000 {

Sort according to the address.

> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0x0 0x984000 0x0 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +                               interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnect-names = "qup-core", "qup-config", "qup-memory";
> +                               interconnects =
> +                               <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +                               <&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
> +                               <&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c1_data_clk>;
> +                               dmas = <&gpi_dma0 0 1 3 64 0>,
> +                                       <&gpi_dma0 1 1 3 64 0>;
> +                               dma-names = "tx", "rx";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               status = "disabled";
> +                       };
> +

> @@ -381,6 +654,98 @@ rx {
>                                         bias-disable;
>                                 };
>                         };
> +
> +                       qup_i2c1_data_clk: qup-i2c1-data-clk {
> +                               pins = "gpio10", "gpio11";
> +                               function = "qup0_se1_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;

No 'drive-strength' and 'bias-pull-up' here please.

> +                       };
> +
> +                       qup_i2c2_data_clk: qup-i2c2-data-clk {
> +                               pins = "gpio12", "gpio13";
> +                               function = "qup0_se2_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c3_data_clk: qup-i2c3-data-clk {
> +                               pins = "gpio14", "gpio15";
> +                               function = "qup0_se3_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c4_data_clk: qup-i2c4-data-clk {
> +                               pins = "gpio16", "gpio17";
> +                               function = "qup0_se4_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c5_data_clk: qup-i2c5-data-clk {
> +                               pins = "gpio130", "gpio131";
> +                               function = "qup0_se5_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c6_data_clk: qup-i2c6-data-clk {
> +                               pins = "gpio132", "gpio133";
> +                               function = "qup0_se6_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c9_data_clk: qup-i2c9-data-clk {
> +                               pins = "gpio22", "gpio23";
> +                               function = "qup1_se1_l0";
> +                               drive-strength = <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       qup_i2c10_data_clk: qup-i2c10-data-clk {
> +                               pins = "gpio24", "gpio25";
> +                               function = "qup1_se2_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
> +                       qup_i2c11_data_clk: qup-i2c11-data-clk {
> +                               pins = "gpio26", "gpio27";
> +                               function = "qup1_se3_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
> +                       qup_i2c12_data_clk: qup-i2c12-data-clk {
> +                               pins = "gpio28", "gpio29";
> +                               function = "qup1_se4_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
> +                       qup_i2c13_data_clk: qup-i2c13-data-clk {
> +                               pins = "gpio30", "gpio31";
> +                               function = "qup1_se5_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
> +                       qup_i2c14_data_clk: qup-i2c14-data-clk {
> +                               pins = "gpio34", "gpio35";
> +                               function = "qup1_se6_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
> +                       qup_i2c15_data_clk: qup-i2c15-data-clk {
> +                               pins = "gpio40", "gpio41";
> +                               function = "qup1_se7_l0";
> +                               drive-strength = <2>;
> +                               bias-pulll-up;
> +                       };
> +
>                 };
>
>                 pdc: interrupt-controller@b220000 {
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
