Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A015365BF8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjACMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbjACMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:00:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33560FAF4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:00:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g14so31539051ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WASsB7/AJqbpaPPWYR4utmgdw/hH8Pgkp8M5/xpRI4=;
        b=Nth5ZQoNuZmn0yqe5lvb7E+hHBM8CT1C4aDINcQe8B9os4W9gWouhPkaymvvI0lyqO
         8oAlAGPi8NvRIYvS7ZQj6ZRDP6ra1CyAedk2aJiooHMyOA13HKLk4gLRvJHqikAjJgw4
         nxUQXIHZB7GnfcX3DdTbGzgKA3uomal39uupZGqFRgBVS81TQWUSDaqx3qYrRykXZRKc
         O3sIWbqBpXH9vN1KnchuzUpwXxV92qY16PSQnaUlnaEFDkzzCSgPmxu6q43lT1tdHP6C
         Uys+2Wxmp4j+RLqJC1c5UQKrbOr7zKylb8NmY8lwcYQIs7zuCOtGUiJCEboKQ8ViYnx8
         WszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WASsB7/AJqbpaPPWYR4utmgdw/hH8Pgkp8M5/xpRI4=;
        b=JjTr8kQgyiuPEogFSvQKcKw3Zsy7y2hwYjU5U2nZ1PSBVGQ4Tw/eToedeWMugeswDW
         yNI7NR+5Oa3C8x28auE5OWQHh9XoY7quwpTIY4nPOElj0OjHwbuUNaH6HhR5bGtSzCUO
         29/dPhzA7fxdPvW9BBFs+2IlbEcCqpasIypx6Sio9K2Hk3yOpf5jD3RkfRHPdU4dnw0I
         6sCseB4TEimqLD7pTImcGuDWpjB/qbz6x8qDpAdGUNjzHJYGOnefCyRSHwGZTi0paRBy
         x1+SKq3fQWQnIjjE7oZhC1osvXRtRn9613wcmc85+rAQwqEpEZo1020jHf6PBxmqT6oY
         7O/g==
X-Gm-Message-State: AFqh2kpG291Pxuko/AeEtlxqWKwfig7V6fXkjeKAcspByVkg3bp+Gbas
        TGxSM9qlyeokVhek6R2S4PaeRQ==
X-Google-Smtp-Source: AMrXdXuz2e5a92GvjETuBtgsHW6dLugRBY6fhHbi60NEj86Q2I8xP5ItVbu4751AwOJsiucLKTLGwg==
X-Received: by 2002:a2e:e1a:0:b0:27f:f46c:2ae5 with SMTP id 26-20020a2e0e1a000000b0027ff46c2ae5mr1457430ljo.6.1672747226522;
        Tue, 03 Jan 2023 04:00:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y4-20020a2e9784000000b0027fd238fd44sm1585676lji.100.2023.01.03.04.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:00:26 -0800 (PST)
Message-ID: <4632f71b-2b67-b634-1cdb-69ac741a8ef0@linaro.org>
Date:   Tue, 3 Jan 2023 13:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
To:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
 <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
 <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
 <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 12:18, Claudiu.Beznea@microchip.com wrote:
> On 03.01.2023 12:06, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 03/01/2023 11:00, Claudiu.Beznea@microchip.com wrote:
>>> Hi, Krzysztof,
>>>
>>> On 08.12.2022 13:45, Claudiu Beznea wrote:
>>>> Driver does only clock request + enable for DDR clocks. DDR clocks are
>>>> enabled by bootloader and need to stay that way in Linux. To avoid having
>>>> these clocks disabled by clock subsystem in case there are no Linux
>>>> consumers for them the clocks were marked as critical in clock drivers.
>>>> With this, there is no need to have a separate driver that only does
>>>> clock request + enable.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>
>>> As this patch depends on patch 1/3 from this series, can I have your ack
>>> for it to take it though clock tree?
>>
>> Uh, why does it depend? I understood the changset is bisectable and
>> removal of unneeded driver will happen later. Otherwise it is not
>> bisectable...
> 
> AT91 devices will fail to boot if this patch is applied and 1/3 is not
> there. This is because clock framework will disable DDR clocks because
> there will be no consumer for them.

This I understand, but why do you need this patch to be able to apply
1/3? This is problem of bisectability. Not the other way.

Best regards,
Krzysztof

