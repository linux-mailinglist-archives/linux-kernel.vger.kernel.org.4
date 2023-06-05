Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22754722F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjFETA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFETA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:00:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B6ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:00:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so6411983e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685991652; x=1688583652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMwzIPlODC0QOUJdlXUZkOVWqPlnGZwWFxdHkZLNYGA=;
        b=dz23iTnVRgYqMunvVhbF5seqyhwo16GwcjqDUUyYIk+d7gPwsscuTKnwUG4FsoieW2
         KsiNXTgp6oKjD8aDjS4LzZmmCu2gDVWFkDiUREbYMNTwE6v7ZFa3OGwXpvbuBQ5G/qSP
         9wfSF/VnyizQ8/fTP+b8HfYGU4bqub16McKfE6WjqTpzPoUX16BJIZGMTDBb4SOucgbZ
         0XpCsQ1Ux3y47v4GtCIvAdv6ty8np+GyZjWQNLjiPxLB9nMqjLjcUmxvRF74HojLSXHQ
         G8rkZNXglwYzsr16sYQTVf5H3i29DOoVq5TCLpDnrRl1sS1+iofHK7aJlI33GYYUMe9h
         imFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685991652; x=1688583652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMwzIPlODC0QOUJdlXUZkOVWqPlnGZwWFxdHkZLNYGA=;
        b=PjYoM3xUkpHciExb4ezpSIXJZ0RYikbbt7jw1GZvbO9BGDj3u8oBVeaWRn4pEiHIkN
         U4txX7dosR40juHFiA7pqoZ839UpaxufA52rXaF1N0HXiHIFwiqBkSPMtjEJdc5deb9F
         InlAY6f3CWJj8L/mPrJhOEeFPEgOimwyznq7bvVcolITu8SSIUdhI47cYQmM/WhzEdTM
         Y6qo67jLWizLaPkt+iOsptpAVhNMOxwA/IaN0uypgRsn360wQdNh6Bb+TaQGS8WSnTtu
         slrRcyfxVqQFTBKJKh7HHRi2dAz3snfa5L8DrR4lF5rthjYASSSEgo+YjNYkXcefL3hp
         m4CA==
X-Gm-Message-State: AC+VfDxJTQj3Uj6fvlaOuApWcnLzLaMz98Hj4OA1BBbG9GLeEuEf3pEV
        WXFHpxBOLNthGC7xhWWfqyHTNw==
X-Google-Smtp-Source: ACHHUZ5jhXh2yuwV2j+EjO2cLgcazZrzCa396tGgJWOala/a5rOOH1VJ/jmql+DUdSG05Xb8HCMzrA==
X-Received: by 2002:a05:6512:33c5:b0:4f4:f38a:4423 with SMTP id d5-20020a05651233c500b004f4f38a4423mr4465933lfg.27.1685991652353;
        Mon, 05 Jun 2023 12:00:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id i2-20020a056512006200b004f60ca8aa2asm1217829lfo.55.2023.06.05.12.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:00:51 -0700 (PDT)
Message-ID: <4d2e6530-ec72-6b76-ed75-c623071bba53@linaro.org>
Date:   Mon, 5 Jun 2023 21:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 14/14] ARM: dts: qcom: apq8064: Drop redundant /smd node
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-14-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-14-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 09:08, Stephan Gerhold wrote:
> The "smd-edge"s for remote processors are typically specified below the
> remoteproc nodes. For some reason apq8064 also has them all listed in a
> top-level /smd node, disabled by default. None of the boards enable them.
> 
> Right now apq8064 only has support for WCNSS/riva, but there the
> smd-edge is already defined with the same interrupt etc below the
> riva-pil node.
> 
> Drop these redundant definitions since the /smd top-level node is now
> deprecated.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Hm, 2012 is calling.. it wants it dead code back!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 40 -------------------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index d2289205ff81..e0adf237fc5c 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -226,46 +226,6 @@ smem {
>  		hwlocks = <&sfpb_mutex 3>;
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> -
> -		modem-edge {
> -			interrupts = <0 37 IRQ_TYPE_EDGE_RISING>;
> -
> -			qcom,ipc = <&l2cc 8 3>;
> -			qcom,smd-edge = <0>;
> -
> -			status = "disabled";
> -		};
> -
> -		q6-edge {
> -			interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
> -
> -			qcom,ipc = <&l2cc 8 15>;
> -			qcom,smd-edge = <1>;
> -
> -			status = "disabled";
> -		};
> -
> -		dsps-edge {
> -			interrupts = <0 138 IRQ_TYPE_EDGE_RISING>;
> -
> -			qcom,ipc = <&sps_sic_non_secure 0x4080 0>;
> -			qcom,smd-edge = <3>;
> -
> -			status = "disabled";
> -		};
> -
> -		riva-edge {
> -			interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
> -
> -			qcom,ipc = <&l2cc 8 25>;
> -			qcom,smd-edge = <6>;
> -
> -			status = "disabled";
> -		};
> -	};
> -
>  	smsm {
>  		compatible = "qcom,smsm";
>  
> 
