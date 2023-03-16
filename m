Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA196BD0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCPN2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCPN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:28:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1DCB056;
        Thu, 16 Mar 2023 06:28:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i5so1744863pla.2;
        Thu, 16 Mar 2023 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678973287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+/4xGXSIIqVHrJfFoI+s8Nb1Q7Tp/djFpxQiZ3xkXA=;
        b=MwyyQpk5ivWuYQTZgsIZ7q2L18fP26B6/u65oWV3qOXu5rB/vi28MQ9fbgf9d1Z6el
         A4tYvvZ3m2iB2ve3iDD66hyDAh3MsxWseh5O6ANbOgM9ON4vgINHzKoGQXh74kG9zM8Q
         b3VcU/0JlaGdNvZW1uVoPlzq9UPS18OBmBh5aPvBSMzqCCRd+NXhm+QsmrDyg913p85x
         9VkAwQ7TlvJ+643BjBwZe5Gi3gLeF4LbdStcN4aF/BySiIQEh1gjwzXLlsJ0AMXCZxmT
         94FyWrgBR6J4xHPATGvVd5Qt3i2f8nIAZsBQKXHPUufgwVpHPSa+Y1Z5ir+kL8LA75Ef
         fnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+/4xGXSIIqVHrJfFoI+s8Nb1Q7Tp/djFpxQiZ3xkXA=;
        b=G/QYDZO9ND2ox61U0Hcm0t7c1q1ytm3zQ/kb1/2Qj61ONW9FTbvN95w8MJn5T8au8v
         8Mdi6B8rrzdy/pcJT5U+kyxC044mUNxBbPG2E3GcZGQBxYQmgx8/uC1SeV7hXuy/Oh0R
         oRSXiWL/qFnS74DCvx154gu0ghTHFurTuh8Vcmz0ewjJaGCKVw8unTnNdtYbnDqw6eHr
         MDAFPqauekaed/SMIDJUok3dmnN1tSIrgXXGE72BZp4KNG1BbzAAf9pJdaIyoeFgweE9
         UgdTG4T2nr1IUTA9pwvcj3zfxOThflykarY1s3dliF8iLCDWThJNziqQHm085U5AJhst
         CXNg==
X-Gm-Message-State: AO0yUKXyVFvuS3EridH0QPXqnOdVCND7Et8U5b9phHMMJr9LQDjEaSkV
        OOGTXmqAhtCJ+/BbT4Mig5Q=
X-Google-Smtp-Source: AK7set/4Rbaj+QlgCv43hU0fOGTciyoSJieWlpgWfHPy8CvNKeAMDY4xX/+LtQyJraWxAgX7i9Vklg==
X-Received: by 2002:a17:903:187:b0:19c:eda7:e0fd with SMTP id z7-20020a170903018700b0019ceda7e0fdmr3716608plg.59.1678973286381;
        Thu, 16 Mar 2023 06:28:06 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kl3-20020a170903074300b0019abd4ddbf2sm5610833plb.179.2023.03.16.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:28:05 -0700 (PDT)
Message-ID: <d7291026-eab4-89e6-98d5-d7cfbaab18de@gmail.com>
Date:   Thu, 16 Mar 2023 21:28:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-15-ychuang570808@gmail.com>
 <18250d8b-77b6-4887-44b4-a60bf1211a31@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <18250d8b-77b6-4887-44b4-a60bf1211a31@kernel.org>
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

Dear Jiri,


Thanks for your review.

I will create #define constant to replace every occurrence of magics or
hard coding number.

For every occurrence of "struct uart_ma35d1_port *up = (struct 
uart_ma35d1_port *)port; ",
it will be replaced with to_ma35d1_uart_port() .


On 2023/3/15 下午 06:13, Jiri Slaby wrote:
> On 15. 03. 23, 8:29, Jacky Huang wrote:
>> --- /dev/null
>> +++ b/drivers/tty/serial/ma35d1_serial.c
>> @@ -0,0 +1,842 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  MA35D1 serial driver
>> + *  Copyright (C) 2023 Nuvoton Technology Corp.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>
> What parameters does this module have?
+#include <linux/ioport.h>
>> +#include <linux/init.h>
>> +#include <linux/console.h>
>> +#include <linux/sysrq.h>
>> +#include <linux/delay.h>
>
> What do you use from delay.h?
>
>> +#include <linux/platform_device.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/clk.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial.h>
>> +#include <linux/nmi.h>
>
> nmi.h?
>
> Please clean up all of the includes.
>

