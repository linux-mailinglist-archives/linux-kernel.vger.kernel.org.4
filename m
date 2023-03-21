Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA526C3409
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjCUOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCUOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:23:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3234E5073A;
        Tue, 21 Mar 2023 07:23:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16so11362908pjs.4;
        Tue, 21 Mar 2023 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679408589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPJqVRgz3gFdhUtg1OsnDcJUeKLu470USkIcRL0Wcsg=;
        b=fPEdcR6B6OVZ0D5Qi9y4wojlJiISCDdrorjgCxBnx2PWjUt2TzxTsH99RZtfVT7t4q
         gevoloZ1bMyUDTdfGfKTbVUGD2yICUalezQCLsyne/7a6IkcM8cHdukCUqVVg/L1lJyZ
         C+oALAcw+fp9UmPpIZdGVs/FSkkd6fL7t4GfvcujDC/noIbUxtgwBrVIO0A7+KpcMkqG
         6AuueUG/zzM/LLBCIcF7Y+6qIXl7b1BngdsdSj9IylFmE/2LWYg36IYdsz2/K55UJWNd
         mncbcd+rx6vjrqzDiEyF/NK7/SxFzT6CM6rAGTHJNvVZQiv03hTQVP59s9mAqTMCjEMX
         uyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPJqVRgz3gFdhUtg1OsnDcJUeKLu470USkIcRL0Wcsg=;
        b=nPCrk7V9ov92RhzOfN3fSjdrk+MSPH8lTVQj5XuKOarOm/dQLhgf9cPAckucMiBKZl
         dy/Q2/8eAA3xvLOvyRWxuZV6NlZfryjvi8qlB8YHFw6Ggo5/DEa6+SPiK7EI5d7sxt2q
         XgqsV48yWq6y1NxldNsRp24XnbxS6xBkT9MTkaIWmmJ8Hf/iOFLVL66rWJE1YfrM4yPb
         4symOgnwxDgVtc51DVoOVqQFODFQcBtnumhygy3WGgKcMMP4FrYX1Gx2JuRb/3qXHso8
         Yg56jYJ+x6HdDKWka3Zk57y4f1nhMgtA/TaW+DkMOLlrjAZK17iW3O0ktSWuhJtBKghg
         pBIw==
X-Gm-Message-State: AO0yUKV/Q9mDHnLFrW9TAAB+HTjQRSlH99xdOkrjdqjRPfon/O1c3mrH
        QnNEhR0A4PDjFeEIoUPEjAU=
X-Google-Smtp-Source: AK7set8lL25IFZZW4wDy69YzSLrHnsslSLBhUp+/akavxGrrTybSVthUFyKRvY3xxyL2GQSFmXo4Zg==
X-Received: by 2002:a17:903:33c5:b0:1a0:6a47:184e with SMTP id kc5-20020a17090333c500b001a06a47184emr2496512plb.42.1679408589537;
        Tue, 21 Mar 2023 07:23:09 -0700 (PDT)
Received: from [192.168.1.101] (1-160-162-168.dynamic-ip.hinet.net. [1.160.162.168])
        by smtp.gmail.com with ESMTPSA id bc11-20020a170902930b00b001a1a0db7f50sm8764050plb.90.2023.03.21.07.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:23:09 -0700 (PDT)
Message-ID: <fff88562-2bb4-fe7f-8963-c9da4e7017b2@gmail.com>
Date:   Tue, 21 Mar 2023 22:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>, mjchen@nuvoton.com
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-15-ychuang570808@gmail.com>
 <24ce3334-b535-f6d5-70dd-3ba9be991252@linux.intel.com>
 <c755e596-9187-8de1-5769-9c67c1f01c48@gmail.com>
 <b6995749-4b54-59d1-99d2-6b64b438f22f@linux.intel.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b6995749-4b54-59d1-99d2-6b64b438f22f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilpo,


On 2023/3/20 下午 06:04, Ilpo Järvinen wrote:
> On Mon, 20 Mar 2023, Jacky Huang wrote:
>
>> Dear Ilpo,
>>
>>
>> Thanks for your advice.
>>
>> On 2023/3/16 下午 10:54, Ilpo Järvinen wrote:
>>> Hi,
>>>
>>> I'll not note all things below because others have already seemingly
>>> commented many things.
>>>
>>> On Wed, 15 Mar 2023, Jacky Huang wrote:
>>>
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>>>> +		}
>>>> +		ch = (u8)serial_in(up, UART_REG_RBR);
>>> Drop the case.
>> I  will fix it.
> I meant "cast" in case it wasn't obvious.


