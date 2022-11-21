Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812CD631B00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKUIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKUIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:09:39 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F6165B2;
        Mon, 21 Nov 2022 00:09:37 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id n20so26779244ejh.0;
        Mon, 21 Nov 2022 00:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqRaa79Rc3cifC4XGMv+vqJE3qX/IM89zz4U8xNpD4A=;
        b=48J8IrgscK+6BibN9dXwChs8d06XOwyjv85LNoQjJoFhys1NQ8nXwRSegSraYK8h5f
         ug+LFDByiudP//1S5z3RIjtNPcKqDyojgjXs55zh4lAKLKt9h7470/ZTLGAAKH34dRvn
         +XVJTFcp7XqfdREWPVJNLxLa6/2yigolpssZopk8hX+EL51w3wW9jdygHBduxe1Ccqf9
         hXZ+MPA8QwMAlGwmsO3KkCKVZ2LjnjTk/cE13Hn85Lcoss6f4DDYSQY0G6dKqoOQw8HM
         5pJ0vEBBd360eZjdze/vqrc9KfiGv0F5HA2CEsmJdjhHl0NLgkrhE2eTnaPdRYC6HNBu
         v+JQ==
X-Gm-Message-State: ANoB5pmweL7tWXVpvT9Lh08CWnA4Cl3Sy2eJ836HIAYCXjLNUQM0eXPA
        wVe3mIQsojUJWj/ozr8v5Jc=
X-Google-Smtp-Source: AA0mqf57RJ5xD73Ge4dm5atkMbDKSzweSU91OHQ6FaeZXpcgvYsG+eKyqO4u0pzF6/7WD5iNRyNGHw==
X-Received: by 2002:a17:906:6892:b0:78d:ab48:bc84 with SMTP id n18-20020a170906689200b0078dab48bc84mr15107208ejr.22.1669018176269;
        Mon, 21 Nov 2022 00:09:36 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id qm13-20020a170907674d00b0077e6be40e4asm4727001ejc.175.2022.11.21.00.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:09:35 -0800 (PST)
Message-ID: <7c450045-c3b2-b16d-609d-810608949611@kernel.org>
Date:   Mon, 21 Nov 2022 09:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-3-jszhang@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 2/7] serial: bflb_uart: add Bouffalolab UART Driver
In-Reply-To: <20221120082114.3030-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20. 11. 22, 9:21, Jisheng Zhang wrote:
> Add the driver for Bouffalolab UART IP which is found in Bouffalolab
> SoCs such as bl808.
> 
> UART driver probe will create path named "/dev/ttySx".
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
...

 > #define UART_FIFO_CONFIG_0		(0x80)

Superfluous parentheses.

