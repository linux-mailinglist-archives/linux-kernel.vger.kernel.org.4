Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AF75BB970
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIQQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIQQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:36:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7253055F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:36:42 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c7so17864733ljm.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/ai+7SsL/h1KwbYitYUtAaE2JHJ2xYhMnUl9VlW5Wl4=;
        b=R193AffSliQz0TPGQUzIlMu2Ccw6tPKAks6zPn4TVzP0+kakt8Qk+7zPB88k1e9RZc
         nbLJ7FQQIp2fwTNsE1opqe+hFuBgJg4mD/5y/QERxiCde6bm2Emr6/7f8eOOXMUw4ux2
         3dKRpUBrdPHyrY1MBDONbtUPZ8oRhGrZYBW2U0ITBxPSD+NCdRpAexinOLE+sEQ7JW/P
         pqp1b7NCTZfa266w4G3qqdIv6ZVpuKsShLcZ0N5MTtjVcMlFh4ov+48E/eiowDgkVRsq
         QHtelPKutVswypicGp/17+Cr9FgSuERju++cA8RglypF5isHsEEL0COuiPnqcgtEBdnv
         VAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/ai+7SsL/h1KwbYitYUtAaE2JHJ2xYhMnUl9VlW5Wl4=;
        b=qNVUjqX/G/yBAbI80Zg7geqaZimV0U+cCkHC9HAPKAIGbQW2tat2gj2GSIN8tlmw83
         uDAY8RqqixoignzxAVFDKCauRdrVJxsH7nvkwL3kWO6L3FT5KGexLQRjM5BuRZIbOUl8
         9imwH7JIdqCxh2ZDUVfgzOPr3dX0zI+PBIMTenyiXdVYAn0jQUvATQmuOL79/1LfXOyN
         mkXuE7YIk5boorwid/tz2C3vbpiJs+B12DE/v4Kdt3VXUPRujDjhr+A/LiHGR79746Az
         x6MmK6KZ/jTvwdwsKkiZQ1Z+yCCxI0yWTxDtS2Ef8rX+4hzPns8li6+o7yRbD+AZ5PLJ
         gREg==
X-Gm-Message-State: ACrzQf0IDXLTFwF6G+vgTe3O825wSDvBqBvZqMmvAS1VmxYagqpfdWj3
        onibRMjQUX3XnFHW0fRoKapyAA==
X-Google-Smtp-Source: AMsMyM4O9nhkGk4g36ZJAGZfZMuqar3D6fO7Dhcld2L1JJ8BHSxHVSeiQOXk6iSG4KCkeq+7P+rppw==
X-Received: by 2002:a2e:a385:0:b0:26b:e6b4:6d2d with SMTP id r5-20020a2ea385000000b0026be6b46d2dmr2800392lje.507.1663432600878;
        Sat, 17 Sep 2022 09:36:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z28-20020a2eb53c000000b0025fe7f33bc4sm4212849ljm.49.2022.09.17.09.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:36:40 -0700 (PDT)
Message-ID: <50c18f2e-53d2-21b3-b36e-7a2045b96c11@linaro.org>
Date:   Sat, 17 Sep 2022 17:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sc8180x: Introduce Primus
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916121204.3880182-1-vkoul@kernel.org>
 <20220916121204.3880182-6-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916121204.3880182-6-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 13:12, Vinod Koul wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Introduce support for the SC8180X reference device, aka Primus, with
> debug UART, regulators, UFS and USB support.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

(...)

> +&wifi {
> +	memory-region = <&wlan_mem>;
> +
> +	vdd-0.8-cx-mx-supply = <&vreg_l1e_0p75>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l9a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l10c_3p3>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> +
> +/* PINCTRL */
> +
> +&pmc8180c_gpios {
> +	bl_pwm_default_state: bl-pwm-default-state {
> +		en {

Suffix -pins

> +			pins = "gpio8";
> +			function = "normal";
> +		};
> +
> +		pwm {

Suffix -pins

> +			pins = "gpio10";
> +			function = "func1";
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <47 4>, <126 4>;
> +
> +	aux_i2c_active_state: aux-i2c-active-state {
> +		pins = "gpio98", "gpio99";
> +		function = "qup7";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	edp_hpd_active: epd-hpd-active-state {
> +		pins = "gpio10";
> +		function = "edp_hot";
> +	};
> +
> +	hall_int_active_state: hall-int-active-state {
> +		pins = "gpio121";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-disable;
> +	};
> +
> +	kb_int_active_state: kb-int-active-state {
> +		int-n {

Suffix -pins

> +			pins = "gpio37";
> +			function = "gpio";
> +
> +			bias-pull-up;
> +			intput-enable;
> +		};
> +
> +		kp-disable {

Suffix -pins

> +			pins = "gpio135";
> +			function = "gpio";
> +
> +			output-high;
> +		};
> +	};
> +
> +	kb_tp_3v3_en_active_state: kb-tp-3v3-en-active-state {
> +		pins = "gpio4";
> +		function = "gpio";
> +
> +		bias-disable;
> +	};
> +
> +	pcie2_default_state: pcie2-default-state {
> +		clkreq {

Suffix -pins

> +			pins = "gpio176";
> +			function = "pci_e2";
> +			bias-pull-up;
> +		};
> +
> +		reset-n {

Suffix -pins

> +			pins = "gpio175";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			output-low;
> +			bias-pull-down;
> +		};
> +
> +		wake-n {

Suffix -pins

> +			pins = "gpio177";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	tp_int_active_state: tp-int-active-state {
> +		tp-int {

Suffix -pins

> +			pins = "gpio24";
> +			function = "gpio";
> +
> +			bias-disable;
> +			input-enable;
> +		};
> +
> +		tp-close-n {

Suffix -pins

> +			pins = "gpio116";
> +			function = "gpio";
> +
> +			bias-disable;
> +			input-enable;
> +		};
> +	};
> +
> +	ts_active_state: ts-active-state {
> +		int-n {

Suffix -pins

> +			pins = "gpio122";
> +			function = "gpio";
> +
> +			input-enable;
> +			bias-disable;
> +		};
> +
> +		reset-n {

Suffix -pins

> +			pins = "gpio54";
> +			function = "gpio";
> +
> +			output-high;
> +		};
> +	};
> +
> +	ts_i2c_active_state: ts-i2c-active-state {
> +		pins = "gpio114", "gpio115";
> +		function = "qup1";
> +
> +		/* External pull up */
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	uart13_state: uart13-state {
> +		cts {

Suffix -pins

> +			pins = "gpio43";
> +			function = "qup13";
> +			bias-pull-down;
> +		};
> +
> +		rts-tx {

Suffix -pins

> +			pins = "gpio44", "gpio45";
> +			function = "qup13";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		rx {

Suffix -pins

> +			pins = "gpio46";
> +			function = "qup13";
> +			bias-pull-up;
> +		};
> +	};
> +};


Best regards,
Krzysztof
