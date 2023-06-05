Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACE722779
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjFENdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFENdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:33:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9CD2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:33:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9700219be87so750688766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685971993; x=1688563993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5td0n1OvHthGT+rYvOKyDnfAlYftJUri63KAdUFjjX4=;
        b=GpGf+ZAHiKw5CeQROXmI7BXdxSJGNiH6ruouE6v57AAxj+pC7fiI3+8CpMO9kFwcuK
         iNPforeiEAMnIoXrJb1EZXYUwFVEQsMvAFZkRmdW4c6d7Ip5H2M84h4qjp28RNoKT/uR
         OMvw3dnaWEEsqky8/DMhbQDm3Dsq7CCeoTGvCohAFJHyuEpp50e4Fo1TnExn+9D1abNt
         yajUtClSURN7C9lC3mZLhrGfJU0b0OgOLcMpbvA1zwlYAnhP8/WbrPygdy0+2cSUmaEx
         cT4Bxbl2xDd0SYvFRMnYy68yKURwQTcIzWrbpmgGCdpvma6EImClRdauQWMvOD7TS0q4
         JdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971993; x=1688563993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5td0n1OvHthGT+rYvOKyDnfAlYftJUri63KAdUFjjX4=;
        b=csjZg2fA4aOHuMenKvaTxdqSmIztWKgQ1D/SnuKitNDZVsfEqGeoypmnflgPzdpZDZ
         5j0O5PfZeqhl2Ktj/ZxSOO/w+LugE5DtqiHZcnWnIPYjER7AzHM8FwC50ReMGjiotSmW
         y+V4HA/flpMF0/gj1WTbSKJ6NPO67ZbmKISunu1MGjhc1Gp8z3kefL6kE19gDjw8ZILk
         VwIvo1nGodlKWbRiyJQFF6kwVIMU70pE7befU5KueJrjkfdQyKAc5/IIs0DUn/u7e64A
         0ONfZg02k4Zox6wzic4f/PuG4CnadUHzOY29qgD1arfxzdb42ZSbNa+LiPdtiYMcqUaM
         tAeA==
X-Gm-Message-State: AC+VfDzPCNpPA+yqMe4qifnUEuaGUotkJqgpADqn1j15eeXK2vUp27KF
        UO+yo7OAdK+V4/bMcMnaNjsbyg==
X-Google-Smtp-Source: ACHHUZ7i0dZuu2ejZXYkgJWGy7Hr2iBDXk7V3bsNPClqMUut+YnNpuZvBzrBR+n5kZfawV9IaK5Sng==
X-Received: by 2002:a17:907:7e87:b0:968:1e8:a754 with SMTP id qb7-20020a1709077e8700b0096801e8a754mr6829413ejc.72.1685971993350;
        Mon, 05 Jun 2023 06:33:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709067d5200b0096a27dbb5b2sm4196195ejp.209.2023.06.05.06.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:33:12 -0700 (PDT)
Message-ID: <9296f953-62d9-fd77-ffcb-42dbbcdcc77f@linaro.org>
Date:   Mon, 5 Jun 2023 15:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 17/21] power: reset: at91-poweroff: lookup for proper pmc
 dt node for sam9x7
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        sre@kernel.org, broonie@kernel.org, arnd@arndb.de,
        gregory.clement@bootlin.com, sudeep.holla@arm.com,
        balamanikandan.gunasundar@microchip.com, mihai.sain@microchip.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-18-varshini.rajendran@microchip.com>
 <2a538004-351f-487a-361c-df723d186c27@linaro.org>
 <c3f7c08f-272a-5abb-da78-568c408f40de@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c3f7c08f-272a-5abb-da78-568c408f40de@microchip.com>
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

On 05/06/2023 15:04, Nicolas Ferre wrote:
> On 05/06/2023 at 08:43, Krzysztof Kozlowski wrote:
>> On 03/06/2023 22:02, Varshini Rajendran wrote:
>>> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver
>>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>>   drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
>>> index d8ecffe72f16..d0f29b99f25e 100644
>>> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
>>> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
>>> @@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
>>>        { .compatible = "atmel,sama5d2-pmc" },
>>>        { .compatible = "microchip,sam9x60-pmc" },
>>>        { .compatible = "microchip,sama7g5-pmc" },
>>> +     { .compatible = "microchip,sam9x7-pmc" },
>>
>> Why do you need new entry if these are compatible?
> 
> Yes, PMC is very specific to a SoC silicon. As we must look for it in 
> the shutdown controller, I think we need a new entry here.

??? How does it answer to my question at all? What is exactly specific
which warrants new entry?


Best regards,
Krzysztof

