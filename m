Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B281365B066
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjABLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjABLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:16:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6B6356
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:16:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so41162310lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nNJE27UFSVYT9QWUr/Yq5NlT4xBOUzY+RpF8vfGt8A=;
        b=cDQZkz4VTKIlJmwOou1MCRvVmgzEIx2pBw3qLRzPt7fdy6IfqZV6mJY6m6vh+e4TBL
         LyTRWFdnLggNV+8niQYxlw19NCfGzDSy0+lfeuQF6U1AkoIvExpUJR1A4zBqsmWXgp2N
         UqR60JMePi4rd3LjwL+h6mKDX2zX6WI5TQOpPvSgs3WY9RPKwLxWDw36XzR7FbBCYpdn
         LDhC3nw4nZ+4OtDHMfU4c28CoTNQM73dvgoyrVhIB2ABH4ABYAzKtfLKOCsFWvvxUMn0
         hFhagDP4OFQ2CqpIkraJGzy/YIVWkr70qo3N3tMMIJ2bH+/rI0o0OecHNeIJ+FGe3Ko2
         c/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nNJE27UFSVYT9QWUr/Yq5NlT4xBOUzY+RpF8vfGt8A=;
        b=u+oKrz6SAAw3F0T3EsMEmzNNBeUfc9EbdbACSN+F2cXc+215mu9f0+R61AgQk0JD8j
         70cpU1KVgJH0GY8f0eQper0GUVl3ZBU92HO5xGOYg6CqGX/nBKp1i0x+W3WcTKp5i35g
         srzZaG70o/DEKybhwtqWHv+uC4m0LP6Rmpjv+DALihELjhox3+D+OeBasrXBkjaAedNL
         Kv6hfN7iSiVky5cvwvS2uLX8UA+XWC12vgam+OvxqFqVnXl2mBNixjcNlCHQsetmg8It
         XWaMo++hZZh6taNz8YS0IRxLOwzRuiIdbrIXCD/1vSr9sjhE5uJbU4Zgnk8NmpWgQVDr
         CNgw==
X-Gm-Message-State: AFqh2ko2eH3PaNCZ5VYrquAMbVTT49LHP0iAdh7aMX0FKc8NMfeBfD8u
        MXxDCiEZGQ86Zy65Jun2JO5c2Q==
X-Google-Smtp-Source: AMrXdXsARwZ2D/GSWiU2/jf4ewnDCZQzLd6Fiplz47PEFhPkmSRKSpUlvvtWuVosNN8AMowDnjYjeg==
X-Received: by 2002:a05:6512:2284:b0:4b5:634f:9b93 with SMTP id f4-20020a056512228400b004b5634f9b93mr13244402lfu.18.1672658206598;
        Mon, 02 Jan 2023 03:16:46 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24351000000b0048a934168c0sm4430166lfl.35.2023.01.02.03.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:16:46 -0800 (PST)
Message-ID: <6447bb2f-0ef1-a8a8-4b94-875e16954ca6@linaro.org>
Date:   Mon, 2 Jan 2023 12:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230102105038.8074-7-johan+linaro@kernel.org>
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
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Third patch concerning the audio codec and third different
order of properties :/ Please consolidate that.

Konrad
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 4de3e1f1c39c..217b2c654745 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -17,6 +17,31 @@ aliases {
>  		serial0 = &uart7;
>  	};
>  
> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
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
> +		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <1>;
> +
> +		vdd-buck-supply = <&vreg_s10b_1p8>;
> +		vdd-rxtx-supply = <&vreg_s10b_1p8>;
> +		vdd-io-supply = <&vreg_s10b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -407,33 +432,6 @@ &sdhc_2 {
>  	status = "okay";
>  };
>  
> -&soc {
> -	wcd938x: codec {
> -		compatible = "qcom,wcd9380-codec";
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wcd_default>;
> -
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
> -		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
> -		#sound-dai-cells = <1>;
> -
> -		vdd-buck-supply = <&vreg_s10b_1p8>;
> -		vdd-rxtx-supply = <&vreg_s10b_1p8>;
> -		vdd-io-supply = <&vreg_s10b_1p8>;
> -		vdd-mic-bias-supply = <&vreg_bob>;
> -	};
> -};
> -
>  &sound {
>  	compatible = "qcom,sm8450-sndcard";
>  	model = "SM8450-HDK";