moduleparam.h, delay.h, and nmi.h are not used.

I will test and remove all unused #include.

>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/io.h>
>> +#include <asm/irq.h>
>> +#include <asm/serial.h>
>> +#include "ma35d1_serial.h"
>> +
>> +#define UART_NR            17
>> +
>> +static struct uart_driver ma35d1serial_reg;
>> +struct clk *clk;
>> +
>> +struct uart_ma35d1_port {
>> +    struct uart_port port;
>> +    u16 capabilities; /* port capabilities */
>> +    u8 ier;
>> +    u8 lcr;
>> +    u8 mcr;
>> +    u8 mcr_mask;   /* mask of user bits */
>> +    u8 mcr_force;  /* mask of forced bits */
>
> Where are all those used?
>

I will remove the unused structure members in the next version.

>> +    struct serial_rs485 rs485; /* rs485 settings */
>> +    u32 baud_rate;
>
> And this one.
>

It's not used. I will remove it.

>> +    int rx_count;
>> +    u32 console_baud_rate;
>> +    u32 console_line;
>> +    u32 console_int;
>> +};
>> +
>> +static struct device_node *ma35d1serial_uart_nodes[UART_NR];
>> +static struct uart_ma35d1_port ma35d1serial_ports[UART_NR] = { 0 };
>
>> +static void __stop_tx(struct uart_ma35d1_port *p);
>
> What for?

This function is used to disable TX FIFO empty interrupt.

naming issue?

>
>> +static void transmit_chars(struct uart_ma35d1_port *up);
>> +
>> +static struct uart_ma35d1_port *to_ma35d1_uart_port(struct uart_port 
>> *uart)
>> +{
>> +    return container_of(uart, struct uart_ma35d1_port, port);
>> +}
>> +
>> +static u32 serial_in(struct uart_ma35d1_port *p, int offset)
>
> Q: int? A: No.

will modify "int offset" to "u32 offset"

>
>> +{
>> +    return __raw_readl(p->port.membase + offset);
>> +}
>> +
>> +static void serial_out(struct uart_ma35d1_port *p, int offset, int 
>> value)
>
> No ints here, please.

will modify offset and value data type to u32


