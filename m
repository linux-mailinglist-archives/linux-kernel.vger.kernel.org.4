Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F165B204
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjABMZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjABMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:25:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6756149
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:25:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so41371598lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYvKlUi/RDW5YivL0q5FxoavIC8zWsKG2TbgeF8z0Dk=;
        b=N3zSbUCzojODVcBQSEAkuAzab0qQQCQRReSOSIhh3zYlmXGbjwDX9ttMda7ExykkUO
         1Ygl/sfIde2u5jx9nKbpROTq9dARRjzJRAoST9m847CIaDKDCdCepaiE2a4JC38WTxAY
         FVIpktGpELdoPtPDmJfBPqGchvAYqGZ6xXoyP1cYOZo9WnUtYJwZ1iOPq67So7dbKhs+
         kK6aFv97hk6XR1SV767P+2Qw3Yl/FwaomvEn/hmS/FQ0JvlnbTSQmBUrCJNz5c5+eu1Q
         yxKOJrhB91Q6bW1zWYGaCnQ6hx/Da4A6CFCasnsI2PwktjGVgStMy0ms4lA/0jVyY7Hb
         Rfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYvKlUi/RDW5YivL0q5FxoavIC8zWsKG2TbgeF8z0Dk=;
        b=mmqvHNyxH6d1I9qTXO5ATCqmc8x8rKWzh2PXbRV6YY0//sIVF2k4f0Va1OiHJBJke/
         TYo/fNPRWK+JcEbPuC8ttZyrp/eBAlO7iAoR9DwbRqgBZQd4nJp0NpEcRB3OT6/D74wg
         qkujMjws3oJPpaE3vGmTgxJyzRbcj0AcIKKPCrDf1DAZR85XeqTCli2ETdh8ymIhp1b9
         4Srovznw+IlBd6mSJhM1mOKvYSuRhA6HfoC905LtQTvTSRankG/uzZcpJPJHEtcvIwrA
         PfsUCEVoiGBQofh/YZEbRs1EmSr7CX3hYqDQTwjRnWhkNJAEquAJWpLxIEBLRcgW1r95
         vjyw==
X-Gm-Message-State: AFqh2krDA/NGeHlLB0uTBuymlZb6voRpUZY1UyeAjxJXOGaHrOIDTZ4X
        uWrkcU1qY0cQ3Emn6XvsxwCg6Q==
X-Google-Smtp-Source: AMrXdXs7v3IcnmwVzB84sKMo0bv9edKcpGwHDPhEehknj6tOJg44ikFYYYFlWcbUrBlZvUOCt1Abgg==
X-Received: by 2002:a05:6512:2a98:b0:4b5:23c4:ab1a with SMTP id dt24-20020a0565122a9800b004b523c4ab1amr11250052lfb.42.1672662340549;
        Mon, 02 Jan 2023 04:25:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m1-20020a197101000000b004b094730074sm4451207lfc.267.2023.01.02.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:25:39 -0800 (PST)
Message-ID: <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
Date:   Mon, 2 Jan 2023 13:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102105038.8074-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 11:50, Johan Hovold wrote:
> Driver support for the X13s soundcard is not yet in place so disable it
> for now to avoid probe failures such as:
> 
> [   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
> [   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
> [   21.221104] platform 3210000.soundwire-controller: deferred probe pending
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 0201c6776746..97ff74d5095e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -649,6 +649,8 @@ wcd938x: codec {
>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>  		qcom,rx-device = <&wcd_rx>;
>  		qcom,tx-device = <&wcd_tx>;
> +
> +		status = "disabled";
>  	};
>  };
>  
> @@ -669,6 +671,8 @@ &sound {
>  		"TX DMIC2", "MIC BIAS3",
>  		"TX SWR_ADC1", "ADC2_OUTPUT";
>  
> +	status = "disabled";
> +
>  	wcd-playback-dai-link {
>  		link-name = "WCD Playback";
>  		cpu {
> @@ -731,6 +735,8 @@ codec {
>  };
>  
>  &swr0 {
> +	status = "disabled";
> +
>  	left_spkr: wsa8830-left@0,1 {
>  		compatible = "sdw10217020200";
>  		reg = <0 1>;
> @@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
>  };
>  
>  &swr1 {
> -	status = "okay";
> +	status = "disabled";
>  
>  	wcd_rx: wcd9380-rx@0,4 {
>  		compatible = "sdw20217010d00";
> @@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
>  };
>  
>  &swr2 {
> -	status = "okay";
> +	status = "disabled";

That's a double disable.

>  
>  	wcd_tx: wcd9380-tx@0,3 {
>  		compatible = "sdw20217010d00";
> @@ -781,6 +787,8 @@ &vamacro {
>  	pinctrl-names = "default";
>  	vdd-micb-supply = <&vreg_s10b>;
>  	qcom,dmic-sample-rate = <600000>;
> +
> +	status = "disabled";

That's a double disable.

Best regards,
Krzysztof

