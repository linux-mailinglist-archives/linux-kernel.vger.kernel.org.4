Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33276101B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiJ0TdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiJ0TdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:33:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B917A773
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:33:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z6so2005570qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQI3LphKdUKfSMPC5E/0S2hsbKeYljk0IHAsBDPnaQk=;
        b=rHY/Uj8d1kLGva+GaFjVY77q7FMzS+C9HgWiMagaOYih0C6ETP2Gakc5AAKXKLaTNi
         qUMx5CK0KtwFK0T5XPRgM1HQUQfuIeE8CT68hmcsWWZI8hzLaVM0ud6+BiUMXsE7Jca0
         LWe4IzLMMa/gNyqmJL3jt369cY6OXNf4tJ3XmrEurQL9RwXU9KFtw0NgabaL7mWRtKuJ
         tEKS/fnJ4XN9oN7odri6nZQhqoNj0gb2PL1SbKO7BnuMNbyq7ZYMKkUPAjVsRwmwzMV7
         Kr/VSQoQfzPnyDNYOvW1QkqyYyE0l4LdinDECoYIRlcA9RU12JZa+UnO4UxlI1o8/rar
         lmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQI3LphKdUKfSMPC5E/0S2hsbKeYljk0IHAsBDPnaQk=;
        b=8HGNZJwQzxy2wQXMsB4LJSn3SIUDyzQovD4bYEt17HGn3yEkJAx+f4DVCo5w9SjGkl
         0xCHNtEDcfdOrWMbryk8RlA4zRSvWiup3Zx4u/ytD3VKDntEF/SA/H8Jzp1WcbY+ELub
         mXvPGzDdm/E6mnigwC7cFwJViuMOqEZ4hqv8fjSL8bB1gfFUZL+Ry8JaPnpWR7lZ1QY2
         ICf+fVmFlZG9JCV6WUVh3nhY/8o46mOsjieUfByxeRCIviLe8UN9FohLprcTp/2/YDwk
         fnMgObeVX0694gm69mLjpKoFqg3ms4J9/EQyH9XC7E4Ca0Om7w95ZcWlns6Pim1ZPBbg
         yTFg==
X-Gm-Message-State: ACrzQf1I9py7ucAyWmhmvxTH2LZfOW5I+mTE2nwDIVrXu7lI/ODkxj8M
        XIJpEBGZdu7PEMEYeCLCQy6rSg==
X-Google-Smtp-Source: AMsMyM6Doqe8fC75+O0x7wOvaGjtUNeFFc4hfjCF5qjJWLNcXyOMvsGPgbmoPxFqRlYVxMh9/N73tg==
X-Received: by 2002:a05:622a:6096:b0:39c:f37c:4d97 with SMTP id hf22-20020a05622a609600b0039cf37c4d97mr43578676qtb.395.1666899195252;
        Thu, 27 Oct 2022 12:33:15 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a400100b006e54251993esm1514846qko.97.2022.10.27.12.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:33:14 -0700 (PDT)
Message-ID: <050f3d65-5720-9c97-1930-bc458c4c2fb8@linaro.org>
Date:   Thu, 27 Oct 2022 15:33:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/9] ARM: dts: nspire: Use syscon-reboot to handle
 restart
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221027181337.8651-1-afd@ti.com>
 <20221027181337.8651-3-afd@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027181337.8651-3-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 14:13, Andrew Davis wrote:
> Writing this bit can be handled by the syscon-reboot driver.
> Add this node to DT.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
> Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>
> ---
>  arch/arm/boot/dts/nspire.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
> index bb240e6a3a6f..48fbc9d533c3 100644
> --- a/arch/arm/boot/dts/nspire.dtsi
> +++ b/arch/arm/boot/dts/nspire.dtsi
> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>  			};
>  
>  			misc: misc@900a0000 {
> +				compatible = "ti,nspire-misc", "syscon", "simple-mfd";

You have syscon and simple-mfd, but bindings in patch #1 say only syscon.


Best regards,
Krzysztof

