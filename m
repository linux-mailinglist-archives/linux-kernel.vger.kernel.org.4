Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782A70EFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjEXHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjEXHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:43:25 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4AE9;
        Wed, 24 May 2023 00:43:02 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96fb1642b09so85133666b.0;
        Wed, 24 May 2023 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914172; x=1687506172;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwgrcZ2UwBjm9qvElzAVRShxkr9NVzmzmVcR8DMPVj8=;
        b=gwoCb4k7kosytRstrrwY+/Tfkh5Be2VOlVsSVd1a+ofL8nOe8lDKE86qIOJhCgtWvr
         VQxm1jdtc88aK57m+xQHXgYf5CjriNPEv5ngisp4QgkMMCTovECQ85j00JmG87QxlIf4
         KmSwjT2mtafiFDq+9LNYPb78qFXn70qt/Tr+JKINF9dRocHaKIePn7DiiOKfKwFjIOgc
         sjGVlLBKAoRrN2Qmiv5BNkOJQPRFTcmI7FZxHa6bpzkIl0eDOJ6U3u1F782MQeks60jc
         7N3Ni87XmbBDyR9uQVAAu2vzBRkxThSSRgomkvakO+LhzwQbH1tf1jWqIZ5Ard2w01t+
         aBEg==
X-Gm-Message-State: AC+VfDxLWwQtboeGa/pDyikCtjiALgzx/HQQLlCHN8J3Mo2pHU61HOUM
        WWkj4M3ewkQl+80ZNU9TKQs=
X-Google-Smtp-Source: ACHHUZ4HvOu04Y5mGSqqaAuE6ebBkKg8OJvbfmZxEJbWTMKb6kSYysDu9rwF9z+yUleqxo4VhBArLg==
X-Received: by 2002:a17:907:2cc7:b0:959:18b2:454a with SMTP id hg7-20020a1709072cc700b0095918b2454amr15794693ejc.76.1684914172213;
        Wed, 24 May 2023 00:42:52 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id mj14-20020a170906af8e00b009659fa6eeddsm5381880ejb.196.2023.05.24.00.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:42:51 -0700 (PDT)
Message-ID: <3d4acb20-c80e-fd39-c0d0-e9b1e0309d81@kernel.org>
Date:   Wed, 24 May 2023 09:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
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
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230516075217.205401-11-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 05. 23, 9:52, Jacky Huang wrote:
> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
> +{
> +	/*
> +	 * Driver core for serial ports forces a non-zero value for port type.
> +	 * Write an arbitrary value here to accommodate the serial core driver,
> +	 * as ID part of UAPI is redundant.
> +	 */
> +	port->type = 1;

So this 1 translates to PORT_8250. Why not to use it directly? Or 
something more saner like PORT_16550A?

> +}
> +
> +static int ma35d1serial_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +	if (port->type != PORT_UNKNOWN && ser->type != 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
...
> +static int __init ma35d1serial_console_setup(struct console *co, char *options)
> +{
> +	struct device_node *np = ma35d1serial_uart_nodes[co->index];
> +	struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
> +	u32 val32[4];
> +	struct uart_port *port;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';
> +
> +	/*
> +	 * Check whether an invalid uart number has been specified, and

You dereferenced ma35d1serial_uart_nodes already. Doesn't 
console=ttyNVT1000 (or something like that) crash the system?

> +	 * if so, search for the first available port that does have
> +	 * console support.

The code below doesn't match this comment.

> +	 */
> +	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
> +		pr_debug("Console Port%x out of range\n", co->index);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_array(np, "reg", val32, 4) != 0)

Shouldn't that 4 be ARRAY_SIZE(val32) instead?

> +		return -EINVAL;

One \n here please.

> +	p->port.iobase = val32[1];
> +	p->port.membase = ioremap(p->port.iobase, MA35_UART_REG_SIZE);

What if this fails?

> +	p->port.ops = &ma35d1serial_ops;
> +	p->port.line = 0;
> +	p->port.uartclk = MA35_UART_CONSOLE_CLK;
> +
> +	port = &ma35d1serial_ports[co->index].port;

Isn't this:
   port = &p->port;
?

Either use port on all above lines or drop the "port" variable 
completely and use "p->port" below instead.

> +
> +	if (options)
> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct console ma35d1serial_console = {
> +	.name    = "ttyNVT",
> +	.write   = ma35d1serial_console_write,
> +	.device  = uart_console_device,
> +	.setup   = ma35d1serial_console_setup,
> +	.flags   = CON_PRINTBUFFER | CON_ENABLED,
> +	.index   = -1,
> +	.data    = &ma35d1serial_reg,

I don't see console->data used anywhere in the driver?

> +};
...
> +static int ma35d1serial_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_ma35d1_port *up;
> +	int ret = 0;
> +
> +	if (pdev->dev.of_node) {
> +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	up = &ma35d1serial_ports[ret];
> +	up->port.line = ret;
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_mem)
> +		return -ENODEV;
> +
> +	up->port.iobase = res_mem->start;
> +	up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);

Check this too.

> +	up->port.ops = &ma35d1serial_ops;
> +
> +	spin_lock_init(&up->port.lock);
> +
> +	up->clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(up->clk)) {
> +		ret = PTR_ERR(up->clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
> +		goto err_iounmap;
> +	}
> +
> +	ret = clk_prepare_enable(up->clk);
> +	if (ret)
> +		goto err_iounmap;
> +
> +	if (up->port.line != 0)
> +		up->port.uartclk = clk_get_rate(up->clk);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		goto err_clk_disable;
> +
> +	up->port.irq = ret;
> +	up->port.dev = &pdev->dev;
> +	up->port.flags = UPF_BOOT_AUTOCONF;
> +
> +	platform_set_drvdata(pdev, up);
> +
> +	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
> +	if (ret < 0)
> +		goto err_free_irq;
> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(up->port.irq, &up->port);
> +
> +err_clk_disable:
> +	clk_disable_unprepare(up->clk);
> +
> +err_iounmap:
> +	iounmap(up->port.membase);
> +	return ret;
> +}

thanks,
-- 
js
suse labs

