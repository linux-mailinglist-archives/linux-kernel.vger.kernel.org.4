Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466946AB88F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCFIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCFIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:41:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66941F5E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:41:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g3so35282720eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0hvCUS2RnuyKyKcSKPMu82+TR7YTLGF+96x9KM1C2g=;
        b=Oieuslgh80ioeucxJfkCVgFiWEZcE+/HZugeV+So9Pw3NECRxw+KIbOz21P6uRN0V1
         YZCeQ1XSZv+RiZZODXnqhLVqe0ikVw6rMd2jwtcyhWHh1qtNCxyw3mkl5Wy5iio2AFBk
         zV0ykIyoqUbqhdTeY9NuKt+43NepdSxh6zC7RBowcgZBkO3Y8ZI8KieksO/KKmdj40Iy
         wBQIxSXwGtZLOpL6MM+t5X1UIFBtFFO/La/tmS3BeBq0xi6DBv0/EmVJrXmWY8CmTjcw
         Ak7qGYDl+vq838sDk9+H+BYKKNbqeHquYgmygTXNA6x3ehGWy4OuyrtjSXURSV68Dxt1
         z5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0hvCUS2RnuyKyKcSKPMu82+TR7YTLGF+96x9KM1C2g=;
        b=LrKjFDRN4dkM+izOSue4lRVb5YHrQqiMmCF1iFEDWDdDNdGpZ3hLtpyecKocdKSXA/
         QaVnMqYxMsfXyH00o4qDW5RtAxmRRlubZRsAdOnuqBhj7ztGlvAhi6m0RUtYYyG7mNGz
         KPSvk5ie2wlrt8dkPK69zrpd3zOAW3iHLCSCRi48EJrEufKPSRPnB3pmNXQUsTqRdzMx
         3VI4QtFz2DDOLmQMmTsY5rxiRVpEu4d/ZWijKgcWLfO6Y8qMcC1+txLJN3v4lAQxrhSM
         Z6RjxYs9OwEN+scT5JuQVzMJwcPuNEXFFshstEecLG9gcP41DAQa5Wrbs6Mj17uCOVGa
         EQ9w==
X-Gm-Message-State: AO0yUKX/FaSaNkbUx9nWwv1qyRQrDjv1rPqL9HoNrBV8lKRRyjTZtHAV
        6Hq70JJfml1yYwhLH+tmo7e1gg==
X-Google-Smtp-Source: AK7set+yE7GU1CBgum6GZtjjr6iJIj0W3qxiDFILIz/saxdFocyofEegQHo8SY3j/QZJyEDTv34Y4g==
X-Received: by 2002:aa7:c14e:0:b0:4ac:d2cd:81c7 with SMTP id r14-20020aa7c14e000000b004acd2cd81c7mr9999053edp.5.1678092073290;
        Mon, 06 Mar 2023 00:41:13 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004be64b284b2sm4768770edh.3.2023.03.06.00.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:41:12 -0800 (PST)
Message-ID: <302654ee-3ecb-2274-af1a-9b58f7d0f49d@linaro.org>
Date:   Mon, 6 Mar 2023 10:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Content-Language: en-GB
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1678080302-29691-4-git-send-email-quic_rohiagar@quicinc.com>
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

On 06/03/2023 07:24, Rohit Agarwal wrote:
> Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
> used by the PCIe EP controller.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>   arch/arm/boot/dts/qcom-sdx65.dtsi | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index b073e0c..246290d 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -292,6 +292,38 @@
>   			status = "disabled";
>   		};
>   
> +		pcie0_phy: phy@1c07000 {
> +			compatible = "qcom,sdx65-qmp-pcie-phy";
> +			reg = <0x01c07000 0x1e4>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_PHY_BCR>;
> +			reset-names = "phy";
> +			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> +			assigned-clock-rates = <100000000>;
> +			status = "disabled";
> +
> +			pcie0_lane: lanes@1c06000 {

Please use new style bindings found in qcom,sc8280xp-qmp-pcie-phy.yaml

> +				reg = <0x01c06000 0xf0>, /* tx0 */
> +				      <0x01c06200 0x2f0>, /* rx0 */
> +				      <0x01c07200 0x1e8>, /* pcs */
> +				      <0x01c06800 0xf0>, /* tx1 */
> +				      <0x01c06a00 0x2f0>, /* rx1 */
> +				      <0x01c07400 0xc00>; /* pcs_misc */
> +				clocks = <&gcc GCC_PCIE_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_pipe_clk";
> +			};
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x01f40000 0x40000>;

-- 
With best wishes
Dmitry

