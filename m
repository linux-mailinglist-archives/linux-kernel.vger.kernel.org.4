Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0B70F125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjEXIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbjEXIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:36:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0910DA;
        Wed, 24 May 2023 01:34:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so624900b3a.2;
        Wed, 24 May 2023 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684917271; x=1687509271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVLu9J9bPh+2rRySJRbCvWIrIN06DaPuyL4368frERU=;
        b=BEiqCV2skxteCHF6gJIXNcEPy9N7Y4l/hVdwzg8juR/ExQ8LFn+P0Vgc7MVcxLBLRF
         ag0SC0QTIvX9q0iEjRHG2pA3s2yhxwf7v7q0wI7yOw2BigNSDfKB4ITSP3igZKqkJlhw
         dUAHazKTTO59rs30xYDwJNL0bh3nIgbvB9CSgQbU+8l7yuB2qvZF1OJI/ShrY/9cdSe4
         p7akHiZwMYclgums6O7Aw20lUInCA6ZS/g/6N+/TtafH4SH++nRg5hBRlDEnQOHxgK65
         UuLCsyCvE+R7rdXUVzvOJe/LB3+tZIX0qU8mbx8CL+6keXTLB3nPk16kQ2naAqAU65e9
         vh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917271; x=1687509271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVLu9J9bPh+2rRySJRbCvWIrIN06DaPuyL4368frERU=;
        b=SXwe2k91pElOuQKDorAFw/qsxtDC1d205X2OfWhZJOOQbn4pP9lz6DNkpFx1XBLhHx
         lRvwQYglAXPUDlNHqrqw5cIaNZXIDYoznXrKUedcYn20EQUiff5ZJtNgc3sJnB+10PVc
         81v/Fb3RxtDEzGr4ZjOYPGwAb94JL1498PzO8aufIeCp7Yt9Jc8NkPOMLPlesg73219x
         iO8iLHurFKz1sfxWrB8HElrnOOzyIM9EjkwRMz9JjYy2c8CQLtl2PLdAsxiT72dgQGCT
         X6k1+vF+rNkDwnCrPfFzWuwqPZMPoN2zeQlsfpWSWO60Q590dccE1FhXnaLeJ0b2caTx
         xxrA==
X-Gm-Message-State: AC+VfDzV3sX8x6fhYhKtcfwtUrx9bchKFNIuUPJA2r0+MfxZDFZMC2u/
        WpODag1GUd4VYsk8NdFCf+4=
X-Google-Smtp-Source: ACHHUZ5lxTTG65pVSIiJHH9CSoWTk0Ct2ooLQyqcSdibswps4X+OBsBz7+TYwOVVSh0HIersUhJGWQ==
X-Received: by 2002:a05:6a00:1408:b0:647:3de:c0ff with SMTP id l8-20020a056a00140800b0064703dec0ffmr1753269pfu.30.1684917270836;
        Wed, 24 May 2023 01:34:30 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id e26-20020a63501a000000b005143448896csm7259981pgb.58.2023.05.24.01.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:34:30 -0700 (PDT)
Message-ID: <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
Date:   Wed, 24 May 2023 16:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
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
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <3d4acb20-c80e-fd39-c0d0-e9b1e0309d81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,

Thanks for your advice.

