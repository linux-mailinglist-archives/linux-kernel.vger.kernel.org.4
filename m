Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8569922C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBPKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:49:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3255E65
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:48:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x40so2207040lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhWmw2hU5CpjAu/G8PlR3IasZAJo9t8FS9xeW4+4qLg=;
        b=ngOtomFRa3x1BXfs+M54l4Lf9tBbn+73Z2srUXTbGQgvaqPDpw4OoDk8jKpIUOyhxJ
         UN/I5sJXVrQ4zAuZVhJS9mp7Knpji/sGfq+l2utZqvD+WavPUOPLRRUu0vSfnWGPbOg0
         o6eYHzEl5DLgwvhbqgSG6OBrh5smwHCO6p2bYwgAL/UxMviJ05X8/bE+UcHPOXu4mrHK
         GxsqVIP6tIwNtkHdjOJMe5pd9uEWBRyEEoUikaS0oduJVnxBV5bHvRUbdDn7EtwVeaQz
         rbX3s+5wvBLYN2g1g0YDq1J5seBkuRkr0Ffd/Qw4IZsui3ZISICvavq6k7eCcKYGJPA9
         v7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWmw2hU5CpjAu/G8PlR3IasZAJo9t8FS9xeW4+4qLg=;
        b=qX0E+hA3/IbBNLi4dllGBW6ROfPxUQ7TZDFxFwbrPHaVIvC0FtUZvrS7/qJLWScrc9
         jgT7s2S2X8Z2b3rA6/8z89hNpqk1w9v4KfBUyjD/ejzeZ+kOLLVXeAko+K02n31p0uV9
         +7Zjp4wN3Hp3kd9c8DQJQUga55v1V12yvBucwgINVc/E0Xgwy2TjlQgMdDljt9TXg3jE
         8N4mm+QCILFJmi0oVz6u/AoE3yrv7XMeetmXHkxCQ8xc8cpmnTpgTqKLEzyoektPvmcx
         poVErwSNWvRfwpR+4obrvuGrN2/WL9EgRwm+sFVf1ujjF9xzU9wHonJl252nIpofGMye
         DQxg==
X-Gm-Message-State: AO0yUKWCR3NEJTlyyyyOjTwMN1oDZ9ce2qRkZgs7I7vGDt8wFtBbErkR
        1+Yo/qEWLX5GxNbqcafAqtW+GQ==
X-Google-Smtp-Source: AK7set+dmMQN0uHFLsdzPkHn2zb2Dz703g51An4vt/fuoxbOWy1DVn/lOlBxm7nuXsykWNTntK86cA==
X-Received: by 2002:ac2:54b8:0:b0:4d8:71dd:5c5e with SMTP id w24-20020ac254b8000000b004d871dd5c5emr1536971lfk.37.1676544529237;
        Thu, 16 Feb 2023 02:48:49 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004dc4d984911sm244653lfc.271.2023.02.16.02.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:48:48 -0800 (PST)
Message-ID: <c55a17fb-3c49-6e7e-f22e-95917daf97c0@linaro.org>
Date:   Thu, 16 Feb 2023 11:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/4] ARM: dts: qcom: ipq4018-ap120c-ac: align GPIO hog
 with DT schema
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214161211.306462-1-robert.marko@sartura.hr>
 <20230214161211.306462-2-robert.marko@sartura.hr>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214161211.306462-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.02.2023 17:12, Robert Marko wrote:
> Align USB power GPIO hog node to DT schema.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
Unless you submitted a separate patch for this, I only see
hog being allowed in 845 TLMM.

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> index 38efd45433da5..cd2a32d0d5548 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> @@ -76,7 +76,7 @@ mux_cs {
>  		};
>  	};
>  
> -	usb-power {
> +	usb-power-hog {
>  		line-name = "USB-power";
>  		gpios = <1 GPIO_ACTIVE_HIGH>;
>  		gpio-hog;