I know that, thank you.


>>>> +/* Enable or disable the rs485 support */
>>>> +static int ma35d1serial_config_rs485(struct uart_port *port,
>>>> +				     struct ktermios *termios,
>>>> +				     struct serial_rs485 *rs485conf)
>>>> +{
>>>> +	struct uart_ma35d1_port *p = to_ma35d1_uart_port(port);
>>>> +
>>>> +	p->rs485 = *rs485conf;
>>>> +
>>>> +	if (p->rs485.delay_rts_before_send >= 1000)
>>>> +		p->rs485.delay_rts_before_send = 1000;
>>> Don't do this in driver, the core handles the delay limits. You don't seem
>>> to be using the value anyway for anything???
>>>
>>> Please separate the RS485 support into its own patch.
>>
>> OK, we will remove RS485 support from this initial patch.
>> Once this initial patch was merged, we will submit the patch for RS485
>> support.
> You could do that but you could just as well include it into the same
> series as another patch after the main patch.
>>>> +	serial_out(p, UART_FUN_SEL,
>>>> +		   (serial_in(p, UART_FUN_SEL) & ~FUN_SEL_MASK));
>>>> +
>>>> +	if (rs485conf->flags & SER_RS485_ENABLED) {
>>>> +		serial_out(p, UART_FUN_SEL,
>>>> +			   (serial_in(p, UART_FUN_SEL) | FUN_SEL_RS485));
>>> Does this pair of serial_out()s glitch the RS485 line if ->rs485_config()
>>> is called while RS485 mode is already set?
>>>
>>> Why you need to do serial_in() from the UART_FUN_SEL twice?
>> UART_FUN_SEL (2 bits) definition:
>> 00 - UART function
>> 01 - IrDA function
>> 11 - RS485 function
>>
>> The first searial_in() is used to clear set as UART function.
>> The second one is used to set RS485 function if SER_RS485_ENABLED is true.
> I got that, but it doesn't answer either of my questions which are:
>
> Can you clear the UART function without causing a glitch in the RS485?
> ->rs485_config() can be called while already in RS485 mode so does it
> cause the UART to temporarily switch away from RS485 mode to "UART
> function" until the second write.
>
> Also, you didn't explain why you need to read the register again, does
> the HW play with other bits when you do the clearing or to they remain
> the same (in which case you can just use a temporary variable to store
> the value)? ...It would be better to just write once too so this question
> might not matter in the end.


Thank you for the detailed explanation.

OK, the register won't change. I will modify the code to read once and 
write once only.


>>>> +	if (pdev->dev.of_node) {
>>>> +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>>> +		if (ret < 0) {
>>>> +			dev_err(&pdev->dev,
>>>> +				"failed to get alias/pdev id, errno %d\n",
>>>> +				ret);
>>> Just put error prints to one line if you don't break 100 chars limit.
>> But the checkpatch limitation is 80 characters.
> No, it isn't. It was changed years ago already.


I have a test on the checkpatch script.

You are right. It won't complain about over 80 characters now.


>>>> +++ b/drivers/tty/serial/ma35d1_serial.h
>>>> @@ -0,0 +1,93 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + *  MA35D1 serial driver header file
>>>> + *  Copyright (C) 2023 Nuvoton Technology Corp.
>>>> + */
>>>> +#ifndef __MA35D1_SERIAL_H__
>>>> +#define __MA35D1_SERIAL_H__
>>>> +
>>>> +/* UART Receive/Transmit Buffer Register */
>>>> +#define UART_REG_RBR	0x00
>>>> +#define UART_REG_THR	0x00
>>>> +
>>>> +/* UART Interrupt Enable Register */
>>>> +#define UART_REG_IER	0x04
>>>> +#define RDA_IEN		0x00000001 /* RBR Available Interrupt Enable
>>>> */
>>>> +#define THRE_IEN	0x00000002 /* THR Empty Interrupt Enable */
>>>> +#define RLS_IEN		0x00000004 /* RX Line Status Interrupt Enable
>>>> */
>>>> +#define RTO_IEN		0x00000010 /* RX Time-out Interrupt Enable */
>>>> +#define BUFERR_IEN	0x00000020 /* Buffer Error Interrupt Enable */
>>>> +#define TIME_OUT_EN	0x00000800 /* RX Buffer Time-out Counter
>>>> Enable */
>>>> +
>>>> +/* UART FIFO Control Register */
>>>> +#define UART_REG_FCR	0x08
>>>> +#define RFR		0x00000002 /* RX Field Software Reset */
>>>> +#define TFR		0x00000004 /* TX Field Software Reset */
>>>> +
>>>> +/* UART Line Control Register */
>>>> +#define UART_REG_LCR	0x0C
>>>> +#define	NSB		0x00000004 /* Number of “STOP Bit” */
>>>> +#define PBE		0x00000008 /* Parity Bit Enable */
>>>> +#define EPE		0x00000010 /* Even Parity Enable */
>>>> +#define SPE		0x00000020 /* Stick Parity Enable */
>>>> +#define BCB		0x00000040 /* Break Control */
>>>> +
>>>> +/* UART Modem Control Register */
>>>> +#define UART_REG_MCR	0x10
>>>> +#define RTS		0x00000020 /* nRTS Signal Control */
>>>> +#define RTSACTLV	0x00000200 /* nRTS Pin Active Level */
>>>> +#define RTSSTS		0x00002000 /* nRTS Pin Status (Read Only) */
>>>> +
>>>> +/* UART Modem Status Register */
>>>> +#define UART_REG_MSR	0x14
>>>> +#define CTSDETF		0x00000001 /* Detect nCTS State Change Flag */
>>>> +#define CTSSTS		0x00000010 /* nCTS Pin Status (Read Only) */
>>>> +#define CTSACTLV	0x00000100 /* nCTS Pin Active Level */
>>>> +
>>>> +/* UART FIFO Status Register */
>>>> +#define UART_REG_FSR	0x18
>>>> +#define RX_OVER_IF	0x00000001 /* RX Overflow Error Interrupt Flag */
>>>> +#define PEF		0x00000010 /* Parity Error Flag*/
>>>> +#define FEF		0x00000020 /* Framing Error Flag */
>>>> +#define BIF		0x00000040 /* Break Interrupt Flag */
>>>> +#define RX_EMPTY	0x00004000 /* Receiver FIFO Empty (Read Only) */
>>>> +#define RX_FULL		0x00008000 /* Receiver FIFO Full (Read Only)
>>>> */
>>>> +#define TX_EMPTY	0x00400000 /* Transmitter FIFO Empty (Read Only) */
>>>> +#define TX_FULL		0x00800000 /* Transmitter FIFO Full (Read
>>>> Only) */
>>>> +#define TX_OVER_IF	0x01000000 /* TX Overflow Error Interrupt Flag */
>>>> +#define TE_FLAG		0x10000000 /* Transmitter Empty Flag (Read
>>>> Only) */
>>>> +
>>>> +/* UART Interrupt Status Register */
>>>> +#define UART_REG_ISR	0x1C
>>>> +#define RDA_IF		0x00000001 /* RBR Available Interrupt Flag */
>>>> +#define THRE_IF		0x00000002 /* THR Empty Interrupt Flag */
>>>> +#define RLSIF		0x00000004 /* Receive Line Interrupt Flag */
>>>> +#define MODEMIF		0x00000008 /* MODEM Interrupt Flag */
>>>> +#define RXTO_IF		0x00000010 /* RX Time-out Interrupt Flag */
>>>> +#define BUFEIF		0x00000020 /* Buffer Error Interrupt Flag */
>>>> +#define WK_IF		0x00000040 /* UART Wake-up Interrupt Flag */
>>>> +#define RDAINT		0x00000100 /* RBR Available Interrupt
>>>> Indicator */
>>>> +#define THRE_INT	0x00000200 /* THR Empty Interrupt Indicator */
> I forgot to mention earlier, there are many defines above which should use
> BIT().
>
Sure we will fix them all.


Best regards,

Jacky Huang