On 2023/5/24 下午 03:42, Jiri Slaby wrote:
> On 16. 05. 23, 9:52, Jacky Huang wrote:
>> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
>> +{
>> +    /*
>> +     * Driver core for serial ports forces a non-zero value for port 
>> type.
>> +     * Write an arbitrary value here to accommodate the serial core 
>> driver,
>> +     * as ID part of UAPI is redundant.
>> +     */
>> +    port->type = 1;
>
> So this 1 translates to PORT_8250. Why not to use it directly? Or 
> something more saner like PORT_16550A?
>
It's not actually 8250 or 16550A.
Can we add the following definition to 
'include/uapi/linux/serial_core.h' and use PORT_MA35 instead?

#define PORT_MA35    124


>> +}
>> +
>> +static int ma35d1serial_verify_port(struct uart_port *port, struct 
>> serial_struct *ser)
>> +{
>> +    if (port->type != PORT_UNKNOWN && ser->type != 1)
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
> ...
>> +static int __init ma35d1serial_console_setup(struct console *co, 
>> char *options)
>> +{
>> +    struct device_node *np = ma35d1serial_uart_nodes[co->index];
>> +    struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
>> +    u32 val32[4];
>> +    struct uart_port *port;
>> +    int baud = 115200;
>> +    int bits = 8;
>> +    int parity = 'n';
>> +    int flow = 'n';
>> +
>> +    /*
>> +     * Check whether an invalid uart number has been specified, and
>
> You dereferenced ma35d1serial_uart_nodes already. Doesn't 
> console=ttyNVT1000 (or something like that) crash the system?
>

I will add the following check before np = 
"ma35d1serial_uart_nodes[co->index]".

if (co->index < 0 || co->index >= MA35_UART_NR)
     return -EINVAL;


>> +     * if so, search for the first available port that does have
>> +     * console support.
>
> The code below doesn't match this comment.

Yes, I will remove the above comment.

>
>> +     */
>> +    if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
>> +        pr_debug("Console Port%x out of range\n", co->index);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
>
> Shouldn't that 4 be ARRAY_SIZE(val32) instead?
>

Will be fixed.

>> +        return -EINVAL;
>
> One \n here please.
>

Okay, I will add it.

>> +    p->port.iobase = val32[1];
>> +    p->port.membase = ioremap(p->port.iobase, MA35_UART_REG_SIZE);
>
> What if this fails?
>

I will add a check for the return value.

>> +    p->port.ops = &ma35d1serial_ops;
>> +    p->port.line = 0;
>> +    p->port.uartclk = MA35_UART_CONSOLE_CLK;
>> +
>> +    port = &ma35d1serial_ports[co->index].port;
>
> Isn't this:
>   port = &p->port;
> ?
>
> Either use port on all above lines or drop the "port" variable 
> completely and use "p->port" below instead.
>

I will remove port variable and use p->port only.

>> +
>> +    if (options)
>> +        uart_parse_options(options, &baud, &parity, &bits, &flow);
>> +
>> +    return uart_set_options(port, co, baud, parity, bits, flow);
>> +}
>> +
>> +static struct console ma35d1serial_console = {
>> +    .name    = "ttyNVT",
>> +    .write   = ma35d1serial_console_write,
>> +    .device  = uart_console_device,
>> +    .setup   = ma35d1serial_console_setup,
>> +    .flags   = CON_PRINTBUFFER | CON_ENABLED,
>> +    .index   = -1,
>> +    .data    = &ma35d1serial_reg,
>
> I don't see console->data used anywhere in the driver?
>

I will remove it.

>> +};
> ...
>> +static int ma35d1serial_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res_mem;
>> +    struct uart_ma35d1_port *up;
>> +    int ret = 0;
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
>> +    up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);
>
> Check this too.
>

Okay, sure.

>> +    up->port.ops = &ma35d1serial_ops;
>> +
>> +    spin_lock_init(&up->port.lock);
>> +
>> +    up->clk = of_clk_get(pdev->dev.of_node, 0);
>> +    if (IS_ERR(up->clk)) {
>> +        ret = PTR_ERR(up->clk);
>> +        dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
>> +        goto err_iounmap;
>> +    }
>> +
>> +    ret = clk_prepare_enable(up->clk);
>> +    if (ret)
>> +        goto err_iounmap;
>> +
>> +    if (up->port.line != 0)
>> +        up->port.uartclk = clk_get_rate(up->clk);
>> +
>> +    ret = platform_get_irq(pdev, 0);
>> +    if (ret < 0)
>> +        goto err_clk_disable;
>> +
>> +    up->port.irq = ret;
>> +    up->port.dev = &pdev->dev;
>> +    up->port.flags = UPF_BOOT_AUTOCONF;
>> +
>> +    platform_set_drvdata(pdev, up);
>> +
>> +    ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
>> +    if (ret < 0)
>> +        goto err_free_irq;
>> +
>> +    return 0;
>> +
>> +err_free_irq:
>> +    free_irq(up->port.irq, &up->port);
>> +
>> +err_clk_disable:
>> +    clk_disable_unprepare(up->clk);
>> +
>> +err_iounmap:
>> +    iounmap(up->port.membase);
>> +    return ret;
>> +}
>
> thanks,

Best regards,
Jacky Huang

