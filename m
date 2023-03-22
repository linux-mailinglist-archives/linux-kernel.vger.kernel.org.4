Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C06C4E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCVOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjCVOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:41:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46A5FA77
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:41:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b18so2219283ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwrWFBfwB9kGIHdKOm9I7XrkyLQMCrqtoZsi4Z0QdbM=;
        b=F0w5e6ZMX4ejR5QsVQiqxR3dcGhYhLoC0lZNvEZOA0Q7DL2mOy3SrO7dbV15fGayLP
         OyXmKujQ0zcDkkemYCGNsyf75hLK6LlpbxIh5GVqde2o0sjQo2lRTFwIGGSvLk/nvdTr
         lkuNFvcuE+FNrR6LuFS5EuCM4/ZRCbnvpW7opbAWoh13a9QP8sFpw36WEdUMsREEIpK1
         adCs+5hzP7cWPvxU5pwPwkG1I6W24jY2fEoKgMWEPbDVIJVbGAWAbRg3G3t/ua30bcE2
         Bp3nUoo3S5yMaczrYsbO+6tNLgweA9mdFDVwZwLvJGeb/9kGlJVSb/ZNdehyTelgUAc2
         gNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwrWFBfwB9kGIHdKOm9I7XrkyLQMCrqtoZsi4Z0QdbM=;
        b=Fz3g4fUmKbU45q5Vz5k7pH2G7BvQks8rO0uVw+hy8SGSxcQ4BdVVRw1aRC+r9Iagym
         J7/fgzjT7DZWuOe97dV9R7FHihjd60faK2e4n1pATTiN2BFHKjjFej3Bfzgqa6csTyuv
         SxojFjgg+AtHEcP85kMpr1VAf1OFENlF3wkjPwQIBGUlFOX13o+laVCW+LuKg7Q5hfNv
         hT8XGTJMT0oXie6nabq3FR9pZ0+LjYe0ANaOvWaNL0tO7TuB3a3+45mUmIWOI8pU8lbB
         ipdTkAQDYiPWHkFZq/0hDDYful2hI6VRIPAuAvvzc+BfYSpkm4HyMMhJ8KYCzJOXOGoF
         XFDQ==
X-Gm-Message-State: AAQBX9d851GiDvOU9boT7JosawhJGtQNDt2hSwVH39C3LpvElLQC5B67
        +NPRocDbDYacpnhaaoeTUX6t4LPUHCq8I8IkeaW0rg==
X-Google-Smtp-Source: AKy350brfn7Z6o8S2/0vpnavmEx1927OK55K5Jv3TrdYOcq2VC9PIKusWzICyXRr17lUOcIb7jQf8MvaL8LUkwY93es=
X-Received: by 2002:a25:7456:0:b0:b6b:79a2:8cff with SMTP id
 p83-20020a257456000000b00b6b79a28cffmr12890ybc.9.1679496072367; Wed, 22 Mar
 2023 07:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679479634.git.quic_varada@quicinc.com> <5b7213a4c402ee334ff48f2efe2b920858637ac5.1679479634.git.quic_varada@quicinc.com>
In-Reply-To: <5b7213a4c402ee334ff48f2efe2b920858637ac5.1679479634.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Mar 2023 16:41:01 +0200
Message-ID: <CAA8EJppXuaGx4VhZ9fOBUkD8fECngzJ8pubNC4bm_0M9+64ZqQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 12:46, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Add USB phy and controller related nodes
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v3:
>         - Insert the nodes at proper location
>
>  Changes in v2:
>         - Fixed issues flagged by Krzysztof
>         - Fix issues reported by make dtbs_check
>         - Remove NOC related clocks (to be added with proper
>           interconnect support)
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 86 +++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 2bb4053..0943901 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -215,6 +215,48 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               qusb_phy_0: phy@7b000 {
> +                       compatible = "qcom,ipq9574-qusb2-phy";
> +                       reg = <0x07b000 0x180>;

Please pad addresses to 8 hex digits.


> +                       #phy-cells = <0>;
> +
> +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +                               <&xo_board_clk>;
> +                       clock-names = "cfg_ahb", "ref";
> +
> +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +                       status = "disabled";
> +               };
> +
> +               ssphy_0: phy@7d000 {
> +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> +                       reg = <0x7d000 0x1c4>;
> +                       #clock-cells = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;

Could you please check the indentation here? Vertical lists should be aligned

> +                       clock-names = "aux", "cfg_ahb";

One item per line

> +
> +                       resets =  <&gcc GCC_USB0_PHY_BCR>,
> +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +                       reset-names = "phy","common";
> +                       status = "disabled";
> +
> +                       usb0_ssphy: phy@7d200 {

Newer bindings please, without subnodes.

> +                               reg = <0x0007d200 0x130>,       /* tx */
> +                                     <0x0007d400 0x200>,       /* rx */
> +                                     <0x0007d800 0x1f8>,       /* pcs  */
> +                                     <0x0007d600 0x044>;       /* pcs misc */
> +                               #phy-cells = <0>;
> +                               clocks = <&gcc GCC_USB0_PIPE_CLK>;
> +                               clock-names = "pipe0";
> +                               clock-output-names = "usb0_pipe_clk";
> +                       };
> +               };
> +
>                 pcie0_phy: phy@84000 {
>                         compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>                         reg = <0x00084000 0x1bc>; /* Serdes PLL */
> @@ -436,6 +478,50 @@
>                         status = "disabled";
>                 };
>
> +               usb3: usb3@8a00000 {
> +                       compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> +                       reg = <0x8af8800 0x400>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
> +                                <&gcc GCC_ANOC_USB_AXI_CLK>,
> +                                <&gcc GCC_USB0_MASTER_CLK>,
> +                                <&gcc GCC_USB0_SLEEP_CLK>,
> +                                <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +
> +                       clock-names = "sys_noc_axi",
> +                                     "anoc_axi",
> +                                     "master",
> +                                     "sleep",
> +                                     "mock_utmi";
> +
> +                       assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                       assigned-clock-rates = <200000000>,
> +                                              <24000000>;

Indentation?

> +
> +                       resets = <&gcc GCC_USB_BCR>;
> +                       status = "disabled";
> +
> +                       dwc_0: usb@8a00000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x8a00000 0xcd00>;
> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                               clock-names = "ref";
> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
> +                               phy-names = "usb2-phy", "usb3-phy";
> +                               tx-fifo-resize;
> +                               snps,is-utmi-l1-suspend;
> +                               snps,hird-threshold = /bits/ 8 <0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_u3_susphy_quirk;
> +                               dr_mode = "host";

Is dr_mode a property of the host or of the board?

> +                       };
> +               };
> +
>                 intc: interrupt-controller@b000000 {
>                         compatible = "qcom,msm-qgic2";
>                         reg = <0x0b000000 0x1000>,  /* GICD */
> --
> 2.7.4
>


--
With best wishes
Dmitry
