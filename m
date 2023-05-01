Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0716F3003
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEAJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:59:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7353CE46
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:59:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-958bb7731a9so482706166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682935141; x=1685527141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iC542I8sMMVaQ/GKCt5KrdijPnyOsGoeQvZFa5279s=;
        b=FTD6ea9xiiKA9CmBhw8FW4LKyQUFRuC89lG4rnIisz/8N1dldoe8cPSsN6MLa1SYwr
         gfhVVv/XY3zv2PTMgGAwn4219JxsRMUUboFHWzvlPp/1GDb6GWLfB1/MqA8nt07Q5ZsH
         MLj27lA648g3YAnkS95kNomb2Px4hkVKw5X25rSLrVFuRfVner1KSLcm7q4OM+oeM8p8
         J73jFRvf45UThva8feihLugrk5xVJLSBN/C6FBMh5I1CEMemSkN7uLtjYiWKcxkwA1An
         1CjWGNGp9ivABvGTzo+bp/8Uepj1BIfduNN8ZwDwET0gAVDW7/RRJEU4SyD8ZOmFCl0A
         cMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682935141; x=1685527141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iC542I8sMMVaQ/GKCt5KrdijPnyOsGoeQvZFa5279s=;
        b=HWOcWjONkAjLwJeCfeIof21l0jkJfelDwvw5UJjAWw5jk1JTweMLhyiYjI9g5bEoFO
         kcpLaO/gyrmEok93pmpvAiWimvPNyEmypojpZtaIZce/DJ8mrpLcCVgEFJEWiQSBWHxq
         LZlxTr1NAeN5ag7rpOwbQioJEvtWX4Xra3cXrwKW2WJ0D8qzM8AjLZrvAAEHb+YHmEIa
         s5Bx169Q5rKTRIvSak/GoDjLBKjSNqa2I9XoZHstkRFKuTes9Vw6E98fH19SVXMPvvgb
         2GcalMBJyIWn/j8OpjdOI4kUiKZ4uY/2fUyCmjwk5VU/dOLl2GjSMcXP1J9Jbdtz9887
         L7YA==
X-Gm-Message-State: AC+VfDyJWrxe1FJ8ltTd4Ce8K4FnEcmBTgZzIkeNc5XQQh4St9HTmIPS
        OfgL9qlS27gW31NbJpOXwKx53paBlsUjSBEwnuzN8Q==
X-Google-Smtp-Source: ACHHUZ5tqLgVByqmgtfFg0+IfGabRKnA3PjKgolnSWjhoxA7MZt9uWHkPm73ChEJKMLqaehLn0+ANA==
X-Received: by 2002:a17:907:7245:b0:94e:b3a1:3ed9 with SMTP id ds5-20020a170907724500b0094eb3a13ed9mr12018150ejc.49.1682935140884;
        Mon, 01 May 2023 02:59:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id oz5-20020a170906cd0500b0094f58a85bc5sm14534591ejb.180.2023.05.01.02.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 02:59:00 -0700 (PDT)
Message-ID: <36e7a445-7d19-911a-1a94-ffc30172e1a3@linaro.org>
Date:   Mon, 1 May 2023 11:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:58, Xianwei Zhao wrote:
> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
> applications.
> 
> Add basic support for the C3 based Amlogic AW409 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> ---
> V1 -> V2: Remove new arch, and use ARCH_MESON;
>           Modify node name, and delete superfluous blank lines.
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..bcec872c2444 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409-256m.dtb

Looks wrongly ordered. 'a' is before 'm'.

> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
> new file mode 100644
> index 000000000000..edce8850b338
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-c3.dtsi"
> +
> +/ {
> +	model = "Amlogic C302 aw409 Development Board";
> +	compatible = "amlogic,aw409", "amlogic,c3";

Missing bindings.

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

