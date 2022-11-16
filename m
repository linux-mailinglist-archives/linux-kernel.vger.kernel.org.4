Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9786662B545
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiKPIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiKPIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:31:45 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA3B2A70E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:29:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a29so28354028lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOjQ8ZqJCJ4XjyB8rqTKWkM81Yey0vtzEtDeEu0P90I=;
        b=ddQzH/c2j2Si8AIuiK1A0Rq1ixXSilknotZ052ApAz7qYx9AV+DoM07IK4rHpZFrUy
         sy/B8x0Y38ioefWRDHtuYSuioS2LzeZqfFeob32keLihp0F/Xy3RzMo7BIuq2Wx2pBhk
         XkjbdberdCUJXyB5BgWf1HuPpVnRI0mpNcmCll6Uvjk2X4xO1QY/IpvH3r++aa7pev12
         Juh57ArZguG+lA8VDe/w4FPfAGN+p8oILuuU5n950cCaVi1muIXyZ1QCmr3b/vwsHR0J
         SnL/Zmme82PHBh2IHfi9g5a7ZgmDwvkx08SxceQEIDe/xMa9JubBjjt5QIaOSW7nfXT3
         sTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOjQ8ZqJCJ4XjyB8rqTKWkM81Yey0vtzEtDeEu0P90I=;
        b=mfKDM4OcjcSSZMOVLUEe3k5QIkNoKb6e4K0BUPd65k42p7+v22Q16n1qzWyTilJ3Mn
         f+5zbDQDsv7KhuuQAEWUA57kjRvXokS/U2EYbQgtB1kHlI2aPRz3gETK3W5FGJsL3QjD
         mx4JgZRFTn7GyFRrCZsoLaPhrpNZODB1Wig1QerCtLCPQJj+z4vQdSr+Pz5JT22/0o3V
         Pl6z2U+XbIhLrKHCq/2pi80fcVpruPVXoq+Jfj+/GVtdM3OoKvy1DMjoRjdLXnQcpoLB
         Yo9Vf2TqFW2WsCZgK20pXtOzFOuYjdM/1sDvc/uO7drWia+BOwnejpu6oUvmrJnT5tt+
         9tqw==
X-Gm-Message-State: ANoB5pmwlCwWfR/+/LNbUe6Yyg0mWy6EfLTnBrsoJh/7V9SqiJK80s9w
        8dxzMyTVcpygrd25LyBUTColCA==
X-Google-Smtp-Source: AA0mqf7rULVHcsf3HCvYdqj87GhYFRO63xMUx9uE9UbMvF2N35rMtDdJ3PniuUJlyYcTUYRDVJUddw==
X-Received: by 2002:a19:5051:0:b0:499:8e29:2763 with SMTP id z17-20020a195051000000b004998e292763mr7780310lfj.137.1668587344089;
        Wed, 16 Nov 2022 00:29:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w26-20020ac254ba000000b0049c29389b98sm2490272lfk.151.2022.11.16.00.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:29:03 -0800 (PST)
Message-ID: <7083614f-578c-7ed9-5f6b-c64718747dea@linaro.org>
Date:   Wed, 16 Nov 2022 09:29:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
 <20221115172828.14372-4-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115172828.14372-4-konrad.dybcio@linaro.org>
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

On 15/11/2022 18:28, Konrad Dybcio wrote:
> Adjust regulators, add required pin setup and finally enable SDHCI2
> to get the SD Card slot going on Sagami Xperias.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index a428ce31ab4e..fdf95b763cf4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -312,7 +312,8 @@ pm8350c_l8: ldo8 {
>  		pm8350c_l9: ldo9 {
>  			regulator-name = "pm8350c_l9";
>  			regulator-min-microvolt = <2960000>;
> -			regulator-max-microvolt = <3008000>;
> +			/* Originally max = 3008000 but SDHCI expects 2960000 */
> +			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> @@ -558,6 +559,19 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_active>;
> +	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_sleep>;
> +	vmmc-supply = <&pm8350c_l9>;
> +	vqmmc-supply = <&pm8350c_l6>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
> +

Only one blank line.

Best regards,
Krzysztof

