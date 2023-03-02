Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885C6A863E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCBQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCBQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:22:58 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E591729C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:22:56 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c2a1cc07so436868377b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCApAgcIZfANpiFmByH1aTwW6u2oVMPpnwz61BwzJjc=;
        b=f/DOK7UHxMH/ekwT+WKzGB4okPXD9Ae2eK8cRsjT7HLMIMU3Dw/u0ru69aP9b7mmSD
         yF6MWaJkIMMspZj8iwqr+b+P9zT1BKPjr0wrtbyIjX3Sqa7j0K59t9FGWHA9tCeh1vK0
         34o5eEvK9eYix65ZWa0sKsFSNdhjG3PAYkxphHQTHozGMciBn7aR/t/WoYD0cOpn0k+o
         xaOYmafuNtPZ7TRidRqlzeKP4r19AvdOyN5iDEsc8pEmWgJYYoT/fGzNyX2bFZ8xXDFq
         BwL1oL88Q/dC2WhTMtru5I4Kj9/HDLhZb0VWQKq5zMIlDEwqDGbLQvZmlkCAX+tuAvS9
         BDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCApAgcIZfANpiFmByH1aTwW6u2oVMPpnwz61BwzJjc=;
        b=n18GBWPQqyee1q3xzg4ky39b5dH6Xg3CxY960mNY2LG6h0vX5e96Duj7lR24aYh6x2
         XLk14t0UNH3UyV49mxFZUjGJ3zMLuE6xPcrseVxRSUj6P9ADy4z06CJXUHYqWQrayYMQ
         oy+RfI6jM/AM5drpq+R5M79qujWsZztRQymipWajrslNVYnxUJ3vpqinHxGsXeUNi3xd
         rlR3yx0WnBi+eOnrjFY3Hcy/bMk4mj2XVPN3dZXuvnHajxGvm2oswxa12oS0vfk2WS5q
         hE6h4uvwIJ9rOWtIMFbZyOPfYOv6B7q7V6nKVeK2SPO0REICiwLEM/9xG6zWr3L1oS8E
         UZrA==
X-Gm-Message-State: AO0yUKVfSAW5EY16btJhdYPGY6z2jsDCQlUAeDKO1wb5dNhWAOcMQMOk
        9Z7tF5MQFCezB8bJDiZYxRCNX0rvhCMkM0L2iqJlDg==
X-Google-Smtp-Source: AK7set/StpHra4/3NZPyZ26Xud3sSUsWFOI2GHWbIQiPOsqSsjWXwk2ABk8nbm22rIkDkynZ64iCKeAx4b98a1W3nOA=
X-Received: by 2002:a81:ac25:0:b0:52f:2695:5d05 with SMTP id
 k37-20020a81ac25000000b0052f26955d05mr6682356ywh.3.1677774175123; Thu, 02 Mar
 2023 08:22:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677749625.git.quic_varada@quicinc.com> <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
In-Reply-To: <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 18:22:44 +0200
Message-ID: <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Add USB phy and controller related nodes
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 +++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 2bb4053..319b5bd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -215,6 +215,98 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               ssphy_0: ssphy@7D000 {
> +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> +                       reg = <0x7D000 0x1C4>;
> +                       #clock-cells = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +                       clock-names = "aux", "cfg_ahb";
> +
> +                       resets =  <&gcc GCC_USB0_PHY_BCR>,
> +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +                       reset-names = "phy","common";
> +                       status = "disabled";
> +
> +                       usb0_ssphy: lane@7D200 {

Please use newer style device bindings for new PHYs.

> +                               reg = <0x0007D200 0x130>,       /* Tx */
> +                                     <0x0007D400 0x200>,       /* Rx */
> +                                     <0x0007D800 0x1F8>,       /* PCS  */
> +                                     <0x0007D600 0x044>;       /* PCS misc */
> +                               #phy-cells = <0>;
> +                               clocks = <&gcc GCC_USB0_PIPE_CLK>;
> +                               clock-names = "pipe0";
> +                               clock-output-names = "gcc_usb0_pipe_clk_src";

No, this clock doesn't originate from gcc, so the gcc prefix is incorrect.

> +                       };
> +               };
> +
> +               qusb_phy_0: qusb@7B000 {
> +                       compatible = "qcom,ipq9574-qusb2-phy";
> +                       reg = <0x07B000 0x180>;
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
> +               usb3: usb3@8A00000 {

You know the drill. This node is in the wrong place.

> +                       compatible = "qcom,dwc3";
> +                       reg = <0x8AF8800 0x400>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
> +                               <&gcc GCC_ANOC_USB_AXI_CLK>,
> +                               <&gcc GCC_USB0_MASTER_CLK>,
> +                               <&gcc GCC_USB0_SLEEP_CLK>,
> +                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +
> +                       clock-names = "sys_noc_axi",
> +                               "anoc_axi",
> +                               "master",
> +                               "sleep",
> +                               "mock_utmi";

Please fix the indentation of the lists.

> +
> +                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
> +                                         <&gcc GCC_ANOC_USB_AXI_CLK>,

Why do you assign clock rates to the NOC clocks? Should they be set
using the interconnect instead?

> +                                         <&gcc GCC_USB0_MASTER_CLK>,
> +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +                       assigned-clock-rates = <200000000>,
> +                                              <200000000>,
> +                                              <200000000>,
> +                                              <24000000>;
> +
> +                       resets = <&gcc GCC_USB_BCR>;
> +                       status = "disabled";
> +
> +                       dwc_0: dwc3@8A00000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x8A00000 0xcd00>;
> +                               clock-names = "ref";
> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;

clocks before clock-names

> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
> +                               phy-names = "usb2-phy", "usb3-phy";
> +                               tx-fifo-resize;
> +                               snps,dis_ep_cache_eviction;
> +                               snps,is-utmi-l1-suspend;
> +                               snps,hird-threshold = /bits/ 8 <0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_u3_susphy_quirk;
> +                               snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
> +                               dr_mode = "host";
> +                       };
> +               };
> +
>                 pcie0_phy: phy@84000 {
>                         compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>                         reg = <0x00084000 0x1bc>; /* Serdes PLL */
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
