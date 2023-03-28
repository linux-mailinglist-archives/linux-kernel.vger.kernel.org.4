Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D456CBA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjC1JXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjC1JXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:23:51 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA895254;
        Tue, 28 Mar 2023 02:23:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id eh3so46732541edb.11;
        Tue, 28 Mar 2023 02:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995427;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l31qcmsAfbBMTOm3JDbwOz7mZ9GJ7Ef30fDGCWtgXJ4=;
        b=SBr8nON2AcM9YlII8XGYCnTvlNxMZv/ciXju4iCbgaN7ZnNQyXGYsA/O+UwAVOFc1A
         FcSamB1f2uvtVlxkVMLMizUJe/XTv64IqEy5KecytipZrIBzanwvsuneBeVUjCQ0uBea
         qUGe7g8dbBdSDKutQDpw9SB8J2pkzujnRbI4HZNqma9r6aDfE2NPQ36MzuspjwtqUPXn
         3A8sReqOBOutVxTEmZ3QLDzhh1gI43HjujPL1iOhe2OrHpFOrycoVdLP2cMA87SMwAXO
         vp0ZjEu5ePkOTFrd57WzZDE2zhNq9RNSWcAlEKlM4DzMHXJg1AxGgh65BKV52kw7MleO
         s+3w==
X-Gm-Message-State: AAQBX9eZx9GWx+El+zljwzQEA1IM1swdzE5F+1QDh2P8u2F2YQ0Sd+cX
        p+cEC0vD1kDQsUnR2hjlrMg=
X-Google-Smtp-Source: AKy350axhg8A8xNabQ/bU2xIpk5SuH/99UCFfO21+2Ew5xSLa+UBLTbX2gQ0M+Kybvc6ygzyb+kipg==
X-Received: by 2002:aa7:c249:0:b0:4fb:395a:6aa4 with SMTP id y9-20020aa7c249000000b004fb395a6aa4mr14939663edo.31.1679995427321;
        Tue, 28 Mar 2023 02:23:47 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm15805828edb.72.2023.03.28.02.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:23:46 -0700 (PDT)
Message-ID: <f44fffcf-c592-0c73-6e6c-f5914de82503@kernel.org>
Date:   Tue, 28 Mar 2023 11:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-12-ychuang570808@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v6 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230328021912.177301-12-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 03. 23, 4:19, Jacky Huang wrote:
> +static void transmit_chars(struct uart_ma35d1_port *up)
> +{
> +	struct circ_buf *xmit = &up->port.state->xmit;
> +	int count;
> +	u8 ch;
> +
> +	if (uart_tx_stopped(&up->port)) {
> +		ma35d1serial_stop_tx(&up->port);
> +		return;
> +	}
> +	if (uart_circ_empty(xmit)) {
> +		__stop_tx(up);
> +		return;
> +	}

Why is this necessary?

> +	count = UART_FIFO_DEPTH - ((serial_in(up, UART_REG_FSR) & FSR_TXPTR_MSK) >> 16);
> +
> +	uart_port_tx_limited(&up->port, ch, count,
> +			     !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
> +			     serial_out(up, UART_REG_THR, ch),
> +			     ({}));
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&up->port);
> +
> +	if (uart_circ_empty(xmit))
> +		__stop_tx(up);

uart_port_tx_limited() should take care about the above and this too, right?

