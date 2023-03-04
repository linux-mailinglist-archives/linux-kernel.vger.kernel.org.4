Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9146AA99E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCDM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCDM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:57:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C581C5A7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:56:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i28so7044323lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934617;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilmTdHidtUxx7fznlKwOL72F3IrCYo0tPai7caU62YA=;
        b=chZwV3gEVk5DTSx3pzkjUmyfoFDmw6RtHWHcLDw2wVBI8VBU6ApjQqnybQ4gQvoBcn
         8fdRFcHQ79gU08prk+tX7rkecHJTLlT5dZJ7rgUGX0aoVUs4XIYU7KHOe2J2+8Cvtems
         gl9JgQY5qFI3C76XNhqgocbgS5S2sQX1Mb3R2V/sk51GC+BHZSfzNol1decPGkzJ7SfG
         pRSVK1L9Fzojj7SJQ/UH8/SbAFIsVSFFWaJoK4sFZZKNo8CKHfOLG6/S6fnDiMI22q5o
         klpOLDXoHZ/TaLnIsDm5tAfywFTWe44K9RsLI1/QU5kINRemyYV2c1kl2CoyJhju4X4A
         Em5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934617;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilmTdHidtUxx7fznlKwOL72F3IrCYo0tPai7caU62YA=;
        b=OcacyNw/BrPjeR2V1fOAIN/4Yy0bheywlrXhHbdM1UTZWXf+upi3yVP8h1kZyVL4MD
         MAW3bsVxjZPCgSLzdqBfYOkIaSlkp85bE9dPRsXfZ9BopZnXTngvqvRds3TS3sLv+Z5X
         QuBtb8pGzJUipQKlqx8seKz6EDYEybDk7CCm0pP+O92AykYExX0f6FTS4r25LXYRO0oh
         Mn0kkcBGosJbkE9VY0r/6CttP8NYZNJAfrYRoW8t7PSCvG10YcoapLmpP3fAGNXDbN3M
         e1OYD6oQ5bVNJ6aJvd3laU2coRe7VuS473P7orAB+OO1VCV+AnJh/IxhAlWwhAlIZQpJ
         ws0w==
X-Gm-Message-State: AO0yUKV/DJRG1dYVbZunMg/IrMS5gwbYWx1aloTIxnRde98Mh78mCaPa
        DtitgJ0Y672rAEdJ7OjIYZhd7g==
X-Google-Smtp-Source: AK7set/UpITZa9Wk9j86ulOrCcxuND+ZgLmY7X4dPXQjQICH1Rcgk8xVIUcTsoXLeoQaMD5FAcVrbg==
X-Received: by 2002:ac2:522e:0:b0:4db:56e:427c with SMTP id i14-20020ac2522e000000b004db056e427cmr1249874lfl.56.1677934617157;
        Sat, 04 Mar 2023 04:56:57 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id f25-20020ac25339000000b004b567e1f8e5sm815969lfh.125.2023.03.04.04.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 04:56:56 -0800 (PST)
Message-ID: <43db5593-354b-4332-e0dc-74b849eb0834@linaro.org>
Date:   Sat, 4 Mar 2023 13:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/8] arm64: dts: qcom: msm8998-fxtec: correct GPIO keys
 wakeup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
 <20230304123358.34274-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304123358.34274-2-krzysztof.kozlowski@linaro.org>
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
>   msm8998-fxtec-pro1.dtb: gpio-hall-sensors: event-hall-sensor1: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> index 5aad9f05780a..8b71b1f8f300 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> @@ -44,7 +44,7 @@ event-hall-sensor1 {
>  			label = "Keyboard Hall Sensor";
>  			gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
>  			debounce-interval = <15>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			linux,input-type = <EV_SW>;
>  			linux,code = <SW_KEYPAD_SLIDE>;
>  		};
> @@ -116,7 +116,7 @@ button-vol-up {
>  			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			debounce-interval = <15>;
>  		};
>  
