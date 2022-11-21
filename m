Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962F631B86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKUIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKUIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:34:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D551EEF1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:34:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l12so17714211lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYejw+k9KxJfa6Qv7Zm4NVNSTlImBJzqWTxtup6xt6k=;
        b=p5+b03NQcjEAjwwFxdx+wjvB1qxgceoMDJxwlT1qbwUVTh1DAnsh6ltatdwsE8lkuE
         HUFh6MivlQk6ozYkX8kWjdDjmjhsespIFrpd51k+XFmwhcOmYEbHYTFcvf/4TIMrHRvr
         sk4zoVRbiC/75afBZ3lEgQ4w5pnVvb6YZJfqwMHx38QL5Fyk+HPeFDK6jIB62Sz5zTXS
         JlgMsARKxLJEcmjMwYnry9woLUenX5jCyM1Oa0HktGcN+uhFS9mI+XjwG+DHzkhKIEwt
         q3VXA10Dax1RstLIYJ1gj+f7JSNjaGCEjsugooUWVUZZduCiEWUj2M+q26g5B6EsX52+
         vPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYejw+k9KxJfa6Qv7Zm4NVNSTlImBJzqWTxtup6xt6k=;
        b=5cqqYl7zTzfviXYvG0mQ/Va/dNFwEUnFlNBwz7Y50t/3kCMkqylhtt+5AGslOZoil3
         ODX1vt3P0a8RfIikEef2wdzJRUUEEY7qlMRBoj/O5ZrbaU2UAerRBPVVIMC01b7wissC
         lMACoGMjc7sF9pOhl8BHxSGFyi6e8kEuUeG+hG3K5c2cJnhLOHV8UZIx0SAgUHCPKun3
         0ohbNXJxaZ2UeNT+dqiUaav6qKf217EROvO5A9okD1+QfX3MdYelSJv5ZSsOJAXuFlaN
         5jWjusd1l4ls+vr8ez+gFvAX7ZMnQc/Okn2HKWlJ0Fg8vTWY4TAgkBPyfWyRYxphZ73F
         WArA==
X-Gm-Message-State: ANoB5pmANPz8pN1OsXa7ojnTJ2PuLLTfajvk4sVM+zjmHy6KpnzUXdKZ
        gHDH0wV8bGDTSe3sydDlclOzdg==
X-Google-Smtp-Source: AA0mqf4eL/MpEQEqX1r7hzYLk3UUuFB3FNAC2RmceF35Js7nzf6LVPqC6nxPBP/Fw53xMviFWSZeOA==
X-Received: by 2002:a19:4f14:0:b0:4b4:b20c:4b7 with SMTP id d20-20020a194f14000000b004b4b20c04b7mr124281lfb.201.1669019670875;
        Mon, 21 Nov 2022 00:34:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i25-20020a2ea239000000b002790fbb5f89sm1387438ljm.44.2022.11.21.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:34:30 -0800 (PST)
Message-ID: <1353266c-2d95-6c68-5288-c405231a37f1@linaro.org>
Date:   Mon, 21 Nov 2022 09:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
 <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
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

On 19/11/2022 17:44, Srinivas Kandagatla wrote:
> Add support for SoundCard on X13s. This patch adds support for Headset
> Playback, record and 2 DMICs on the Panel along with the regulators
> required for powering up the LPASS codecs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Thank you for your patch. There is something to discuss/improve.

> +	right_spkr: wsa8830-right@0,2{
> +		compatible = "sdw10217020200";
> +		reg = <0 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_2_sd_n_default>;
> +		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_LOW>;
> +		#thermal-sensor-cells = <0>;
> +		sound-name-prefix = "SpkrRight";
> +		#sound-dai-cells = <0>;
> +		vdd-supply = <&vreg_s10b>;
> +	};
> +};
> +
> +

Only one blank line.

> +&swr1 {
> +	status = "okay";
> +
> +	wcd_rx: wcd9380-rx@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		qcom,rx-port-mapping = <1 2 3 4 5 6>;

No improvements: Still looks too long.

> +

Drop empty line.
> +	};
> +};
> +
> +&swr2 {
> +	status = "okay";
> +
> +	wcd_tx: wcd9380-tx@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		qcom,tx-port-mapping = <1 1 2 3>;
> +	};
> +};
> +
> +&vamacro {
> +	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
> +	pinctrl-names = "default";
> +	vdd-micb-supply = <&vreg_s10b>;
> +	qcom,dmic-sample-rate = <600000>;
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> @@ -369,6 +558,14 @@ reset {
>  		};
>  	};
>  
> +	wcd_default: wcd-default-state {
> +		reset-pins {
> +			pins = "gpio106";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
>  	qup0_i2c4_default: qup0-i2c4-default-state {
>  		pins = "gpio171", "gpio172";
>  		function = "qup4";
> @@ -383,6 +580,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>  		drive-strength = <16>;
>  	};
>  
> +	spkr_1_sd_n_default: spkr-1-sd-n-default-state {
> +		perst-n-pins {
> +			pins = "gpio178";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
> +	spkr_2_sd_n_default: spkr-2-sd-n-default-state {
> +		perst-n-pins {
> +			pins = "gpio179";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
>  	tpad_default: tpad-default-state {
>  		int-n {

This won't apply cleanly. You need to base your patches on recent trees.

Best regards,
Krzysztof

