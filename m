Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4E5E69AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiIVRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiIVRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:30:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7E69AF9A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:30:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b6so11813016ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3d4XtRz1UVTn9UF6tNTg+CLRSot5BsaX/kpuz1aoWSk=;
        b=gzyjrFUWv6sH5AP1pBpkvTbYf2jzgM5J6nmbzm5OLICG5oHqLOc42PB0JjTtgfVYQz
         BF/uvdqnVUjIG0gUSDXOAGX43nM6ksXQIiY1tSzXR1SMOmRV5qUiDglZFJX41AHE3giu
         tg/8D7PwcQb91U9TFbzIK7dI4g4owsWB+m2N+6yfrX+ZQdJ2gu9iY63t5Yq16lfgOhyE
         0Dh288gd7F5g/9azqxGNWT9Vw9AZd7/KGEigtoukXStyVge9qfZvf9M4unSyF+lhL/Hs
         AjpOOO/Vvn6DR5nNwV7Y3lC+pNxU9oAWVvO2ucAaZXVvRZzPcLjP7UaIuHmIFAASf5QE
         O7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3d4XtRz1UVTn9UF6tNTg+CLRSot5BsaX/kpuz1aoWSk=;
        b=yDOmrM6z25nSnn0zbV4uCmOZE68XmB0CCwRzbg386KVn3CKBW+hYmD3ltlZUD5xJJw
         iTsbUdvh3E/I4obgkSx+Y7RNX3dJk+SNmiAewPxhrrj+aJHkeki+6KIIeAywUAzijd36
         AGswvteD6h+hG3NS2NSHIyBGfqi6DPZ6RAKQTzjHr+4FLcHSX6vuwIim+Wk6sTt3Iks+
         BTx0IcdXREpPrUzMihPQncZMWtTN/tptCO6fEwfs+rLKL6eguj8FdMZvsKzMEH7yT2/d
         JiuJfCMsY7/uVis6G837t8X3QwdZyX2eKvAjjrHSfejPU0zdl2lvfHhimAdCKT2DVT2U
         LJRw==
X-Gm-Message-State: ACrzQf3ju2DQ4iW9t52uyhnKUZgskfwY7n2v0+etudoGg9gBa7+uXXjc
        6Ktut368zb3831OZ0IVf2qZzXA==
X-Google-Smtp-Source: AMsMyM6UoHvK8OQptpz3VhwCgTvbTRlcBxKMUrZWJW1n57MxTQw07sco9Ija42Do0y41A8n03+5iNQ==
X-Received: by 2002:a2e:a54c:0:b0:26c:50c6:75c1 with SMTP id e12-20020a2ea54c000000b0026c50c675c1mr1540727ljn.408.1663867807861;
        Thu, 22 Sep 2022 10:30:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c124e00b00266af46abccsm1011655ljh.72.2022.09.22.10.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:30:07 -0700 (PDT)
Message-ID: <14c980cf-314f-811f-98b8-18457625c2d6@linaro.org>
Date:   Thu, 22 Sep 2022 19:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] dt-bindings: rng: nuvoton,npcm-rng: Add npcm845
 compatible string
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220922142216.17581-1-tmaimon77@gmail.com>
 <20220922142216.17581-2-tmaimon77@gmail.com>
 <29d54940-997a-865a-b9d0-c043a8c9ce99@linaro.org>
In-Reply-To: <29d54940-997a-865a-b9d0-c043a8c9ce99@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 17:08, Krzysztof Kozlowski wrote:
> On 22/09/2022 16:22, Tomer Maimon wrote:
>> Add a compatible string for Nuvoton BMC NPCM845 RNG.
>>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.yaml | 4 +++-
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

And un-acked. Test your patches.

Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

