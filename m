Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47EA66248B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjAILrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjAILqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:46:44 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA749DF47
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:46:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so12487132lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nveDtd10Wvb2GtVD8haiZeOqmw/n0Wm8k2LqTy7wwys=;
        b=PCEJz9PF54gVTfQeUR12IWqVI3PfOzSU8FLIFyJ4RCPiPqMug4nLkJ/jf809e28jWH
         TqUw3Y6t4qaYurCbkLomYHT/aw3nAWakDlQtypOvCTW+lLjOaMN5w5MZl1tNakwBAFGX
         dSeouSyOQ73OTUyjTjDO7waRchKKkpLkPnalQf2KVavGuns3eJb0hIuSupx2gbpaOy2s
         ENz6kZUdjUm+KDp/mYc0/GybfOrPwcn08PkC6vAEB+PMsstRdNltTeAGbeeF1ukSNpN6
         dJPZcL7wAQwmknleQ8SdKcOiFis6k/TaWAuffUSV0CEBbjrjbCUopnKBQ6usk4qyBX2z
         5dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nveDtd10Wvb2GtVD8haiZeOqmw/n0Wm8k2LqTy7wwys=;
        b=mlfRZrleQBWvtEcG6/wRqTyPB8DpPEO+fUnJIFAm8RKqeBpqCrM4KrrcOIprFCP9PS
         pVN6nzSa86BpIApslBkncraq8RWZGZS7Bu5Jise0xe0PSKsYf6wAN2wEzpGTMyDs6Siv
         QBjw81ExheYVEGU0HwKDaqi9NdNXpW1RMyN0JZxQElbYBRYu3yogRr3Hl0HLZXWySK1D
         L0F9c6Gj/lFSpP4z9TTheduUYCq6L2EYeocWFnjly3gCER9NrLswD2Oqs3O9jniU8c12
         F6T+ETxHkr09z5UrWdxW5h+aaPzxFhSqzbNxJF9sHlfdYKrkWbyuBy0bsctG9rpg+JRG
         jeKA==
X-Gm-Message-State: AFqh2kqFstECTAhMiHmgCP1e7zmykbIrygerm5JwRifpKnKpXEY3zo5X
        8rdV6i6IbxEMA1rhUjKubUnFgQ==
X-Google-Smtp-Source: AMrXdXtrqFhAnW5YJj1GRaV3b743IagyoGO7XXyiQXA1GFNatVZGtMEd7Y5b/z/x52tNzpiJxpHSqg==
X-Received: by 2002:ac2:43b5:0:b0:4cb:40ba:4ae8 with SMTP id t21-20020ac243b5000000b004cb40ba4ae8mr5493409lfl.34.1673264801012;
        Mon, 09 Jan 2023 03:46:41 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id j7-20020ac25507000000b004b5831b69dcsm1585863lfk.140.2023.01.09.03.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:46:40 -0800 (PST)
Message-ID: <ab20a6f0-5de6-48c9-cffd-a6bfd9e8ee3e@linaro.org>
Date:   Mon, 9 Jan 2023 12:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm/apq8x16-*: Move status property
 last
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230109110107.3016323-1-nikita@trvn.ru>
 <20230109110107.3016323-2-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109110107.3016323-2-nikita@trvn.ru>
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



