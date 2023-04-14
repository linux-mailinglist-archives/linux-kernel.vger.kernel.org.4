Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6FB6E1CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDNGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:47:30 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EE212A;
        Thu, 13 Apr 2023 23:47:27 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id fy21so223306ejb.9;
        Thu, 13 Apr 2023 23:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681454845; x=1684046845;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkQo8LBS06/e78cfXTve2585dIExf+3TJqJgtxByvP4=;
        b=MMFb4JuVq1eTiZ3bhhBg3PjRaqZ67LNFYW3vrS7PDOH8efpTAeb7qQ7XLvOLnqiL2F
         KSgPqRDivslr+9yd6eY+Oha/gmVJYa1orK14zuabEb81mI43lz5DcxAKul9AQPTHJr5D
         aodc+cjO5E1tpubtaZTB0XKKkWVwwgHjE2eKp0BA8AhA7YLrozxt4BsX/EDit3k7RnCv
         o2po1ycAp+p7DeMP04C9iaiCzquUL0OPpuGEwfeeQOkUxBZzqsy5LIthJaoNb1MWEbv3
         cwrrbuWstMB75hk66/Y+rHpeNCAS0oIazKj+OexeMNcBcNhBPQwfR2hDB6y98ernxD90
         RJVw==
X-Gm-Message-State: AAQBX9dvse9+5766CjSHPj1uAt51W08G5elDq2D6PrI8jduNWjtu2948
        udkkFa8Iq8iV8dt2LDYIe58=
X-Google-Smtp-Source: AKy350aga0dvs2urbZVNKQOJRIwfGzX0fuZRt5+Pn265Jl7GqBhioNj8xErUGIpK0QFL/5uHllZqDQ==
X-Received: by 2002:a17:906:a205:b0:94e:be0:97 with SMTP id r5-20020a170906a20500b0094e0be00097mr5175083ejy.26.1681454845178;
        Thu, 13 Apr 2023 23:47:25 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906c18800b0094e877ec197sm2002877ejz.148.2023.04.13.23.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 23:47:24 -0700 (PDT)
Message-ID: <9bd73f85-9d9a-8c44-e4e6-3c10b76fe135@kernel.org>
Date:   Fri, 14 Apr 2023 08:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-12-ychuang570808@gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v7 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230412053824.106-12-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 04. 23, 7:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> It supports full-duplex communication, FIFO control, and
> hardware flow control.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
...
> --- /dev/null
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -0,0 +1,773 @@
...
> +static void transmit_chars(struct uart_ma35d1_port *up)
> +{
> +	int count;

count is unsigned.

> +	u8 ch;
> +
> +	if (uart_tx_stopped(&up->port)) {
> +		ma35d1serial_stop_tx(&up->port);
> +		return;
> +	}
> +	count = UART_FIFO_DEPTH - ((serial_in(up, UART_REG_FSR) & FSR_TXPTR_MSK) >> 16);

So this could be FIELD_GET() while you are defining FSR_TXPTR_MSK using 
GENMASK(), right?

> +	uart_port_tx_limited(&up->port, ch, count,
> +			     !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
> +			     serial_out(up, UART_REG_THR, ch),
> +			     ({}));
> +}
...
> +static void ma35d1serial_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     const struct ktermios *old)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 lcr = 0;
> +	unsigned long flags;
> +	u32 baud, quot;
> +
> +	lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
> +
> +	if (termios->c_cflag & CSTOPB)
> +		lcr |= LCR_NSB;
> +	if (termios->c_cflag & PARENB)
> +		lcr |= LCR_PBE;
> +	if (!(termios->c_cflag & PARODD))
> +		lcr |= LCR_EPE;
> +	if (termios->c_cflag & CMSPAR)
> +		lcr |= LCR_SPE;
> +
> +	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 0xffff,
> +				  port->uartclk / 11);
> +
> +	quot = ma35d1serial_get_divisor(port, baud);
> +
> +	/*
> +	 * Ok, we're now changing the port state.  Do it with
> +	 * interrupts disabled.
> +	 */
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	up->port.read_status_mask = FSR_RX_OVER_IF;
> +	if (termios->c_iflag & INPCK)
> +		up->port.read_status_mask |= FSR_FEF | FSR_PEF;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		up->port.read_status_mask |= FSR_BIF;
> +
> +	/*
> +	 * Characteres to ignore

"Characters"

The comment could be oneline.

> +	 */
> +	up->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		up->port.ignore_status_mask |= FSR_FEF | FSR_PEF;
> +	if (termios->c_iflag & IGNBRK) {
> +		up->port.ignore_status_mask |= FSR_BIF;
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			up->port.ignore_status_mask |= FSR_RX_OVER_IF;
> +	}

