Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0B6BE4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCQJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCQJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:06:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09851A0286
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:05:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so17534281edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzBd7HT5FyF1nJ/VeywWx68y7xEvX1DO0Qu+XaR3Ies=;
        b=nFzHQ8e59uVOg3X5y/kmGeK5xG6QDYyZSib3GNyucs3oz+XLZI2Fi+ytZhHZ+PorXX
         AsDfbT7vtTV49SmQrY3DS8R0glPoribCUp1ydUq74Yjv5ai9XU2kBqrwbKxGY44wJk4P
         BpectOPAUXM/SyAoohmc/um6LwGj0pbGxO1lk+dLkRO34thmuNWGKkAg26g3xkqiDDXP
         oe+CqhAe8yRaHpiaiXe3/9T+2QnOrMoPvjy0V5/H4BK9jvdKZBIFbcoiM/8HR4JbM6pN
         H/HITyJ8CR6jYq9JdVj+3JGZ7yfm9OVaKyGSHqEqxluLJLEFTdRB7+gQcCqP8mHTIEKh
         vA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzBd7HT5FyF1nJ/VeywWx68y7xEvX1DO0Qu+XaR3Ies=;
        b=KA1JHErXD6mWQ0QSEVn9XJ4Skw0MHApHgO5ur6ulq+k23xsbrK+GcfReXMpiBm1w5K
         /9mK5sWq4ZFityPRrcR9oeFun7+BVehHXScpljWdSDADxB9UOAhHb9KMGPvSzZfFNTDt
         FD0EB2ycyjp/c+x5+EQeDvls6i5vsZGcKY6a6ZT50VloyN9PXdPvaKbcN/T5yQiFO0MB
         HzJBpfifw5sUHJgZYgjmpxMno1TPOZFgyJn5Jh3HMX4vR7zjO4z8/uuinj/hHwSL3/dh
         9erQkt/wXBeSSjeDchDUu6XwFKY/B5TPYfhgQApXw4yfUNmhKIitQOIWg77k7Y61OKiS
         fznA==
X-Gm-Message-State: AO0yUKWr9JOHEnzf+IEahev9bTiCdAlkNrtE0E2uUp404LRGHjkOx3YQ
        fbfZ1wUE7Q0JDrtOCBoq+/c1ig==
X-Google-Smtp-Source: AK7set+3ApSYPWrNrDJMa5s0BnGt06KsinVyg9V6q9n4BTTzQ3csEXPJyQOI88XIQvE/hDMHbuYUpw==
X-Received: by 2002:a17:906:950b:b0:8b1:77bf:3bdd with SMTP id u11-20020a170906950b00b008b177bf3bddmr14005064ejx.36.1679043927574;
        Fri, 17 Mar 2023 02:05:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id ce6-20020a170906b24600b0092101bb66desm723105ejb.147.2023.03.17.02.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:05:27 -0700 (PDT)
Message-ID: <7060560d-eb09-4400-7a68-496a53e5da33@linaro.org>
Date:   Fri, 17 Mar 2023 10:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: ti: Add BeaglePlay
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Andrew Davis <afd@ti.com>, Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
References: <20230316152143.2438928-1-nm@ti.com>
 <20230316152143.2438928-2-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316152143.2438928-2-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 16:21, Nishanth Menon wrote:
> From: Robert Nelson <robertcnelson@gmail.com>
> 
> This board is based on ti,am625
> 
> https://beagleplay.org/
> https://git.beagleboard.org/beagleplay/beagleplay
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

