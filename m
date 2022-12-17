Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3D64F994
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLQPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 10:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLQPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:04:22 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB08E08F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:04:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so7753354lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyQwYotwFo1Kdd3TcYj4RcjJFej1hnlZ4LHTPyy+j+w=;
        b=yKDOg0iOz8aWkF1+IMWego2W/bWGiArJesQTAtUgW65j8ZHfOu0qZ9jSJfsJAhECYT
         W4rD6HxpFqRfakp8VTJnGhh6ftpSq8sbEvIMYD0Wz37KzCibJVWqb3ilcGCp1m8iPoLf
         nWiduzZfM9s/gFzCvBPwnSdOw42O0vpleFBxMN/wamWSvEMBYdXRe2RO6XQrMWC84RvM
         +mAu3N/NlsBrQaIIliSVFh/bktm38Pg8hp6ZCRGJ/m1sBh9iUhZq8senySYjRuPCyvGE
         ttSPap5yuDDAE9iJuToTnwHN8UrOWjuu9EDiwf2pEcXAeuXOzZ8afSwvaqB9DxTBxOLv
         F9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyQwYotwFo1Kdd3TcYj4RcjJFej1hnlZ4LHTPyy+j+w=;
        b=kYAqOrevur6p2bR2VKjALOP5U07oDZgRMjyePuZj3gWg9Qh3i/GLv6ic3E0xtfK+Me
         2l58R36jmax9sz1Ig+I3XgSS0LwY93ydC1/0rv0U5mfAoGyandx9UnRI1Pu92HqTH5Fi
         ePnnnlu1+i7zMnqiEipvnjscswOKKM0eYhzzQYtH9v4weC8ALdfZBgpPGGXTmch+XTis
         +6SoqUzI8T3hjooQEWKjA3LQlaIadAIBAOIEJwMUFYSlvnimTuoFwq96Q7PzDXoG2Khr
         9b5BGOgEEobkWWD6rjRow2wehEDPwWhDHBnv1X2wNiMV/TAsbC3efbeK7ApMSxzJSGrQ
         EeuA==
X-Gm-Message-State: ANoB5pnGhBa6XwQXnJyjdCZbyfgBAbvuoMyIyLRH3azSrDzoiR6nuLzF
        JaOZsVCSBOHne5EZGHgO6ZqbSw==
X-Google-Smtp-Source: AA0mqf5pCMMfp2ZmMFhqcQt8HIDrPtQG40+9L6xOvOth/N/wgUZdVsdomUJF2saefgPyykgUAes8bw==
X-Received: by 2002:ac2:4283:0:b0:4a4:68b7:deb7 with SMTP id m3-20020ac24283000000b004a468b7deb7mr9908501lfh.19.1671289459199;
        Sat, 17 Dec 2022 07:04:19 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id n7-20020ac242c7000000b00499bf7605afsm530708lfl.143.2022.12.17.07.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 07:04:18 -0800 (PST)
Message-ID: <11174eb6-0a9d-7df1-6f06-da4010f76453@linaro.org>
Date:   Sat, 17 Dec 2022 16:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys
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
References: <20221217100455.52593-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221217100455.52593-1-marijn.suijten@somainline.org>
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



On 17.12.2022 11:04, Marijn Suijten wrote:
> - Remove autorepeat (leave key repetition to userspace);
> - Remove unneeded status = "okay" (this is the default);
> - Allow the interrupt line for this button to be disabled;
> - Use a full, descriptive node name;
> - Set proper bias on the GPIO via pinctrl;
> - Sort properties.
> 
> Fixes: 82e1783890b7 ("arm64: dts: qcom: sm6125: Add support for Sony Xperia 10II")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 1b9e40d3d269..8c7c9331fd21 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -41,17 +41,17 @@ extcon_usb: extcon-usb {
>  	};
>  
>  	gpio-keys {
> -		status = "okay";
>  		compatible = "gpio-keys";
> -		autorepeat;
> +		pinctrl-0 = <&gpio_keys_state>;
> +		pinctrl-names = "default";
>  
> -		key-vol-dn {
> +		key-volume-down {
>  			label = "Volume Down";
>  			gpios = <&tlmm 47 GPIO_ACTIVE_LOW>;
> -			linux,input-type = <1>;
>  			linux,code = <KEY_VOLUMEDOWN>;
> -			gpio-key,wakeup;
>  			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
>  		};
>  	};
>  
> @@ -270,6 +270,16 @@ &sdhc_1 {
>  
>  &tlmm {
>  	gpio-reserved-ranges = <22 2>, <28 6>;
> +
> +	gpio_keys_state: gpio-keys-state {
> +		key-volume-down-pins {
I see no need for defining a wrapper node.
The other changes look good!

Konrad
> +			pins = "gpio47";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +			input-enable;
> +		};
> +	};
>  };
>  
>  &usb3 {
