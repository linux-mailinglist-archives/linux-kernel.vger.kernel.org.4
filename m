Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AB65B05D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjABLOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjABLO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:14:29 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63F62CB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:14:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j17so31679441lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jt0wCG03tGFVNQOZNggM83RnxWMauNZ2iVmL0QtApec=;
        b=E/5/hfGI8HwxHW9PrjHCGcdrb54WpLWDfCkchCWa3oQyRCmkzFtj9LwmnXh37qZulx
         OD4+MBnog8fFQ2CAvh0F0YLCTZ51mZBRVSpU2JANrDrLDw9sEg2ahTGR9HPJzP46RiAk
         oaM1LhjZ/Wilzl4x/vI9aYGTxCn/Tra2vNEIpHKT+AcQQjUg/M9dDE7u71wUhFdtPhaX
         WJLbQC1IFpAcZPoU1zkrAWcBQvOHTnZwmRjTjGWAJ9xW5b0Hrv/gNmp4jaq2vw6sGkd1
         A7PMvWPZLT3McUDbTWYxAcdFkBtHq036H/eNx52Dqtm5DUxhZlIwQZS+uUimsCKAQIod
         qqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt0wCG03tGFVNQOZNggM83RnxWMauNZ2iVmL0QtApec=;
        b=jMvBRw3zgxQuKlSq2CFig4AmmB6FOlkQL91jSnzPXX4yd6WJckU/fAttkUTkGqU/st
         2/i7ISMMqIPezqKinkrJOY/qj/StISepUr/X8NN+r+9n7MTXFrgG1TFpQ0zBQeHIPQcq
         /kyHEWDQjhfojrw3E+L/Mf/osos/TvpV0qNL/Iqx9AUOXRSYPg596VXj5CVl46ZlwbU7
         64t4HUjzVcljVbfBoUvPmVGUI0/csdhBPbVWmPW3tBPiQeCJraFSIUMbu45CbkriqvFI
         5KQDotNnS1dYh+OacoDNf+Wx0t4f4Sh3sEZvCreyaSf8zdYZdlU70Y4F6mzr9RARp3uC
         a0Yg==
X-Gm-Message-State: AFqh2kqYWM3GcsL+/N8zJYNBp6yjjt3vuHTMApBiQt9Eok55UTv9Nhn3
        Sjek149+DFcvlC+6IQc8ILcsBg==
X-Google-Smtp-Source: AMrXdXvwXcOY1obeuIZVkrEgCEXjiZE0pmZkvu/ptTyd1xiaThKWMUknh+BWrHJj1FptOjObtMDIvg==
X-Received: by 2002:ac2:5606:0:b0:4b6:e493:b798 with SMTP id v6-20020ac25606000000b004b6e493b798mr12608880lfd.68.1672658066995;
        Mon, 02 Jan 2023 03:14:26 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o10-20020ac24e8a000000b004cb1e2f8f4dsm1690661lfr.152.2023.01.02.03.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:14:26 -0800 (PST)
Message-ID: <b579ea50-1edb-7291-7eb5-da6d462bbda8@linaro.org>
Date:   Mon, 2 Jan 2023 12:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sc8280xp-x13s: fix wcd938x codec
 node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-5-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230102105038.8074-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 11:50, Johan Hovold wrote:
> The wcd938x codec is not a memory-mapped device and does not belong
> under the soc node.
> 
> Move the node to the root node to avoid DT validation failures.
> 
> While at it, clean up the node somewhat by adding newline separators,
> reordering properties and renaming it 'audio-codec'.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 54 ++++++++++---------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 97ff74d5095e..ae67c11bfc22 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -21,6 +21,34 @@ / {
>  	model = "Lenovo ThinkPad X13s";
>  	compatible = "lenovo,thinkpad-x13s", "qcom,sc8280xp";
>  
> +	wcd938x: audio-codec {
> +		compatible = "qcom,wcd9380-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
> +
> +		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> +
> +		vdd-buck-supply = <&vreg_s10b>;
> +		vdd-rxtx-supply = <&vreg_s10b>;
> +		vdd-io-supply = <&vreg_s10b>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		#sound-dai-cells = <1>;
> +
> +		status = "disabled";
> +	};
> +
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pmc8280c_lpg 3 1000000>;
> @@ -628,32 +656,6 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
>  
> -&soc {
> -	wcd938x: codec {
> -		compatible = "qcom,wcd9380-codec";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wcd_default>;
> -		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> -		#sound-dai-cells = <1>;
> -
> -		vdd-buck-supply = <&vreg_s10b>;
> -		vdd-rxtx-supply = <&vreg_s10b>;
> -		vdd-io-supply = <&vreg_s10b>;
> -		vdd-mic-bias-supply = <&vreg_bob>;
> -		qcom,micbias1-microvolt = <1800000>;
> -		qcom,micbias2-microvolt = <1800000>;
> -		qcom,micbias3-microvolt = <1800000>;
> -		qcom,micbias4-microvolt = <1800000>;
> -		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> -		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> -		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> -		qcom,rx-device = <&wcd_rx>;
> -		qcom,tx-device = <&wcd_tx>;
> -
> -		status = "disabled";
> -	};
> -};
> -
>  &sound {
>  	compatible = "qcom,sc8280xp-sndcard";
>  	model = "SC8280XP-LENOVO-X13S";
