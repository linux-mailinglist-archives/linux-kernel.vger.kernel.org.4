Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B9651F40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiLTKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiLTKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:52:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDDA186B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:52:05 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b13so18019928lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xhjhk+r4I/urUe50CHvmJaxBj9q3ZzrLGBb8/x9cWjw=;
        b=N7iPb/8U9sNHulv5n/T/nqtYGRGjrlGEMFOBX/D45ZP8pBDQ4bQn9gpWmqvXZ7SjyA
         ShmX8Onj+yeLWXIMzWY/slE6G4UgoDzLe5+ETDepQe0pCWjO5t+OZ+dlXQUUPEH1B5pZ
         lKY2Wk/RbKX1jia06jDA8UsJVXAUCPOozwk3L88tx1JGbt7dsyU4W7mawrqiiECvxWNB
         4pFvgp9E3+W/Nv9hEcE9c740Af97tL4s2O6Rm0Lv88JbRX2S21A5jJTtgsvAC39cuBuL
         FI4kTTD7IjvFfo8XATLf8eyKBD2sY/MKDEY2UjDalSHbh/BlEAx0L4vlRxG1RrpdweNU
         locg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhjhk+r4I/urUe50CHvmJaxBj9q3ZzrLGBb8/x9cWjw=;
        b=KJYJZ2RoPKcMZ+mE8u0+fOenHCoHnpsdJVhgB83/DJRnLlc0yJXdX7mv2VfxJrVbwT
         LRQ86b7blu/o95hX+n3WDrNx5MGUpFFpc0hpIuReqnQ+eWN1i2qnuUiyVOUUW6DAV1Pv
         VcMVuP06BCi7To/Qll+xGYYyxyx2ri7gZ7yyg/PuhQM23YHKsIjMja8SlSVz0eiD7vC9
         LGB7dkKKz60AkP8gswnrBVA+VvbzRbCuCvFB3Fam3Hg/z4Et+1HD+3cmBmMlEetwgZos
         USKACbfDAJ1wOpQsUzXSxnyyKXwzmdgOG/yfVN7t4rdK3Q2BoS64x7tkKT/9yagaGs3K
         RdfQ==
X-Gm-Message-State: ANoB5pkIADLJ6H0mWFZ2cGI7Lzk+/F5Wse60OSkBqq7+/QWvQE2I0uLF
        HfBvA41usKraoj4EayM836Iy3A==
X-Google-Smtp-Source: AA0mqf57xGpbOxVQYqGlY6dApDnrR3iSOA73z3w87Bf1ofEDLxMNEwYRikJWL2oK3oz6tOWmIy39Sg==
X-Received: by 2002:a19:6a0f:0:b0:4b5:6db0:d598 with SMTP id u15-20020a196a0f000000b004b56db0d598mr12785985lfu.20.1671533523447;
        Tue, 20 Dec 2022 02:52:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512074500b004994117b0fdsm1398758lfs.281.2022.12.20.02.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:52:03 -0800 (PST)
Message-ID: <a3414477-eb9b-83ee-ab11-b2b629b6d23b@linaro.org>
Date:   Tue, 20 Dec 2022 11:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] dt-bindings: m41t80: add xtal load capacitance
Content-Language: en-US
To:     Dennis Lambe Jr <dennis@sparkcharge.io>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alexander Bigga <ab@mycable.de>
References: <20221219190915.3912384-1-dennis@sparkcharge.io>
 <20221219190915.3912384-3-dennis@sparkcharge.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219190915.3912384-3-dennis@sparkcharge.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 20:09, Dennis Lambe Jr wrote:
> The ST m41t82 and m41t83 support programmable load capacitance from 3.5
> pF to 17.4 pF. The hardware defaults to 12.5 pF.
> 
> The accuracy of the xtal can be calibrated precisely by adjusting the
> load capacicance.
> 
> Add default, minimum, and maximum for the standard rtc property
> quartz-load-femtofarads on compatible devices.
> 
> Signed-off-by: Dennis Lambe Jr <dennis@sparkcharge.io>
> ---
>  .../devicetree/bindings/rtc/st,m41t80.yaml     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,m41t80.yaml b/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
> index fc9c6da6483f..6b72580dc031 100644
> --- a/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
> +++ b/Documentation/devicetree/bindings/rtc/st,m41t80.yaml
> @@ -33,6 +33,11 @@ properties:
>    "#clock-cells":
>      const: 1
>  
> +  quartz-load-femtofarads:
> +    default: 12500
> +    minimum: 3500
> +    maximum: 17375
> +
>    clock-output-names:
>      maxItems: 1
>      description: From common clock binding to override the default output clock name.
> @@ -44,8 +49,21 @@ properties:
>        clock-frequency:
>          const: 32768
>  
> +  wakeup-source: true

Why do you need it here? It's already accepted in rtc.yaml. Adding it is
not explained in commit msg.

> +
>  allOf:


Best regards,
Krzysztof

