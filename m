Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3370A341
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjESXWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:22:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142701B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:22:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac735fee70so17655281fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684538535; x=1687130535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nepunp4fNJZ0cdeTy2tGfj9P3Fsv1fCmkFoDKdwZv4A=;
        b=plWSAUmHNgwvxDHwmWGqig3CyFIRbk+eq02fNiaiEbqEvwLRUbPPa5L4qpdnMQZUZq
         LCa1q1HLCspncGuheQ9wdpOBBDLBlSjjb/pnoAnEkr1FHiADSBbefcR1vlN4fvA8bI3A
         l5umLiHwAPs2Vzeem4avtzXSW+E4toLpRfd5/idCSYW2Z7WK0/+epr+X/WyEoZZDMWBT
         UXVLkLExDfAQUYmL56J6GWhBsPmEok0bYB9IFxDNLq2NUC5lxj9c4R7URJoE5cNzXPoH
         2YZYGQGlE1WbeWnF/9ks7hDmFTnuG41J9wMAHPSl6gwr4dM+aiuOKlL+0DApaMug8qE1
         68sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538535; x=1687130535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nepunp4fNJZ0cdeTy2tGfj9P3Fsv1fCmkFoDKdwZv4A=;
        b=HOvz21lFRnRxLDJIgERLgZIdZfIQBq7MAuIukgCLBv7+9Uw3pQ/6t0Y2nSNqsyITep
         Wxu/Em3n+oMGEFpVu7/NMyBEuqr3iahJE4vVNIwjEGPxx91f4yteeO1UIhNaWtQ5ZpBW
         Rz7fYFAzCWjBNAvF+nI8JAwQ79HYWwh9iJojppW9GUWVMR/TbAkeB9mmzZEtLlCi9URZ
         lQdPlJ0F2IoOl/dr9n787nOwKRMeEdcC70Ml2wZiFhg2KB5DkjxVrZHm8PRYJlV2VSzC
         NErWQmwFTS7SB8FWJpE+eUospxyahWbZirsZQeW4QAxjmaT/gOkksQtwqrCrpNhV53Az
         2whQ==
X-Gm-Message-State: AC+VfDy4nWjBL4GqbOEp/6fdST2j7eP1+r1X7SC0TeZYBXs64PMTwUaW
        sOdTjf7G1WlS3P83i4AaF1B9aw==
X-Google-Smtp-Source: ACHHUZ5aLyr+vu0y1hUGSRxUui+KRWNbohGetFXOjorq5/KI1ZLq9496kUMUjGd7qzP6313HAZmTGg==
X-Received: by 2002:a2e:b4a2:0:b0:2af:2451:b346 with SMTP id q2-20020a2eb4a2000000b002af2451b346mr1055041ljm.11.1684538535312;
        Fri, 19 May 2023 16:22:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id s17-20020a2e9c11000000b002a9eba29c39sm38061lji.91.2023.05.19.16.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:22:14 -0700 (PDT)
Message-ID: <beb391ac-e646-d5e9-1a5b-02d6477c2517@linaro.org>
Date:   Sat, 20 May 2023 01:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] ARM: dts: qcom: msm8226: Add PMU node
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
 <20230519210903.117030-3-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519210903.117030-3-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 23:08, Matti Lehtimäki wrote:
> Enable perf events on MSM8226 devices by adding the PMU node.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 42acb9ddb8cc..e272a1e15b44 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -47,6 +47,11 @@ scm {
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_PPI 7 0xf04>;
GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH

Konrad
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