On 9.01.2023 12:01, Nikita Travkin wrote:
> It's agreed that the status property should always be the last.
> Move it in all msm8916 dts.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 44 ++++++++++---------
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 12 ++---
>  .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts |  9 ++--
>  .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 16 +++----
>  .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 12 ++---
>  .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 12 ++---
>  .../qcom/msm8916-samsung-a2015-common.dtsi    | 12 ++---
>  .../boot/dts/qcom/msm8916-samsung-j5.dts      | 12 ++---
>  .../dts/qcom/msm8916-samsung-serranove.dts    | 12 ++---
>  .../dts/qcom/msm8916-wingtech-wt88047.dts     | 12 ++---
>  10 files changed, 78 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index ef5b39ba1238..3586f373d511 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -175,18 +175,16 @@ &blsp_dma {
>  
>  &blsp_i2c2 {
>  	/* On Low speed expansion */
> -	status = "okay";
>  	label = "LS-I2C0";
> +	status = "okay";
>  };
>  
>  &blsp_i2c4 {
>  	/* On High speed expansion */
> -	status = "okay";
>  	label = "HS-I2C2";
> +	status = "okay";
>  
>  	adv_bridge: bridge@39 {
> -		status = "okay";
> -
>  		compatible = "adi,adv7533";
>  		reg = <0x39>;
>  
> @@ -208,6 +206,8 @@ adv_bridge: bridge@39 {
>  		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
>  		#sound-dai-cells = <1>;
>  
> +		status = "okay";
> +
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -231,34 +231,35 @@ adv7533_out: endpoint {
>  
>  &blsp_i2c6 {
>  	/* On Low speed expansion */
> -	status = "okay";
>  	label = "LS-I2C1";
> +	status = "okay";
>  };
>  
>  &blsp_spi3 {
>  	/* On High speed expansion */
> -	status = "okay";
>  	label = "HS-SPI1";
> +	status = "okay";
>  };
>  
>  &blsp_spi5 {
>  	/* On Low speed expansion */
> -	status = "okay";
>  	label = "LS-SPI0";
> +	status = "okay";
>  };
>  
>  &blsp1_uart1 {
> -	status = "okay";
>  	label = "LS-UART0";
> +	status = "okay";
>  };
>  
>  &blsp1_uart2 {
> -	status = "okay";
>  	label = "LS-UART1";
> +	status = "okay";
>  };
>  
>  &camss {
>  	status = "okay";
> +
>  	ports {
>  		port@0 {
>  			reg = <0>;
> @@ -319,43 +320,41 @@ &mdss {
>  };
>  
>  &mpss {
> -	status = "okay";
> -
>  	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
> +
> +	status = "okay";
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pronto {
> -	status = "okay";
> -
>  	firmware-name = "qcom/apq8016/wcnss.mbn";
> -};
>  
> -&sdhc_1 {
>  	status = "okay";
> +};
>  
> +&sdhc_1 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> -};
>  
> -&sound {
>  	status = "okay";
> +};
>  
> +&sound {
>  	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
>  	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
>  	pinctrl-names = "default", "sleep";
> @@ -364,6 +363,8 @@ &sound {
>  		"AMIC2", "MIC BIAS Internal2",
>  		"AMIC3", "MIC BIAS External1";
>  
> +	status = "okay";
> +
>  	quaternary-dai-link {
>  		link-name = "ADV7533";
>  		cpu {
> @@ -396,12 +397,13 @@ codec {
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
>  
>  	pinctrl-names = "default", "device";
>  	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
>  	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
> +
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index 701a5585d77e..20301eaa3b95 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -152,8 +152,8 @@ led@1 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_vib {
> @@ -165,26 +165,26 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> index 3618704a5330..a0f868854d53 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> @@ -133,26 +133,27 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> +
> +	status = "okay";
>  };
>  
>  &sdhc_2 {
> -	status = "okay";
>  	vmmc-supply = <&reg_sd_vmmc>;
>  
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> index 8c07eca900d3..2d266fd417f8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> @@ -219,8 +219,8 @@ &lpass {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_vib {
> @@ -232,16 +232,14 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdhc2_cd_default>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdhc2_cd_default>;
> @@ -260,11 +258,11 @@ &sdhc_2 {
>  	 * SD card slot and forgot to re-route to gpio38.
>  	 */
>  	cd-gpios = <&msmgpio 56 GPIO_ACTIVE_LOW>;
> -};
>  
> -&sound {
>  	status = "okay";
> +};
>  
> +&sound {
>  	model = "msm8916";
>  	audio-routing =
>  		"AMIC1", "MIC BIAS External1",
> @@ -275,6 +273,8 @@ &sound {
>  	pinctrl-0 = <&cdc_pdm_lines_act>;
>  	pinctrl-1 = <&cdc_pdm_lines_sus>;
>  
> +	status = "okay";
> +
>  	primary-dai-link {
>  		link-name = "WCD";
>  		cpu {
> @@ -297,8 +297,8 @@ codec {
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index d1e8cf2f50c0..f63f0fb797b4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -219,8 +219,8 @@ &blsp1_uart2 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_usbin {
> @@ -236,27 +236,27 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
>  
>  	non-removable;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	dr_mode = "peripheral";
>  	extcon = <&pm8916_usbin>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> index 3899e11b9843..4d627d06f87b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> @@ -91,8 +91,8 @@ &blsp1_uart2 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_vib {
> @@ -104,26 +104,26 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> index d600916a0e55..13c586079e50 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> @@ -248,8 +248,8 @@ &mdss {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pronto {
> @@ -257,26 +257,26 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&muic>, <&muic>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> index 7ac49a021563..8eb68bb6607c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> @@ -53,8 +53,8 @@ &blsp1_uart2 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  /* FIXME: Replace with SM5703 MUIC when driver is available */
> @@ -67,27 +67,27 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  
>  	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	dr_mode = "peripheral";
>  	extcon = <&pm8916_usbin>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> index d4984b3af802..34bee5211413 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> @@ -264,8 +264,8 @@ &blsp1_uart2 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_vib {
> @@ -281,16 +281,14 @@ iris {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
> @@ -309,11 +307,13 @@ &sdhc_2 {
>  	 * (without tuning), so maybe only tuning is broken?
>  	 */
>  	no-1-8-v;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&muic>, <&muic>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> index a87be1d95b14..24a5c3486beb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> @@ -145,8 +145,8 @@ &blsp1_uart2 {
>  };
>  
>  &pm8916_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
>  };
>  
>  &pm8916_vib {
> @@ -158,26 +158,26 @@ &pronto {
>  };
>  
>  &sdhc_1 {
> -	status = "okay";
> -
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>  	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> -};
>  
> -&sdhc_2 {
>  	status = "okay";
> +};
>  
> +&sdhc_2 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
>  
>  	non-removable;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> -	status = "okay";
>  	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
>  };
>  
>  &usb_hs_phy {
