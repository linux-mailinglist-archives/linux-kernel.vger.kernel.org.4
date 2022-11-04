Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84002619717
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKDNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKDNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:09:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461E27B3F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:09:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w4so2997630qts.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8hfa5U3lUaaForj2mH3Ulz54E7m/Sy69csnuU6d1I=;
        b=jthoUqjMA2TjIz8CooFEFC1WQHTjAz/A4lZ+uBXFlARKTaTZm0FEj8AbAXdQKI/C5Q
         s5rK/pzYhtrNhlJ5wBSI5+hhTg4UUXPAkUvsRr3XwWqJinBUi1Q4kzZXxDjsVAPh6Hl1
         +9x+timhhVAL+4VreRxB0tjGF1qNPvFsYLMstc9yva/ZlxvtGeicL1/pjSJ2HfXU+9f9
         ts6q52vkNK0dz3lVoZ6CKZqUtdW1lSDCGforMu9FuS8OkmcEXoO90fw2BpMGRDH5GzfL
         MqYithP93WSyajXKzqz24RY9kZDWosc5lI0a7VDDklwwxRUtErdMU7nmUTW1VQeaFKZI
         vgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8hfa5U3lUaaForj2mH3Ulz54E7m/Sy69csnuU6d1I=;
        b=StKeBtMkL7hv/4+9LDm3VY0Pb/HNp/SQvFnxnqoXDgxU1Bcdh9TeugP6eHJjcAG01Q
         jqQt6eGp0d0fap3+SlJ4Me50Ues/nUC9U5LrLrO+x2s6gkwQr2cfOocNq1BMPsgYZZyx
         x4oyHXjOERwmOcz1tC2Ad6MGSdGB4cS20mmnQMq5vgDbGh6u4NvOFcesqHQQFu+QAmvA
         ryzOjfrLu/V243/mySkYKF18g+56IkigUZmMi1AQKlItfOPiEOJLeXG5lsRPDjuSAbgR
         x+vSxznDFTAAvEtEjGZDCb6IY2gMqjJvfc2u3BuoGO1ZXi7q79ALYIhYIAJUzjplCuXF
         ynxg==
X-Gm-Message-State: ACrzQf32S6QYhg8eaJfgS9ES/0YtfWh+MUuSt+z0E5WaqOZw6ltc5SIB
        wE3cMJ7LKCKQ7auKnyxhZ5cj1/h8RHwJPw==
X-Google-Smtp-Source: AMsMyM6Mj8AWm3KMbV3ZCvDwJXJMgtC//MdJssJ2i8xP7YwpBQ+mizNHgB8VAwFkINWnPdaT9J8FPA==
X-Received: by 2002:a05:622a:12:b0:3a5:6899:5add with SMTP id x18-20020a05622a001200b003a568995addmr1816091qtw.629.1667567343572;
        Fri, 04 Nov 2022 06:09:03 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0cc600b006e6a7c2a269sm2861212qkj.22.2022.11.04.06.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:09:03 -0700 (PDT)
Message-ID: <6056fe63-26f8-bbda-112a-5b7cf25570ad@linaro.org>
Date:   Fri, 4 Nov 2022 09:09:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221102185232.131168-1-krzysztof.kozlowski@linaro.org>
 <20221103233319.m2wq5o2w3ccvw5cu@skbuf>
 <698c3a72-f694-01ac-80ba-13bd40bb6534@linaro.org>
 <20221104020326.4l63prl7vxgi3od7@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104020326.4l63prl7vxgi3od7@skbuf>
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

On 03/11/2022 22:03, Vladimir Oltean wrote:
> On Thu, Nov 03, 2022 at 09:44:36PM -0400, Krzysztof Kozlowski wrote:
>>> Don't these belong to spi-peripheral-props.yaml?
>>
>> No, they are device specific, not controller specific. Every device
>> requiring them must explicitly include them.
>>
>> See:
>> https://lore.kernel.org/all/20220816124321.67817-1-krzysztof.kozlowski@linaro.org/
>>
>> Best regards,
>> Krzysztof
>>
> 
> I think you really mean to link to:
> https://lore.kernel.org/all/20220718220012.GA3625497-robh@kernel.org/
> 
> oh and btw, doesn't that mean that the patch is missing
> Fixes: 233363aba72a ("spi/panel: dt-bindings: drop CPHA and CPOL from common properties")
> ?
> 
> but I'm not sure I understand the reasoning? I mean, from the
> perspective of the common schema, isn't it valid to put "spi-cpha" on a
> SPI peripheral OF node even if the hardware doesn't support it, in the
> same way that it's valid to put spi-max-frequency = 1 GHz even if the

It is not valid to put spi-max-frequency = 1 GHz in
spi-peripheral-props.yaml.

> hardware doesn't support it? Or maybe I'm missing the point of
> spi-peripheral-props.yaml entirely? Since when is stacked-memories/
> parallel-memories something that should be accepted by all schemas of
> all SPI peripherals (for example here, an Ethernet switch)?

Since we discussed it last time.  What is not clear in Rob's response?
He nicely explained the purpose of spi-peripheral-props.yaml.

> I think that spi-cpha/spi-cpol belongs to spi-peripheral-props.yaml just
> as much as the others do.
> 
> The distinction "device specific, not controller specific" is arbitrary
> to me. These are settings that the controller has to make in order to
> talk to that specific peripheral. Same as many others in that file.

Not every fruit is an orange, but every orange is a fruit. You do not
put "color: orange" to schema for fruits. You put it to the schema for
oranges.

IOW, CPHA/CPOL are not valid for most devices, so they cannot be in
spi-peripheral-props.yaml.

Best regards,
Krzysztof

