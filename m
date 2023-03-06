Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC36AC439
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCFO77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjCFO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:59:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA372119
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:59:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r27so13091698lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UB5v2RX+j52KB6eh5rlkxpiYT0kxV2odW5AsLehylHE=;
        b=JkJQoAEOoT0EJWvMUm1p3O4ILrW2MG0eY0nRCc/uZtDAhje7A4Nk8wXJiVgAdiVnZ3
         0hwKwd2y4O7a/MG22pbqL9jWkqT9wG+T/EiF9n/gECbnWRvXB6x/PjD1Zh1wEojlXtR7
         WdNs41QHNiz9QhTVS2Th46wy6gb8XVftApjXz1BhTR3wtvSTXmVf+Fqss1YzfYJgrPm0
         IH6gGnwhGIUMbqMLIc+enpxaAyMQb1eVi5jPG4vtTO0bOocu51uAvojNqC2i4W3hy0SJ
         Qpy0xDbFiy4wRb5dmOk1SRq8Fcd3TzmTPLQdSTqWxNZMjsvCSkembelaJIlxoXVMu4F6
         wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UB5v2RX+j52KB6eh5rlkxpiYT0kxV2odW5AsLehylHE=;
        b=OjYWHd4/dCxTnafY7E7kXr3rM0ifZFv19NszCcD/NR4mR9WOXWpzmMB7DkORYgZ6mP
         a3Kpxj4OoidmwO0aVYZDV6Afq7QFFq12bO027Kk+z04SQh1HsiNcYSxd3ej1L8RpIwOr
         infvQijO6gUhspgzdndZNkb/upjyyl3aTQQ6ml1tPsXmMe/B3KzGLny94mhhE/zKzP9y
         Zc48F7J/PzQ/ANNolmTTnFHlSs2T0okyiPcdPjoi5PfyRqQQmP87vXARLvPXV5k8Wa0g
         opsN6IbWIWLugZ145i8WLMOr7m2ZV2sAL6ufaSqZEvji2gppzBvsg9jLfApmC944fzLW
         0MPQ==
X-Gm-Message-State: AO0yUKUOpNeqHpkWnCY2iHgmn9pHYG/Y7uES9tN55CPUhxZqvyGjFYvI
        8BbBmQ0MR2GuMfZ9OEgtYAZC7w==
X-Google-Smtp-Source: AK7set8ZWbOUzo0DgO03QfQEkl1/WMQa53Pglmv1mYEyANP/ITwKFhpjwVwPfYjweW6jSea/GJ+wUw==
X-Received: by 2002:a05:6512:503:b0:4ae:8476:2df with SMTP id o3-20020a056512050300b004ae847602dfmr3021287lfb.10.1678114773354;
        Mon, 06 Mar 2023 06:59:33 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x8-20020ac25dc8000000b004db297957e8sm1689120lfq.305.2023.03.06.06.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:59:33 -0800 (PST)
Message-ID: <de02c8af-7e20-a67c-a314-2944d755ec43@linaro.org>
Date:   Mon, 6 Mar 2023 15:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: sa8775p-ride: enable the BT UART
 port
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230216125257.112300-1-brgl@bgdev.pl>
 <20230216125257.112300-10-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230216125257.112300-10-brgl@bgdev.pl>
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



On 16.02.2023 13:52, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the high-speed UART port connected to the Bluetooth controller on
> the sa8775p-adp development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Same comments as in the previous patch.

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 33 +++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 6f96907b335c..1de3b9d4a05a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -14,6 +14,7 @@ / {
>  	aliases {
>  		serial0 = &uart10;
>  		serial1 = &uart12;
> +		serial2 = &uart17;
>  		i2c18 = &i2c18;
>  		spi16 = &spi16;
>  	};
> @@ -89,6 +90,29 @@ qup_uart12_tx: qup-uart12-tx-state {
>  	qup_uart12_rx: qup-uart12-rx-state {
>  		pins = "gpio55";
>  		function = "qup1_se5";
> +	};
> +
> +	qup_uart17_cts: qup-uart17-cts-state {
> +		pins = "gpio91";
> +		function = "qup2_se3";
> +		bias-disable;
> +	};
> +
> +	qup_uart17_rts: qup0-uart17-rts-state {
> +		pins = "gpio92";
> +		function = "qup2_se3";
> +		bias-pull-down;
> +	};
> +
> +	qup_uart17_tx: qup0-uart17-tx-state {
> +		pins = "gpio93";
> +		function = "qup2_se3";
> +		bias-pull-up;
> +	};
> +
> +	qup_uart17_rx: qup0-uart17-rx-state {
> +		pins = "gpio94";
> +		function = "qup2_se3";
>  		bias-pull-down;
>  	};
>  };
> @@ -109,6 +133,15 @@ &uart12 {
>  	status = "okay";
>  };
>  
> +&uart17 {
> +	pinctrl-0 = <&qup_uart17_cts>,
> +		    <&qup_uart17_rts>,
> +		    <&qup_uart17_tx>,
> +		    <&qup_uart17_rx>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