...
> +static void bflb_uart_set_termios(struct uart_port *port,
> +				  struct ktermios *termios,
> +				  const struct ktermios *old)
> +{
> +	unsigned long flags;
> +	u32 valt, valr, val;
> +	unsigned int baud, min;
> +
> +	valt = valr = 0;

Unneeded (see below).

> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	/* set data length */
> +	val = tty_get_char_size(termios->c_cflag) - 1;
> +	valt |= (val << UART_CR_UTX_BIT_CNT_D_SFT);

Use =, not |=. Other than that, can FIELD_SET() be used, provided you 
already define the constants using GENMASK()?

> +
> +	/* calculate parity */
> +	termios->c_cflag &= ~CMSPAR;	/* no support mark/space */
> +	if (termios->c_cflag & PARENB) {
> +		valt |= UART_CR_UTX_PRT_EN;
> +		if (termios->c_cflag & PARODD)
> +			valr |= UART_CR_UTX_PRT_SEL;

This should be valt, IMO.

> +	}
> +
> +	valr = valt;

If not, this doesn't make sense to me.

> +	/* calculate stop bits */
> +	if (termios->c_cflag & CSTOPB)
> +		val = 2;
> +	else
> +		val = 1;
> +	valt |= (val << UART_CR_UTX_BIT_CNT_P_SFT);
> +
> +	/* flow control */
> +	if (termios->c_cflag & CRTSCTS)
> +		valt |= UART_CR_UTX_CTS_EN;
> +
> +	/* enable TX freerunning mode */
> +	valt |= UART_CR_UTX_FRM_EN;
> +
> +	valt |= UART_CR_UTX_EN;
> +	valr |= UART_CR_URX_EN;

Why this is not the very first and only for valt and copied to valr above?

> +
> +	wrl(port, UART_UTX_CONFIG, valt);
> +	wrl(port, UART_URX_CONFIG, valr);
> +
> +	min = port->uartclk / (UART_CR_UTX_BIT_PRD + 1);
> +	baud = uart_get_baud_rate(port, termios, old, min, 4000000);
> +
> +	val = DIV_ROUND_CLOSEST(port->uartclk, baud) - 1;
> +	val &= UART_CR_UTX_BIT_PRD;
> +	val |= (val << 16);
> +	wrl(port, UART_BIT_PRD, val);
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void bflb_uart_rx_chars(struct uart_port *port)
> +{
> +	unsigned char ch, flag;

Please use u8. (serial_core should too, but that's only on a TODO list yet)

> +	unsigned long status;

Long? I think u32.

> +
> +	while ((status = rdl(port, UART_FIFO_CONFIG_1)) & UART_RX_FIFO_CNT_MSK) {
> +		ch = rdl(port, UART_FIFO_RDATA) & UART_FIFO_RDATA_MSK;
> +		flag = TTY_NORMAL;

Drop this flag completely and use the constant below directly.

> +		port->icount.rx++;
> +
> +		if (uart_handle_sysrq_char(port, ch))
> +			continue;
> +		uart_insert_char(port, 0, 0, ch, flag);
> +	}
> +
> +	spin_unlock(&port->lock);
> +	tty_flip_buffer_push(&port->state->port);
> +	spin_lock(&port->lock);
> +}
> +
> +static void bflb_uart_tx_chars(struct uart_port *port)
> +{

Are you unable to use the TX helper? If so:
* why?
* use uart_advance_xmit() at least.

> +	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned int pending, count;
> +
> +	if (port->x_char) {
> +		/* Send special char - probably flow control */
> +		wrl(port, UART_FIFO_WDATA, port->x_char);
> +		port->x_char = 0;
> +		port->icount.tx++;
> +		return;
> +	}
> +
> +	pending = uart_circ_chars_pending(xmit);
> +	if (pending > 0) {
> +		count = (rdl(port, UART_FIFO_CONFIG_1) &
> +			 UART_TX_FIFO_CNT_MSK) >> UART_TX_FIFO_CNT_SFT;
> +		if (count > pending)
> +			count = pending;
> +		if (count > 0) {
> +			pending -= count;
> +			while (count--) {
> +				wrl(port, UART_FIFO_WDATA, xmit->buf[xmit->tail]);
> +				xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +				port->icount.tx++;
> +			}
> +			if (pending < WAKEUP_CHARS)
> +				uart_write_wakeup(port);
> +		}
> +	}
> +
> +	if (pending == 0)
> +		bflb_uart_stop_tx(port);
> +}
> +
> +static irqreturn_t bflb_uart_interrupt(int irq, void *data)
> +{
> +	struct uart_port *port = data;
> +	u32 isr, val;
> +
> +	isr = rdl(port, UART_INT_STS);
> +	wrl(port, UART_INT_CLEAR, isr);
> +
> +	isr &= ~rdl(port, UART_INT_MASK);
> +
> +	spin_lock(&port->lock);
> +
> +	if (isr & UART_URX_FER_INT) {
> +		/* RX FIFO error interrupt */
> +		val = rdl(port, UART_FIFO_CONFIG_0);
> +		if (val & UART_RX_FIFO_OVERFLOW)
> +			port->icount.overrun++;
> +
> +		val |= UART_RX_FIFO_CLR;
> +		wrl(port, UART_FIFO_CONFIG_0, val);
> +	}
> +
> +	if (isr & (UART_URX_FIFO_INT | UART_URX_RTO_INT)) {
> +		bflb_uart_rx_chars(port);
> +	}
> +	if (isr & (UART_UTX_FIFO_INT | UART_UTX_END_INT)) {
> +		bflb_uart_tx_chars(port);
> +	}

Superfluous braces.

> +
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_RETVAL(isr);

Can it happen that UART_INT_STS is nonzero and UART_INT_MASK is zero? 
You'd cause "irqX: nobody cared" in that case.

> +}
> +
> +static void bflb_uart_config_port(struct uart_port *port, int flags)
> +{
> +	u32 val;
> +
> +	port->type = PORT_BFLB;
> +
> +	/* Clear mask, so no surprise interrupts. */

surprising?

> +	val = rdl(port, UART_INT_MASK);
> +	val |= UART_UTX_END_INT;
> +	val |= UART_UTX_FIFO_INT;
> +	val |= UART_URX_FIFO_INT;
> +	val |= UART_URX_RTO_INT;
> +	val |= UART_URX_FER_INT;
> +	wrl(port, UART_INT_MASK, val);
> +}
> +
> +static int bflb_uart_startup(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	int ret;
> +	u32 val;
> +
> +	ret = devm_request_irq(port->dev, port->irq, bflb_uart_interrupt,
> +			       IRQF_SHARED, port->name, port);
> +	if (ret) {
> +		dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
> +			port->irq, ret);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	val = rdl(port, UART_INT_MASK);
> +	val |= 0xfff;

Can this be a defined macro too, please?

> +	wrl(port, UART_INT_MASK, val);
> +
> +	wrl(port, UART_DATA_CONFIG, 0);
> +	wrl(port, UART_SW_MODE, 0);
> +	wrl(port, UART_URX_RTO_TIMER, 0x4f);

Another magic constant.

> +
> +	val = rdl(port, UART_FIFO_CONFIG_1);
> +	val &= ~UART_RX_FIFO_TH_MSK;
> +	val |= BFLB_UART_RX_FIFO_TH << UART_RX_FIFO_TH_SFT;

FIELD_SET()?

> +	wrl(port, UART_FIFO_CONFIG_1, val);
> +
> +	/* Unmask RX interrupts now */
> +	val = rdl(port, UART_INT_MASK);
> +	val &= ~UART_URX_FIFO_INT;
> +	val &= ~UART_URX_RTO_INT;
> +	val &= ~UART_URX_FER_INT;
> +	wrl(port, UART_INT_MASK, val);
> +	val = rdl(port, UART_UTX_CONFIG);
> +	val |= UART_CR_UTX_EN;
> +	wrl(port, UART_UTX_CONFIG, val);
> +	val = rdl(port, UART_URX_CONFIG);
> +	val |= UART_CR_URX_EN;
> +	wrl(port, UART_URX_CONFIG, val);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return 0;
> +}
...
> +/*
> + * Interrupts are disabled on entering
> + */
> +static void bflb_uart_console_write(struct console *co, const char *s,
> +				    u_int count)
> +{
> +	struct uart_port *port = &bflb_uart_ports[co->index]->port;
> +	u32 status, reg, mask;
> +
> +	/* save then disable interrupts */
> +	mask = rdl(port, UART_INT_MASK);
> +	reg = -1;

You use 0xfff earlier, now 0xffffffff. Is that OK? Why not use the same 
constant?

> +	wrl(port, UART_INT_MASK, reg);
> +
> +	/* Make sure that tx is enabled */
> +	reg = rdl(port, UART_UTX_CONFIG);
> +	reg |= UART_CR_UTX_EN;
> +	wrl(port, UART_UTX_CONFIG, reg);
> +
> +	uart_console_write(port, s, count, bflb_console_putchar);
> +
> +	/* wait for TX done */
> +	do {
> +		status = rdl(port, UART_STATUS);
> +	} while ((status & UART_STS_UTX_BUS_BUSY));
> +
> +	/* restore IRQ mask */
> +	wrl(port, UART_INT_MASK, mask);
> +}

regards,
-- 
js
suse labs

