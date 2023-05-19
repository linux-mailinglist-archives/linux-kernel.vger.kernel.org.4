Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACC70A34A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjESXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjESXZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:25:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC7E7F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:25:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so9731571fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684538719; x=1687130719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOvjqN8AVqDU+Adbzq8R5mSYYGxz+RyLYVuQ1pVdfBY=;
        b=gKrVCbH6ooo39BHamSYxZz6HuvRVrXQVsJtkCWbh4jQeEI7sCxkC1DUoPJv2RNCPG7
         T02BfXw3Lrqlz3dwzaSiM0TwitcOSWlZp+RcZ3DfQfVmCUXh+os8KYtfuqStyoS2fd52
         xX4N8V5YnGsXRyY6+WTJFbkx6e6UVYOz92z1Tk8XSph/y2QXHs9Z304p3xgSa5nxmWnC
         zsvFvCIA1yBppLLRNZG+hxBOeoDflCRUkDSfwUZfG/Iaq2Hdwdtm+k7sy910PwXb3dCI
         xR+/U2MzIZCUPQzxjAKKZGUSMhLXRx2+j+XAMxLeRNjM/xowphXBEAlF/kpEf+a1BLUj
         caJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538719; x=1687130719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvjqN8AVqDU+Adbzq8R5mSYYGxz+RyLYVuQ1pVdfBY=;
        b=CVinpqH7k4xly/EEztBn4Md2cr2kOZ/pIsRly2GfK+e61d7xGjhmrsttc/+7PjGtDi
         g88K2O2nMYhrqYCyyDQ6R/LAybdRxGjuO7Wyz44ym5DaVdvJmNPrUHzom+E7HNlXY3Qv
         qWALrRX6acD7qbbDtOeGAFaXzqpEMvY+/G8PGl82ap1frEuz0MsV812AyCUvJW27e6hk
         NGHYe4vGuMABE9EGao/M8fhzhemyqPrjX21Op+DktPRye0Gor12khS/WWPpNbGVtr7lj
         jHlb8GEIknVU5rkcvq47+nOBN7bEUROGJoBlfczcSwFVSwicvDn7raUeQLH7h8gIsOr0
         7eVQ==
X-Gm-Message-State: AC+VfDzRmPdVNCEP7dt00Bz7JikToOJ9fMD5KgFyydKVaVkgJyR/Qg1Z
        V+BVieSb4TSJr1KZNEFIJ4gdQg==
X-Google-Smtp-Source: ACHHUZ420IDbdaMgoPXwNeI7sLTtm8/VjDcIy3Q4qQuT2OHkdFB7TWfA1g9j1hTnqdFHEInpUQpC3w==
X-Received: by 2002:a2e:2e0f:0:b0:2a8:e480:a3c8 with SMTP id u15-20020a2e2e0f000000b002a8e480a3c8mr1302991lju.44.1684538719272;
        Fri, 19 May 2023 16:25:19 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e9b87000000b002af2a411655sm41597lji.41.2023.05.19.16.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:25:18 -0700 (PDT)
Message-ID: <7d8ff3f4-fa9f-109e-b255-329803532e9f@linaro.org>
Date:   Sat, 20 May 2023 01:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] ARM: dts: qcom: msm8226: Add IMEM node
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
 <20230519210903.117030-5-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519210903.117030-5-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 23:09, Matti Lehtimäki wrote:
> This is used for example for reboot-mode which enables userspace to
> signal the bootloader to go into the bootloader or recovery mode.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 006263373348..3628e48c1ec1 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -646,6 +646,18 @@ smd-edge {
>  				label = "lpass";
>  			};
>  		};
> +
> +		imem: sram@fe805000 {
> +			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
> +			reg = <0xfe805000 0x1000>;
> +
> +			status = "disabled";
> +
> +			reboot-mode {
> +				compatible = "syscon-reboot-mode";
> +				offset = <0x65c>;
> +			};
> +		};
>  	};
>  
>  	timer {
