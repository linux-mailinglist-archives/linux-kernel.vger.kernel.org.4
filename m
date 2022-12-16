Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510A64EA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiLPLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiLPLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:24:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A275EBCBF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:24:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so3003387lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oadVGd57HGb0baAnuWVTlFJ21yCLcJ3hvQQLSSBFlZY=;
        b=qFOIeVgvZhAug6UXK4OCScMRG19Sv03IHtsTXlrkH9oya91BU8zFEimG+l+ALLg5Tr
         h/yui/y4AxOmwQ+MQty3BLwmTRbVdnNR/Af1EE6wuIUZr9iFF7iah3cG3B80ORIUWSaZ
         vsiKu9e/PjgPrvCSn5dxUDZ5UH4lSs5JsM3zn1D7sQXQvVw9lDSjZW6KeJl9Yhw7S+nO
         SePttbzbsZGxL4QLvq+enj28Qtt1EVrm2jX+CYYPyvNT97fn5qdzh7xHc6F4d8mzhgul
         0YVweBTt2tT+XANvS0FU0rI2/KA0ySmDKkg2NErjMM+BiKQVirpA1hwzRFd2sX38pnD7
         UdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oadVGd57HGb0baAnuWVTlFJ21yCLcJ3hvQQLSSBFlZY=;
        b=PUWiCpEdtQR4D8hj5tcV8fg4ldU2zFKiJChAJCi9m2MIwHkTnPwhGenTKbnOkFEFZf
         iPoYDo9ONOYFVORZodLqeb+xFdI4PvNVbrEWZsvxn6L7OADA7zQarjL3y9lH2kKU+KRe
         gr2NQ2vC3HxPQ6dXbjrhEU/0KO/cbfj9ty8ZnqiOPq1SR/ftvMHtaw1maCv9uRZOc1Qu
         QJML7K/DN0nqs1pEqa3aj1uOUazWSpGr51Avl4yYJxXgFRFhN+bGy24eKHbtMH7j58zA
         e0kDpiBp4/xgMtn0plWwGFWBa1yYE4/cefGzeBkaLkynPV+RbIRqG72LAGZHJxbOQfXm
         3Aww==
X-Gm-Message-State: ANoB5pkyERlH4zZjpFLkwMtJMNMJPO9Sl1ClMDXQ3ck4qR/neJ1vIFmT
        xZ26OkUkLIiMHEqxkyI78dbj6g==
X-Google-Smtp-Source: AA0mqf7mP4Hf8z9YCDFV5CozdEkrHHPmhzrkwVqhfJ8cAVEQ0Zlv7Qbv+/z9hKDXL46ARbPNxmg1Bw==
X-Received: by 2002:ac2:4a9d:0:b0:4b5:7338:e2c7 with SMTP id l29-20020ac24a9d000000b004b57338e2c7mr4630070lfp.53.1671189877995;
        Fri, 16 Dec 2022 03:24:37 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c14-20020a05651200ce00b004a4754c5db5sm193654lfp.244.2022.12.16.03.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:24:37 -0800 (PST)
Message-ID: <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
Date:   Fri, 16 Dec 2022 12:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215190404.398788-2-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
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



On 15.12.2022 20:04, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
Please include a changelog, I don't know what you changed and
what you didn't. Also, you sent 4 revisions in one day, not
letting others review it.


>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7e25a4f85594..b64c5bc1452f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		ufs_mem_hc: ufs@4804000 {
> +			compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
> +			reg-names = "std", "ice";
> +			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <1>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "ice_core_clk";
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +			freq-table-hz = <50000000 240000000>,
> +					<0 0>,
> +					<0 0>,
> +					<37500000 150000000>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>,
> +					<75000000 300000000>;
> +
> +			non-removable;
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@4807000 {
> +			compatible = "qcom,sm6115-qmp-ufs-phy";
Krzysztof asked you to add a SoC-specific compatible in v1.


> +			reg = <0x04807000 0x1c4>;
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			clock-names = "ref", "ref_aux";
> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			ufs_mem_phy_lanes: lanes@4807400 {
> +				reg = <0x4807400 0x098>,
> +				      <0x4807600 0x130>,
> +				      <0x4807c00 0x16c>;
> +				#phy-cells = <0>;
> +			};
I believe this is deprecated. See [1].


Konrad

[1] https://lore.kernel.org/linux-arm-msm/20221104092045.17410-1-johan+linaro@kernel.org/T/#m988f3fe3d83b76bac247aea2d9dac34f37728d65

> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
