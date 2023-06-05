Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62C721E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFEGfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFEGfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:35:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B839EA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:35:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so6558687a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685946912; x=1688538912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAkCrvHOWXDqwj1iMGZRedd16rhqvqKQgu07G0b3u+w=;
        b=e7E3JztSPDwCFOVrzxyEbVKg2EBeBOYgZaTU4BRpwJs1h7uHWXDo+l4Zk5OwWH3gxO
         EqYoWrI2nluRnjKjwdlqLEnBcCpOkMVsq/NL07i8ATGoappT2Y7Iu+bHCO+sxDx/d6PF
         m1yW2VgipEcnRLFaW68NCN+FFcFIJPbw/eYHR3Y07vtSoQ9V57ZsG/OrkuBfp0zcE7uO
         mUMJdZb3Ktm56WuGjYfV4znaUsZVjWccpeON3w72rzjU7HO+wQmcEKdi3vZPb9spMHEO
         MAxQO8sclY35BjwjlYS1iRkx51Kv62cQ0tFvY3zdkd4n9Jlo0VDzxWWtcb/m129XFaB6
         19jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946912; x=1688538912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAkCrvHOWXDqwj1iMGZRedd16rhqvqKQgu07G0b3u+w=;
        b=Jtl2q9/M5a2ZqTdosL6Z5gkdeUTl6TALjlaa7fqiEGJJIVxhA5GdqR6qry9ONqnwTv
         +GUeTNDpcjAiV63SMwmRE6Nce/C2uM2daSSGYte7PvGhxFGpyK/uoi6dvpbFQeIlesMq
         1G9ab65YOOj/8dXJv/iMCjVVeYlSnioPqFrlJtd0uSRCnmPOw3IyXR5Kn2gH7KxxnCKH
         Z6fS7hHtOhP9/nqp0sGPypy3WX/7MmsIHrrkvRKbwnIH8PRv476YQLD12lIA+BSncQqz
         GeiWC9kbVavaCd72J+u0FAY+G7DGiqsF2LJMdlYemHrwUYFCVUk3tl0q6pjNf+7IL5Sk
         SWow==
X-Gm-Message-State: AC+VfDy6XqSYict9lKkGkg8pkpLWObXT+tkz7RsmmpOoBYjlyQVM1vh/
        XVXtB2Xkm4od21LlwnRirJqdUw==
X-Google-Smtp-Source: ACHHUZ4BgooRJqWw2thRF8QqkzdRcCJ+hGa1VmZ7YEgpaG6Ikj580m9cbKbqSO9oirFRyquUlSnLew==
X-Received: by 2002:aa7:cd10:0:b0:513:53f7:8ca2 with SMTP id b16-20020aa7cd10000000b0051353f78ca2mr6734317edw.9.1685946911857;
        Sun, 04 Jun 2023 23:35:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7dbc1000000b005163a0f84a1sm3636951edt.48.2023.06.04.23.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:35:11 -0700 (PDT)
Message-ID: <c72f45ec-c185-8676-b31c-ec48cd46278c@linaro.org>
Date:   Mon, 5 Jun 2023 08:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/21] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 sam9x60 compatible
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-2-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230603200243.243878-2-varshini.rajendran@microchip.com>
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

On 03/06/2023 22:02, Varshini Rajendran wrote:
> Add sam9x60 compatible string support in the schema file
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index a46411149571..c70c77a5e8e5 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -20,6 +20,7 @@ properties:
>            - atmel,at91rm9200-tcb
>            - atmel,at91sam9x5-tcb
>            - atmel,sama5d2-tcb
> +          - microchip,sam9x60-tcb

No wildcards.

Best regards,
Krzysztof