> +}
...
> +static void receive_chars(struct uart_ma35d1_port *up)
> +{
> +	u8 flag;
> +	u32 fsr;
> +	unsigned int ch;

Shouldn't ch be u8 too?

> +	int max_count = 256;
> +
> +	fsr = serial_in(up, UART_REG_FSR);
> +	do {
> +		flag = TTY_NORMAL;
> +		up->port.icount.rx++;
> +
> +		if (unlikely(fsr & (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF))) {
> +			if (fsr & FSR_BIF) {
> +				up->port.icount.brk++;
> +				if (uart_handle_break(&up->port))
> +					continue;
> +			}
> +			if (fsr & FSR_FEF)
> +				up->port.icount.frame++;
> +			if (fsr & FSR_PEF)
> +				up->port.icount.parity++;
> +			if (fsr & FSR_RX_OVER_IF)
> +				up->port.icount.overrun++;
> +
> +			serial_out(up, UART_REG_FSR, fsr &
> +				   (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF));
> +
> +			if (fsr & FSR_BIF)
> +				flag = TTY_BREAK;
> +			else if (fsr & FSR_PEF)
> +				flag = TTY_PARITY;
> +			else if (fsr & FSR_FEF)
> +				flag = TTY_FRAME;
> +		}
> +
> +		ch = serial_in(up, UART_REG_RBR);
> +		if (uart_handle_sysrq_char(&up->port, ch))
> +			continue;
> +
> +		spin_lock(&up->port.lock);
> +		uart_insert_char(&up->port, fsr, FSR_RX_OVER_IF, ch, flag);
> +		spin_unlock(&up->port.lock);
> +
> +		fsr = serial_in(up, UART_REG_FSR);
> +	} while (!(fsr & FSR_RX_EMPTY) && (max_count-- > 0));
> +
> +	spin_lock(&up->port.lock);
> +	tty_flip_buffer_push(&up->port.state->port);
> +	spin_unlock(&up->port.lock);
> +}
...
> +static int ma35d1serial_remove(struct platform_device *dev)
> +{
> +	struct uart_port *port = platform_get_drvdata(dev);
> +
> +	if (port) {

Can this ever be NULL?

> +		uart_remove_one_port(&ma35d1serial_reg, port);
> +		free_irq(port->irq, port);
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	int i;
> +	struct uart_ma35d1_port *up;
> +
> +	if (dev->dev.of_node)
> +		i = of_alias_get_id(dev->dev.of_node, "serial");
> +	if (i < 0) {
> +		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n", i);
> +		return i;
> +	}
> +	up = &ma35d1serial_ports[i];

platform_get_drvdata(dev) ?

> +	if (i == 0) {
> +		up->console_baud_rate = serial_in(up, UART_REG_BAUD);
> +		up->console_line = serial_in(up, UART_REG_LCR);
> +		up->console_int = serial_in(up, UART_REG_IER);
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_resume(struct platform_device *dev)
> +{
> +	int i;
> +	struct uart_ma35d1_port *up;
> +
> +	if (dev->dev.of_node)
> +		i = of_alias_get_id(dev->dev.of_node, "serial");
> +	if (i < 0) {
> +		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n", i);
> +		return i;
> +	}
> +	up = &ma35d1serial_ports[i];
> +	if (i == 0) {
> +		serial_out(up, UART_REG_BAUD, up->console_baud_rate);
> +		serial_out(up, UART_REG_LCR, up->console_line);
> +		serial_out(up, UART_REG_IER, up->console_int);
> +	}
> +	return 0;
> +}

No uart_suspend_port()/uart_resume_port()? You don't wait for 
transmitter to be empty in suspend. You don't stop tx etc.

> +static struct platform_driver ma35d1serial_driver = {
> +	.probe      = ma35d1serial_probe,
> +	.remove     = ma35d1serial_remove,
> +	.suspend    = ma35d1serial_suspend,
> +	.resume     = ma35d1serial_resume,
> +	.driver     = {
> +		.name   = "ma35d1-uart",
> +		.owner  = THIS_MODULE,
> +		.of_match_table = of_match_ptr(ma35d1_serial_of_match),
> +	},
> +};
> +
> +static int __init ma35d1serial_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&ma35d1serial_reg);
> +	if (ret)
> +		return ret;
> +	ret = platform_driver_register(&ma35d1serial_driver);
> +	if (ret)
> +		uart_unregister_driver(&ma35d1serial_reg);
> +	return ret;
> +}
> +
> +static void __exit ma35d1serial_exit(void)
> +{
> +	platform_driver_unregister(&ma35d1serial_driver);
> +	uart_unregister_driver(&ma35d1serial_reg);
> +}
> +
> +module_init(ma35d1serial_init);
> +module_exit(ma35d1serial_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MA35D1 serial driver");


> +MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);

Why is this needed? How are other platform drivers autoloaded?

thanks,
-- 
js
suse labs

