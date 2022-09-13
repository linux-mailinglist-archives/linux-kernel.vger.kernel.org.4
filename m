Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04D5B6AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIMJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIMJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:30:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D155B05A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:30:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n8so1504408wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+N+ujER/9JIZn1JwaBf+A/u+Qd6nR459uhJiQp3pSiY=;
        b=LbGj1Sh4O3nW3xlqqLV1aGWl3y1uh/wNp/zfbXvAVph+Lt7FYiipo8a8Y4KiFCuL78
         J1PV+v54JPkpq91+5hRbvJlPRFHOf7T7oLJxpCV8Cvgk21C/3lPVsmyl1j63yrl+G6kU
         HCYT5psy/c7TCgQhjDk6pnhd8jkej0YNaBZU5anSGN3j7SlOaCaFXAw6oBp8/LBmRIsJ
         IPXDMQRv2dC7cs0S/R3JXMT00c1TgTu2ktbaEq/W63UlIcHCgIvy2itCdYfk+d5u6uAc
         KJ4gcyJcRy+QxMhIexv+9mq1rkim/71KVuBkhhmy/+VpC947qHLkV8QmWNWPiQoODPEw
         xeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+N+ujER/9JIZn1JwaBf+A/u+Qd6nR459uhJiQp3pSiY=;
        b=2KjSvOS0v9otzqoOSPMHfc8KfycbXUZVTiqTf5/rI8yGxZnS4ftg1qTgbvlc05WtMu
         Thrt96EAi2XSCuWY2GcGa12GF25qPlw6g5W6bmi64GekHmZq70d1Hm6k8cncrJm51z1v
         s/83sLsgWJ/q+FueWMFwuA0L9Huppq8pmv8RDZNxpW5FS6oZPT5I1hshMkcpJaXeczs7
         +E29jxBAl5kQi5X8fdc1wLurNOu3Csjl1yjITE6oAr4G8o7FyGYvEkiEncSQfEIxzgpK
         d8NQw6+fQyOA5GpPQVBZIZ1ksphlCoacfK0hAvyL4yaMpqZDdUYMhFrFe4RF6VTxHU/M
         76ZA==
X-Gm-Message-State: ACgBeo2RldC95ovMR5cNXPefTFMoascnCTL6yOatB1WU4iVJbQz6I6RP
        oNix1zOonqhU8+T3w3NkbZFz5A==
X-Google-Smtp-Source: AA6agR6tMZYMePH2bDBrW9HnCXYv1LS4Q6LJWPEY4WvD7F+T3PP8mN06GXtMIEfH3JWwrQ3ncYwvNg==
X-Received: by 2002:a05:600c:4606:b0:3b4:62b3:150b with SMTP id m6-20020a05600c460600b003b462b3150bmr1714539wmo.3.1663061437795;
        Tue, 13 Sep 2022 02:30:37 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c4e5300b003a62bc1735asm13221868wmq.9.2022.09.13.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:30:37 -0700 (PDT)
Message-ID: <f9e03913-b3dd-c82e-8c63-d912c0bbf443@linaro.org>
Date:   Tue, 13 Sep 2022 11:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, robh@kernel.org
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        Kavyasree.Kotagiri@microchip.com, Tudor.Ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
 <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
 <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
 <5f8ca612-5a89-db3a-42f3-a0613c192a87@linaro.org>
 <888b8ab9-f8cb-2e1f-465c-3cb97187fce0@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <888b8ab9-f8cb-2e1f-465c-3cb97187fce0@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 11:19, Sergiu.Moga@microchip.com wrote:
>>
>> Let me rephrase it:
>>
>> What your commit is doing is requiring additional fallback compatibles.
>> Therefore the commit msg should answer - why do you require additional
>> fallback compatibles?
>>
> 
> 
> The additional fallback compatibles are required because the driver in 
> question only knows about the atmel,at91sam9260-usart compatible. 
> Furthermore, it is also a better representation of the fact that the 
> serial IP of 9x60 is an improvement over the serial IP of 9260 (it 
> contains more hardware features not yet implemented in the driver).
> 
> 
>> Incremental characteristics sound to me optional. I can increment
>> sam9x60 with something or I can skip it. But you are not doing it...
>> sam9x60 was already there and now you require a fallback.
>>
>> Best regards,
>> Krzysztof
> 
> So, what is your opinion on the following commit message:
> 
> "Fix sam9x60 compatible list by adding the sam9260 compatibles as 
> fallback, since the atmel_serial driver only knows of the latter's 
> compatible. The atmel_serial driver only has knowledge of the sam9260 
> compatible because it does not have the sam9x60's serial IP specific 
> features implemented yet and adding an empty compatible without adding 
> support specific to that compatible would be misleading. Thus prefer the 
> fallback mechanism in the detriment of adding an empty compatible in the 
> driver."

It's fine. Also could work:

"Require sam9260 fallback compatible for sam9x60, because sam9x60 is
fully compatible with sam9260 and Linux driver requires the latter."

If it fixes any observable issue like lack of driver binding to DTS, you
can also mention that.

Best regards,
Krzysztof
