Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CB6E34BC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 04:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDPCb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 22:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 22:31:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50432D5F;
        Sat, 15 Apr 2023 19:31:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so8702247pjb.1;
        Sat, 15 Apr 2023 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681612312; x=1684204312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mbh8KBxteAdMHdfu1a3aRujCPPZXG30RxkMg5arQofY=;
        b=TuGBhR0oV1QNnf+DO8mRmOvRRAovA31JL6MCftHNQAGsj6GE/hSvzuK2w0mFg62TGS
         NdxzpcFT4yYoaeqmcFwkp4Nk/VxlBokT/j/ZhmFzKi5+ccHWn6iLXwYZgT9rVc09DcMR
         4d8c4eQrpHjYmiQQm86wJmX8QxtYZZvKG0RpvCoset+PQ+JsDWAZkSdc0vTBnp5ugCRg
         I8Qw/I9cK1yvvQFw9wa4d2izGk4i9ouZgulCddxycmFLEh7shq/LsTzJiFfjuqTxox1l
         brN4z7O+oxi3gLMoKFE4PVT8SyunXZvhdaoERlgsD22PR8zwlIBSPnf5YYPk29LldwdL
         zRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681612312; x=1684204312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mbh8KBxteAdMHdfu1a3aRujCPPZXG30RxkMg5arQofY=;
        b=bgeSeWeI8JjbAnQoBGCdCvIvl9qOoaO+eGA95EwrWUdFE2JRNJ6MSmtqYBn/vJzbO3
         EMMg/CEJ9bUW44aP4z/Vdoylj6MdfEfxSW5h+X3+sRn+ZzQtBQoUBmCEfnIUqzSiTajv
         2Ya4BS7j+i3kXufhyTa6iXY90u2h88rdho/WxaMXsLa1/vuyN7y3FrGoxOx6AKFqL7I1
         ir61IIP3l1N2EqTy5Hi2S3jMz6o+2iRGGzhwrTPiico2CeQxM8Rc313K6VE7IqsRhdI7
         RxeYw8yNYrkOojUPY1CDnRJfCdgTiGdlLWETdi91nV2upZEgAG82HVydntOJINo0YYPF
         K9wA==
X-Gm-Message-State: AAQBX9dtcMok0CXO0H6pppiZOJSrQbwsYo77VS+pBRhYnmDLBe4hUuO8
        M/TFHNo4ojbOW2dvAanAArE=
X-Google-Smtp-Source: AKy350aCEe8StHXF+JpU9stlV4jilDL5hUak/GTLTuS4QN1nrMp0VEsTW3USsgODPq0DZ2N+orUdxQ==
X-Received: by 2002:a17:902:e5c8:b0:1a6:be37:22e1 with SMTP id u8-20020a170902e5c800b001a6be3722e1mr2901809plf.15.1681612311968;
        Sat, 15 Apr 2023 19:31:51 -0700 (PDT)
Received: from [192.168.1.101] (1-160-170-76.dynamic-ip.hinet.net. [1.160.170.76])
        by smtp.gmail.com with ESMTPSA id jl4-20020a170903134400b001a52abb3be3sm5208710plb.201.2023.04.15.19.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 19:31:51 -0700 (PDT)
Message-ID: <ae2883a6-2fbe-666f-c17d-169faa9a619e@gmail.com>
Date:   Sun, 16 Apr 2023 10:31:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-12-ychuang570808@gmail.com>
 <9bd73f85-9d9a-8c44-e4e6-3c10b76fe135@kernel.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <9bd73f85-9d9a-8c44-e4e6-3c10b76fe135@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,


Thanks for you advice.


