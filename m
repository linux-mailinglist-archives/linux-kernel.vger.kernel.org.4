Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44F07051F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjEPPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjEPPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:20:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E597A83
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:20:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso100344711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684250448; x=1686842448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AWKpnwAVSZF0RZwgYNJ8KCTEC9gSaQ9TieU/3HHmrk=;
        b=AnsdaeP4dmnBP43DGnvBvHTNFMtmfhFQFiLK/08atFTSAN+VloaXOkeBJc4bCM8qhP
         V3Hr6A/9CyI37N7c2VZyW4Biz8gcVK8yDgkIl5W4NJbLTL3C8e7NrcBiAgw0tjRgMxrt
         5VI+oM5HaItWJdAs7jk9E6oRMn8p9CVmVFgODj2oqR6ybB8AZMwmFfltQhNkC528Rol3
         Krl+vv6/e3zVuoPB674IOboe6f8d8wcjlR/RjGq0H+PqU3UgjHfAGgUbZZArjN4J8Pv+
         aa+ICsS/nYtBToxtxgnvbsITNxz4uaCK/bZNdKgAinydyAxU+fIMWgQI1wZUrxSgpndx
         slyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684250448; x=1686842448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AWKpnwAVSZF0RZwgYNJ8KCTEC9gSaQ9TieU/3HHmrk=;
        b=XNXPdkcFgSJTE4Po3aav1P+ruEi8EdRXmPBUHd1v9hLRa+kePp1kfW5fRiD1vqerX2
         FundeeCGyQCBH1le4J4o7ijL/3WXWDSzXWxOHfWhxJJcv3ODvJdKgHBhKBhcoTZ2v5Dh
         4/V8KXBvU8Z728eksJ8IdBSR/BC71a6dEZDyiSR/XmeDPDm9XQ1GFpRYmtDJ1ZRHq/Kp
         RuoymRdwOSumsWtA7CYF8d9S0W8BL581BAdVucAFO+yp/taaJ8AdwBow0XvZGDCjy0JG
         KSXA88gtkK9nw2zWJwhCZMXi9PQHPANHJh4BfWTiCqkOLRHSYkEhLDsrqZVPJhmaM+ST
         LqMA==
X-Gm-Message-State: AC+VfDxNXf3ztAkqRhZRc3tiQUE9JbvMT5zmdJfhWAitz6JJydhOkJo6
        9GmKzr0WeuGLcXExPcWHs+Hfdg==
X-Google-Smtp-Source: ACHHUZ6G+XLqcLw33b1steb9Qp3niR/qMasK+d1jeR1V41r8rEkIjoPng8pZOKr/AFkIdQutysToLA==
X-Received: by 2002:ac2:4d0b:0:b0:4f1:223c:dc83 with SMTP id r11-20020ac24d0b000000b004f1223cdc83mr6672497lfi.48.1684250448249;
        Tue, 16 May 2023 08:20:48 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651204d100b004f14898d18esm2959685lfq.85.2023.05.16.08.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:20:47 -0700 (PDT)
Message-ID: <ecfe4f62-9c54-df5e-cd5d-e7a956510696@linaro.org>
Date:   Tue, 16 May 2023 17:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-qrd: add display and panel
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
References: <20230516151708.213744-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230516151708.213744-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 17:17, Krzysztof Kozlowski wrote:
> Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
> MTP8550).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context in the patch depends on:
> 1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
> 2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 30b36a149125..03bf6bc2db4d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -420,6 +420,10 @@ vreg_l3g_1p2: ldo3 {
>  	};
>  };
>  
> +&dispcc {
> +	status = "okay";
> +};
Missed this in the bigpatchdrop review.. It makes no sense to keep
dispcc disabled by default (other than for lazily "solving" UEFI
framebuffer being shut down)

> +
>  &gcc {
>  	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>  		 <&pcie0_phy>,
> @@ -431,6 +435,50 @@ &gcc {
>  		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l3e_1p2>;
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "visionox,vtdr6130";
> +		reg = <0>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
> +		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
property-n
property-names

> +
> +		vddio-supply = <&vreg_l12b_1p8>;
> +		vci-supply = <&vreg_l13b_3p0>;
> +		vdd-supply = <&vreg_l11b_1p2>;
> +
> +		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			panel0_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&panel0_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vreg_l1e_0p88>;
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
This should also be enabled by default, MDSS is useless when MDP is
disabled.

lgtm otherwise

Konrad

> +
>  &pcie_1_phy_aux_clk {
>  	status = "disabled";
>  };
> @@ -532,6 +580,34 @@ wcd_tx: codec@0,3 {
>  &tlmm {
>  	gpio-reserved-ranges = <32 8>;
>  
> +	sde_dsi_active: sde-dsi-active-state {
> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_suspend: sde-dsi-suspend-state {
> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_active: sde-te-active-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_suspend: sde-te-suspend-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
>  	wcd_default: wcd-reset-n-active-state {
>  		pins = "gpio108";
>  		function = "gpio";
