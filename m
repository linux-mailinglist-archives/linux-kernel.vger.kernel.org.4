Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFB74C028
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGIA2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGIA2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:28:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F0102;
        Sat,  8 Jul 2023 17:28:10 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57045429f76so39165407b3.0;
        Sat, 08 Jul 2023 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688862490; x=1691454490;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OBSPXfN1Pwv2ZSkij5y8Bia7PAEVNCyrq8cTcnAzz8=;
        b=GBYuHJ3qX9Db1V2m3ArmLdt2PzyjFxEXmWiZZFP06if3FzDFk/ztg3PracHa3wXbiB
         oSTCjgawNbQePrj+VaiC4pCPEkOyRNefpxsu2YTFSUaa+0BnSAQIXlTvLq3dlVNSfUIM
         P8LhE3JA5pJf4x4tNxZn3KsFB6yIagBxEmlArH7yHaE5zMcKKm9ec/r+YHT67w3nAAMw
         hvi+2R8nEaIOxSiE/qLgPfxwm+tQA2dK9spX10TnDy/vKG/Vv99j2I76tfLz5Cbn//hk
         bcIhG5SQd7v62PQvHoTbi9q+f3w1LGYlKpxS9pWROngEpW6C2SuFcpIvhF/cWEmumxL7
         Ntfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688862490; x=1691454490;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OBSPXfN1Pwv2ZSkij5y8Bia7PAEVNCyrq8cTcnAzz8=;
        b=ctl9KbojJy8jDPJKAfVXxTsTKFa8uoI3Y300qALeUJSxO2H923KTYIKQx7pA7FHIMf
         jMaukZ++h1XNNtQ2fq0Uyz8qY1H9XiqLfG/WArwysGAbv1G1axJU8XB6ngiCE73SDehm
         JiKsCqY97qbIt8vptqaF3WhDKqUy8X+pfK1KsUPVSptcZFWFAdV9iE5h6s0PAUxtbpby
         28NrSqUmCMlen21aKuztkdvuytbMwIkQs3lu3dp+Bp5gFoRqHrPLFxfDuWxqdg9O4FeQ
         XRdVgZxjztDOqzMV6OKJxPjY/82B/enK2Kky2xSxHx64Xeq9L/HnhIQnQwbaL/9dxtqt
         +JMw==
X-Gm-Message-State: ABy/qLZ0BccMG9nMoj5Ed379cKxO3KUbPgX80GupKMWQgLgG6hGMvwio
        FOMmr71ROLdMPDyDi5+E6V4=
X-Google-Smtp-Source: APBJJlF+uPkNeiVHtJk05sQ2le3v4mjYkvSUKvER1ZcZtKSkOVD8hFPl3vN7wxtgtoELC6150mu08g==
X-Received: by 2002:a81:a001:0:b0:577:f47:3d92 with SMTP id x1-20020a81a001000000b005770f473d92mr8503372ywg.23.1688862490031;
        Sat, 08 Jul 2023 17:28:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a815b04000000b005702bfb19bfsm2129105ywb.130.2023.07.08.17.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 17:28:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0858aeb0-0310-7eb2-dec2-8e7ad3c90d94@roeck-us.net>
Date:   Sat, 8 Jul 2023 17:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
 <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
 <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
In-Reply-To: <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 16:13, John Paul Adrian Glaubitz wrote:
> Hello Guenter!
> 
> On Sat, 2023-07-08 at 15:06 -0700, Guenter Roeck wrote:
>> On 7/8/23 13:52, Sergey Shtylyov wrote:
>>> On 7/6/23 7:38 PM, John Paul Adrian Glaubitz wrote:
>>> [...]
>>>
>>>>> Which sh4 platforms in particular?
>>>>>
>>>>> I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
>>>>> (physical) two days ago.
>>>>
>>>> I gave it a try with the command line Guenter suggested and indeed the kernel locks
>>>> up right here with the patch applied and boots fine without it:
>>>>
>>>> Creating 4 MTD partitions on "physmap-flash":
>>>> 0x000000000000-0x000000040000 : "U-Boot"
>>>> 0x000000040000-0x000000080000 : "Environment"
>>>> 0x000000080000-0x000000240000 : "Kernel"
>>>> 0x000000240000-0x000001000000 : "Flash_FS"
>>>> 8139too: 8139too Fast Ethernet driver 0.9.28
>>>> 8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
>>>> sm501-usb sm501-usb: SM501 OHCI
>>>> sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
>>>> sm501-usb sm501-usb: irq 116, io mem 0x13e40000
>>>
>>>      I guess it was irq 100 before my patch. What if you undo the following
>>> part of my patch?
>>>
>>
>> No, that doesn't help.
> 
> Since the SM501 works fine with the patch on my SH7785LCR board, I assume it's
> related to the IRQ code for the r2d2 board.
> 
> Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
> on and maybe that's the part where we need to correct the offset by 16?
> 

I don't know the sh code at all. I only know that the sh4 qemu emulation
(both little and big endian) is broken since your patch has been applied.
Everything else would be just wild guesses from my side.

Guenter

