Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134E96A5445
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjB1ISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjB1ISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:18:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74712EC46
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:18:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so8786305wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677572325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlZr9oxmYNUQ6f8YSJQivzDcQiNNTEU7Yai8ML9O5lE=;
        b=au1/3g1GzCRev6Ak2uA4BouE6GKnfc6aFbZdP0mbKGR5mmYrF7nbpyPMHloJYjqUmL
         dGkVdftqBcy6Ddf4zyc8HfPqUIZH86xKyTBY2V0ajPhTLhrcKxVXEvZyoRTjNtWx7inB
         gIVEEabVNEzBrh2tFjlr5SJI8TlxUAUrrt3PsHIbpoFpJ45ZdXtVQJjrSAeDM/Zg6aYf
         i1aEkGRVq4XkaMlt1+00ybeSjXV51dym/aR3p1V5OS2vX8U621SyM7uPXBcMegJAdKAV
         8Ieq+6z3lFybeYHyxkIv5sgorMd8XE7XdOaLL0Vo5/2jiK/9/tOvzhq45rdq7xkH3ffV
         idIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677572325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlZr9oxmYNUQ6f8YSJQivzDcQiNNTEU7Yai8ML9O5lE=;
        b=qUpeMgZE8o1McYMY53A7E7cFIuTZU9BjndDw9TIyqupQfK+xWPPWfJ64/9xsQNwyVt
         sE7dn8vc8HljSNi0QbwrNPovzZY+XMJwvgwAmSKqwLlgMMGNzqRCiHGI4OYwZs+FG51q
         CANrIdPigAG5pz3gYRXvxePxkw6qfZau7RVVR/EgZxEnSzEqnJmBW5uMp+sBrhQhnC47
         tesqJu46AHrz4o2y/p+DClHl1hDAN6OagzexJvC3zt/V2jtlWiDGpb/PxjQvJiyG7xpa
         sDVyxUzofF26JllQlBxMF0J2kVg/FsKcTdUZOd0W20AoiZ8UI8kXP7jBZIPFs9C+OfOT
         cKQA==
X-Gm-Message-State: AO0yUKV7eZkIKMhlkxMVEiormBYBo7g3fARQhvJmPiVSX1QrgpVkFkSj
        59gvOwAD0fP1EMPEppot9uPpJg==
X-Google-Smtp-Source: AK7set/8ouL5IkXuB8PTui01SZapBw/nJOwDWjonLcPESa00+L/KSM/f5xxPdkwfHvL/yf3QLTU1Yg==
X-Received: by 2002:adf:dbc2:0:b0:2cc:5ee8:fee5 with SMTP id e2-20020adfdbc2000000b002cc5ee8fee5mr1363557wrj.71.1677572324894;
        Tue, 28 Feb 2023 00:18:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c0a1300b003e4326a6d53sm15105502wmp.35.2023.02.28.00.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:18:44 -0800 (PST)
Message-ID: <64f65665-1d3e-b629-d3f8-dce63aaee8bc@linaro.org>
Date:   Tue, 28 Feb 2023 09:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: input: atmel,maxtouch: add
 linux,keycodes
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht
References: <20230227205035.18551-1-git@apitzsch.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227205035.18551-1-git@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 21:50, André Apitzsch wrote:
> In some configurations the touch controller can support the touch keys.
> Document the linux,keycodes property that enables those keys and
> specifies the keycodes that should be used to report the key events.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

