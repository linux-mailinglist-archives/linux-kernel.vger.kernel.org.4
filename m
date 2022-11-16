Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FE62BF74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiKPN2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiKPN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:27:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475345090
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:27:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so26525925edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7n/++2Ra6h2v7Wvi16whBljKU1AOEc4Bg+41whL+y0=;
        b=xrMYOn7BgRfD9DcteMgTTy5w/2PfGpDLky7B91NlkBrLrA3EeSMYYm1cKiRZJxsYHa
         MrD8O12oPTyiO4Pn74cMlbsKbGV13flf9ZPXlFdoqDkOiQnfkitf65lYqcvbwwNpglgQ
         DzQdrLjHXiUGZNC70Zyef2R88iqjiJWxvxieHQi6GX80OZaafT3ooo+37kLLvGU7gAyV
         1zltPvowqd7CRp2ql80vpsRjppYIBn/EVFkAjLpeqIm3tgiNt4+j/zMTterzuEiWfPa3
         Xwl1h3N3xOeZrH+xH/H5RG+x5XLHnFyiYxj/hVU7Pbao0uSDK0OXtrGX0/nEXIPCh6XX
         Kj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7n/++2Ra6h2v7Wvi16whBljKU1AOEc4Bg+41whL+y0=;
        b=EK9qeKsyUVY8glfgyqG93YQLqXrlbMtzSyjoIKaPPfteXyn6l9kzmSORDzqyM3Bj6C
         8zLheMtypbAxJGFH/aeylwoprXfCtydGIi+Xf8x7w5uICMHUfYeuimIyB0KoQLNyxb8w
         ui0rnRpM3uTIlr5hAynSH1+Vfd+OcPILwW2PWFh/+OTjFRT3RBpoRdJVsVKiYukIXfsr
         NfwMkaKOqioDBUx+wvrozj0xHdeYqs6Kq0CfUdq0/IlFUyfimfxTBTjKppknaNAZjWN0
         ZRtHGkeOMtBDKmNSd4ArqAP+I7ukMwCvprF+ck+EWlcQI09BjC0/fzj8EP7+D9G5nERd
         7JLA==
X-Gm-Message-State: ANoB5pm2mD5oTGqPECTy3eC9yt+Oe53ibJ/sZEm9dhnphkMXBm5Is6t6
        Iuz7G1XCzStMLRM9P/faYUHXOQ==
X-Google-Smtp-Source: AA0mqf4yGh0tO6kvUQv/wiTIvRzBpbV9FBnSF3tZpKE3eLzDDo78NB5H6CDy2CXNbHDq82ryd9UXdQ==
X-Received: by 2002:aa7:c90c:0:b0:461:bacd:c85d with SMTP id b12-20020aa7c90c000000b00461bacdc85dmr18476234edt.278.1668605273900;
        Wed, 16 Nov 2022 05:27:53 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906300300b0079800b8173asm6816929ejz.158.2022.11.16.05.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:27:53 -0800 (PST)
Message-ID: <d94a7dbe-fa26-686d-9051-3ed52f063dd9@linaro.org>
Date:   Wed, 16 Nov 2022 14:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add USB PHYs and controller
 nodes
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116132212.2842655-1-abel.vesa@linaro.org>
 <20221116132212.2842655-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116132212.2842655-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 14:22, Abel Vesa wrote:
> Add USB host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 99 ++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..1b62395fe101 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1460,6 +1460,105 @@ opp-202000000 {
>   			};
>   		};
>   
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x088e3000 0x0 0x154>;
> +			status = "disabled";
Status last.

> +			#phy-cells = <0>;
> +
> +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		};
> +
> +		usb_1_qmpphy: phy-wrapper@88e9000 {
> +			compatible = "qcom,sm8550-qmp-usb3-phy";
> +			reg = <0x0 0x088e9000 0x0 0x200>,
> +			      <0x0 0x088e8000 0x0 0x20>;

> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
Move these four down, please.

> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_PAD_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				<&gcc GCC_USB3_PHY_PRIM_BCR>;
Indentation seems off.

> +			reset-names = "phy", "common";
> +			power-domains = <&gcc USB3_PHY_GDSC>;
> +
> +			usb_1_ssphy: phy@88e9200 {
> +				reg = <0x0 0x088e9200 0x0 0x200>,
> +				      <0x0 0x088e9400 0x0 0x200>,
> +				      <0x0 0x088e9c00 0x0 0x400>,
> +				      <0x0 0x088e9600 0x0 0x200>,
> +				      <0x0 0x088e9800 0x0 0x200>,
> +				      <0x0 0x088e9a00 0x0 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
> +			reg = <0x0 0x0a6f8800 0x0 0x400>;

> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
Move these four down, please.

> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&tcsr TCSR_USB3_CLKREF_EN>;
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
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +			usb_1_dwc3: usb@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x0a600000 0x0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x40 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				snps,usb3_lpm_capable;
> +				phys = <&usb_1_ssphy>,
> +				       <&usb_1_hsphy>;
> +				phy-names = "usb3-phy",
> +					    "usb2-phy";
No need for newlines here and in phys =

Konrad
> +			};
> +		};
> +
>   		pdc: interrupt-controller@b220000 {
>   			compatible = "qcom,sm8550-pdc", "qcom,pdc";
>   			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