>
>> +{
>> +    __raw_writel(value, p->port.membase + offset);
>> +}
>> +
>> +static void __stop_tx(struct uart_ma35d1_port *p)
>> +{
>> +    u32 ier;
>> +
>> +    ier = serial_in(p, UART_REG_IER);
>> +    if (ier & THRE_IEN)
>> +        serial_out(p, UART_REG_IER, ier & ~THRE_IEN);
>> +}
>> +
>> +static void ma35d1serial_stop_tx(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>
> Despite you have to_ma35d1_uart_port(), you do this?
>

You're right. I will use to_ma35d1_uart_port() to replace it.


>> +
>> +    __stop_tx(up);
>> +}
>> +
>> +static void ma35d1serial_start_tx(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +    u32 ier;
>> +    struct circ_buf *xmit = &up->port.state->xmit;
>> +
>> +    ier = serial_in(up, UART_REG_IER);
>> +    serial_out(up, UART_REG_IER, ier & ~THRE_IEN);
>> +    if (uart_circ_chars_pending(xmit) <
>> +        (16 - ((serial_in(up, UART_REG_FSR) >> 16) & 0x3F)))
>
> You look like you need a helper for this computation (hint: 
> GENMASK()). What do those magic constants mean?
>

I will add #define macro for the bit mask..

>> +        transmit_chars(up);
>> +    serial_out(up, UART_REG_IER, ier | THRE_IEN);
>> +}
>> +
>> +static void ma35d1serial_stop_rx(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>
> Bah. Nah.

>> +
>> +    serial_out(up, UART_REG_IER, serial_in(up, UART_REG_IER) & 
>> ~RDA_IEN);
>> +}
>> +
>> +static void
>> +receive_chars(struct uart_ma35d1_port *up)
>> +{
>> +    u8 ch;
>> +    u32 fsr;
>> +    u32 isr;
>> +    u32 dcnt;
>> +    char flag;
>
> flag is u8 too. And a reverse xmas tree, please. Actually, you can put 
> all those u32 to a single line.
>

OK, I will fix it.

>> +
>> +    isr = serial_in(up, UART_REG_ISR);
>> +    fsr = serial_in(up, UART_REG_FSR);
>> +
>> +    while (!(fsr & RX_EMPTY)) {
>> +        flag = TTY_NORMAL;
>> +        up->port.icount.rx++;
>> +
>> +        if (unlikely(fsr & (BIF | FEF | PEF | RX_OVER_IF))) {
>> +            if (fsr & BIF) {
>> +                serial_out(up, UART_REG_FSR, BIF);
>> +                up->port.icount.brk++;
>> +                if (uart_handle_break(&up->port))
>> +                    continue;
>> +            }
>> +            if (fsr & FEF) {
>> +                serial_out(up, UART_REG_FSR, FEF);
>> +                up->port.icount.frame++;
>> +            }
>> +            if (fsr & PEF) {
>> +                serial_out(up, UART_REG_FSR, PEF);
>> +                up->port.icount.parity++;
>> +            }
>> +            if (fsr & RX_OVER_IF) {
>> +                serial_out(up, UART_REG_FSR, RX_OVER_IF);
>> +                up->port.icount.overrun++;
>> +            }
>> +            if (fsr & BIF)
>> +                flag = TTY_BREAK;
>> +            if (fsr & PEF)
>> +                flag = TTY_PARITY;
>> +            if (fsr & FEF)
>> +                flag = TTY_FRAME;
>> +        }
>> +        ch = (u8)serial_in(up, UART_REG_RBR);
>> +        if (uart_handle_sysrq_char(&up->port, ch))
>> +            continue;
>> +
>> +        uart_insert_char(&up->port, fsr, RX_OVER_IF, ch, flag);
>
> No lock needed?
>

I will wrap it with spin_lock and spin_unlock.

>> +        up->rx_count++;
>> +        dcnt = (serial_in(up, UART_REG_FSR) >> 8) & 0x3f;
>
> More magic constants. No.
>
>> +        if (up->rx_count > 1023) {
>> +            spin_lock(&up->port.lock);
>> + tty_flip_buffer_push(&up->port.state->port);
>> +            spin_unlock(&up->port.lock);
>> +            up->rx_count = 0;
>> +            if ((isr & RXTO_IF) && (dcnt == 0))
>> +                goto tout_end;
>> +        }
>> +        if (isr & RDA_IF) {
>> +            if (dcnt == 1)
>> +                return;
>> +        }
>> +        fsr = serial_in(up, UART_REG_FSR);
>> +    }
>> +    spin_lock(&up->port.lock);
>> +    tty_flip_buffer_push(&up->port.state->port);
>> +    spin_unlock(&up->port.lock);
>> +tout_end:
>> +    up->rx_count = 0;
>> +}
>> +
>> +static void transmit_chars(struct uart_ma35d1_port *up)
>
> Why this cannot use uart_port_tx()?

OK, I will rename it as uart_port_tx().

