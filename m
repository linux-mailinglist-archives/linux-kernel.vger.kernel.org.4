Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF17152DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjE3BJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjE3BJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:09:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7232CF;
        Mon, 29 May 2023 18:09:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso912564a91.0;
        Mon, 29 May 2023 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685408962; x=1688000962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1wG3ZzBNrC3Iuv0Sazp7NPX3sgvbpQA8Twr3uxU34s=;
        b=kXw1U6akBeszmRiZ1MVvqGt5eDQuWhg17xwHKHH1jEX/9yaFkD1SOvWX/DEiaSJ8V9
         a39ZEYAGgARyRX7UhQmHCk6Ej8CON2madP8nOXK+2PwuqPMl7c39mDtdlgUY2qONvt4O
         17GOFsEwtbE1glmbzKXvHUnmFP86NdwnWvazFzlNQSlmKMm0RxUAnSXNw3RXzsnw3mma
         adXNWyoyVDsjz+4PA2AMk3EJ9+cLtETJoBicLQLeaR+5EPBiZN0vSR7ej7T6bl5azXNN
         gXCpv+CXrKKrWXCo74OPAUXxjC/6Kj8uND/4IW5e5bLShDEOZKg7DeX93UwgYWKlPIGn
         TYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685408962; x=1688000962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1wG3ZzBNrC3Iuv0Sazp7NPX3sgvbpQA8Twr3uxU34s=;
        b=GZYbuKS9LvAHhiCTaKE6/o8aWjPJ4ZVYeQPWN+w3FNy51OnH6dS1N9DooT0/CHYKLP
         5GFrE4auFAOf7AQvn+fI8SyQbq81WTLireYtp1XSw+2LLp5XMUPOfUbJvP07KRS7UKEP
         5ZZH5F0sQwIDVvsh18PCxvjjYAqbMWR4fvl4Ky1UQZj3ZTh1WwDmdkTRoVvYo9bcbkHn
         cbFaRO+AceO/UVRW7dLdgwfzfTOZO5iXFNaQfcfXcJXCqbQHi+AsAPIAef7xEAE1Tck2
         sELSuSGvbW/3fFl24E4Y9lSVDnZlHzMXyXBHQxZPNaq889ygucZvzIGJrQFy7rwoi0X+
         phxg==
X-Gm-Message-State: AC+VfDwP5L7KbjyLUTDpSmgzleEelqj8U8lC13QMZqGMvJN+x8pjjLq3
        9jjxsNYbmbfGkptFUS0S790=
X-Google-Smtp-Source: ACHHUZ4lRcccoA8lGODePVC271WFd12PsoH9zTA9AafQ4ZPdWcMilHiDIITrvpbD1M0gojDXw1+KCw==
X-Received: by 2002:a17:90b:3a91:b0:24e:3752:194f with SMTP id om17-20020a17090b3a9100b0024e3752194fmr9899966pjb.21.1685408961878;
        Mon, 29 May 2023 18:09:21 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a100100b002532eef4fc5sm8271339pja.34.2023.05.29.18.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 18:09:21 -0700 (PDT)
Message-ID: <c9493f4d-8056-20a0-6ed2-161fbcc3d34e@gmail.com>
Date:   Tue, 30 May 2023 09:09:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
From:   Jacky Huang <ychuang570808@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
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
Content-Language: en-US
In-Reply-To: <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,


