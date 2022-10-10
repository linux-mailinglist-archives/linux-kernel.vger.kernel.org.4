Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88B5FA0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJJOz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJJOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:55:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2F26138
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:55:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so4577339qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZbLB4JCRD9eMPrz6hZDO0DGi49LxoO2ksZ24HFdMXE=;
        b=Az8N6bWO/eiut7c+UDPy5gPlcSL4FZPXFgWCJe2LaqDwWujMdxCX/ZD2MmMwHGUKUY
         NY7EmBcxMvzb82Yo6vI/iDPXUaQcQHH2aukKZnEsJaqPGcnu/06YIYZrMSxUwIU8wm+Y
         47mASZsLd5TZ4X/6oH87EEHhhEZ5pHWD2ETH4SSPW7PHBOQPQIfTbEoetlauO7x2OVlz
         L2OEycu4OziI6m33Sp+DS2RcSRbugoxdikbyNmUHJ2VhanKaHxVcIDl1DEcHddBxpM20
         n3rB/Y7nZh1fHaudAcwonu1paU49Y+WnsbdKniUifzad1wEQXt/7UOAskXH+tIYlpIgv
         1fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZbLB4JCRD9eMPrz6hZDO0DGi49LxoO2ksZ24HFdMXE=;
        b=MeezNOkJ6UXfnc4mbQOxV5Zzfh2CiM9e54dUhpCwEinMMZQm3iLtZ4QKeFnKY7LDzl
         gfYx43HfMUxOyQnLZmLcmjKAgC/7Qm1oLPGPnwkhkWE/Xnf3p3WU0jnm8PTBmdTPoWIz
         Rbi+RvuLQL64ebkBzBbQs5rWp5QirbWSQFnJEbiZlZWdOU4upSNedAaWnVlKr8Xgpn/Q
         rE0N2DzA9bMjERFNH6mxWdRC0LumuAa1WJEWzD/juisi4hDmimzjVJp1KyWsUJRRR6Go
         e+MPW8eKb1kmxcoDPT1VB3c9LjEPXSKajzz2fZBcaS5TiWaBaqPB+7BxjcjEWEgn018m
         +nPA==
X-Gm-Message-State: ACrzQf0vJ5ivsD0QVcp9wFSpNA3L9/yMg0HaxP7SNrUJwTC5YpBbC2FL
        6s9nTB/INmD/ayJUUwcwdnWttg==
X-Google-Smtp-Source: AMsMyM72FXX/gmvm1GIWKH7GJ5BuHjnNd8tECzXDhUfrvSe8aAejLL/3rhQIHb4O5m2pR5KfpYpVbg==
X-Received: by 2002:a05:620a:34e:b0:6ce:43ea:89b0 with SMTP id t14-20020a05620a034e00b006ce43ea89b0mr12941414qkm.30.1665413715416;
        Mon, 10 Oct 2022 07:55:15 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id h7-20020ac87447000000b0039a372fbaa5sm2495397qtr.69.2022.10.10.07.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:55:14 -0700 (PDT)
Message-ID: <84b6dae0-d503-bbd2-d483-80462917afa4@linaro.org>
Date:   Mon, 10 Oct 2022 10:53:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/8] dt-bindings: ingenic: Add support for the JZ4755 SoC
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221009181338.2896660-1-lis8215@gmail.com>
 <20221009181338.2896660-2-lis8215@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221009181338.2896660-2-lis8215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 14:13, Siarhei Volkau wrote:
> JZ4755 is a low-power SoC similar to JZ4725B which is already here.
> 
> The patch adds compatibles for parts which aren't implemented yet and
> they are subject of this patch serie.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/ingenic,cgu.yaml   | 2 ++
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml     | 1 +
>  Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 4 ++++

How do you plan to merge it? Usually these go via subsystem trees...


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

