Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6346866A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBANRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBANRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:17:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A52ED66;
        Wed,  1 Feb 2023 05:17:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so27759020ejb.0;
        Wed, 01 Feb 2023 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q18/Ed4T8GStZk15GEcB47v5vCjiaTS4iyhypSPJu1c=;
        b=JmXFrwpatuTq3LWhLPd7SSN+VgTLrGv+Pu0GTsto+GV3gVuqhNQzDP0DAYx8jkcH7H
         9uYGH4EqNmL7p8U28TW3R6zVUxJy38aQjFuUn3fo35iHwDM160C47Lz/2jdw8eN/cERU
         USFpn+VWil/vlRk99jIox78vAyUngLoi9nzE3q7N1tdxjsa5Xk7jl6ehiqsfFzj+cumV
         mit4XvpMf/fXrIAv5/bCFI3Av7S25h9AbQ+64EEG3a8zJlpt17StKkBFvBV3ee+UyPvd
         /pA8a2JjvkSZKdXerzJ9n2CGPmK1gF0wovbttM4oKYkA9LD94QarxUF8OWnpGCY/nK5a
         +ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q18/Ed4T8GStZk15GEcB47v5vCjiaTS4iyhypSPJu1c=;
        b=QQ71RH2eYdOgI15QjTfXpB7cOqNH6ew9wP5zgSkdk7gEHfgZ8YPdOonvCE5j5kuGo9
         7WkxCWZLtiQ0Ng4zMMXkL0p58rA0iOWQNOF/Ro4diIeFusVzfd1QrrqH0zvGyWnVuH2J
         Dtg/OC4gy2Ta7hRENeYwJSG62rRVr4Wmh0l4qU8VcVnOJ59KmSY3JQYDzSPpNIR4DVSX
         /3FX3x3lvb9lkaJ2Bva85H9ynTEpAruHAZg3S1WwAolGLegZxmyDVD1SuRRyj8rgCn4V
         8nWzvMtYrrINPVapAnkuazVJyOBWlKg1kC3Q/2S/hEsdH+w4joWHuTGIbF6Om7DCrbAt
         860Q==
X-Gm-Message-State: AO0yUKW8FFSCYmy6jDAyW9WwqaWq1DCUsw7/IwfZsk+FIt7Ej9nVp1mZ
        uPdOen9zyZaCe6Ausaf999I=
X-Google-Smtp-Source: AK7set9lneu1cp3XEMIAG3dTmb/E4Cbk7JJqwigXvxQL2oOBvz03WVsu3DzW8iGx9S4B1h+zd2Mcrw==
X-Received: by 2002:a17:906:c2d3:b0:7c1:1e5a:ed10 with SMTP id ch19-20020a170906c2d300b007c11e5aed10mr2260655ejb.8.1675257464189;
        Wed, 01 Feb 2023 05:17:44 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906435000b007b935641971sm9946719ejm.5.2023.02.01.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:17:43 -0800 (PST)
Message-ID: <8b9e509c-2ff8-7948-17a8-54c2d98713cb@gmail.com>
Date:   Wed, 1 Feb 2023 14:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] arm64: dts: mt8173-elm: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220729053254.220585-1-treapking@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220729053254.220585-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2022 07:32, Pin-yen Lin wrote:
> Switch to SMC watchdog because we need direct control of HW watchdog
> registers from kernel. The corresponding firmware was uploaded in
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Applied, sorry for the delay!

Matthias

> ---
> 
> Changes in v5:
> - Remove redundant new line.
> 
> Changes in v4:
> - Rename the watchdog node (smc_watchdog -> watchdog)
> - Correct the patch summary (mt8173-oak -> mt8173-elm)
> 
> Changes in v3:
> - Remove /delete-node/ and create a new node for SMC watchdog.
> 
> Changes in v2:
> - Move the modifications to mt8173-elm.dtsi and add some comments.
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index e21feb85d822..abe3140cfcc6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
>   			};
>   		};
>   	};
> +
> +	watchdog {
> +		compatible = "arm,smc-wdt";
> +	};
> +};
> +
> +/*
> + * Disable the original MMIO watch dog and switch to the SMC watchdog, which
> + * operates on the same MMIO.
> + */
> +&watchdog {
> +	status = "disabled";
>   };
>   
>   &mfg_async {