Actually I don't understand the "Characteres" comment above at all. What 
characters?

> +	if (termios->c_cflag & CRTSCTS)
> +		up->mcr |= UART_MCR_AFE;
> +	else
> +		up->mcr &= ~UART_MCR_AFE;
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +	ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
> +	serial_out(up, UART_REG_BAUD, quot | BAUD_MODE2);
> +	serial_out(up, UART_REG_LCR, lcr);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
...

> +/*
> + *  Print a string to the serial port trying not to disturb
> + *  any possible real use of the port...
> + *
> + *  The console_lock must be held when we get here.
> + */
> +static void ma35d1serial_console_write(struct console *co,
> +				       const char *s, u32 count)
> +{
> +	struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
> +	unsigned long flags;
> +	u32 ier;
> +
> +	local_irq_save(flags);

This doesn't protect access to the registers on other CPUs.

> +
> +	/*
> +	 *  First save the IER then disable the interrupts
> +	 */
> +	ier = serial_in(up, UART_REG_IER);
> +	serial_out(up, UART_REG_IER, 0);
> +
> +	uart_console_write(&up->port, s, count, ma35d1serial_console_putchar);
> +
> +	wait_for_xmitr(up);
> +
> +	serial_out(up, UART_REG_IER, ier);
> +	local_irq_restore(flags);
> +}
> +
> +static int __init ma35d1serial_console_setup(struct console *co,
> +					     char *options)
> +{
> +	struct device_node *np = ma35d1serial_uart_nodes[co->index];
> +	struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
> +	u32 val32[4];
> +	struct uart_port *port;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';

If you don't do uart_parse_options() (why you don't?), you don't need 
the variables.

> +	/*
> +	 * Check whether an invalid uart number has been specified, and
> +	 * if so, search for the first available port that does have
> +	 * console support.
> +	 */
> +	if ((co->index < 0) || (co->index >= UART_NR)) {
> +		pr_debug("Console Port%x out of range\n", co->index);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
> +		return -EINVAL;
> +	p->port.iobase = val32[1];
> +	p->port.membase = ioremap(p->port.iobase, UART_REG_SIZE);
> +	p->port.ops = &ma35d1serial_ops;
> +	p->port.line = 0;
> +	p->port.uartclk = UART_CONSOLE_CLK;
> +
> +	port = &ma35d1serial_ports[co->index].port;
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
...> +static void ma35d1serial_console_init_port(void)
> +{
> +	int i = 0;

unsigned

> +	struct device_node *np;
> +
> +	for_each_matching_node(np, ma35d1_serial_of_match) {
> +		if (ma35d1serial_uart_nodes[i] == NULL) {
> +			of_node_get(np);
> +			ma35d1serial_uart_nodes[i] = np;
> +			i++;
> +			if (i == UART_NR)
> +				break;
> +		}
> +	}
> +}

> +/*
> + * Register a set of serial devices attached to a platform device.
> + * The list is terminated with a zero flags entry, which means we expect
> + * all entries to have at least UPF_BOOT_AUTOCONF set.
> + */
> +static int ma35d1serial_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_ma35d1_port *up;
> +	int ret = 0;
> +	struct clk *clk;
> +	int err;
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
> +	up->port.membase = ioremap(up->port.iobase, UART_REG_SIZE);
> +	up->port.ops = &ma35d1serial_ops;
> +
> +	spin_lock_init(&up->port.lock);
> +
> +	clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +		return -ENOENT;

iounmap(membase) missing.

> +	}
> +	err = clk_prepare_enable(clk);
> +	if (err)
> +		return -ENOENT;

Dtto.

> +
> +	if (up->port.line != 0)
> +		up->port.uartclk = clk_get_rate(clk);
> +	up->port.irq = platform_get_irq(pdev, 0);

What if this fails?

> +	up->port.dev = &pdev->dev;
> +	up->port.flags = UPF_BOOT_AUTOCONF;
> +	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);

And this?

> +	platform_set_drvdata(pdev, up);
> +	return 0;
> +}
> +
> +/*
> + * Remove serial ports registered against a platform device.
> + */
> +static int ma35d1serial_remove(struct platform_device *dev)
> +{
> +	struct uart_port *port = platform_get_drvdata(dev);
> +
> +	uart_remove_one_port(&ma35d1serial_reg, port);
> +	free_irq(port->irq, port);

You do this in ma35d1serial_shutdown() already, correct? So this will 
error out, right?

> +	return 0;
> +}

Just a couple of questions about testing. Have you tried to:
* remove the module?
* suspend/resume the machine while having a line active (device node 
opened)?
* running at least a lockdep-enabled kernel while using the device 
extensively?

thanks,
-- 
js
suse labs

