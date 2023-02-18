Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069F69B952
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBRKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBRKUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:20:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40420047
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:20:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i28so1183493eda.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXWBqPKJATEbQwMYn1AOi6oyN/FWqf7mF2sCGoJ9wDs=;
        b=Ng5uo45ErLmboggTHebCdSpnwp3piawmsLsVVqlNi7RHFIXAsLnKY6k35oWiVl/TE7
         xZcX5WoQM6voUzlj1B7sUJwCV4oK0kpVtJpKXvu7NAhqOBY4+7Z6oHQsbv7YUaZ0JRYt
         GsuiDLRlhDomrxfJT51N6BsHl4LsBvTtIsK+ksat91OUnm0BItUjXTKtmDwYGiSLfPv9
         fd7uiOASPoDC1BOBt+xnpIjj4PgXZWJ2iswOSpeJWzyqGedJT7XX8AX4wTbt+8yIFS8k
         csNpzKMblJkNAgbIFAqsQKyPJ7LS7eJKucf1TPUgDwYJu9d/g8vmZb2y8heX5Er1td1G
         NdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXWBqPKJATEbQwMYn1AOi6oyN/FWqf7mF2sCGoJ9wDs=;
        b=dIIXF77B65X5OFerf7oodFO3hNC1kCUeVkqXVnSkv0M3jvXA7+vGE9aLD07tyUMv4d
         090nKkhEofxDSZQ6ZKDIkhaMjXYXVLVI+Fj+VGvHIpXRkOgU9GUFdR5LdGRILEWOvyPE
         JiuEynyXu3PVrqZNyvwD9OYHH0gtmuVrPKbeyjgSm1E7CA5snWxR1ePqqDLub67+PruI
         mjaeD0yahyJ8M5FS25PTs4GnC7o2uRATnq1oIqn3vAFb6sBqzU33eK/vQL1DNuYZXlub
         X9TELFPTAHvGfr4l5vwdc/IAsQx+hnpnWJcWx3QtqWx2UMLqTaXJTWfLC1lTGoYddUMV
         ZRhQ==
X-Gm-Message-State: AO0yUKX7wN0TxsmOpgxhgUlZEIvbRPdKEau0WZf9JIS/Mx/G4Ro9/88k
        4FSpkXV6HnltFskpjF5e2cEowQ==
X-Google-Smtp-Source: AK7set8EH3WvOb4bGkAmEmqcxjuZE97vKew424/l2lcrLJnoJMro4k6GqKtZRnMJkCm4Qx3TKYnsAg==
X-Received: by 2002:a17:906:b359:b0:8c2:d53c:377a with SMTP id cd25-20020a170906b35900b008c2d53c377amr624263ejb.51.1676715632769;
        Sat, 18 Feb 2023 02:20:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090671c100b0087bdae9a1ebsm3225075ejk.94.2023.02.18.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:20:32 -0800 (PST)
Message-ID: <41e4f293-99eb-f157-b4a9-3d00b15f4652@linaro.org>
Date:   Sat, 18 Feb 2023 11:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
 <Y+8x/KSujhgNLAd6@wendy>
 <d3b06d0b-ff17-ebab-bae5-e1ec836fe667@starfivetech.com>
 <Y++B43uCnPQlRYFi@wendy> <dcba75b5-7b62-35aa-6836-5d5edd785002@linaro.org>
 <Y++q9ln8P3XegqfN@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y++q9ln8P3XegqfN@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 17:27, Conor Dooley wrote:
> On Fri, Feb 17, 2023 at 04:47:48PM +0100, Krzysztof Kozlowski wrote:
>> On 17/02/2023 14:32, Conor Dooley wrote:
>>>>>> Yes, it is.
>>>>>
>>>>> Which would then make GMAC1 RGMII RX optional, rather than required?
>>>>
>>>> If thinking in this way, I must say yes, it is optional. But actually
>>>> GMAC1 RGMII RX feeds gmac1_rx by default. 
>>>> For a mux, it usually works if you populate only one input to it.
>>>> Does it mean all the other inputs are optional? And how can we define
>>>> which input is required?
>>>
>>> I'm not sure, that is a question for Krzysztof and/or Rob.
>>
>> That's a long thread, please summarize what you ask. Otherwise I have no
>> clue what is the question.
> 
> Sorry. I tried to preserve the context of the conversation the last time
> I cropped it so that things would be contained on one email.
> 
> For me at least, I am wondering how you convey that out of a list of
> clock inputs (for example a, b, c, d) that two of the clocks are inputs
> to a mux and it is only required to provide one of the two (say b & c).
> 
>> Does the mux works correctly if clock input is not connected? I mean,
>> are you now talking about real hardware or some simplification from SW
>> point of view?
> 
> I'm coming at this from an angle of "is a StarFive customer going to show
> up with a devicetree containing dummy fixed-clocks to satisfy dtbs_check
> because they opted to only populate one input to the mux".
> I don't really care about implications for the driver, just about
> whether the hardware allows for inputs to the mux to be left
> un-populated.

Whether hardware allows - not a question to me. BTW, this is rather
question coming from me...

Best regards,
Krzysztof

