Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EE6AA9A9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCDM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCDM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:58:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABB20065
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:57:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a32so5014197ljr.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtDlYoBhyC7slXDQwy9Ex6gPgK7sgUjZKuAt4o5uWag=;
        b=wd4oXqCbYcZwBEP7PavW7RiuBpBgPNvjpX8ssrJB5uHElZ2Rpianelwdhw2bJ3UfQt
         PQYwV1PuAC6ZrZm+QVjvv1HEbMNgagoE+sKiNMyzE/AEsSCsse3svTI5BJa5bzrF/Vx3
         hjs5vv2oLeLKpxU90hYoeiHg2bsSZhhb7yLADgHhgGars19Qd33RJpM8wWntdL0PayUi
         Har5CyLDOFty4B60DHa5aKwYD44L0U/03R/Qk5YFvvWSM+O3YLJStp0e/gGWwSctbML7
         dWTVI1/rbSL9t3gZ2GnvEVZRPqPVZ8eHuWn8v5FO6NztBysRX+9lhzv+1UZuZxafSFTv
         SSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtDlYoBhyC7slXDQwy9Ex6gPgK7sgUjZKuAt4o5uWag=;
        b=UpjuBNKWqbGENo8KKaLFSaSeeEdDRMHzYoslVcNZdAurJB7zTW+6wlKWIlCPSWUTaF
         /JEdxnb8IC5pQPPpzmZ8r2t0Y7AV1hQ68b5RIp++EYLPDttOtznn6/6jlLRN0AaTVrWH
         rEH8EMkzBpNV2hMxQmtV08UP2HF7YoEO4YcK/m3YLS5KjpboTPaZHLwIiL2iZQNmtP/K
         Rqt3fGahl7STRBXRR7yrnzSsvTGGofm4jAcwytcnclo0NHW95RyrxQKddZxil24kKLFS
         TZSd3SfeAW60iTsDrLpkCc/+lEZcl46yYp6M2bHX79oibpPFNLi+UcSzjpcx8RnY+u+e
         nLbw==
X-Gm-Message-State: AO0yUKVBfoc2OcIy9twObfFT8Vi4NtGFCv5G/TLs72y7qW6ZdGkyDgM/
        ySRxM6FnCpW/FK22HAd/DipYBEA2qDNjl+dRDOI=
X-Google-Smtp-Source: AK7set+tY6mNqQmc1K5OVm4RA/ouR2k0GO4nVqN2umxSySQYJxq6pyGGWLQ8eVGvTXl4FmIg8p5sCw==
X-Received: by 2002:a2e:9a8a:0:b0:291:efae:a49a with SMTP id p10-20020a2e9a8a000000b00291efaea49amr1545851lji.13.1677934657400;
        Sat, 04 Mar 2023 04:57:37 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x7-20020a05651c104700b00295b588d21dsm770480ljm.49.2023.03.04.04.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 04:57:37 -0800 (PST)
Message-ID: <529f18fc-1828-f2dd-3e2c-9caf23809fbb@linaro.org>
Date:   Sat, 4 Mar 2023 13:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/8] arm64: dts: qcom: sdm630-sony-xperia: correct GPIO
 keys wakeup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
 <20230304123358.34274-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304123358.34274-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.03.2023 13:33, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property:
> 
>   sdm630-sony-xperia-nile-voyager.dtb: gpio-keys: key-vol-down: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index e52580acd5c8..2ca713a3902a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -112,7 +112,7 @@ key-vol-down {
>  			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <1>;
>  			linux,code = <KEY_VOLUMEDOWN>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			debounce-interval = <15>;
>  		};
>  	};
