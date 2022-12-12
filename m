Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7164A797
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiLLSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiLLSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:51:11 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71C186D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:48:52 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h10so793238ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZS2AFgbeUqbIyP+vspk/7zGGQh523qi91eWgk2+pE=;
        b=mh2mMApK/v/DCOdDC/e9YBRqOUf6HnCOJPs29ijhdu8YOGGTAc1qW7GRtqnfGn+Z5s
         DvgsKNgx65roIYwQsnXBy1aHurvg3TZoTYvSknprl2xRx+JFRf+Uz2JD70ptKczO4EzI
         Wig3h3LWGg+mjm8fPszUCoKer85CY5m5h9e9u8eZZi7a+Dz0G78vY3cAnoKaPJIC1H1V
         F+lm98E9Mpro7/5tLMcLOwxduLu/zPXtCVlPtuJmwT0c7hNupdJuJrdKYHBqeYww5J5F
         Zlx5abNmf3LqwZZEhDs84LJIqDgRz26HhBvZkfaIKTy0a0w2k91EGbofaRU4eN5PerXF
         2P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZS2AFgbeUqbIyP+vspk/7zGGQh523qi91eWgk2+pE=;
        b=3iQ+ptUE2CGqvN4vGju9HadRm//lv/8OSbn/+C+NBFlEHkQBLu3iYRd3TxlzNt3WBR
         WMBjKXQaF1hCuZrF7Z4/aSZRVyMKs5rRsW7R9MUGkyvJlrEvsvTlmbBYakcs3aMTby8T
         JncbIzwJGK28jeOZ49vD6EIJvZodXMC158wTOdktJOhmNVGQMmFYXDxR88fxSnFfV4/e
         v5L08UjJJl9c7b35G3ErMrWSnQ5gDYN8lEDdqaE95SVi5Z8B1tocQphhlo8y495axvvv
         RFSb5efOs/gaWIJkj2LZ2ifLBZAERVwlQgOOsJOe45oxyak/Pmt4eLTJZLA4c9mtA2ut
         Ppmw==
X-Gm-Message-State: ANoB5pmOuFJMGKnlxQhh4ttNPGrhz9vapyU683vJfNFirjl/a2UtWUrb
        kjFLU8+CLSaz3ROccSkkqXiMFw==
X-Google-Smtp-Source: AA0mqf78O+abfksMWJHo7jefNo/CTbXNSgyYKih0mcpFTWplw5xsRH0KzjV6ld2EOCXpMBA9xr9ypA==
X-Received: by 2002:a2e:be85:0:b0:26f:db34:a151 with SMTP id a5-20020a2ebe85000000b0026fdb34a151mr5515664ljr.20.1670870931208;
        Mon, 12 Dec 2022 10:48:51 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id 11-20020a2eb94b000000b0027776efa48csm56327ljs.91.2022.12.12.10.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:48:50 -0800 (PST)
Message-ID: <e3c49e2a-3439-8016-0b39-e16068aa78a0@linaro.org>
Date:   Mon, 12 Dec 2022 19:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, quic_shazhuss@quicinc.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212182314.1902632-2-bmasney@redhat.com>
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



On 12.12.2022 19:23, Brian Masney wrote:
> According to the downstream 5.4 kernel sources for the sa8540p,
> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
> also match. Let's go ahead and correct the name that's used in the
> three files where this is listed.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 6 +++---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 551768f97729..1ab76724144d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -326,11 +326,11 @@ &qup2 {
>  	status = "okay";
>  };
>  
> -&qup2_i2c5 {
> +&qup2_i2c21 {
>  	clock-frequency = <400000>;
>  
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&qup2_i2c5_default>;
> +	pinctrl-0 = <&qup2_i2c21_default>;
>  
>  	status = "okay";
>  
> @@ -598,7 +598,7 @@ qup0_i2c4_default: qup0-i2c4-default-state {
>  		drive-strength = <16>;
>  	};
>  
> -	qup2_i2c5_default: qup2-i2c5-default-state {
> +	qup2_i2c21_default: qup2-i2c21-default-state {
>  		pins = "gpio81", "gpio82";
>  		function = "qup21";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 568c6be1ceaa..284adf60386a 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -531,11 +531,11 @@ &qup2 {
>  	status = "okay";
>  };
>  
> -&qup2_i2c5 {
> +&qup2_i2c21 {
>  	clock-frequency = <400000>;
>  
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&qup2_i2c5_default>;
> +	pinctrl-0 = <&qup2_i2c21_default>;
>  
>  	status = "okay";
>  
> @@ -801,7 +801,7 @@ qup0_i2c4_default: qup0-i2c4-default-state {
>  		drive-strength = <16>;
>  	};
>  
> -	qup2_i2c5_default: qup2-i2c5-default-state {
> +	qup2_i2c21_default: qup2-i2c21-default-state {
>  		pins = "gpio81", "gpio82";
>  		function = "qup21";
>  		bias-disable;
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 109c9d2b684d..875cc91324ce 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
>  				status = "disabled";
>  			};
>  
> -			qup2_i2c5: i2c@894000 {
> +			qup2_i2c21: i2c@894000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0 0x00894000 0 0x4000>;
>  				clock-names = "se";