>
>> +{
>> +    struct circ_buf *xmit = &up->port.state->xmit;
>> +    int count = 16 - ((serial_in(up, UART_REG_FSR) >> 16) & 0xF);
>> +
>> +    if (serial_in(up, UART_REG_FSR) & TX_FULL)
>> +        count = 0;
>> +    if (up->port.x_char) {
>> +        serial_out(up, UART_REG_THR, up->port.x_char);
>> +        up->port.icount.tx++;
>> +        up->port.x_char = 0;
>> +        return;
>> +    }
>> +    if (uart_tx_stopped(&up->port)) {
>> +        ma35d1serial_stop_tx(&up->port);
>> +        return;
>> +    }
>> +    if (uart_circ_empty(xmit)) {
>> +        __stop_tx(up);
>> +        return;
>> +    }
>> +    while (count > 0) {
>> +        serial_out(up, UART_REG_THR, xmit->buf[xmit->tail]);
>> +        xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>> +        up->port.icount.tx++;
>> +        count--;
>> +        if (uart_circ_empty(xmit))
>> +            break;
>> +    }
>> +    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> +        uart_write_wakeup(&up->port);
>> +    if (uart_circ_empty(xmit))
>> +        __stop_tx(up);
>> +}
>> +
>> +static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)dev_id;
>> +    u32 isr, fsr;
>> +
>> +    isr = serial_in(up, UART_REG_ISR);
>> +    fsr = serial_in(up, UART_REG_FSR);
>> +    if (isr & (RDA_IF | RXTO_IF))
>> +        receive_chars(up);
>> +    if (isr & THRE_INT)
>> +        transmit_chars(up);
>> +    if (fsr & (BIF | FEF | PEF | RX_OVER_IF | TX_OVER_IF))
>> +        serial_out(up, UART_REG_FSR,
>> +               (BIF | FEF | PEF | RX_OVER_IF | TX_OVER_IF));
>> +
>> +    return IRQ_HANDLED;
>
> You give no way for OS to disable the irq when the HW goes crazy. I.e. 
> you should return IRQ_HANDLED only when you really handled the irq.
>
>> +}
> ...
>> +static u32 ma35d1serial_get_mctrl(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +    u32 status;
>> +    u32 ret = 0;
>> +
>> +    status = serial_in(up, UART_REG_MSR);
>> +    if (!(status & 0x10))
>
> 0x10 is magic.
>
>> +        ret |= TIOCM_CTS;
>> +    return ret;
>> +}
>> +
>> +static void ma35d1serial_set_mctrl(struct uart_port *port, u32 mctrl)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +    u32 mcr = 0;
>> +    u32 ier = 0;
>> +
>> +    if (mctrl & TIOCM_RTS) {
>> +        /* set RTS high level trigger */
>> +        mcr = serial_in(up, UART_REG_MCR);
>> +        mcr |= 0x200;
>> +        mcr &= ~(0x2);
>> +    }
>> +    if (up->mcr & UART_MCR_AFE) {
>> +        /* set RTS high level trigger */
>> +        mcr = serial_in(up, UART_REG_MCR);
>> +        mcr |= 0x200;
>> +        mcr &= ~(0x2);
>
> This is repeated. Parentheses are superfluous. And again, 0x200, 0x2 
> are magic.
>
>> +
>> +        /* enable CTS/RTS auto-flow control */
>> +        serial_out(up, UART_REG_IER,
>> +               (serial_in(up, UART_REG_IER) | (0x3000)));
>> +
>> +        /* Set hardware flow control */
>> +        up->port.flags |= UPF_HARD_FLOW;
>> +    } else {
>> +        /* disable CTS/RTS auto-flow control */
>> +        ier = serial_in(up, UART_REG_IER);
>> +        ier &= ~(0x3000);
>
> Detto.
>
>> +        serial_out(up, UART_REG_IER, ier);
>> +
>> +        /* un-set hardware flow control */
>> +        up->port.flags &= ~UPF_HARD_FLOW;
>> +    }
>> +
>> +    /* set CTS high level trigger */
>> +    serial_out(up, UART_REG_MSR, (serial_in(up, UART_REG_MSR) | 
>> (0x100)));
>> +    serial_out(up, UART_REG_MCR, mcr);
>> +}
> ...
>> +static int ma35d1serial_startup(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +    struct tty_struct *tty = port->state->port.tty;
>> +    int retval;
>> +
>> +    /* Reset FIFO */
>> +    serial_out(up, UART_REG_FCR, TFR | RFR /* | RX_DIS */);
>
> So why not RX_DIS?
>
>> +
>> +    /* Clear pending interrupts */
>> +    serial_out(up, UART_REG_ISR, 0xFFFFFFFF);
>> +
>> +    retval = request_irq(port->irq, ma35d1serial_interrupt, 0,
>> +                 tty ? tty->name : "ma35d1_serial", port);
>> +    if (retval) {
>> +        dev_err(up->port.dev, "request irq failed.\n");
>> +        return retval;
>> +    }
>> +
>> +    /* Now, initialize the UART */
>> +    /* FIFO trigger level 4 byte */
>> +    /* RTS trigger level 8 bytes */
>> +    serial_out(up, UART_REG_FCR,
>> +           serial_in(up, UART_REG_FCR) | 0x10 | 0x20000);
>> +    serial_out(up, UART_REG_LCR, 0x7); /* 8 bit */
>> +    serial_out(up, UART_REG_TOR, 0x40);
>
> You know what.
>
>> +    serial_out(up, UART_REG_IER,
>> +           RTO_IEN | RDA_IEN | TIME_OUT_EN | BUFERR_IEN);
>> +    return 0;
>> +}
>> +
>> +static void ma35d1serial_shutdown(struct uart_port *port)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +
>> +    free_irq(port->irq, port);
>> +
>> +    /* Disable interrupts from this port */
>> +    serial_out(up, UART_REG_IER, 0);
>
> The two lines are switched, IMO. First disable HW, then let the ISR 
> finish and free it.

