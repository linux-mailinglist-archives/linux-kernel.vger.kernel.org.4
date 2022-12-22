Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12D65468A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiLVT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLVT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:26:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E4DFC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:26:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z26so4150812lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JqeEZSd1UOcPM/zfA1+Eb3uLCWIXgqtqwd++CBjCb8=;
        b=q+eYALM+vYHR5TGJ0/I7KCyKn3Swa1KZYqvFwBCci62j6wcF/iGjzYLz3I/vMe5W34
         3XLhMGt2YTyIIYgLmy38wh/q2x5iZd70R//9rUzqqMYiWRR7DUGL083K84iLZ9oyJifh
         7ZIwTvKEAAHG+/wiJSClvHKZmVR/Sr5M+wkJyTvpnvUIJSUimFzzj2Cwbz2uNdeXy6EN
         Fk0HEaC7P3vLvAhZ/6amdAQ6JYj662Ah35Lg6QkuMokGpVfi1+AjLPtDmYoVrKHuP64F
         UmENGKULJ6isqUg8UFLOIT+lHLxH2I//Y+R5q8STUZhdS4BQp5xcq1ZcNTQLz5jr/EL+
         f8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JqeEZSd1UOcPM/zfA1+Eb3uLCWIXgqtqwd++CBjCb8=;
        b=1a32R7K/sbEKSr0XeRwSTG9tI0u9CNcQpci6rDkr9Nwp/GHhlDc6HRhy9ZfIIv8cXy
         2AsB207mY5+rhpw8G+Z0JgdxpVN5Ejrka8En6WpUXZWrEOTKqxwmw4GEDgga6s2yYijJ
         ja6m2tjsY6nFr+kfmgNeLKbDmshePRBECNVeTJmmKwQ2d/7J4qomIuyVDAjRfxdkVd/l
         us6IhVIerCE8/zNltKTjEqcFYK3CxS8hFA+AUV4pl2L481T8OB8YJzm2H3pDMKLy26rb
         l2gRh3456SsN2cnCBexlXcL51qheqop6Dz/QzLtPzr2o9a7sR67EGCt9Y/23cxsDw+Xj
         Zsiw==
X-Gm-Message-State: AFqh2krNwCedxLpHtH5I5vSim2abwEBTTckQ1FXXXJHV8f0OKwBMlfNx
        Esd+SoHeL5XtI3xikV6rLSIjaA==
X-Google-Smtp-Source: AMrXdXtbSafXzCJ9qrBUx7rkHsccdHRt06gob4+L3jRDhSqfVo2W9/vmTJPj6NERI/nFbkeZ7hoUGg==
X-Received: by 2002:ac2:55a3:0:b0:4a4:68b8:f4d6 with SMTP id y3-20020ac255a3000000b004a468b8f4d6mr1779174lfg.28.1671737181899;
        Thu, 22 Dec 2022 11:26:21 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id v12-20020a19740c000000b0049ae3ed42e8sm171379lfe.180.2022.12.22.11.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:26:21 -0800 (PST)
Message-ID: <9a1b7b1d-67ca-0e52-0d58-b0d21a402032@linaro.org>
Date:   Thu, 22 Dec 2022 20:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys
 (volume down)
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222192443.119103-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222192443.119103-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.2022 20:24, Marijn Suijten wrote:
> - Remove autorepeat (leave key repetition to userspace);
> - Remove unneeded status = "okay" (this is the default);
> - Remove unneeded linux,input-type <EV_KEY> (this is the default for
>   gpio-keys);
> - Allow the interrupt line for this button to be disabled;
> - Use a full, descriptive node name;
> - Set proper bias on the GPIO via pinctrl;
> - Sort properties;
> - Replace deprecated gpio-key,wakeup property with wakeup-source.
> 
> Fixes: 82e1783890b7 ("arm64: dts: qcom: sm6125: Add support for Sony Xperia 10II")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 
> - Flatten gpio-keys pinctrl state into controlling just the volume-down
>   pin;
> - Replace deprecated gpio-key,wakeup property with wakeup-source.
> 
> v1: https://lore.kernel.org/linux-arm-msm/20221217100455.52593-1-marijn.suijten@somainline.org/
> 
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 0de6c5b7f742..09cff5d1d0ae 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -41,17 +41,18 @@ extcon_usb: extcon-usb {
>  	};
>  
>  	gpio-keys {
> -		status = "okay";
>  		compatible = "gpio-keys";
> -		autorepeat;
>  
> -		key-vol-dn {
> +		pinctrl-0 = <&vol_down_n>;
> +		pinctrl-names = "default";
> +
> +		key-volume-down {
>  			label = "Volume Down";
>  			gpios = <&tlmm 47 GPIO_ACTIVE_LOW>;
> -			linux,input-type = <1>;
>  			linux,code = <KEY_VOLUMEDOWN>;
> -			gpio-key,wakeup;
>  			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
>  		};
>  	};
>  
> @@ -270,6 +271,14 @@ &sdhc_1 {
>  
>  &tlmm {
>  	gpio-reserved-ranges = <22 2>, <28 6>;
> +
> +	vol_down_n: vol-down-n-state {
> +		pins = "gpio47";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		input-enable;
> +	};
>  };
>  
>  &usb3 {
