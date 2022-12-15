Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514BA64DE66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLOQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLOQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:18:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562332BBA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:18:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b13so16444387lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUWi8X7N5NfAargziR2v2NwUWgt6sv76E1zQIWO6Rqc=;
        b=rv6mwdv++zFy+FJxcI+ItLrfJeymvYqN757ya0wG69S1weGFbUEyzXLvr7yFY5koNH
         kdOoQsopAyK7sQHXf7xS4sYInn3mBzyk250HOwT20hvGixLskmZB77cb4g2D6J76DUEV
         TqEEMutsRAf6trkokcMK3z7EdTKY7w9i9XAVk82OhEIhngrLS/K9M7wKWwhOubEABt0c
         cfn5GzMQF8CpexckTD680CicFCGwIjDDkViDXiTIRtcIwQ7fv3AjkcMx/WBL2c4xY+MV
         qzw3gE3mRuBeRaK0hsJbmbLdhgd54werWqeYYlWtfNo3mP8marDVdyVKi709ezQGM6AU
         MuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUWi8X7N5NfAargziR2v2NwUWgt6sv76E1zQIWO6Rqc=;
        b=ijhsCzz2oGLTLYqfFLeNuk+Z0CpWG+zSN4HyQIGjTu49LfSFm7zgwSVENZMCjr7UMP
         Yjaq6IG96xC4DsL36BrVZIXhEV694RJrRb7dnOI9fCy9CG+3jJqy/r64xN1nTk8OYBON
         K9mS4MCVa6WqEmc+aowgUzP54vusmkrUgJIoLDuJxMu0eb3f7pEmQup/aNDYzQYJQBup
         UIQlxBloeIg7Gg71b8c4FurXxnPFTZxe/HqANh84wg89ZdjZrFx6XhdLQcLHbzMdC6qN
         Bp/9NDDyajDr70E4fModL0qpfNcfqFlvjEASl5qxxpJX2YY2NZRC0nBPZLt0LdMiIGXe
         FrRQ==
X-Gm-Message-State: ANoB5pl4rVcjNJBOJzEZf7J5Mk9n5BxtfiCpWjFqOcH8evqtMk7Q4igS
        WOz/30CFkTAFjWQHU+ncCHkZcA==
X-Google-Smtp-Source: AA0mqf74b2vGxIQtzSg0J6NlOmjL0nIDO8OQduiL+XyWle0of7H3QAdX1OGYFIRNgWr25V43vz2uPg==
X-Received: by 2002:a05:6512:33c5:b0:4a4:68b7:f86d with SMTP id d5-20020a05651233c500b004a468b7f86dmr16486377lfg.17.1671121107277;
        Thu, 15 Dec 2022 08:18:27 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h12-20020a056512054c00b004b577085688sm1200652lfl.82.2022.12.15.08.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 08:18:26 -0800 (PST)
Message-ID: <875bd0a8-fc08-1d19-2c75-65713d9d2317@linaro.org>
Date:   Thu, 15 Dec 2022 17:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215161258.355962-1-they@mint.lgbt>
 <20221215161258.355962-2-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215161258.355962-2-they@mint.lgbt>
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



On 15.12.2022 17:12, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 66 ++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7e25a4f85594..6d4534c7a2fe 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -508,6 +508,72 @@ sdhc_2: mmc@4784000 {
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
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"ice_core_clk";
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_UFS_PHY_AHB_CLK>,
> +				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				<&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +			freq-table-hz = <50000000 240000000>,
> +				<0 0>,
> +				<0 0>,
> +				<37500000 150000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>,
> +				<75000000 300000000>;
The indentation is wrong. Make sure your tab size is set to 8
and all the <> entries align with the first one.

> +
> +			non-removable;
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@4807000 {
> +			compatible = "qcom,sm6115-qmp-ufs-phy";
> +			reg = <0x04807000 0x1c4>;

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
Please move these three properties last.

Konrad
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			clock-names = "ref", "ref_aux";
> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> +					 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			status = "disabled";
> +
> +			ufs_mem_phy_lanes: lanes@4807400 {
> +				reg = <0x4807400 0x098>,
> +				      <0x4807600 0x130>,
> +				      <0x4807c00 0x16c>;
> +				#phy-cells = <0>;
> +			};
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
