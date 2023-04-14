Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA916E1DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDNH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDNH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:58:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE97165BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:58:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt6so5395151ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681459086; x=1684051086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+Yfacuylo4JJllG71Jbnk5n4HfFW0n3lsROPOxpb4Q=;
        b=hYsjh40aaQY+oQS6OIgh1++bqNzesCTrsemH5MrmXBQsMPZYgIi4sE2nGto8mUCzgI
         HqJ0WYIt/aZyqgqWn4/+kRwu0ykQomNrD1SafbfrXabhI3khubdOSrsApy+tSPYAsGuB
         718bbAdR5JvYxoItiKAM0UedmLR8y6RcSxqiX1UFL3LoGCy2c/DjcYiGnoBfxlP9MXGE
         yS+jG3JJHPYT+9lPqxwC171OFl+jLOrdA7IbUMmUsDsH7/73Q1We3YGCd4ID/8tLIS5D
         KCA8EUi/oDCMSMxZYBgP3Lb4OFJTMyKKMJIKvuRB0qzHT4ida0/ri8NWmjV5aAyjKHsr
         f7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681459086; x=1684051086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+Yfacuylo4JJllG71Jbnk5n4HfFW0n3lsROPOxpb4Q=;
        b=QZnZT8AxtEggUaOui4JOjwqLlZGqpImjSFKViqUH7jPglyynbAsN7aOJFG8aCi8IhP
         zQcHMVOt70/hMr/nG8Ayu2g2A7RPhKLRIRU2WRsaTtrXSTazE5BA/LCBnQUmeOSaWmtC
         eEvSQ7kPv01NoUtop649YpVKkoxexXxjqxOd4VatcmOs2XfcRlNnKV3mI6jmodV5639E
         5tpiDGlrfJS5c+hlTKtZXaaL2JrTdKzd5Q/akj8W9OjpylVoy5zRQ7ffhLPFdx0s6vCU
         wICxWxngZPODicz3AYU5C70pnJi8m8mc8Mji5ZgnKrzYW1af01EJwd4ITbaqwKa6hQRV
         JjuQ==
X-Gm-Message-State: AAQBX9fWtKGHThdoFMdiMxLVYDcmXTzGgwSvLxxUMZv0Q3e3wpBRQ3Mz
        hmC9ff9weXzPeHUdEBcVsvJVdQ==
X-Google-Smtp-Source: AKy350ayYVeThpnJSr6PrFCeZNPNgJ1qRrffU60LjVtr/ZwlCmdM05fvQSt0QM9iqYBYcNV0jvsAGQ==
X-Received: by 2002:a17:906:a3c3:b0:94a:8771:fb60 with SMTP id ca3-20020a170906a3c300b0094a8771fb60mr4272971ejb.37.1681459086379;
        Fri, 14 Apr 2023 00:58:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906c18800b0094e877ec197sm2089687ejz.148.2023.04.14.00.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:58:05 -0700 (PDT)
Message-ID: <45602a7e-9385-296b-d704-64cdf727f5db@linaro.org>
Date:   Fri, 14 Apr 2023 09:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add KUNBUS GmbH
Content-Language: en-US
To:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Stefano Bossi <stefano.bossi@gmail.com>
References: <20230414045747.5499-1-bruno.thomsen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414045747.5499-1-bruno.thomsen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 06:57, Bruno Thomsen wrote:
> KUNBUS GmbH created the modular DIN-rail mounted open source hardware
> platform called Revolution Pi for automation and IIoT projects.
> https://www.kunbus.com/
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Reviewed-by: Stefano Bossi <stefano.bossi@gmail.com>

I do not see it being used in current next. We do not document all
possible companies in the world. We document prefixes used in bindings.

Best regards,
Krzysztof