On 2023/4/14 下午 02:47, Jiri Slaby wrote:
> On 12. 04. 23, 7:38, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>> It supports full-duplex communication, FIFO control, and
>> hardware flow control.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ...
>> --- /dev/null
>> +++ b/drivers/tty/serial/ma35d1_serial.c
>> @@ -0,0 +1,773 @@
> ...
>> +static void transmit_chars(struct uart_ma35d1_port *up)
>> +{
>> +    int count;
>
> count is unsigned.


I will use 'u32' instead.


>
>> +    u8 ch;
>> +
>> +    if (uart_tx_stopped(&up->port)) {
>> +        ma35d1serial_stop_tx(&up->port);
>> +        return;
>> +    }
>> +    count = UART_FIFO_DEPTH - ((serial_in(up, UART_REG_FSR) & 
>> FSR_TXPTR_MSK) >> 16);
>
> So this could be FIELD_GET() while you are defining FSR_TXPTR_MSK 
> using GENMASK(), right?


Yes, I will modify it as

     count = UART_FIFO_DEPTH - FIELD_GET(FSR_TXPTR_MSK, serial_in(up, 
UART_REG_FSR));


>
>> + uart_port_tx_limited(&up->port, ch, count,
>> +                 !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
>> +                 serial_out(up, UART_REG_THR, ch),
>> +                 ({}));
>> +}
> ...
>> +static void ma35d1serial_set_termios(struct uart_port *port,
>> +                     struct ktermios *termios,
>> +                     const struct ktermios *old)
>> +{
>> +    struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +    u32 lcr = 0;
>> +    unsigned long flags;
>> +    u32 baud, quot;
>> +
>> +    lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>> +
>> +    if (termios->c_cflag & CSTOPB)
>> +        lcr |= LCR_NSB;
>> +    if (termios->c_cflag & PARENB)
>> +        lcr |= LCR_PBE;
>> +    if (!(termios->c_cflag & PARODD))
>> +        lcr |= LCR_EPE;
>> +    if (termios->c_cflag & CMSPAR)
>> +        lcr |= LCR_SPE;
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
>> +    up->port.read_status_mask = FSR_RX_OVER_IF;
>> +    if (termios->c_iflag & INPCK)
>> +        up->port.read_status_mask |= FSR_FEF | FSR_PEF;
>> +    if (termios->c_iflag & (BRKINT | PARMRK))
>> +        up->port.read_status_mask |= FSR_BIF;
>> +
>> +    /*
>> +     * Characteres to ignore
>
> "Characters"
>
> The comment could be oneline.

Okay, I will modify it as as oneline.


>
>> +     */
>> +    up->port.ignore_status_mask = 0;
>> +    if (termios->c_iflag & IGNPAR)
>> +        up->port.ignore_status_mask |= FSR_FEF | FSR_PEF;
>> +    if (termios->c_iflag & IGNBRK) {
>> +        up->port.ignore_status_mask |= FSR_BIF;
>> +        /*
>> +         * If we're ignoring parity and break indicators,
>> +         * ignore overruns too (for real raw support).
>> +         */
>> +        if (termios->c_iflag & IGNPAR)
>> +            up->port.ignore_status_mask |= FSR_RX_OVER_IF;
>> +    }
>
> Actually I don't understand the "Characteres" comment above at all. 
> What characters?


We just follow what other serial drivers have done.

You can find the same code segment in tty/serial dz.c, fsl_lpuart.c, 
atmel_serial.c, 8250_port.c ....


>
>> +    if (termios->c_cflag & CRTSCTS)
>> +        up->mcr |= UART_MCR_AFE;
>> +    else
>> +        up->mcr &= ~UART_MCR_AFE;
>> +
>> +    uart_update_timeout(port, termios->c_cflag, baud);
>> +    ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
>> +    serial_out(up, UART_REG_BAUD, quot | BAUD_MODE2);
>> +    serial_out(up, UART_REG_LCR, lcr);
>> +    spin_unlock_irqrestore(&up->port.lock, flags);
>> +}
> ...
>
>> +/*
>> + *  Print a string to the serial port trying not to disturb
>> + *  any possible real use of the port...
>> + *
>> + *  The console_lock must be held when we get here.
>> + */
>> +static void ma35d1serial_console_write(struct console *co,
>> +                       const char *s, u32 count)
>> +{
>> +    struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
>> +    unsigned long flags;
>> +    u32 ier;
>> +
>> +    local_irq_save(flags);
>
> This doesn't protect access to the registers on other CPUs.
>

We will add spin_lock protect to it.


>> +
>> +    /*
>> +     *  First save the IER then disable the interrupts
>> +     */
>> +    ier = serial_in(up, UART_REG_IER);
>> +    serial_out(up, UART_REG_IER, 0);
>> +
>> +    uart_console_write(&up->port, s, count, 
>> ma35d1serial_console_putchar);
>> +
>> +    wait_for_xmitr(up);
>> +
>> +    serial_out(up, UART_REG_IER, ier);
>> +    local_irq_restore(flags);
>> +}
>> +
>> +static int __init ma35d1serial_console_setup(struct console *co,
>> +                         char *options)
>> +{
>> +    struct device_node *np = ma35d1serial_uart_nodes[co->index];
>> +    struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
>> +    u32 val32[4];
>> +    struct uart_port *port;
>> +    int baud = 115200;
>> +    int bits = 8;
>> +    int parity = 'n';
>> +    int flow = 'n';
>
> If you don't do uart_parse_options() (why you don't?), you don't need 
> the variables.


