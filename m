Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA174BFC4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGHWGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 18:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHWGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 18:06:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A2E4A;
        Sat,  8 Jul 2023 15:06:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c4d1b491095so3617601276.0;
        Sat, 08 Jul 2023 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688853976; x=1691445976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wXSZlFGeP1fpLBmig7AsRhQFCecsgJSjoELC00VLPeg=;
        b=eZIj4B4l7JsIdZ1qLhUYI0uTfwBw569ErwjZaY7IluiO4nBKaPePfIqIh2tPUGeMZB
         Y8d2Bx1wJ+jIg/S02S9Q3I1COctU08QrJFM8R5OVlpGUHP/tJgqWNiunZJbXEBzCr1kH
         SPaeABftAYkiXfTwMeAmyJCUsCoY1xH0q36/wwVZGVtCl98zx5P64A5aMgGC//OPRLEK
         Z+9yuLryjG5uXmH2e1y8fq08BLJY04maVbTvNu/oZs4ictG5AwxEWhUoXV10GNcM+RPa
         NjvHbLqI2hOayXF/SFP4q/B6JsRr8q3u/pKPRb+aDFri/DJMXHX/K+KwJWvUUksFAxdu
         a4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688853976; x=1691445976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXSZlFGeP1fpLBmig7AsRhQFCecsgJSjoELC00VLPeg=;
        b=I2+a+Xdcj5Ya1zJwCn3gmqPm9N60ELbOWjItwKYpBDWnaO7IhFCGNUbOrXvLvQMIyB
         mjzxekj2ZLk06pRW/1/iLQmGVJybSSOjruMJ6S/NDMbqSHN5unaMYGF4DvOJRAIbLAD2
         h/Q/6KSWhCFkdhlQGfcMUm11NAD9+X2h09QqrHQUF9x1ri0W9kSt7jdwAeAzeUvNtSEG
         jYgQLJU8kZDoBcte82ASFLFI0pbPvqNozaWwsM+GjYlf0Kt/TSaYwZX+u93Bd/5oZRBO
         5iZxKfesWMHmv68dmnH2oz+jtbo0Ohbo8XYWRx3M0nghkFikOAwcOcoOTcswHx8kyN1/
         Rm7Q==
X-Gm-Message-State: ABy/qLYksMTKzBE8QlOftmNj9IL95/qjHhMYVhlUEmvqF9m3u/EBpFj2
        SYqbYF6W6PvJntyDNi2ps2ysf7Ag6mc=
X-Google-Smtp-Source: APBJJlHhqhibggaL5EwwFbuy64J9O6LNE1TRDxBGUvlHatip8YXsoL419y1v3ttL/lJVyGPWFXPgJg==
X-Received: by 2002:a5b:749:0:b0:c5f:15f2:375 with SMTP id s9-20020a5b0749000000b00c5f15f20375mr7450001ybq.9.1688853976447;
        Sat, 08 Jul 2023 15:06:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18-20020a056902019200b00bc7c81c3cecsm1774891ybh.14.2023.07.08.15.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 15:06:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
Date:   Sat, 8 Jul 2023 15:06:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 13:52, Sergey Shtylyov wrote:
> On 7/6/23 7:38 PM, John Paul Adrian Glaubitz wrote:
> [...]
> 
>>> Which sh4 platforms in particular?
>>>
>>> I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
>>> (physical) two days ago.
>>
>> I gave it a try with the command line Guenter suggested and indeed the kernel locks
>> up right here with the patch applied and boots fine without it:
>>
>> Creating 4 MTD partitions on "physmap-flash":
>> 0x000000000000-0x000000040000 : "U-Boot"
>> 0x000000040000-0x000000080000 : "Environment"
>> 0x000000080000-0x000000240000 : "Kernel"
>> 0x000000240000-0x000001000000 : "Flash_FS"
>> 8139too: 8139too Fast Ethernet driver 0.9.28
>> 8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
>> sm501-usb sm501-usb: SM501 OHCI
>> sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
>> sm501-usb sm501-usb: irq 116, io mem 0x13e40000
> 
>     I guess it was irq 100 before my patch. What if you undo the following
> part of my patch?
> 

No, that doesn't help.

Guenter

> Index: linux/arch/sh/include/mach-common/mach/r2d.h
> ===================================================================
> --- linux.orig/arch/sh/include/mach-common/mach/r2d.h
> +++ linux/arch/sh/include/mach-common/mach/r2d.h
> @@ -47,7 +47,7 @@
>   
>   #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
>   
> -#define R2D_FPGA_IRQ_BASE	100
> +#define R2D_FPGA_IRQ_BASE	(100 + 16)
>   
>   #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
>   #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)
> 
>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.04
>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> usb usb1: Product: SM501 OHCI
>> usb usb1: Manufacturer: Linux 6.4.0-12069-gc17414a273b8 ohci_hcd
>> usb usb1: SerialNumber: sm501-usb
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 2 ports detected
>> usbcore: registered new interface driver usb-storage
>> rtc-r9701 spi0.0: cannot read RTC register
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> NET: Registered PF_PACKET protocol family
>> heartbeat: version 0.1.2 loaded
>> ata1: found unknown device (class 0)
> [...]
> 
>> Adrian
> 
> MBR, Sergey

