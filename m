Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F37032E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbjEOQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjEOQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:28:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FB127
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:28:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d84f5ce4so3904941f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684168124; x=1686760124;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0EEEgIKjrzXriSIZ47448RB5cvvZ9f5tDK/8irMyJ0A=;
        b=q+6DFdEJ9P6y6gOzW1Amd/ymELg/jIXWBJNSmQSpi/fDkwod/uEA41cAt0DT+rXDgR
         ke33N+i5dCKM0/P2JhM/9MEY5E1bi4U+Iq0vWxU8BCc6Pjf4fxCmxEo6RbO8629K9qT0
         Az65ViRhzQSDrYqSeOXa8lkXrLTkcxhkVDjR0CbySgGeN29S0/BRdQFAOAZ5qfZvw6QN
         rIIEaev5SmOQxj+nuZBy8HqF4f4iv5q8qvDaL1D27MUur1oSZZ3R/UEU3+4nV2FCNwmB
         I4JbiHRS0HIMLtqwIWW9pHJeHUlq7/cjJ3WS69iYg8SXXG/37NP4P6t1RJytRyhy6MGF
         bH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684168124; x=1686760124;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EEEgIKjrzXriSIZ47448RB5cvvZ9f5tDK/8irMyJ0A=;
        b=NPxehlImv8hWuPzH09a6unduKkAQlQFpq6wUOtweIXjYGJJTQenfkzFWcYIq7wJaMb
         kaAuospWdhcR81kkcFQ0aTwUdBEwh52KiOb0dfDVQyAnCAypv8HyhBd//bIJPBhsSdIo
         ONX4qufJKlXRKMLIIPDfu4/Jz4yOfSwGQWdviwPzEObOwCXaQEkIzzl3fn6LpYGimnJV
         D/tCIr19IJCrzy2nCqboE8ILm98QQsYLjEJ97/mViakRGiw2M46Ud5lpzJ6y4Pzxch5J
         7QnXuFOVbvFANtAwDhS7UKNBWtnljcYrHhvL7g1j/OUefOXnS/bgP+UX8bFUruqkLjqZ
         VqAA==
X-Gm-Message-State: AC+VfDxJDzI1R6S28Wkhu3buzBvO3MIwY4mx5/jeIMUN4TxAUyg9vDIQ
        oP0Kfeuf3OBbUXYk0FrGpGdReA==
X-Google-Smtp-Source: ACHHUZ4keKZPJ3OsaATsIDklN6VcscEM8Q+RmelGpy5mLTn+dW5HEPELp7rHCx1oGcdaks1d2wvlwQ==
X-Received: by 2002:adf:ef8c:0:b0:306:8034:b2e4 with SMTP id d12-20020adfef8c000000b003068034b2e4mr23192900wro.69.1684168123493;
        Mon, 15 May 2023 09:28:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee7:a396:6195:bb56? ([2a01:e0a:982:cbb0:ee7:a396:6195:bb56])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm30127103wmo.0.2023.05.15.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:28:43 -0700 (PDT)
Message-ID: <14405799-9b56-6767-4a35-51ab8ae636a9@linaro.org>
Date:   Mon, 15 May 2023 18:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 04/13] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
 <fe2f22c7-8c39-faf3-bc65-a7c089200134@linaro.org>
 <eaa3ecd0-dcf0-01d8-b3ea-9dd900215839@linaro.org>
 <80da6b9e-ba82-d2c9-2854-b444635150fd@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <80da6b9e-ba82-d2c9-2854-b444635150fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 18:22, Krzysztof Kozlowski wrote:
> On 15/05/2023 18:15, Neil Armstrong wrote:
>> On 13/05/2023 20:32, Krzysztof Kozlowski wrote:
>>> On 12/05/2023 15:11, Neil Armstrong wrote:
>>>> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
>>>> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI Glue
>>>> on the same Amlogic SoCs.
>>>
>>> Please wrap commit message according to Linux coding style / submission
>>> process (neither too early nor over the limit):
>>> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
>>
>> This message may be automatic, but context is always important when reviewing,
>> this commit message is a re-spin on v3 that was reviewed by rob but I decided to remove the review
>> tags since I added a new clock and did some other cleanups.
>>
>> While the process describes "how the patch itself *should* be formatted", it's a best effort
>> and not a blocker.
> 
> Other issues are blockers.

I agree with that

> 
>>
>> I'll fix the wrapping since you pointed out, but referring to the submitting-patches.rst
>> file (from a very old v5.18-rc4 version) is kind of childish.
> 
> It's just a link stored in automated responses, what's here childish?
> It's still valid in current cycle! Look:
> 
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 
> What's the difference? Srsly, I can point you to submitting patches
> without reference to specific line if you wish... Or you can check by
> yourself.
> 
> I give the same reviews to so many people that have templates and Elixir
> happens to be the only place allowing bookmarking specific line. Which
> is helpful for beginners because the entire doc is huge.
> 
> I can make an exception for you and never paste direct links.

I value those kind of links for beginners and newcomers, really, it's a good
thing to do and we should all do the same.

But I always take in account who I'm reviewing, and adapt my comments,
I think it's sane to not appear as rude because we all forget to check
some stuff when send patches upstream, or at least I often forget...

Anyway, don't make exceptions or change your process for me, I'll live with it.

Neil

> 
> Best regards,
> Krzysztof
> 

