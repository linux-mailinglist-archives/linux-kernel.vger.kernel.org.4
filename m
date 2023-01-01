Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608065AA6E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjAAPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjAAPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:41:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF55589
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:41:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z26so38402827lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0yD3wERlGAM8pv5eeEX31uYMLCnHOtnWRAsTfmi30Y=;
        b=qeGNsAtZHXdURWEhF+H3FgvhVvRwqMUnZlGU28ZmQ84w14j2B5l2HP09ToQwlySnQm
         3TgkyhPGPLVQiSlSlWksU668SjS5B4Yv5xRNiXB+wVa6BucShiU/inBVZcnR7BpCZLz2
         LOJYy65mOYak3gF74MXinBEG5p3L6ZvQUQW9USdYmSLY1r7LBNDpJze2XN7o6VaSSBlm
         x9tkPs52CianzXBU+0YTM3qZYnOO9C5949IdQGuW6Zma0/fxn6UVMvZMjt2zs1UzKg87
         rpc9RZHgzwovMXHmCAOk4m8TcUrztfUTijUbCLu2ZJVCvh2mUqZUbsvxPixIXINj78SG
         ADvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0yD3wERlGAM8pv5eeEX31uYMLCnHOtnWRAsTfmi30Y=;
        b=oytvBngE3BnSZptzieAi1DH8z37/00CZmYyV5fuLsb4Buxswj49X1oy8L36IDJARzZ
         Zrx8ArBd7S/os4c+mfhN/s9z5CTMiwmKxz18CSAyl+Noa+SczvQc9lHAQpthSNxMD+Po
         rexjl2yUiqoofOMO3gzOYkS5+4ULWwvCTmovwfkioHOSuzxk6dASSvnhXc2HiZ8bAZ8D
         2lqwEAZW686VUvrERnoYHw56oUifmhDS3oVac1fTWY3Dr2vnW98vdHYM3D9J7afhXySv
         KIzczC0TS39YQTT7fisbotuMJVvjJOCv6qQAlxXw/5sLEBQ8dClyUs/WlT8Fzo/UW6zo
         XReA==
X-Gm-Message-State: AFqh2ko4myMwAAVLtPvD02ZpAQ513dckEQlx9QoM3IiZbp5KGU/0dHV9
        TRgUBMmVsdw+gh7F9/8dJLBtpg==
X-Google-Smtp-Source: AMrXdXvAGX+KauCUfod5Ps7UZ3sIVH1Arp3+D4BElKB9MZZFVU7WsDG+p81ErPfcqwvfc38Hyb1Anw==
X-Received: by 2002:ac2:5494:0:b0:4b5:5bc1:16da with SMTP id t20-20020ac25494000000b004b55bc116damr10172612lfk.39.1672587705164;
        Sun, 01 Jan 2023 07:41:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b004b55b404d36sm4166310lfr.156.2023.01.01.07.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 07:41:44 -0800 (PST)
Message-ID: <3e67f0e1-1809-344c-5bc9-fdb72ade4df7@linaro.org>
Date:   Sun, 1 Jan 2023 16:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 4/6] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-5-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231222420.75233-5-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 23:24, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 59 ++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index df5453fcf2b9..9cb081332849 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -511,6 +511,65 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		ufs_mem_hc: ufs@4804000 {
> +			compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
> +			reg-names = "std", "ice";
> +			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <1>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +			iommus = <&apps_smmu 0x200 0x0>;
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

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

