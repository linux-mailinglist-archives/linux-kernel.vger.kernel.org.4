Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390E602D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJRNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiJRNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:32:32 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B02CA8B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:32:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d13so8585356qko.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaCHs2xS34elvJKmekTcmuQN9rNgKKexethJB2Y5REc=;
        b=ZjLD7F1VbceTQdc2FVYGM7rpP0gstOOB09yNhHNiAVOxHHRSI7rGQKG/pWUAG9tV9u
         xsu9qHuKEEYagg01nvbAohXXIwLdUGr59Bf+RzhYYiPHCII2jlQ5LBcNagarjtuR7QKz
         x49vCaGeYNSKtFDuti8ryyppzuXuaHEsY/ezLvw7QniellFRh24Ql7wd4m6hgzrF1JBF
         d84sYUuyKZlSpbZPk/76KcsOZxmzkzXbooe39RKpshXZEqRVWUhwKjCJHcF/qzXAFMBO
         v4UapfMF9rX5/53ohSH4zefn1KbtUo1MBUIY+TvJoWYx1ua+XHg40ymsrkA/SF8QfoeK
         masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaCHs2xS34elvJKmekTcmuQN9rNgKKexethJB2Y5REc=;
        b=A3jBlOcA9+am0UYMm+EjemRl2c3wIMjIXHUWOjFdOxgMMSC2BuT+3U31pP4BQVGxeM
         W5Ejf6vsBaSAo4lggmyWi09RXORtzMCNxx0n+/p4WldJRhWtkEbaYyF2o7TCeSavucEl
         FTS39YN7zuMEhh+TGPEa4SyDIdbPiradUqodOPgYhZdzsKoOfc09ibW9a7uAWEwCYEut
         RKOwI54z/JgI5Hor/ls31pvpTw84g3Spwm4GfRYMGN8aED/HLTcNNwFu5O2qO9lNusil
         09pU0Oy/yihZNgMPNdg6ZbymmBijF0BKinOl4gSJiklSxS7hp6kMU7QfVIm8BrtVsTcc
         +wgg==
X-Gm-Message-State: ACrzQf31H7D1KXvyH8YdqNF3/U+Y0qzwBKbVfDi92/ySxk6XBpxu1Wov
        VHug9aC/hCjNFqRQjhzlACZEAg==
X-Google-Smtp-Source: AMsMyM6HmKsH2C2pBgFfSroERxT1KE12W4nAI9sADy1phl2YVcta9wYDoZr46YTDutbO0FZuaKq7aA==
X-Received: by 2002:a05:620a:2150:b0:6e0:79d1:3216 with SMTP id m16-20020a05620a215000b006e079d13216mr1799310qkm.406.1666099950341;
        Tue, 18 Oct 2022 06:32:30 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a28cc00b006ecf030ef15sm2427438qkp.65.2022.10.18.06.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:32:29 -0700 (PDT)
Message-ID: <d681e41f-fd8e-f233-2a25-53c4e0a52c33@linaro.org>
Date:   Tue, 18 Oct 2022 09:32:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 05:27, Krzysztof Kozlowski wrote:
> Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
> compatible.  Drop the '-a1' suffix from the first to match what is
> expected by bindings.
> 
> Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index c698e6538269..2010e3cb6158 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "AST2600 EVB";
> -	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
> +	compatible = "aspeed,ast2600-evb", "aspeed,ast2600";

This is weird. I sent this patch on 4th August but it was never
applied... yet instead I see a commit in mainline from end of September:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d916109169159f9319f45ce7e1339e41eccf22c4
which was never sent to mailing list.

So instead of picking up existing commit from mailing list waiting there
for 1.5 months, Joel just committed something without sharing in public way.

Best regards,
Krzysztof

