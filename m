Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6391863421C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiKVRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiKVRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:03:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD5A442;
        Tue, 22 Nov 2022 09:03:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n3so9124194wrp.5;
        Tue, 22 Nov 2022 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2ESf2ffEWNtfVyM0ZPvb6Y0s026dxSYBpFrwcaZ3J0=;
        b=jYH5L4jwO3/d+gHzNoEfN+SNyVccGsviLt9pM8GecpnpvqZNCOeanh91XhU9KlIWTa
         Bt6yU12pdtmPRaYodwRAFupLAk80R4xeJedy9BnqAWYbi+2IlgQ1IIQ6+Wg5ddg+xZPg
         Ne1X8dT2ltDivCtWGr1pN61s4Y5AN+S/DHlMq/+avsQLfAmXN8OX6XrzYMqC85/DYSgu
         pyzckN2+ZJ4vRprzLunP04BTAZx7zqpINeHK41p7vDkE1Qc33XKR8wxcZAzoMl9XhnP8
         ttx2giyAp2NdtLntxKdENItCv8OXzHTlqGOyTSCowzAoy20dgxe/3YcgnU0KNP8hZ9Kk
         z43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2ESf2ffEWNtfVyM0ZPvb6Y0s026dxSYBpFrwcaZ3J0=;
        b=Pe8qG60YPyBdeyGXGNscvdgnrtpWbP4xILJmzmYVpu9x/prcc4GU26p2uZeuYCazCV
         vdGWbIPfwBnSyszwgYbokFEZh/OhrsZGAsAJ6Er2Cemj5xh84TJP9tVtTXbzVvw2kcaI
         /bRKRhbnoJRzZ4kgJCdT5/1v5jHXk2pUhN2tZvFLtXLFXuG/SsiUiGh/SIau7JX2q1oF
         Zb8jJPxOo+xdonFVkCKMjtipB7DpjtAEeCCoeCueBlXDUXMhdc4LqIETpqnLN/7n4BDs
         85HEUZZrpXZAUhzWaAKaJeje6q5ErYoQ/DQ7ALLV7ej34NtsCOAuLLlz6u3kuD1tYvbk
         MlzQ==
X-Gm-Message-State: ANoB5pm5CXRHbW6jhSNhyB87e7otQ9WX8D7Ks/Y2XsWZ72/nQj3UJshU
        vTr7s3AyY2MP22REvp4hYZg=
X-Google-Smtp-Source: AA0mqf5AAB2WpZpQrxG/QW1P9YfLF2voM76+7M892xh+AKLCme4WOa5olE+MEanw9+a/FkosbhcpOw==
X-Received: by 2002:adf:ed8e:0:b0:241:d7ce:4395 with SMTP id c14-20020adfed8e000000b00241d7ce4395mr6251645wro.553.1669136584924;
        Tue, 22 Nov 2022 09:03:04 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id c4-20020adfe704000000b00241cfe6e286sm8503223wrm.98.2022.11.22.09.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:03:03 -0800 (PST)
Message-ID: <16774569-6dbe-3bc9-7471-f238e04e6050@gmail.com>
Date:   Tue, 22 Nov 2022 18:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/7] dt-bindings: pinctrl: st,stm32: Deprecate
 pins-are-numbered
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221122010753.3126828-1-bero@baylibre.com>
 <20221122010753.3126828-5-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221122010753.3126828-5-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2022 02:07, Bernhard Rosenkränzer wrote:
> Deprecate the pins-are-numbered property
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml      | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
> index 9d59208d83c18..eeb29b4ad4d1a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
> @@ -34,7 +34,9 @@ properties:
>       const: 1
>   
>     ranges: true
> -  pins-are-numbered: true
> +  pins-are-numbered:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    deprecated: true
>     hwlocks: true
>   
>     interrupts:
> @@ -206,7 +208,6 @@ required:
>     - '#address-cells'
>     - '#size-cells'
>     - ranges
> -  - pins-are-numbered
>   
>   additionalProperties: false
>   
> @@ -220,7 +221,6 @@ examples:
>                 #size-cells = <1>;
>                 compatible = "st,stm32f429-pinctrl";
>                 ranges = <0 0x40020000 0x3000>;
> -              pins-are-numbered;
>   
>                 gpioa: gpio@0 {
>                         gpio-controller;
> @@ -238,7 +238,6 @@ examples:
>                 #size-cells = <1>;
>                 compatible = "st,stm32f429-pinctrl";
>                 ranges = <0 0x50020000 0x3000>;
> -              pins-are-numbered;
>   
>                 gpiob: gpio@1000 {
>                         gpio-controller;
