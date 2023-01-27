Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02F67E446
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjA0L4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjA0LzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:55:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E33AB2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:52:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so4757187wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUxkjbPI2hGs2bTAnhOWhZx0Y3u570fRt/MEL0+XvDc=;
        b=nPrIxS6CM21G3+sUYx9go7df0QKfN3/Dtsq+WpA/kOh5cKqckydPi/hrYpQrqkUKAZ
         QIgTraYG/K8jnwZsSQq8ymhiarXYxgGcNmaXEJBiuZUy1gEgkcb0aRm8TbSfLwCGOz8Z
         IyoTBq5NwNaOPQdwoVrKMQAOHmUdK/7LjNJmKRHYMLnTlqvY+slLeTtIXtOu/GWf766p
         Taxs8meQgkIFyjj22jSYK0We4LS0nKuMo01qrQ2CR2DCa6d7qGQ2OmG4ax8pb+3vpTRK
         mfQe5Tewu6PrfbGmvyFSLdx480x+SOLB8FTvch5JebZVHMbGryve27Q325tOj62McMmS
         3QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUxkjbPI2hGs2bTAnhOWhZx0Y3u570fRt/MEL0+XvDc=;
        b=sbBHjMZ66SI8xG+sgVwbpHUQbIeSCAgGrVNOrRX22JIBxhZDcNR0SlKA4PrPyiqvKZ
         x6nG2hdpTRshFgiWQQFMdCOGbwtEDOkTKu6Dds9GGHZIfouheFY8E3XQT1DxSR2IHqOk
         E5nqwlqELCXRFd/eJd4wihlz9SJWuofZDfOWZ5z3/5RuGsRxp8mdwlzoqdPIpRi3BqOz
         Hd2hm5j7SKA1MbTd1a0huVlPJtk63DTatnhgCJMXnsnTQS+2NJdFZzxNhlTjvOETk5nI
         xH5GtEF94NRHibbeRdn0BSs68gHvPHYL2Ww4aXiYDvaYY58oqOZ/UqL4hUwTZ0XoXLsO
         Pq9g==
X-Gm-Message-State: AFqh2kpTbJUEXBZ+JeWwrzyk60Ot5Ru+rQy+Xra867tTNHztNvRVMBgs
        q6fGuWC/wLf8rYTthEF+adJG1Q==
X-Google-Smtp-Source: AMrXdXu/ppR95kNTQmFZaEgCcnWnz2FywoDoW01+9eBW7RnHLZ/01Gr9HpcBmhdtrkOjZiIM+x1cyw==
X-Received: by 2002:adf:e18c:0:b0:2be:493f:3b34 with SMTP id az12-20020adfe18c000000b002be493f3b34mr33144295wrb.26.1674820267487;
        Fri, 27 Jan 2023 03:51:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b002b6bcc0b64dsm3804434wrq.4.2023.01.27.03.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:51:07 -0800 (PST)
Message-ID: <2d368c6f-5240-8aec-ef27-a86b2a361856@linaro.org>
Date:   Fri, 27 Jan 2023 12:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
References: <20230126124651.1362533-1-abel.vesa@linaro.org>
 <20230126124651.1362533-8-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126124651.1362533-8-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 13:46, Abel Vesa wrote:
> Add USB host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> NOTE: This patch has been already merged. It is here only to provide
> context for the rest of the patchset. There is a change with respect to the
> clocks, but that will be sent as a separate/individual fix patch.
> 
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 92 +++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 4daf1f03d79f..6801454bbe10 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -652,7 +653,7 @@ gcc: clock-controller@100000 {
>  				 <&ufs_mem_phy 0>,
>  				 <&ufs_mem_phy 1>,
>  				 <&ufs_mem_phy 2>,
> -				 <0>;
> +				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>  		};
>  
>  		ipcc: mailbox@408000 {
> @@ -1924,6 +1925,95 @@ opp-202000000 {
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x088e3000 0x0 0x154>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_dp_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
> +			reg = <0x0 0x088e8000 0x0 0x3000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> +
> +			power-domains = <&gcc USB3_PHY_GDSC>;
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
> +			reg = <0x0 0x0a6f8800 0x0 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&rpmhcc TCSR_USB3_CLKREF_EN>;
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi",
> +				      "xo";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 14 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "hs_phy_irq",
> +					  "ss_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;

This part was merged but it is not correct without [1]. Are we going to
revive [1] or should we drop it?

[1] https://lore.kernel.org/all/YXcBK7zqny0s4gd4@ripper/

Best regards,
Krzysztof

