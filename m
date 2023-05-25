Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8D771056D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjEYFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:48:51 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B495;
        Wed, 24 May 2023 22:48:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so3693233a12.3;
        Wed, 24 May 2023 22:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684993728; x=1687585728;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8+s/K+5RvHd3mBUPmt+K92bKir5drTiVIL22nfYEIw=;
        b=KRrFryhheh/ZeXU1dlBJNp3XYdKdEqdTXRk17E4sPW0496eoqAizFBO4HOQhXAXqHQ
         +I3zGLfTBICtRAOmdfvUVyCJxnDon/VHu03pIbc6+6GP4EgTh4MoKakKf05kq2dbeTkW
         P5HV2VWSmDLRFnOqfW81XtrsfKH6x3IOylWCTQBGdwAtFGaYrU7QJWKj9h3PinX52pMR
         bQWRGoW3tw8vBP00HUfyDudiEvaW1zY6HIM3eFL3zWxtW03/yJ6oefit/84CX2mI1HVC
         g3XFPKkFMENozcdI4nWLwrUbJS5ZKpk/Ga31RyrCVFTXiWOvuuOx3moSWVWXv+AGzOK9
         4iZg==
X-Gm-Message-State: AC+VfDxWDAve2N0QUDINa0moiVAyg8UyXsVXU9r4jYooARDqQfyIXb1U
        GGmKnRhoxxvFUuJ3zU46baU=
X-Google-Smtp-Source: ACHHUZ78kwCROM6GPOi1V6fq6adO7uQrYlWFOtHDvlX1THAntXJfkj8+8n3Bv+8+Mx+VI4jYcFWVQg==
X-Received: by 2002:a50:ed1a:0:b0:510:e877:33c with SMTP id j26-20020a50ed1a000000b00510e877033cmr3218941eds.30.1684993727811;
        Wed, 24 May 2023 22:48:47 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d6-20020a056402078600b0050d89daaa70sm189740edy.2.2023.05.24.22.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 22:48:47 -0700 (PDT)
Message-ID: <75375f8d-e157-a364-3da5-9c8d5b832927@kernel.org>
Date:   Thu, 25 May 2023 07:48:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, soc@kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
 <20230516075217.205401-11-ychuang570808@gmail.com>
 <3d4acb20-c80e-fd39-c0d0-e9b1e0309d81@kernel.org>
 <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
 <e312b861-a5cc-43b0-b2b0-7d66f47a3d0b@app.fastmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <e312b861-a5cc-43b0-b2b0-7d66f47a3d0b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 05. 23, 11:00, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 10:34, Jacky Huang wrote:
>> On 2023/5/24 下午 03:42, Jiri Slaby wrote:
>>> On 16. 05. 23, 9:52, Jacky Huang wrote:
>>>> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
>>>> +{
>>>> +    /*
>>>> +     * Driver core for serial ports forces a non-zero value for port
>>>> type.
>>>> +     * Write an arbitrary value here to accommodate the serial core
>>>> driver,
>>>> +     * as ID part of UAPI is redundant.
>>>> +     */
>>>> +    port->type = 1;
>>>
>>> So this 1 translates to PORT_8250. Why not to use it directly? Or
>>> something more saner like PORT_16550A?
>>>
>> It's not actually 8250 or 16550A.
>> Can we add the following definition to
>> 'include/uapi/linux/serial_core.h' and use PORT_MA35 instead?
>>
>> #define PORT_MA35    124
> 
> This was already in a previous version, until Greg commented
> that it was probably not needed:
> 
> https://lore.kernel.org/lkml/20fc81c9-5517-ce1e-639a-3b425cf27759@gmail.com/
> 
> Since leaving port->type at PORT_UNKNOWN doesn't work, and almost
> all other drivers have something in serial_core.h, it's probably
> best to do the same here. Checking the other drivers showed that
> drivers/tty/serial/lantiq.c is currently the only exception, it
> defines PORT_LTQ_ASC locally, which causes a conflict with
> PORT_SPRD.

Hmm.

Anyone has an idea what this is really used for in userspace? Can we 
replace all of them by simply some sort of "PORT_OTHER"?

For example:

xdg-open `echo -n 'https://codesearch.debian.net/search?q=\b('; sed -n 
's@#define\s\(\w\+\)\s.*@\1@ p' include/uapi/linux/serial_core.h | tail 
-20 | sed 's@.* \(.*\)[\x09 ][\x09 ]*.*@\1@'|paste -sd'|' | tr -d '\n'; 
echo ')\b'`

gives _no_ clue. FTR the above translates here into:
https://codesearch.debian.net/search?q=\b(PORT_HSCIF|PORT_ASC|PORT_TILEGX|PORT_MEN_Z135|PORT_SC16IS7XX|PORT_MESON|PORT_DIGICOLOR|PORT_SPRD|PORT_CRIS|PORT_STM32|PORT_MVEBU|PORT_PIC32|PORT_MPS2UART|PORT_MTK_BTIF|PORT_RDA|PORT_MLB_USIO|PORT_SIFIVE_V0|PORT_SUNIX|PORT_LINFLEXUART|PORT_SUNPLUS)\b

thanks,
-- 
js
suse labs

