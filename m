Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2277154F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjE3Ff4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjE3Ffw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:35:52 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4EEC;
        Mon, 29 May 2023 22:35:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so6402851a12.0;
        Mon, 29 May 2023 22:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685424950; x=1688016950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV4g2QqFAx0Qg2GEdFeROXzdUlE1iPO7BwJG8HSPHco=;
        b=V0ur1r5ZpyYdebIDkztcNCTvjnsnnf7UqOJaf/oyd5y/e3JkrROHrDVGLfaT/6izQc
         +CO3o2W9hYzE+LgJXVdiKKRspzN7FWlxOF0Ul66aEZl15bXB8gIEcoGbfyZn4+Xlswkj
         VAW2S+G7OP+NyEYsZfdAiNrH1NSq4ojDnIx43yan/XtgMoH05OA1xIjg9/v6RlCrewOB
         F1/ITnC0cbITooyJRWScaK0CaFbzkZ81Fg8AT/XM5oTYb9UM1vH5RSfjHjbqJgWgHXWq
         rxdpAh1zNtFfHCLed+pT/KAOV2uITjCx15qKSR/J9ZZ/fNWbe8JPIca1hD9BecyjdEU+
         lhqg==
X-Gm-Message-State: AC+VfDw8VKPjB/E4ZxZhUrJXF2du2OA+Urcf+B9QRtZ8msDP3qlwiYZk
        dLodQNJ+vsQC3OhcPhr/XZE=
X-Google-Smtp-Source: ACHHUZ7d//vbJPuMcuuguqHEIhsa256pT0itLFARVDscaeij15+LBFgsDcQeytTG/QPiy2HgYWfrWQ==
X-Received: by 2002:a17:907:3f1c:b0:970:d85:59e9 with SMTP id hq28-20020a1709073f1c00b009700d8559e9mr1267463ejc.5.1685424949500;
        Mon, 29 May 2023 22:35:49 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090643d700b0095850aef138sm6829336ejn.6.2023.05.29.22.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 22:35:49 -0700 (PDT)
Message-ID: <75747efd-2bfd-d1db-42d9-7a6c90240475@kernel.org>
Date:   Tue, 30 May 2023 07:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
 <20230516075217.205401-11-ychuang570808@gmail.com>
 <3d4acb20-c80e-fd39-c0d0-e9b1e0309d81@kernel.org>
 <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
 <c9493f4d-8056-20a0-6ed2-161fbcc3d34e@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <c9493f4d-8056-20a0-6ed2-161fbcc3d34e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30. 05. 23, 3:09, Jacky Huang wrote:
>>>> +
>>>> +    if (options)
>>>> +        uart_parse_options(options, &baud, &parity, &bits, &flow);
>>>> +
>>>> +    return uart_set_options(port, co, baud, parity, bits, flow);
>>>> +}
>>>> +
>>>> +static struct console ma35d1serial_console = {
>>>> +    .name    = "ttyNVT",
>>>> +    .write   = ma35d1serial_console_write,
>>>> +    .device  = uart_console_device,
>>>> +    .setup   = ma35d1serial_console_setup,
>>>> +    .flags   = CON_PRINTBUFFER | CON_ENABLED,
>>>> +    .index   = -1,
>>>> +    .data    = &ma35d1serial_reg,
>>>
>>> I don't see console->data used anywhere in the driver?
>>>
>>
>> I will remove it.
>>
> 
> I removed the " .data    = &ma35d1serial_reg", but kernel crashed in 
> 'drivers/tty/serial/serial_core.c'.
> 
> The variable 'p' of  uart_console_device() refer to a NULL, because 
> co->data is NULL.
> As a result, kernel crashed at 'p->tty_driver'.
> 
> struct tty_driver *uart_console_device(struct console *co, int *index)
> {
>      struct uart_driver *p = co->data;
>      *index = co->index;
>      return p->tty_driver;
> }
> 
> We seem to be unable to remove it.
> If there are no other considerations, I will keep it in the next version.

Ah, yeah. Sorry, my bad.

-- 
js
suse labs

