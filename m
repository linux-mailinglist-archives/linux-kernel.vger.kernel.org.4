Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE6A3DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjB0JKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjB0JJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:09:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958592ED7A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:01:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp25so7621687lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677488484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5cnbxDoA2z8MMgKZ1eEkxvfArrqRjqqI/vz4psVOcA=;
        b=Uyh+A3pH86NUhT+EuLRN5wPF5k9XyzlkOJt4YJ6YHzkOF9wN1aYBFhQJ7vRtk+Akpt
         m+ekOC0ZRxwhxNgFn6ZteNMSLCJ/WRJ0p0AAGIYxYaxnNE/2qzEZd7Vc3UnfOUTDKu3f
         N1cFtKJCV2ynXeRD7N8Th1G16q5C3lC8VNytX6u0j24TBPYPmVVoNbxejveAA60ieGu6
         mqwOfEfF8ebHdKZenWB8kU6Umg7c+oH3hsBX9EVQTW5aPZDbpUi/nZCKYJhlV+Vu1s0R
         GqMo1pEBLOf9yOmYr1x/rbl+EMplOjT0Iw62LYNhPzpHLKsUCD2CXGXTf+M4+MNwUJPX
         RLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677488484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5cnbxDoA2z8MMgKZ1eEkxvfArrqRjqqI/vz4psVOcA=;
        b=nA6Cy7pAwnoENeW0jSJWyol6+epOfEeWAsPkVIBc0cxGiG/CM1T/L3+g7sOm8v/bEN
         KiDy48HbVYxJsN/Zj/PzuaRrD+XGG1OVUoAx4Na+Vpv2fOmSkePCNCmPoODgR8h3gHwb
         JkGxy/d4iY/U7eKZm7Qbrp/mHyaThxIwNDij9vrOCo8aqlH2BAzI6kpmjc/ql37758Ow
         7dA4yHtsVYxZm5mT2nIhi3WxE8urERJ/8Xz6nMIsvnOiEyZW+U9x4sh/nHUdug4OQJjN
         cwOYDCMhyXyVAgCFNaAox/FGdwMoQCkxn/+gy4gcqU+sbPlYgWOFuKK9QnaKIJ1xPNql
         XnBA==
X-Gm-Message-State: AO0yUKV7ZcwVtlSZruw8vfEKTyqZcyTbkKkLk9JRe6lhUE5z9bV2O+JJ
        3V/P3zg2kAAFWcZtx8Ml9ZBT3aGqeARFA03D
X-Google-Smtp-Source: AK7set+uDR44/fHZYQGtb1Be/hr0MUEZ7D+9d8xERTULeFzAjJTqVdI2RwfOqTEFNKv2uNDRqSPsPg==
X-Received: by 2002:a05:6512:684:b0:4db:971:82cd with SMTP id t4-20020a056512068400b004db097182cdmr2258950lfe.17.1677487562589;
        Mon, 27 Feb 2023 00:46:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id q10-20020ac25fca000000b004dafde0e7b7sm827471lfg.279.2023.02.27.00.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:46:02 -0800 (PST)
Message-ID: <cb50e3a9-0187-5894-cb0f-de477713922b@linaro.org>
Date:   Mon, 27 Feb 2023 09:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 07/13] ARM: dts: qcom: sdx55: Add support for PCIe RC
 controller
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-8-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230224105906.16540-8-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 11:59, Manivannan Sadhasivam wrote:
> The PCIe controller in SDX55 can act as the RC controller also. Let's
> add support for it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 82 +++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index a1f4a7b0904a..b411c4ae34c3 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -303,6 +303,88 @@ qpic_nand: nand-controller@1b30000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_rc: pcie@1c00000 {
> +			compatible = "qcom,pcie-sdx55";
> +			reg = <0x01c00000 0x3000>,
> +			      <0x40000000 0xf1d>,
> +			      <0x40000f20 0xc8>,
> +			      <0x40001000 0x1000>,
> +			      <0x40100000 0x100000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x40200000 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x40300000 0x0 0x3fd00000>;
> +
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "msi8";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>;
> +			clock-names = "pipe",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			iommus = <&apps_smmu 0x0200 0x0f>;
> +			iommu-map = <0x0   &apps_smmu 0x0200 0x1>,
> +				    <0x100 &apps_smmu 0x0201 0x1>,
> +				    <0x200 &apps_smmu 0x0202 0x1>,
> +				    <0x300 &apps_smmu 0x0203 0x1>,
> +				    <0x400 &apps_smmu 0x0204 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			phys = <&pcie_lane>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
>  		pcie_ep: pcie-ep@1c00000 {
>  			compatible = "qcom,sdx55-pcie-ep";
>  			reg = <0x01c00000 0x3000>,