You're right. I will fix it.

>
>> +}
>> +
>> +static u32 ma35d1serial_get_divisor(struct uart_port *port, u32 baud)
>> +{
>> +    u32 quot;
>> +
>> +    quot = (port->uartclk / baud) - 2;
>> +    return quot;
>
> quot variable is completely superfluous.

remove quot
and
return (port->uartclk / baud) - 2;

>
>> +}
>> +
>> +static void ma35d1serial_set_termios(struct uart_port *port,
>> +                     struct ktermios *termios,
>> +                     const struct ktermios *old)
>> +{
>> +    struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
>> +    u32 lcr = 0;
>> +    unsigned long flags;
>> +    u32 baud, quot;
>> +
>> +    switch (termios->c_cflag & CSIZE) {
>> +    case CS5:
>> +        lcr = 0;
>> +        break;
>> +    case CS6:
>> +        lcr |= 1;
>> +        break;
>> +    case CS7:
>> +        lcr |= 2;
>> +        break;
>> +    case CS8:
>> +    default:
>> +        lcr |= 3;
>> +        break;
>> +    }
>
> IOW:
> lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>
All registers in this uart controller are 32-bits.
lcr will finally be written to the register UART_REG_LCR.of
which bit[1:0] represents for UART word length.
00 - 5 bits
01 - 6 bits
10 - 7 bits
11 - 8bits

Instead, I will add
#define WLS_5    0x0
#define WLS_6    0x1
#define WLS_7    0x2
#define WLS_8    0x3

and replace lcr |= 1 with
lcr |= WLS_6;

>> +
>> +    if (termios->c_cflag & CSTOPB)
>> +        lcr |= NSB;
>> +    if (termios->c_cflag & PARENB)
>> +        lcr |= PBE;
>> +    if (!(termios->c_cflag & PARODD))
>> +        lcr |= EPE;
>> +    if (termios->c_cflag & CMSPAR)
>> +        lcr |= SPE;
>> +
>> +    baud = uart_get_baud_rate(port, termios, old, port->uartclk / 
>> 0xffff,
>> +                  port->uartclk / 11);
>> +
>> +    quot = ma35d1serial_get_divisor(port, baud);
>> +
>> +    /*
>> +     * Ok, we're now changing the port state.  Do it with
>> +     * interrupts disabled.
>> +     */
>> +    spin_lock_irqsave(&up->port.lock, flags);
>> +
>> +    up->port.read_status_mask = RX_OVER_IF;
>> +    if (termios->c_iflag & INPCK)
>> +        up->port.read_status_mask |= FEF | PEF;
>> +    if (termios->c_iflag & (BRKINT | PARMRK))
>> +        up->port.read_status_mask |= BIF;
>> +
>> +    /*
>> +     * Characteres to ignore
>> +     */
>> +    up->port.ignore_status_mask = 0;
>> +    if (termios->c_iflag & IGNPAR)
>> +        up->port.ignore_status_mask |= FEF | PEF;
>> +    if (termios->c_iflag & IGNBRK) {
>> +        up->port.ignore_status_mask |= BIF;
>> +        /*
>> +         * If we're ignoring parity and break indicators,
>> +         * ignore overruns too (for real raw support).
>> +         */
>> +        if (termios->c_iflag & IGNPAR)
>> +            up->port.ignore_status_mask |= RX_OVER_IF;
>> +    }
>> +    if (termios->c_cflag & CRTSCTS)
>> +        up->mcr |= UART_MCR_AFE;
>> +    else
>> +        up->mcr &= ~UART_MCR_AFE;
>> +
>> +    ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
>> +    serial_out(up, UART_REG_BAUD, quot | 0x30000000);
>> +    serial_out(up, UART_REG_LCR, lcr);
>> +    spin_unlock_irqrestore(&up->port.lock, flags);
>> +}
> ...
>> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
>> +{
>> +    int ret;
>> +
>> +    /*
>> +     * Find the region that we can probe for.  This in turn
>> +     * tells us whether we can probe for the type of port.
>> +     */
>> +    ret = ma35d1serial_request_port(port);
>> +    if (ret < 0)
>> +        return;
>
> ma35d1serial_request_port() does nothing. You can remove it altogether.
>

OK, I will remove it.

>> +    port->type = PORT_MA35D1;
>> +}
>
>
>> +static int ma35d1serial_ioctl(struct uart_port *port, u32 cmd, 
>> unsigned long arg)
>> +{
>> +    switch (cmd) {
>> +    default:
>> +        return -ENOIOCTLCMD;
>> +    }
>> +    return 0;
>> +}
>
> Drop that completely.
>

