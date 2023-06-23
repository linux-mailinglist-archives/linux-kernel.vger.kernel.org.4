Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEC73BE28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjFWR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFWR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:56:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBEF197
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:56:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b4826ba943so15332331fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687542975; x=1690134975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dqpntf/6Jri52Dcd19VIMHj5sv//Ye/CfucOhTnMjgU=;
        b=Yj0UJFhh2g2V49OOG4n5Gda142ZxJ4dg235MQYhivc9d0ZojA3dKvfYOhxBujrF9QI
         U4BTstcBKpe6uHtOYFF+W25IqepRYllfB/w9tYjAhM7uTCxl9/yr5plD/R6Lit+hFGmT
         +jEV8l66VXQsCO+UXk+jU+tZl1o3rgu8HvvTzh0eD1n9/uHCn6h3Xn1wx5T3ckK3GCzr
         eOr0wXf5u3FZdHmY2gYkQsBHuP+2xtzHU6w6ez03wHwx3JeJ5mxSAX2EhBASwKXh6aeD
         LPewZFDqiWRhO9il6HKDANA87U9FjG7oTr2hV+wrrTHDgRDEYzARs/MDUSDiu7gqileL
         VEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542975; x=1690134975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqpntf/6Jri52Dcd19VIMHj5sv//Ye/CfucOhTnMjgU=;
        b=IJWAOuIJDsSvqs19jdZxXh3je2aNWUMOLLYtZEuJWptm+lLOZzF6iZ8IOvMQsvBnLD
         q90lW8w+STNAFwEMPsFeHoZabgyHUlR0oV813459/Bc/NIyNt4zhSwD4ZjW4CLuEvnZ1
         Jd6Lpm6VWyrDIaU6NA419O0inPRkeGSzBhVZECcwexhZfj8ELJhCw7rFdhxg2PG8RrJZ
         CWdwhFoyWar/5WCvwGSnIbWSlhqv9htBLxDeQdvI5QdrpiecZOwvL2Efsf9wj/+cQH1o
         azX9SA9hZPnIRnhDCI/sEYx4PkE6wE2Q3izNyH43T97tjyLgz5JgSC5fn6M8EhEPPWe/
         K2bg==
X-Gm-Message-State: AC+VfDwq73EOcbwEK1qZ1o9jJ2z+vOWgOg4r9xfPS0JJz5If2h6cpUYH
        tv4NRk++pX5dyWUNuPcB6ew4rxhqtq9d9oIf7xk=
X-Google-Smtp-Source: ACHHUZ5Rb1W0hIZd8jNjDreq5gpwDgx93jadu/h6j65zS2ADyQMD99TR5ZTtPVk0E+fLejpNAIB9BQ==
X-Received: by 2002:a05:651c:1022:b0:2b4:636a:67f4 with SMTP id w2-20020a05651c102200b002b4636a67f4mr13763243ljm.20.1687542974817;
        Fri, 23 Jun 2023 10:56:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b00977eec7b7e8sm6279522ejf.68.2023.06.23.10.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:56:14 -0700 (PDT)
Message-ID: <4fba1603-5741-ec1b-122f-d6a92803f49a@linaro.org>
Date:   Fri, 23 Jun 2023 19:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/4] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Content-Language: en-US
To:     tanure@linux.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230623081242.109131-1-tanure@linux.com>
 <20230623081242.109131-3-tanure@linux.com>
 <a885b97e-aaf0-cb72-f25b-71054d6d3fe2@linaro.org>
 <CAJX_Q+2qZg+RuwxmnM3rzs_akt_UMJRx+=aMxf72P-sGNjm9uw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJX_Q+2qZg+RuwxmnM3rzs_akt_UMJRx+=aMxf72P-sGNjm9uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 19:53, Lucas Tanure wrote:
> On Fri, Jun 23, 2023 at 9:51 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 23/06/2023 10:12, Lucas Tanure wrote:
>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
>>> There is no need for an extra compatible line in the driver, but
>>> add T7 compatible line for documentation.
>>>
>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>> ---
>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>> index 01ec45b3b406..ad970c9ed1c7 100644
>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>> @@ -50,6 +50,10 @@ properties:
>>>          items:
>>>            - const: amlogic,meson-g12a-uart
>>>            - const: amlogic,meson-gx-uart
>>> +      - description: UART controller on T7 compatible SoCs
>>
>> Your description is rather incorrect. This is UART on SoCs compatible
>> with S4, not with T7. Otherwise what do you expect to grow later when
>> adding more compatible devices? Just drop the description, it's kind of
>> obvious when done correctly (but can be misleading if done wrong).
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> Sorry, but S4 is already added in another way, which accepts just an
> S4 compatible string.
> But for T7 we need a fallback.
> Could you let me know what you're asking here? Redo S4 and add T7? Or
> do T7 in another different way that I didn't get?

I comment only about the description, so why touching anything else? You
did not add here T7 compatible SoCs. You added here S4 compatible SoCs.

> Do you want a v6 patch series? If yes, could you be more clear about
> how you want it?

No need. If you are going to send v6, you can as well drop the description.


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

