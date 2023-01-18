Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBD671E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjARNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:53:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ABB792AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:24:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so46733540edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgU9OV81VKNoacRkVG36DRzxhv8CRha3b241eiVTJOU=;
        b=y943B9lru//EWuO6UMJJ3vYBFc9kuFRe8EjbWug/kitczTxrPpjydtYgnSU571IYWv
         +10nJmvwC2S1qdxe0a7VIXrt7bzL9NvjoXV3JZYw+VkaPwnRR1TUxM3E6e+NsfiW1b7H
         aSPjBKope0li8mNKoIOPXNqgXp1EkC6e6zkTjFI8vGKtu3kjWGTgXPlmjIoeGg+w9kOj
         /rpQ6HH9TgFbHoKWCZn7HixvsioMN/DPvLsVrdK7Em/ga84IAYxB0pY2SovhaM0RId41
         w7ZXC1UNMetFeJ8uLvCAahBmOMWXZGN0r5d1Gq0wo466bNPl+MfUBjrXacklZzeRvb5i
         PMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgU9OV81VKNoacRkVG36DRzxhv8CRha3b241eiVTJOU=;
        b=ol7wMHl5enHDkkcxAD1SQzpf1thXMlwS2E+1h3Xthfn0spEfejqcpTki6KvuYyRUFM
         Cm6j1ZdmnvRHlaFiyxusOhGzyzOcfYzy97nE9pkC8PPFL3BOFtleCC/EOM9v+PezXkmc
         VQyqaS7w0UTkVTN5+jpbHoWY2wNkMS8IesdurpC9+7IubhfHBtVtggz/pTAdd2uYn9Bs
         ykLDOjkc5RRP1zYrNrRen9O7dFjwV6nAf3QXyMlNT1H5hivfKNQFDfpPE+I8LNe8/SW5
         FaMiioivKSXhA7V+tBX6/s88Ay+cSgYUlLG91yKBaCqRW8j94tUimCX0chHt4mNgl8+S
         Ow/g==
X-Gm-Message-State: AFqh2koBlO6gTzy7QSN8jY8fQOFiooY3KQs1QwZz9BoaX4U8ij93uZ8t
        F7Xbnf2PBwJqhNgFZbW5FMewIQ==
X-Google-Smtp-Source: AMrXdXsp1+bb0awcdMhn3BnuUs3hIK4/cegYEOwsfNWiIBA5PynRHZ2PN+kb9S7rYz2DsxQSTLEm2g==
X-Received: by 2002:aa7:c1ce:0:b0:49e:89e:3b36 with SMTP id d14-20020aa7c1ce000000b0049e089e3b36mr7350531edp.30.1674048261163;
        Wed, 18 Jan 2023 05:24:21 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id q24-20020a056402249800b0046ac460da13sm14286777eda.53.2023.01.18.05.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:24:20 -0800 (PST)
Message-ID: <3b3709ce-c1ea-155f-f175-c07a3765836d@linaro.org>
Date:   Wed, 18 Jan 2023 14:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Define CMA region for CRD
 and X13s
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
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



On 17.01.2023 19:46, Bjorn Andersson wrote:
> While booting the CRD, a series of CMA allocation errors can be seen in
> the kernel log:
> 
>   cma: cma_alloc: reserved: alloc failed, req-size: 128 pages, ret: -12
> 
> Growing the CMA region and querying /proc/meminfo indicates that a newly
> booted system (currently) uses 64MB CMA.
> 
> Define a memory region sufficiently large for the current use cases, to
> avoid forcing users to add this themselves, through command line
> parameters etc.
> 
> While fixing the CRD define the same region for the X13s.
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> - Updated commit message
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                | 9 +++++++++
>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts      | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 4e92dc28e2ce..6f686377dc3e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -128,6 +128,15 @@ vreg_wwan: regulator-wwan {
>  
>  		regulator-boot-on;
>  	};
> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 55ecbee19a58..8d485e0000cf 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -153,6 +153,15 @@ vreg_wwan: regulator-wwan {
>  		regulator-boot-on;
>  	};
>  
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	thermal-zones {
>  		skin-temp-thermal {
>  			polling-delay-passive = <250>;
