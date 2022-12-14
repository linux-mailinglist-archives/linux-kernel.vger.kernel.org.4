Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475D64C63A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiLNJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLNJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:47:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785238B6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:47:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so9507799lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z442H9rLmk/J986c1cu/kUSBWmpBjFZeRr3rpjO8xeo=;
        b=k7eSCkrJM4Na8rFU+PAi+zaWwH98ytXPesY0413trrNd6ocRoIzHBOh8gCk6bBh8/n
         L3uabpN6vxmbSfBDbwhItE0e6jY+NEUchIEPOkU2I7mVCbjYxl6sq5bRozCTnt5wQElU
         UNDxm10s3H1KNkrvwESgorHNbttahKU9QFOfBy+YODeTP8M33Pw4Q88eRF056n9x9RLB
         SSvpPUCnun114A+11e5AA3ZM8tGjrfIJPlTfPNeys1q7uAz9VVWT/8SG6pmJ0gR72clF
         jX+jGLe7HI8VtGyqe89UrhouEopQ2rcgdmZLz65jcUIcRl1rwpCdjYxoKpP/gBa/c1b5
         cOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z442H9rLmk/J986c1cu/kUSBWmpBjFZeRr3rpjO8xeo=;
        b=6TlUEeA5mvBb6plEsfcdJeyWAVczh7sQHKUKUm1RRzl1Bj3or20HYq0l7wkmHLQBVn
         s/uizio7LyiK5lQ0hvDJ02MSLndsE6V1lMC7Ns/W6r/ZW1EHxkWMByyrWLcVqoUMJ/zq
         icWMhwXSxsbeIAWlDRpt5Z0s8go7sjykocEjlzwtLzHHbzpEA7xpnNhCKtiko33N4F8a
         GFy33DZag4QZhEA4q2j7UzAH0GthTjWPtvoCBD/vDbErMXi+7dEYzb+Hb1Kkv9JQy0o8
         qumXPJ8yGxhe7J6fQbIiFXm+KaXg9WS1WTabr0qRO4ccUJvh27HcJ0myvB1U+6HS+oKq
         4y/A==
X-Gm-Message-State: AFqh2koSGxZLB1PQeQGOqpQYnMpGDkdwNJOQFvhZXTx5eKDkGKr3yuUO
        cCmOzTZengd5lZu0xkSd6Kp0cA==
X-Google-Smtp-Source: AMrXdXsIroKIbnI/X8VH5EGJAgIh9xiOmtCejLWOhEzYc0mRy65P1yhE1elFv9YhDVBeA/GhU/EOBg==
X-Received: by 2002:a05:6512:1045:b0:4b9:555d:b010 with SMTP id c5-20020a056512104500b004b9555db010mr588345lfb.19.1671011226248;
        Wed, 14 Dec 2022 01:47:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u30-20020ac25bde000000b004b49025f96dsm741765lfn.187.2022.12.14.01.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:47:05 -0800 (PST)
Message-ID: <b26b369d-21b7-6119-386a-7652b549305d@linaro.org>
Date:   Wed, 14 Dec 2022 10:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214093209.152991-1-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214093209.152991-1-they@mint.lgbt>
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

On 14/12/2022 10:32, Lux Aliaga wrote:
> This commit adds a UFS host controller node and its corresponding PHY to

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>

You need to thread your patches. git send-email does it automatically.
The patchset is now difficult to review and not possible to apply
because of broken thread.

> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 1fe3fa3ad877..f43b005b9454 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -506,6 +506,76 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		ufs_mem_hc: ufshc@4804000 {

Node name just "ufs"

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
> +			clock-names =
> +				"core_clk",

Merge these two lines.
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"core_clk_ice",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk";
> +			clocks =
> +				<&gcc GCC_UFS_PHY_AXI_CLK>, // 200m

Ditto and drop the comment - I don't get to what 200m refers to.

> +				<&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>, // 200m

Drop this comment as well and all others.

> +				<&gcc GCC_UFS_PHY_AHB_CLK>, // 0
> +				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>, // 150m
> +				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>, // 300m
> +				<&rpmcc RPM_SMD_XO_CLK_SRC>, // 19.2m
> +				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>, // 0
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>; // 0
> +
> +			freq-table-hz =
> +				<50000000 240000000>,

Merge lines.

> +				<0 0>,
> +				<0 0>,
> +				<37500000 150000000>,
> +				<75000000 300000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +
> +			non-removable;

Just to be sure - does your DTS change pass dtbs_check?

> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@4807000 {
> +			compatible = "qcom,sm6115-qmp-ufs-phy";

Most likely this needs also dedicated compatible.

> +			reg = <0x04807000 0x1c4>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
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

Best regards,
Krzysztof

