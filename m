Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5756E987B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjDTPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDTPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:39:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCD1727
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:39:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so7459445ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005147; x=1684597147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFqx6feXpGTHB3FL7fExLBgKD0kA93DiWIz8p5ciQ1A=;
        b=e2wmO4PTrmgFS4PMHpvi7Uj2qDn5QqG9HlLghB79R6YOPGTZ6qhkj2Glk9s3yigX+h
         0zHtj+2P+RmuxnpyutdUDvcRDGpHplCQwn9A1Zw4y0VgiDAfZRrUHTArnKo4bk6WSf3O
         jeUHhEzB/UjpUeEXjj9ADmhwQkevITFchUz5sHELnMoubT+sdEczKYUg6aXjUhKfjJ5v
         A2f4lAtEbHp6DD6axgdR2PsZ0rEj9komqu8T+ylRoQBZiGL7qmtlMDtQAa/5lrMPC75H
         +Tu8brNS4XNq++xgszlxexRdv1YQVyk3+Zle8EqZ0D7RkSWady/nF5SH0o/tPj4LfKU+
         p1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005147; x=1684597147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFqx6feXpGTHB3FL7fExLBgKD0kA93DiWIz8p5ciQ1A=;
        b=UIxSOF35j95t5ZNUf9xxmiqIwR6ptzdaHxKHTupnXrgtQAh8NUYprjAKODu7dGLnd2
         jDIrgpWa32NGJ3GwD1hYJEAMVPsAhAgLDhHgqIyKpEjNZSO0/54cBXcdyqss/3eGb43c
         q2SIc8qQDqNnKj9b0baOwVhbzzURpqKN7mU0XPWoCmYNET29cVED2lqBmPN6xDm4I1WC
         2hmKMbpMAp3BK0g0XZ76dkpjU0w3vi7fRaf/wAzHL45LCadZAfhOMP326yTiDkE9Izih
         0I9h1DRvwxUYbDbM16gmMvPJJjV4x3539IfPHufvOCKe0Nwzqw5RkCSl7acbClBQyqmc
         mRkw==
X-Gm-Message-State: AAQBX9dhbMxhWXSWTsa6DU9tNe6vmmuQoVBBQY50mbEiWPf+nj1ruqri
        CSUf9BqXLXlbjqF5jsBtKizybQ==
X-Google-Smtp-Source: AKy350aN3xhBBxE+VdGqTHz+YbdaIGULhJZIvketzGosMh5NRoGqDsJdEqOwuEDtEcFey41H+14F5A==
X-Received: by 2002:a17:906:2243:b0:889:5686:486a with SMTP id 3-20020a170906224300b008895686486amr1808894ejr.30.1682005147659;
        Thu, 20 Apr 2023 08:39:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id qt18-20020a170906ecf200b0094f2a03486esm851028ejb.224.2023.04.20.08.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:39:07 -0700 (PDT)
Message-ID: <01d22e48-40f0-b1dd-aa00-cf484c4364ee@linaro.org>
Date:   Thu, 20 Apr 2023 17:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: add cpu_relax in polling loop
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p43a646bbae5f01e3120331407ad873318@epcas2p4.samsung.com>
 <20230419060639.38853-3-jaewon02.kim@samsung.com>
 <36f37a18-0022-0368-bf7c-ebdd724b1558@linaro.org>
 <abbf5608-dbe7-af39-e555-d76ffe65dea4@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <abbf5608-dbe7-af39-e555-d76ffe65dea4@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 13:13, Jaewon Kim wrote:
> 
> On 23. 4. 19. 17:14, Krzysztof Kozlowski wrote:
>> On 19/04/2023 08:06, Jaewon Kim wrote:
>>> Adds cpu_relax() to prevent long busy-wait.
>> How cpu_relax prevents long waiting?
> 
> As I know, cpu_relax() can be converted to yield. This can prevent 
> excessive use of the CPU in busy-loop.

That's ok, you just wrote that it will prevent long waiting, so I assume
it will shorten the wait time.

> 
> I'll replace poor sentence like below in v3.
> 
> ("Adds cpu_relax() to allow CPU relaxation in busy-loop")
> 
>>> There is busy-wait loop to check data transfer completion in polling mode.
>>>
>>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>>> ---
>>>   drivers/spi/spi-s3c64xx.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>>> index 273aa02322d9..886722fb40ea 100644
>>> --- a/drivers/spi/spi-s3c64xx.c
>>> +++ b/drivers/spi/spi-s3c64xx.c
>>> @@ -568,6 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>>   
>>>   	val = msecs_to_loops(ms);
>>>   	do {
>>> +		cpu_relax();
>> Shouldn't this be just readl_poll_timeout()? Or the syntax would be too
>> complicated?
> 
> I think we can replace this while() loop to readl_poll_timeout().
> 
> However, we should use 0 value as 'delay_us' parameter. Because delay 
> can affect throughput.
> 
> 
> My purpose is add relax to this busy-loop.
> 
> we cannot give relax if we change to readl_poll_timeout().

readl_poll_timeout() will know to do the best. You do not need to add
cpu_relax there.


Best regards,
Krzysztof

