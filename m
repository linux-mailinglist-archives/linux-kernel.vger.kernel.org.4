Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19569F888
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBVQCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:02:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE433C796
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:02:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n2so7382212lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSdhRobWaqOAm27ryt5Kscp+dhvkPeaZ2BJlCY0wWLk=;
        b=EIwtevyUNGf2HYgSCrjgmy9sAl0XCWkpUV72FBpIz7ovAIl60OY539ULmVFjR+CdVu
         VqXN15tKHquQGVJOlwji2u4NO36PtYcysSFLvtR786KkfIKgRiwA58UAtSi1Oeru65Qj
         YBN1qiuB61qQFt/B4Xm9Y9/Wv0yzZvBJxL3Ef+eCKs4xKI5HRPS7eHQhPRUFitk/fFkT
         5iQehtLX5K5LI9DPDLTe2+eAQZ5FmDjiCv7iTXOrl+XVaKC363rCBY3duN6LAs+XNeaO
         mRR9M2Ku30K5DQ7Z8dayupQnAoKo5jEzmVgcRCW5FLIVOkARbdGn3UFAg6fMa4wtDAX1
         jZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSdhRobWaqOAm27ryt5Kscp+dhvkPeaZ2BJlCY0wWLk=;
        b=A4fTOG+7GM25CYi4YvoGPfI5QmfsiphaLvChX3r6fApRWWrbaOJ+f8/Vx2Gp7s0PZw
         euvSewvH8jDfth62m9fV35mDcWEZbzLME2Zq29Eq+2tckVK3kz8E25b3A3SAnuQs/a5z
         WUFj2ROpHgqd8u/iVhsGKxcW3If98/0VZqO+OsJAyl3x4WcHXM7wBBcY3X/MOLOtUIY+
         8PHM3Gs+1u7Ow4IF6C+qT86y1MHmj8VAXC8YdLmAZ56hH/PSYWYLkRGeA1Aau4I49EdP
         3kukQDhRuQJ+7fvouVx6PQaEV4yn5Q3YbOSc7NdQBNyS1xhKTd0J1IJNjaE/YOhXtcVV
         nfqQ==
X-Gm-Message-State: AO0yUKVMvsE6+i6rz44sQpiAeNf9pLMtIFjPOFbAaVbwEnXpXl2FzSzq
        m3By0Q/Huht6XqJbndllaI2GjA==
X-Google-Smtp-Source: AK7set/Orkhmd+KdiXYqhDJGz7PxjwRoB51xjhB//Z3PfG1F7TVTGggVpicE/PDpLt+nQ9kBoIGPCA==
X-Received: by 2002:ac2:5985:0:b0:4d6:df2e:16f6 with SMTP id w5-20020ac25985000000b004d6df2e16f6mr2229559lfn.36.1677081731007;
        Wed, 22 Feb 2023 08:02:11 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b004dc4b0a0543sm205223lfl.58.2023.02.22.08.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:02:10 -0800 (PST)
Message-ID: <4e61522d-075d-c77d-b1f6-c9f4c25e1cf2@linaro.org>
Date:   Wed, 22 Feb 2023 17:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/11] ARM: dts: qcom: sdx55: Fix the unit address of PCIe
 EP node
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-6-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222153251.254492-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 16:32, Manivannan Sadhasivam wrote:
> Unit address of PCIe EP node should be 0x1c00000 as it has to match the
> first address specified in the reg property.
> 
> This also requires sorting the node in the ascending order.
> 
> Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
Unsure, we aren't fixing the bindings..


> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
For the dt change:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 78 +++++++++++++++----------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index 93d71aff3fab..e84ca795cae6 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -303,6 +303,45 @@ qpic_nand: nand-controller@1b30000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep: pcie-ep@1c00000 {
> +			compatible = "qcom,sdx55-pcie-ep";
> +			reg = <0x01c00000 0x3000>,
> +			      <0x40000000 0xf1d>,
> +			      <0x40000f20 0xc8>,
> +			      <0x40001000 0x1000>,
> +			      <0x40200000 0x100000>,
> +			      <0x01c03000 0x3000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> +				    "mmio";
> +
> +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
> +			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> +				      "slave_q2a", "sleep", "ref";
> +
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global", "doorbell";
> +			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "core";
> +			power-domains = <&gcc PCIE_GDSC>;
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +			max-link-speed = <3>;
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie0_phy: phy@1c07000 {
>  			compatible = "qcom,sdx55-qmp-pcie-phy";
>  			reg = <0x01c07000 0x1c4>;
> @@ -400,45 +439,6 @@ sdhc_1: mmc@8804000 {
>  			status = "disabled";
>  		};
>  
> -		pcie_ep: pcie-ep@40000000 {
> -			compatible = "qcom,sdx55-pcie-ep";
> -			reg = <0x01c00000 0x3000>,
> -			      <0x40000000 0xf1d>,
> -			      <0x40000f20 0xc8>,
> -			      <0x40001000 0x1000>,
> -			      <0x40200000 0x100000>,
> -			      <0x01c03000 0x3000>;
> -			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> -				    "mmio";
> -
> -			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> -
> -			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> -				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> -				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> -				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> -				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> -				 <&gcc GCC_PCIE_SLEEP_CLK>,
> -				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
> -			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> -				      "slave_q2a", "sleep", "ref";
> -
> -			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "global", "doorbell";
> -			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> -			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> -			resets = <&gcc GCC_PCIE_BCR>;
> -			reset-names = "core";
> -			power-domains = <&gcc PCIE_GDSC>;
> -			phys = <&pcie0_lane>;
> -			phy-names = "pciephy";
> -			max-link-speed = <3>;
> -			num-lanes = <2>;
> -
> -			status = "disabled";
> -		};
> -
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sdx55-mpss-pas";
>  			reg = <0x04080000 0x4040>;
