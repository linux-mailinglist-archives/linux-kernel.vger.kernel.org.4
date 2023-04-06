Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA36D9C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbjDFP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjDFP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:29:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DE55AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:28:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so39886851wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680794935; x=1683386935;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnVgwA89bbPaxmqanbnhVOSr5bq4CNPE7S5flcil50=;
        b=GQ8frYy+BEqelamgbAaOgJ+DFHzMiaHHgwC0N4YQwQ7H2MqUAabTiKdWFAxBuxYnPd
         QHI4Jt5yLWFzX9yBnc6BkYeq+ciOL2sqthmZWBZlUQbYNLLlWbsg7aQcOoVIe/Tyt727
         x9vl1xGXB+nrTije6Y7YGII2reCAY0sNuCWKfFkUn6fPPYjsKqxow56ulrcUwPEhkTw4
         mcRaEijsfhc6WX/aAYtKpGo2Ae/IJMYx/BegDQsVdC6H6WytqHljefnXEKfvQyhb4Cig
         bGdgL9fYsvcYOeTVMYDcnYaiIwEI38n7bxYGD/16qA8LSf+RlouFYlHv3c9QbTaNF+7Z
         kvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794935; x=1683386935;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCnVgwA89bbPaxmqanbnhVOSr5bq4CNPE7S5flcil50=;
        b=lcOtZHmhFDUEvvW5lPIiQ8GlwP8Cc5+aJ95qtsddouTi3GBXC24RXH7VMxuAh+E9wo
         u9CLL9WkbG/t1ysA0Ady60Fr0q1c61fzm68nw3XIXJCExTzQBCOoo0EISRRs0CTJLom+
         MWNdM7xH5RWEEk5JEyICuVR6C5M7zSg1OKRhpNGji/GnMwNhtA1ssTBsFnWuUt/w0Er0
         tbuyj5BB4uP9kNTG3hQqSgGPGVSmuSsO5Zq31+Okyc/0ZI2L+nS+qf4NhP6kch0Un0Lm
         zdoEjhYcwiIfxR5s9Y4LnKpowmuTstsgWP0dcfiMFcWEESMtlAhuBfe3If2r8HV0YzJd
         2FpA==
X-Gm-Message-State: AAQBX9dCiAx7PKmTSZnDytU5nYL+S6A1fa0VOznmkMOWvhgK8BvpxHHO
        5B6/jofCqPjG484fUWV5KW5cUPf38yg3d2reTwyBOQ==
X-Google-Smtp-Source: AKy350alghvz6guIgtnaI1Sa+Og3l3vXo21Y+9+mgqkVJnaC91FmFUcBtVF5So5M6wRg2Hc7Ba2HPg==
X-Received: by 2002:adf:f005:0:b0:2d6:cc82:3c49 with SMTP id j5-20020adff005000000b002d6cc823c49mr7527675wro.13.1680794935591;
        Thu, 06 Apr 2023 08:28:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8569:a62a:11bd:c344? ([2a01:e0a:982:cbb0:8569:a62a:11bd:c344])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b002c55521903bsm2041806wrs.51.2023.04.06.08.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:28:55 -0700 (PDT)
Message-ID: <00165b3e-42e4-7be6-bd80-9f0bd26c78e2@linaro.org>
Date:   Thu, 6 Apr 2023 17:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] correct uart_B and uart_C clock references for meson8b
Content-Language: en-US
To:     hfdevel@gmx.net, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org
References: <trinity-3aa9784a-714a-47cd-866b-3ae77ecca0fb-1680773596235@3c-app-gmx-bap56>
Organization: Linaro Developer Services
In-Reply-To: <trinity-3aa9784a-714a-47cd-866b-3ae77ecca0fb-1680773596235@3c-app-gmx-bap56>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/04/2023 11:33, hfdevel@gmx.net wrote:
> commit b3b6a88d2347d2ec9075603920e616836cb46750
> Author: Hans-Frieder Vogt <hfdevel@gmx.net>
> Date:   Thu Apr 6 10:21:49 2023 +0200
> 
>      [PATCH] correct uart_B and uart_C clock references for meson8b

The subject is wrong, should be: "ARM: dts: meson8b: " and you should also CC the linux-amlogic & linux-arm-kernel MLs likes get_maintainers indicates.

Neil

> 
> with the current device tree for meson8b, uarts B (e.g. available on pins 8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they are relying on incorrect clocks.
> This trivial patch changes the references of pclk to the correct CLKID, which allows to use the two uarts.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>   meson8b.dtsi |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index d5a3fe21e8e7..25f7c985f9ea 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -740,13 +740,13 @@ &uart_A {
> 
>   &uart_B {
>   	compatible = "amlogic,meson8b-uart";
> -	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
>   	clock-names = "xtal", "pclk", "baud";
>   };
> 
>   &uart_C {
>   	compatible = "amlogic,meson8b-uart";
> -	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
>   	clock-names = "xtal", "pclk", "baud";
>   };
> 