OK.

>> +static void
>> +ma35d1serial_console_init_port(void)
>> +{
>> +    int i = 0;
>> +    struct device_node *np;
>> +
>> +    for_each_matching_node(np, ma35d1_serial_of_match) {
>> +        if (ma35d1serial_uart_nodes[i] == NULL) {
>> +            ma35d1serial_uart_nodes[i] = np;
>> +            i++;
>
> Unless the dt is broken, this is OK. But I would add a sanity check to i.
>

I will add
if (i == UART_NR)
     break;


>> +        }
>> +    }
>> +}
> ...
>> +/*
>> + * Register a set of serial devices attached to a platform device.
>> + * The list is terminated with a zero flags entry, which means we 
>> expect
>> + * all entries to have at least UPF_BOOT_AUTOCONF set.
>> + */
>> +static int ma35d1serial_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res_mem;
>> +    struct uart_ma35d1_port *up;
>> +    int ret;
>> +    struct clk *clk;
>> +    int err;
>> +
>> +    if (pdev->dev.of_node) {
>> +        ret = of_alias_get_id(pdev->dev.of_node, "serial");
>> +        if (ret < 0) {
>> +            dev_err(&pdev->dev,
>> +                "failed to get alias/pdev id, errno %d\n",
>> +                ret);
>> +        return ret;
>> +        }
>> +    }
>> +    up = &ma35d1serial_ports[ret];
>> +    up->port.line = ret;
>> +    res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res_mem)
>> +        return -ENODEV;
>> +
>> +    up->port.iobase = res_mem->start;
>> +    up->port.membase = ioremap(up->port.iobase, 0x10000);
>> +    up->port.ops = &ma35d1serial_ops;
>> +
>> +    spin_lock_init(&up->port.lock);
>> +
>> +    clk = of_clk_get(pdev->dev.of_node, 0);
>> +    if (IS_ERR(clk)) {
>> +        err = PTR_ERR(clk);
>> +        dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
>> +        return -ENOENT;
>> +    }
>> +    err = clk_prepare_enable(clk);
>> +    if (err)
>> +        return -ENOENT;
>> +
>> +    if (up->port.line != 0)
>> +        up->port.uartclk = clk_get_rate(clk);
>> +    up->port.irq = platform_get_irq(pdev, 0);
>> +    up->port.dev = &pdev->dev;
>> +    up->port.flags = UPF_BOOT_AUTOCONF;
>> +    up->port.rs485_config = ma35d1serial_config_rs485;
>> +    ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
>
> What if this fails?
>

I will add return value check.

>> +    platform_set_drvdata(pdev, up);
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Remove serial ports registered against a platform device.
>> + */
>> +static int ma35d1serial_remove(struct platform_device *dev)
>> +{
>> +    int i;
>> +    struct uart_port *port = platform_get_drvdata(dev);
>> +
>> +    free_irq(port->irq, port);
>
> Hmm, this doesn't look right. You did that already, or?
>
>> +    for (i = 0; i < UART_NR; i++) {
>> +        struct uart_ma35d1_port *up = &ma35d1serial_ports[i];
>> +
>> +        if (up->port.dev == &dev->dev)
>
> You did platform_set_drvdata(), so why all this?
>

static int ma35d1serial_remove(struct platform_device *dev)
{
     struct uart_port *port = platform_get_drvdata(dev);

     uart_remove_one_port(&ma35d1serial_reg, &up->port);
     free_irq(port->irq, port);
     return 0;
}


>> + uart_remove_one_port(&ma35d1serial_reg, &up->port);
>> +    }
>> +    return 0;
>> +}
>


Best Regards,

Jacky Huang


