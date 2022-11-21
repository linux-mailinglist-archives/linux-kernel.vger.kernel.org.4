Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE51632FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKUWcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiKUWcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:32:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A41DDFAF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:32:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x21so16004688ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72FmKroozXGXFSVLROV37Pyi3BIUygUiEj+6BEtiieE=;
        b=VzpwF/89nL23FzIZrtNY0j/sND6WP6P4LEOFXwtY6GDuh87OXSBK1wbA+TlZW+Q62S
         7h7EOU+lgbtfZgWhZNjE4yA3rOWmw9u+ES/TAGBWgJxqRkoh0sXCXeGJ9n2whom5Pr57
         IOrGgMwjVCniSQy5l+R7MPQa+Zs7kgDG1jhee83rMVoIDoSHfos/DtUJgy0E3sqc99pi
         Li+hkC7cU2XzECQhlBphW/KloGC10GgBsYOQ7fqV5xXhc9MaPZSCseXAzj/vq1DmmNzu
         SUIBdqyyjGv3mBk2IDfaCE9AyWHqGXg4Fb8bZsFpW1FjaKPTuN8ZAp0Tsi0tYD1A6Na1
         k26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72FmKroozXGXFSVLROV37Pyi3BIUygUiEj+6BEtiieE=;
        b=iEFM51E1ifOf1traVtF7O6VkFKCD/jbS9BFKm88zBThJ2r+xrMW30ijg4fNJQ9vZOy
         /UZTomOT2kARHltIj7ukkWAXx6ykx8os/V/bzvrl6PT5ckEg/yImKe0icGvpBiOVs5jT
         9DMsS6PTo9EPs3LVLtzkiY8/uuTAkBWbNFIGpND8Cabb2m54OqJyrGukC6X8aVOGcWFb
         gvZb1Ue51gEj+ZW51llP8+ecmnP7YDhZPR6gHIV4lYZ3kF3yXyCx1ZkcYjm8ZOBc7qzW
         p+eLcGVKOY9MsnErsvtRweQGUTHH2Aswm4x9PMOm2Jh7ZoTwGCk0641GWBbNSuCZX1Hv
         LlaQ==
X-Gm-Message-State: ANoB5plKR2ugrWXp0F+G0DoXRGy3X9+27HYpvGtev9m2OneaH48/ePqy
        x1NqgJ6iB0Frbam9zdiKhGhU1A==
X-Google-Smtp-Source: AA0mqf4eOQvprEGtE4HcBGCWu5pBQWUfsa1hwG9jDC5PPbV7mAO6uruXGJQJNbhDE08533P3egx25w==
X-Received: by 2002:a05:651c:c8b:b0:277:f8b:bb4f with SMTP id bz11-20020a05651c0c8b00b002770f8bbb4fmr724534ljb.161.1669069944003;
        Mon, 21 Nov 2022 14:32:24 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id e15-20020ac24e0f000000b00498fc3d4d15sm2186894lfr.190.2022.11.21.14.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 14:32:23 -0800 (PST)
Message-ID: <c6f52e13-3692-5739-eabd-550936f34bed@linaro.org>
Date:   Mon, 21 Nov 2022 23:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] ARM: dts: msm8974: castor: Define pm8841
 regulators
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121212226.321514-1-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221121212226.321514-1-luca@z3ntu.xyz>
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



On 21.11.2022 22:22, Luca Weiss wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Define the pm8841 regulators under SMD/RPM, to allow the modem
> remoteproc to set the voltage during boot of the remote processor.
> 
> Entries are just copied from the Honami dts.
I hope it was supposed to be "identical to" and not "copied and hoped it
would be ok" :/

Maybe I'm a bit picky, but I suppose this is said in a misleading way..

Konrad
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * new patch in this series
> 
>  ...-msm8974pro-sony-xperia-shinano-castor.dts | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> index 3f45f5c5d37b..2c33f84a6e4e 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> @@ -319,6 +319,30 @@ led@7 {
>  };
>  
>  &rpm_requests {
> +	pm8841-regulators {
> +		compatible = "qcom,rpm-pm8841-regulators";
> +
> +		pm8841_s1: s1 {
> +			regulator-min-microvolt = <675000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		pm8841_s2: s2 {
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		pm8841_s3: s3 {
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		pm8841_s4: s4 {
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +	};
> +
>  	pm8941-regulators {
>  		compatible = "qcom,rpm-pm8941-regulators";
>  