On this platform, the serial console is fixed to be 11520, n, 8, since 
booting from

the non-volatile firmware in MaskROM, arm-trust-firmware, uboot. So we 
do not

use usrt_parse_options().

I will remove these variables and modify 'uart_set_options(port, co, 
baud, parity, bits, flow)'

as 'uart_set_options(port, co, 115200, n, 8, n)'


>
>> +    /*
>> +     * Check whether an invalid uart number has been specified, and
>> +     * if so, search for the first available port that does have
>> +     * console support.
>> +     */
>> +    if ((co->index < 0) || (co->index >= UART_NR)) {
>> +        pr_debug("Console Port%x out of range\n", co->index);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
>> +        return -EINVAL;
>> +    p->port.iobase = val32[1];
>> +    p->port.membase = ioremap(p->port.iobase, UART_REG_SIZE);
>> +    p->port.ops = &ma35d1serial_ops;
>> +    p->port.line = 0;
>> +    p->port.uartclk = UART_CONSOLE_CLK;
>> +
>> +    port = &ma35d1serial_ports[co->index].port;
>> +    return uart_set_options(port, co, baud, parity, bits, flow);
>> +}
> ...> +static void ma35d1serial_console_init_port(void)
>> +{
>> +    int i = 0;
>
> unsigned

I will fix it.


>
>> +    struct device_node *np;
>> +
>> +    for_each_matching_node(np, ma35d1_serial_of_match) {
>> +        if (ma35d1serial_uart_nodes[i] == NULL) {
>> +            of_node_get(np);
>> +            ma35d1serial_uart_nodes[i] = np;
>> +            i++;
>> +            if (i == UART_NR)
>> +                break;
>> +        }
>> +    }
>> +}
>
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
>> +    int ret = 0;
>> +    struct clk *clk;
>> +    int err;
>> +
>> +    if (pdev->dev.of_node) {
>> +        ret = of_alias_get_id(pdev->dev.of_node, "serial");
>> +        if (ret < 0) {
>> +            dev_err(&pdev->dev, "failed to get alias/pdev id, errno 
>> %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +    up = &ma35d1serial_ports[ret];
>> +    up->port.line = ret;
>> +    res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res_mem)
>> +        return -ENODEV;
>> +
>> +    up->port.iobase = res_mem->start;
>> +    up->port.membase = ioremap(up->port.iobase, UART_REG_SIZE);
>> +    up->port.ops = &ma35d1serial_ops;
>> +
>> +    spin_lock_init(&up->port.lock);
>> +
>> +    clk = of_clk_get(pdev->dev.of_node, 0);
>> +    if (IS_ERR(clk)) {
>> +        err = PTR_ERR(clk);
>> +        dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
>> +        return -ENOENT;
>
> iounmap(membase) missing.


I will use devm_ioremap instead, and add return value check to it.


>
>> +    }
>> +    err = clk_prepare_enable(clk);
>> +    if (err)
>> +        return -ENOENT;
>
> Dtto.
>
>> +
>> +    if (up->port.line != 0)
>> +        up->port.uartclk = clk_get_rate(clk);
>> +    up->port.irq = platform_get_irq(pdev, 0);
>
> What if this fails?


I will add return value check to it.


>
>> +    up->port.dev = &pdev->dev;
>> +    up->port.flags = UPF_BOOT_AUTOCONF;
>> +    ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
>
> And this?
>

I will add return value check to it.


>> +    platform_set_drvdata(pdev, up);
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Remove serial ports registered against a platform device.
>> + */
>> +static int ma35d1serial_remove(struct platform_device *dev)
>> +{
>> +    struct uart_port *port = platform_get_drvdata(dev);
>> +
>> +    uart_remove_one_port(&ma35d1serial_reg, port);
>> +    free_irq(port->irq, port);
>
> You do this in ma35d1serial_shutdown() already, correct? So this will 
> error out, right?


Yes, the free_irq() should be removed. I  will fix it.


>
>> +    return 0;
>> +}
>
> Just a couple of questions about testing. Have you tried to:
> * remove the module?
> * suspend/resume the machine while having a line active (device node 
> opened)?
> * running at least a lockdep-enabled kernel while using the device 
> extensively?
>
> thanks,

Thank you for the suggestions. Actually, we never remove the serial 
driver module.

We will have a test on serial module remove, and test suspend/resume 
with at least one uart port enabled.

For the last question, as this SoC have dual-core Cortex-A35 CPU. We 
will a test

to run independent uart transfer application on different core.


Best regards,

Jacky Huang





