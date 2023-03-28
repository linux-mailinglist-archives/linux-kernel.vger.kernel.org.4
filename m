Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133D6CB7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjC1HJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjC1HJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:09:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA352681
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:09:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so45580957edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679987351;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOVU8RBe7aR7D4CaCDozBWMIHjex6O25PxAUFtGHR20=;
        b=JzHU38sHO7In6qpvbTJgTbAqk1fVTJ2CQ0Wd9Ls7ggx9Em/S5v+64RwlQECakrVpcH
         zeJydAMiV53vnjPyJV1k73sd2vuMCJ3wXKTvNR8h7UNmQatNDCVwEGX6Up7Y9tDIjCJp
         UivJP29SM8DYeQ8B57yX+9xDbcFaTI8YVL92a7BIb3f5/0Ax/wcrosiNNiFXbpQxxHtu
         n5lNtMFWWdgpr+kwgqqNFyLc5ZMTuLPw2tOtTvQG8cLc+bC7yGIAn/T7/SI8l0MZrgym
         /pNmt13+4uWtqwlnqayT+YQ0cnPqrJy4cGayO9ZM3477EFTdjPjCuzp4vxdY276sf3DF
         21YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987351;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOVU8RBe7aR7D4CaCDozBWMIHjex6O25PxAUFtGHR20=;
        b=nAraZ2Rimm+MLw465QcjWP4uhwErWH/Dg4KmXVAZJOhzZzTUXjkFyhargSqDtK52YC
         b4FhX79608LLF0xjn1dY4bQZoQJkbNt00BvACF/DAlBfiKYFfgr55Uvk1jcs/EiTLxiJ
         xEsrgIuKoKKdnrfKEiI16mvWEcvyFAoSADgrJPTdAHPB4EyXULGIC2X+2ntkFnBDc5S7
         JZ5XMDJgBenny54Xk2LxrtSI59uJdc5C1xWyNyHOfvIn2OqIft2V8hpkxlxalRNVhg+F
         6FaULJqNUun3NRdWj0Aa3uZNwfC5BKnXybK+fwtHKo5mTiRuJBfqMLP7DzH/jDaZqPKg
         7o+w==
X-Gm-Message-State: AO0yUKWtAGOrrl7hz6HoM0zg7GV+nYf4Bh1WTrsz1Yil/8N/ee+thcvO
        j58gWt5sk/4Jy64DPQ0A3xhRDw==
X-Google-Smtp-Source: AK7set++FIrmezxGT+XslLTQjEdJlsT5IB14A1jKFakYYMeGeD3Uyo1qplKKlDhDanwJTz/sSprUyw==
X-Received: by 2002:a05:6402:1c95:b0:4af:7bdc:188e with SMTP id cy21-20020a0564021c9500b004af7bdc188emr22837333edb.16.1679987351279;
        Tue, 28 Mar 2023 00:09:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id j30-20020a508a9e000000b004af5968cb3bsm15378561edj.17.2023.03.28.00.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:09:10 -0700 (PDT)
Message-ID: <e5d4663f-c816-4789-a63c-5d6ce4744692@linaro.org>
Date:   Tue, 28 Mar 2023 09:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <f3c42c0e2e2fb309dc0d248e0e1b921c6b8c11f9.1679909245.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f3c42c0e2e2fb309dc0d248e0e1b921c6b8c11f9.1679909245.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 11:30, Varadarajan Narayanan wrote:
> Add USB phy and controller related nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v4:
> 	- Use newer bindings without subnodes
> 	- Fix coding style issues
> 
>  Changes in v3:
> 	- Insert the nodes at proper location
> 
>  Changes in v2:
> 	- Fixed issues flagged by Krzysztof
> 	- Fix issues reported by make dtbs_check
> 	- Remove NOC related clocks (to be added with proper
> 	  interconnect support)
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 83 +++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 2bb4053..5379c25 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -215,6 +215,45 @@
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		qusb_phy_0: phy@7b000 {
> +			compatible = "qcom,ipq9574-qusb2-phy";
> +			reg = <0x0007b000 0x180>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&xo_board_clk>;
> +			clock-names = "cfg_ahb",
> +				      "ref";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +			status = "disabled";
> +		};
> +
> +		ssphy_0: phy@7d000 {
> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
> +			reg = <0x0007d000 0xa00>;
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;

Why do you need these three?

> +
> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&gcc GCC_USB0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_USB0_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +			status = "disabled";
> +
> +			#phy-cells = <0>;
> +			clock-output-names = "usb0_pipe_clk";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		};
> +
>  		pcie0_phy: phy@84000 {
>  			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>  			reg = <0x00084000 0x1bc>; /* Serdes PLL */
> @@ -436,6 +475,50 @@
>  			status = "disabled";
>  		};
>  
> +		usb3: usb3@8a00000 {

usb@

> +			compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> +			reg = <0x08af8800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;



> +
> +			clocks = <&gcc GCC_SNOC_USB_CLK>,
> +				 <&gcc GCC_ANOC_USB_AXI_CLK>,
> +				 <&gcc GCC_USB0_MASTER_CLK>,
> +				 <&gcc GCC_USB0_SLEEP_CLK>,
> +				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +
> +			clock-names = "sys_noc_axi",
> +				      "anoc_axi",
> +				      "master",
> +				      "sleep",
> +				      "mock_utmi";
> +
> +			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +			assigned-clock-rates = <200000000>,
> +					       <24000000>;
> +
> +			resets = <&gcc GCC_USB_BCR>;
> +			status = "disabled";
> +
> +			dwc_0: usb@8a00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x8a00000 0xcd00>;
> +				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +				clock-names = "ref";
> +				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +				phys = <&qusb_phy_0>, <&ssphy_0>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				tx-fifo-resize;
> +				snps,is-utmi-l1-suspend;
> +				snps,hird-threshold = /bits/ 8 <0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +				dr_mode = "host";

Are you saying that peripheral mode cannot work on this USB controller?
Never?

Best regards,
Krzysztof

