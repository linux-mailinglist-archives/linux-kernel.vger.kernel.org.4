Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8666254F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjAIMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbjAIMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:18:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CEE1ADB2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:18:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d30so7730250lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 04:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DifmN6L/adKoCUxtqAMK0Lt+Rvw7dAd2CGTYKxx25Ks=;
        b=c4c29HwIOCrN5rNFt4Nhyw69bHd78n8mskBOpdz4YTWuE4oXGYmuSieq2+TKbC5Wdy
         HS3U95DF5wBoDXrCdQkr+Jn/v5dQyYWutTE8dmcO5FEtaeSDAkfqtfGOFNWp1Z2LwjSb
         S9u3QVsnxmK9eu2Q5Yz0Rezw1YSikqUh9Kf7v2isCNJy8eMGWNhk0V5HjAwxH2yLlkPC
         Rq7pHtxDZJMLOY8iM8tHyepfNqaAVXEWnrXW7tO2g4+HoG+6Ldk4PafT1xQgqhU6OaxM
         jMz6BGwkbt/98GMKZv5PJ7Nv+18K/7gzJTwTncxuJnTxOO8aXWH7rM2N1eP/D08m4zK1
         dsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DifmN6L/adKoCUxtqAMK0Lt+Rvw7dAd2CGTYKxx25Ks=;
        b=4MR0KDM+kYKXUxShjRqx2tX9jiYA1rTqDx4QPKNUDVJJAaFLoUCBmHSYjfwGZ/wbMN
         2Rqga1ePbOG/uuQfP/3AIBvc9GVDPgyJX2ZKrxYengokqP3a0Qd9nVukDrwDtvRpgOPq
         iZDL4zo4Z/SkQmRRYvAa3samqF3Eh5Woh35yDP7NuhlG+8ZDPjZO1bCoTCzqwWth8LT9
         AF6OSdDshReKC6HIHoDmQId6CRudNszRC3vTRbX7Y60Op5Yto8mxGSe289dglXUPMY1b
         LReyW83AC5asGDvz3AOlzY4w3VZT6KP2sfp0jbyk0ULxA4fDQ7qjbRqOEN/7KPYG9baj
         x1UA==
X-Gm-Message-State: AFqh2krAJOEyQWhoNVqYWJuto4p7EmacSeLZ8GbBt7VfMLNUrmaRcldr
        g5yGiPlBJrd3swFI07dk4ljn/w==
X-Google-Smtp-Source: AMrXdXuH0t6wTXKr/wNZTaA+WuTI+fWxIR9xpAoOUVy3L1mqqK4X3ba9f5GIZ+jNGa0HdYUWL4rqIg==
X-Received: by 2002:a19:9116:0:b0:4cc:5e97:d357 with SMTP id t22-20020a199116000000b004cc5e97d357mr3699274lfd.33.1673266701267;
        Mon, 09 Jan 2023 04:18:21 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm1597098lfe.201.2023.01.09.04.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:18:20 -0800 (PST)
Message-ID: <475d3f2f-114f-d6d2-89db-465ba7acd0d6@linaro.org>
Date:   Mon, 9 Jan 2023 13:18:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/6] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-5-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230108195336.388349-5-they@mint.lgbt>
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



On 8.01.2023 20:53, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 57 ++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index df5453fcf2b9..cec7071d5279 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -511,6 +511,63 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		ufs_mem_hc: ufs@4804000 {
> +			compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
You need reg-names for ICE to probe, otherwise the second reg sits unused.

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
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@4807000 {
> +			compatible = "qcom,sm6125-qmp-ufs-phy";
> +			reg = <0x04807000 0x1c4>;
Isn't this too small? Downstream says 0xdb8, but it's probably even bigger..
> +
> +			clock-names = "ref", "ref_aux";
We recently started an endless quest, trying to unify property
order [1], please adjust this to:

compat
reg
clocks
clock-names
[freq-table-hz seems fitting here tbf]
resets
reset-names
power-domains
#phy-cells
status

so in your case, put power-domains after reset-names and flip
clocks/clock-names

similarly for the node above this order would look good:

compat
reg
reg-names
interrupts
clocks
clock-names
resets
reset-names
reset-cells
phys
phy-names
lines-per-direction
iommus
status


Konrad 

[1] https://github.com/konradybcio-work/dt_review
> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		gpi_dma0: dma-controller@4a00000 {
>  			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0x04a00000 0x60000>;