On 2023/5/24 下午 04:34, Jacky Huang wrote:
> Dear Jiri,
>
> Thanks for your advice.
>
> On 2023/5/24 下午 03:42, Jiri Slaby wrote:
>> On 16. 05. 23, 9:52, Jacky Huang wrote:
>>> +static void ma35d1serial_config_port(struct uart_port *port, int 
>>> flags)
>>> +{
>>> +    /*
>>> +     * Driver core for serial ports forces a non-zero value for 
>>> port type.
>>> +     * Write an arbitrary value here to accommodate the serial core 
>>> driver,
>>> +     * as ID part of UAPI is redundant.
>>> +     */
>>> +    port->type = 1;
>>
>> So this 1 translates to PORT_8250. Why not to use it directly? Or 
>> something more saner like PORT_16550A?
>>
> It's not actually 8250 or 16550A.
> Can we add the following definition to 
> 'include/uapi/linux/serial_core.h' and use PORT_MA35 instead?
>
> #define PORT_MA35    124
>
>
>>> +}
>>> +
>>> +static int ma35d1serial_verify_port(struct uart_port *port, struct 
>>> serial_struct *ser)
>>> +{
>>> +    if (port->type != PORT_UNKNOWN && ser->type != 1)
>>> +        return -EINVAL;
>>> +
>>> +    return 0;
>>> +}
>> ...
>>> +static int __init ma35d1serial_console_setup(struct console *co, 
>>> char *options)
>>> +{
>>> +    struct device_node *np = ma35d1serial_uart_nodes[co->index];
>>> +    struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
>>> +    u32 val32[4];
>>> +    struct uart_port *port;
>>> +    int baud = 115200;
>>> +    int bits = 8;
>>> +    int parity = 'n';
>>> +    int flow = 'n';
>>> +
>>> +    /*
>>> +     * Check whether an invalid uart number has been specified, and
>>
>> You dereferenced ma35d1serial_uart_nodes already. Doesn't 
>> console=ttyNVT1000 (or something like that) crash the system?
>>
>
> I will add the following check before np = 
> "ma35d1serial_uart_nodes[co->index]".
>
> if (co->index < 0 || co->index >= MA35_UART_NR)
>     return -EINVAL;
>
>
>>> +     * if so, search for the first available port that does have
>>> +     * console support.
>>
>> The code below doesn't match this comment.
>
> Yes, I will remove the above comment.
>
>>
>>> +     */
>>> +    if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
>>> +        pr_debug("Console Port%x out of range\n", co->index);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
>>
>> Shouldn't that 4 be ARRAY_SIZE(val32) instead?
>>
>
> Will be fixed.
>
>>> +        return -EINVAL;
>>
>> One \n here please.
>>
>
> Okay, I will add it.
>
>>> +    p->port.iobase = val32[1];
>>> +    p->port.membase = ioremap(p->port.iobase, MA35_UART_REG_SIZE);
>>
>> What if this fails?
>>
>
> I will add a check for the return value.
>
>>> +    p->port.ops = &ma35d1serial_ops;
>>> +    p->port.line = 0;
>>> +    p->port.uartclk = MA35_UART_CONSOLE_CLK;
>>> +
>>> +    port = &ma35d1serial_ports[co->index].port;
>>
>> Isn't this:
>>   port = &p->port;
>> ?
>>
>> Either use port on all above lines or drop the "port" variable 
>> completely and use "p->port" below instead.
>>
>
> I will remove port variable and use p->port only.
>
>>> +
>>> +    if (options)
>>> +        uart_parse_options(options, &baud, &parity, &bits, &flow);
>>> +
>>> +    return uart_set_options(port, co, baud, parity, bits, flow);
>>> +}
>>> +
>>> +static struct console ma35d1serial_console = {
>>> +    .name    = "ttyNVT",
>>> +    .write   = ma35d1serial_console_write,
>>> +    .device  = uart_console_device,
>>> +    .setup   = ma35d1serial_console_setup,
>>> +    .flags   = CON_PRINTBUFFER | CON_ENABLED,
>>> +    .index   = -1,
>>> +    .data    = &ma35d1serial_reg,
>>
>> I don't see console->data used anywhere in the driver?
>>
>
> I will remove it.
>

I removed the " .data    = &ma35d1serial_reg", but kernel crashed in 
'drivers/tty/serial/serial_core.c'.

The variable 'p' of  uart_console_device() refer to a NULL, because 
co->data is NULL.
As a result, kernel crashed at 'p->tty_driver'.

struct tty_driver *uart_console_device(struct console *co, int *index)
{
     struct uart_driver *p = co->data;
     *index = co->index;
     return p->tty_driver;
}

We seem to be unable to remove it.
If there are no other considerations, I will keep it in the next version.

>>> +};
>> ...
>>> +static int ma35d1serial_probe(struct platform_device *pdev)
>>> +{
>>> +    struct resource *res_mem;
>>> +    struct uart_ma35d1_port *up;
>>> +    int ret = 0;
>>> +
>>> +    if (pdev->dev.of_node) {
>>> +        ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>> +        if (ret < 0) {
>>> +            dev_err(&pdev->dev, "failed to get alias/pdev id, errno 
>>> %d\n", ret);
>>> +            return ret;
>>> +        }
>>> +    }
>>> +    up = &ma35d1serial_ports[ret];
>>> +    up->port.line = ret;
>>> +    res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    if (!res_mem)
>>> +        return -ENODEV;
>>> +
>>> +    up->port.iobase = res_mem->start;
>>> +    up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);
>>
>> Check this too.
>>
>
> Okay, sure.
>
>>> +    up->port.ops = &ma35d1serial_ops;
>>> +
>>> +    spin_lock_init(&up->port.lock);
>>> +
>>> +    up->clk = of_clk_get(pdev->dev.of_node, 0);
>>> +    if (IS_ERR(up->clk)) {
>>> +        ret = PTR_ERR(up->clk);
>>> +        dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
>>> +        goto err_iounmap;
>>> +    }
>>> +
>>> +    ret = clk_prepare_enable(up->clk);
>>> +    if (ret)
>>> +        goto err_iounmap;
>>> +
>>> +    if (up->port.line != 0)
>>> +        up->port.uartclk = clk_get_rate(up->clk);
>>> +
>>> +    ret = platform_get_irq(pdev, 0);
>>> +    if (ret < 0)
>>> +        goto err_clk_disable;
>>> +
>>> +    up->port.irq = ret;
>>> +    up->port.dev = &pdev->dev;
>>> +    up->port.flags = UPF_BOOT_AUTOCONF;
>>> +
>>> +    platform_set_drvdata(pdev, up);
>>> +
>>> +    ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
>>> +    if (ret < 0)
>>> +        goto err_free_irq;
>>> +
>>> +    return 0;
>>> +
>>> +err_free_irq:
>>> +    free_irq(up->port.irq, &up->port);
>>> +
>>> +err_clk_disable:
>>> +    clk_disable_unprepare(up->clk);
>>> +
>>> +err_iounmap:
>>> +    iounmap(up->port.membase);
>>> +    return ret;
>>> +}
>>
>> thanks,
>
> Best regards,
> Jacky Huang
>

Best regards,
Jacky Huang

