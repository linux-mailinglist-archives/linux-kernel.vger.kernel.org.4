Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8B64E0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiLOSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLOS3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D84B9B3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:28:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so17010284lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xges9AE4XF5N3tweXiuSjVH3JHoUQgJ5fNKUBxJ0J1M=;
        b=fBuOu4wE0gisay6F4ckCzE9jGK4aMiFrHK4fdRtIXUdhIrrJcAB1J7qwjl7/unNEWB
         6ZL0o7PgL2ZetQwYvNWRA2KTuhpkJuGIvvo0zGC/h+Sv4L4kn+o8LhhoAbbXkNxac4CD
         qC47NlgUIwtmYQUA8HPIuvRUyERwXDCmsPuNYhsq2GCuh9SZ1hk/0WvWH97oZcdAWwTx
         2CkIF0UShwSYAcfPNyb3QrrKeP0SHcnhXiT5OzkNEfI+kXaxQT3F3dyVrHMYkFQAUcoJ
         vz4GV6jpTBs3la6QK276zvuQltoCL4jHI5cG1KhJdX0Rg43egm9lpgCxR9AGuOLq12Q7
         5ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xges9AE4XF5N3tweXiuSjVH3JHoUQgJ5fNKUBxJ0J1M=;
        b=zCymfmAakbf22j7OSNfG4ouam83+/4gx1NHEKP9Aza2GarbEA3OdiNOyF7QgL5DyzR
         qmOIbde7a7APcd33HFU4i3wX+hvQJwjSYwryCxQSgxJolHLUBfk+dASXZqrM0716Jr9W
         icr4JPOlWUqrHvuIWlWSkqhtA/Llq5O9g4uqmD0y//aeCQ7G86eGqloEZAwBCbMjQlTG
         2j3m+qqISxvrMX2LBrkAHRXC4aZc+SOvPuhptwZP2o3RUtn1oTDVn0ITS0kcX4zwJeqT
         N6wb2Qf3mev2hcJ6cebJR9N0YRIRWbCo7sH7Ua24TlHhmMp6M2/nDc3u8MSrK2csJozz
         9teA==
X-Gm-Message-State: ANoB5pkf9bvPGDnfLCuvWOXf0YVTqhy+0D0diObtWHy8TmpBKco5WGJy
        iNh8JhcDQCAThPIUk/gymnM2cQ==
X-Google-Smtp-Source: AA0mqf5MXz+kcxFlOP/wnWxfQJxJHnLflNphonVJK17T7s39Pd5uULmxOKdD16WEN3xhAe/DRi4fGw==
X-Received: by 2002:a19:7405:0:b0:4b5:7096:23ff with SMTP id v5-20020a197405000000b004b5709623ffmr7981816lfe.66.1671128930478;
        Thu, 15 Dec 2022 10:28:50 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id f7-20020a05651c03c700b002776eb5b1ccsm6496ljp.4.2022.12.15.10.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:28:49 -0800 (PST)
Message-ID: <7c6dc327-9cc3-ca00-479b-25b1f6e071dc@linaro.org>
Date:   Thu, 15 Dec 2022 19:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215182412.386064-1-they@mint.lgbt>
 <20221215182412.386064-2-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215182412.386064-2-they@mint.lgbt>
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



On 15.12.2022 19:24, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7e25a4f85594..22c945d5fc7a 100644
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
> +			reg = <0x04807000 0x1c4>;
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
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
That won't compile. Properties must precede subnodes.

Konrad
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
