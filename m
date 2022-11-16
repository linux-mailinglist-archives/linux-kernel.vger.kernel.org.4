Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93CE62BECD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiKPM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiKPM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:58:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB089FFA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:58:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bj12so43786922ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDvwwXEV44aTmmIoKPH7bc6LqlZ8E4Ob4p52TWVGvr4=;
        b=cekHUYpnORylDQCbKrdKPLGkpBFRddBfMwumZYLprtEW+p5C2UDnouejqfjrWJzI4J
         8OhYuUwZdDjveaJCpvi4j6DWMB+mJpJleUVnpDYxrs7maHuyry3aSib5+qOmaXyhXA/n
         nK5vSoTK719b4vBpZ5r30dGWC8GtvYGZd3dMtsrL+D993WOv8adOqln8zPKUBqclhdMb
         ZCeXycgrStly31vJKY4Gx1CcZ85xGMPfETqaRZH/fqXXUST7pOXM2/r4BVJRiLfeECAV
         qkNbie+sL3F4spPeYk+5l8oRjv8RzOcmibjoMAcZoNeO69YRhujrnBKd+QuqMiTozStj
         iWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDvwwXEV44aTmmIoKPH7bc6LqlZ8E4Ob4p52TWVGvr4=;
        b=jtlyuXOJn+bq0Fc2d3ZT6HexiDVMRGTWYi9xvkTREuqiTAij7KqqUKuhxk8cfZSAo5
         rrn7/iX3WKzR8i0EespkoKTvYtBM883j//oDq0jJH9BqybK0UbEFiy9UOMYHoA3pfYhB
         /GCQtkozfkAz3ZxVly8++zC6KOis2fDlcCXJNPt/vpC9pLjHiJ4qq9nzh4MsfK16Od4j
         gsjGQBHJFRrXb6RwNz3maFUCLt0SDs433+iYMX6NLXxx47drPKk2J3KQoJmb680MGoTs
         F3ZKKJCvtW4ZSaXq0Pd61bgJXnxV04nx4QPfwGRinNnKJtgWzoAjhj0nCnDILXcq0kOs
         ngGA==
X-Gm-Message-State: ANoB5plaatlRzMa0b8IrApxLVOUe8SqP0omkUi8Jz+upIfRpVzIBSf/m
        3MTSJOvqiPeEmZ/eUNZAIE8DTQ==
X-Google-Smtp-Source: AA0mqf56KN02I0QAyi1K7BJ8yHmTXAi5FUUAmYTDqbHwTr24Kj7vjxOkDm2xehoN6rUfBRJ6JRfEHg==
X-Received: by 2002:a17:906:1d08:b0:7a9:ecc1:2bd2 with SMTP id n8-20020a1709061d0800b007a9ecc12bd2mr17517688ejh.545.1668603519342;
        Wed, 16 Nov 2022 04:58:39 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id we10-20020a170907234a00b00782fbb7f5f7sm6844407ejb.113.2022.11.16.04.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:58:38 -0800 (PST)
Message-ID: <2b5f65f9-99d0-4ce6-da18-c1d9c8898d70@linaro.org>
Date:   Wed, 16 Nov 2022 13:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add UFS host controller and
 phy nodes
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116125112.2788318-1-abel.vesa@linaro.org>
 <20221116125112.2788318-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116125112.2788318-2-abel.vesa@linaro.org>
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



On 16/11/2022 13:51, Abel Vesa wrote:
> Add UFS host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 76 ++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..27ce382cb594 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1372,6 +1372,82 @@ mmss_noc: interconnect@1780000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		ufs_mem_phy: phy@1d80000 {
> +			compatible = "qcom,sm8550-qmp-ufs-phy";
> +			reg = <0x0 0x01d80000 0x0 0x200>;

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
These three can go at the bottom.


> +			clock-names = "ref", "qref";
> +			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsr TCSR_UFS_CLKREF_EN>;
> +
> +			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			status = "disabled";
> +
> +			ufs_mem_phy_lanes: phy@1d80400 {
> +				reg = <0x0 0x01d81000 0x0 0x134>,
> +				      <0x0 0x01d81200 0x0 0x3d8>,
> +				      <0x0 0x01d80400 0x0 0x258>,
> +				      <0x0 0x01d81800 0x0 0x134>,
> +				      <0x0 0x01d81a00 0x0 0x3d8>;
> +				#phy-cells = <0>;
> +			};
> +		};
> +
> +		ufs_mem_hc: ufshc@1d84000 {
> +			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			iommus = <&apps_smmu 0x60 0x0>;
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> +
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
> +			clock-names =
Why break the line before adding any entries?

Konrad
> +				"core_clk",
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"rx_lane1_sync_clk";
> +			clocks =
> +				<&gcc GCC_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_UFS_PHY_AHB_CLK>,
> +				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				<&rpmhcc RPMH_LN_BB_CLK3>,
> +				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			freq-table-hz =
> +				<75000000 300000000>,
> +				<0 0>,
> +				<0 0>,
> +				<75000000 300000000>,
> +				<100000000 403000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +			status = "disabled";
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x0 0x01f40000 0x0 0x20000>;
