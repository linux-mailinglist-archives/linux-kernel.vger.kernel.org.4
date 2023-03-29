Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15C6CD402
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjC2IGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjC2IGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:06:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C732707;
        Wed, 29 Mar 2023 01:06:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id kc4so14160992plb.10;
        Wed, 29 Mar 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680077196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uEnIi0cFKSPM3eq8kzFysqPyb2/8HIhIAc4vrRVdl0=;
        b=GdQ11lHAt40yCOoQv9ec0N5Yugi8n+frhAX7Zq72JtMzsujnM2J3qNWhyeXcv4Ybfm
         Xp3htMiO+Y3vo9JAVNV6zchpWUcZVeRuiJ8x/qnG4stmkufWOndMpr3qC9T3LP4rq9BK
         l+g1RNm4Low3S+gIm2cuss6ZCSuf6aXMADACiVNuH3lt95s38wvnRDWu1NJY1rfvO6De
         eKhsTaaxXzfVXgtTZPmaq7c6MOBF7F7SsWRkllbXfCHzfy0UeYvzuUuigw83en3hRAF/
         XKieBmV4C+RpSp80/4CN5Nt3KPj7Utcl1QMXAyj8CnofntQF9YQ5U5QsBTiXQxgQ7Htz
         2pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uEnIi0cFKSPM3eq8kzFysqPyb2/8HIhIAc4vrRVdl0=;
        b=o3TsGfoT9QGFi+LsX/iBMmOe97w9fkvDlOzmEHgpJMvJuOBkumwQmeykOo8YRQ5mnr
         kBTiYBTKeCk+SOSNpdTKtd6EfPECZizCEljYlgxUOgRVGAaffuMaRZQ+s/5b+cQt615N
         lYs4XIt4f0dBqgbruE3NNcwsQetc9QR3XUrH5qe+s8rQ+qJ8X5xQzxO0OuzbUOONM+K/
         Cl69xyrgkj5oKVhiayx2j2wJOs3kg6iZrcM5TgfYAoBCQVQFj9nVB2qYi256319NK3j9
         Xmlg9RT3yyGLhamn6v2MgHgN7jojXV61ldSHl6ZBMaRyjVaYZu6FXOcM2CLWt4Mv7fBK
         eoPA==
X-Gm-Message-State: AAQBX9eMMB6zocemnl9Ps3bQ4yhUqCL/UH6JSDiMjhhx1hL5T9s9lqZF
        8voiicBKlHfvVmLxQHmEvcU=
X-Google-Smtp-Source: AKy350arl5AFQOoDFJQLzRzumjFjTGP1vXW1eSudXrADXpvY0P2ASLHuQJZbzrE8lquRYUoweAH0QA==
X-Received: by 2002:a17:90b:38cf:b0:233:feb4:895f with SMTP id nn15-20020a17090b38cf00b00233feb4895fmr20058029pjb.44.1680077195542;
        Wed, 29 Mar 2023 01:06:35 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d88300b0019f789cddccsm13420591plz.19.2023.03.29.01.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:06:35 -0700 (PDT)
Message-ID: <89268a72-468f-415d-0f52-e1e2b8f1ad1e@gmail.com>
Date:   Wed, 29 Mar 2023 16:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 11/12] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-12-ychuang570808@gmail.com>
 <f44fffcf-c592-0c73-6e6c-f5914de82503@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <f44fffcf-c592-0c73-6e6c-f5914de82503@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,


Thanks for your advice.

On 2023/3/28 下午 05:23, Jiri Slaby wrote:
> On 28. 03. 23, 4:19, Jacky Huang wrote:
>> +static void transmit_chars(struct uart_ma35d1_port *up)
>> +{
>> +    struct circ_buf *xmit = &up->port.state->xmit;
>> +    int count;
>> +    u8 ch;
>> +
>> +    if (uart_tx_stopped(&up->port)) {
>> +        ma35d1serial_stop_tx(&up->port);
>> +        return;
>> +    }
>> +    if (uart_circ_empty(xmit)) {
>> +        __stop_tx(up);
>> +        return;
>> +    }
>
> Why is this necessary?
>

I will remove this reduntant uart_circ_empty() check.

>> +    count = UART_FIFO_DEPTH - ((serial_in(up, UART_REG_FSR) & 
>> FSR_TXPTR_MSK) >> 16);
>> +
>> +    uart_port_tx_limited(&up->port, ch, count,
>> +                 !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
>> +                 serial_out(up, UART_REG_THR, ch),
>> +                 ({}));
>> +
>> +    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> +        uart_write_wakeup(&up->port);
>> +
>> +    if (uart_circ_empty(xmit))
>> +        __stop_tx(up);
>
> uart_port_tx_limited() should take care about the above and this too, 
> right?

Yes, you are right. These two are also redundant. I will remove them.
Thank you.

>
>> +}
> ...
>> +static void receive_chars(struct uart_ma35d1_port *up)
>> +{
>> +    u8 flag;
>> +    u32 fsr;
>> +    unsigned int ch;
>
> Shouldn't ch be u8 too?

OK, I will fix it as u8.

>
>> +    int max_count = 256;
>> +
>> +    fsr = serial_in(up, UART_REG_FSR);
>> +    do {
>> +        flag = TTY_NORMAL;
>> +        up->port.icount.rx++;
>> +
>> +        if (unlikely(fsr & (FSR_BIF | FSR_FEF | FSR_PEF | 
>> FSR_RX_OVER_IF))) {
>> +            if (fsr & FSR_BIF) {
>> +                up->port.icount.brk++;
>> +                if (uart_handle_break(&up->port))
>> +                    continue;
>> +            }
>> +            if (fsr & FSR_FEF)
>> +                up->port.icount.frame++;
>> +            if (fsr & FSR_PEF)
>> +                up->port.icount.parity++;
>> +            if (fsr & FSR_RX_OVER_IF)
>> +                up->port.icount.overrun++;
>> +
>> +            serial_out(up, UART_REG_FSR, fsr &
>> +                   (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF));
>> +
>> +            if (fsr & FSR_BIF)
>> +                flag = TTY_BREAK;
>> +            else if (fsr & FSR_PEF)
>> +                flag = TTY_PARITY;
>> +            else if (fsr & FSR_FEF)
>> +                flag = TTY_FRAME;
>> +        }
>> +
>> +        ch = serial_in(up, UART_REG_RBR);
>> +        if (uart_handle_sysrq_char(&up->port, ch))
>> +            continue;
>> +
>> +        spin_lock(&up->port.lock);
>> +        uart_insert_char(&up->port, fsr, FSR_RX_OVER_IF, ch, flag);
>> +        spin_unlock(&up->port.lock);
>> +
>> +        fsr = serial_in(up, UART_REG_FSR);
>> +    } while (!(fsr & FSR_RX_EMPTY) && (max_count-- > 0));
>> +
>> +    spin_lock(&up->port.lock);
>> +    tty_flip_buffer_push(&up->port.state->port);
>> +    spin_unlock(&up->port.lock);
>> +}
> ...
>> +static int ma35d1serial_remove(struct platform_device *dev)
>> +{
>> +    struct uart_port *port = platform_get_drvdata(dev);
>> +
>> +    if (port) {
>
> Can this ever be NULL?

OK, I will remove this NULL check.

>
>> + uart_remove_one_port(&ma35d1serial_reg, port);
>> +        free_irq(port->irq, port);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int ma35d1serial_suspend(struct platform_device *dev, 
>> pm_message_t state)
>> +{
>> +    int i;
>> +    struct uart_ma35d1_port *up;
>> +
>> +    if (dev->dev.of_node)
>> +        i = of_alias_get_id(dev->dev.of_node, "serial");
>> +    if (i < 0) {
>> +        dev_err(&dev->dev, "failed to get alias/pdev id, errno 
>> %d\n", i);
>> +        return i;
>> +    }
>> +    up = &ma35d1serial_ports[i];
>
> platform_get_drvdata(dev) ?

We will fix it.

>
>> +    if (i == 0) {
>> +        up->console_baud_rate = serial_in(up, UART_REG_BAUD);
>> +        up->console_line = serial_in(up, UART_REG_LCR);
>> +        up->console_int = serial_in(up, UART_REG_IER);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int ma35d1serial_resume(struct platform_device *dev)
>> +{
>> +    int i;
>> +    struct uart_ma35d1_port *up;
>> +
>> +    if (dev->dev.of_node)
>> +        i = of_alias_get_id(dev->dev.of_node, "serial");
>> +    if (i < 0) {
>> +        dev_err(&dev->dev, "failed to get alias/pdev id, errno 
>> %d\n", i);
>> +        return i;
>> +    }
>> +    up = &ma35d1serial_ports[i];
>> +    if (i == 0) {
>> +        serial_out(up, UART_REG_BAUD, up->console_baud_rate);
>> +        serial_out(up, UART_REG_LCR, up->console_line);
>> +        serial_out(up, UART_REG_IER, up->console_int);
>> +    }
>> +    return 0;
>> +}
>
> No uart_suspend_port()/uart_resume_port()? You don't wait for 
> transmitter to be empty in suspend. You don't stop tx etc.
>

We will fix it in the next version.

>> +static struct platform_driver ma35d1serial_driver = {
>> +    .probe      = ma35d1serial_probe,
>> +    .remove     = ma35d1serial_remove,
>> +    .suspend    = ma35d1serial_suspend,
>> +    .resume     = ma35d1serial_resume,
>> +    .driver     = {
>> +        .name   = "ma35d1-uart",
>> +        .owner  = THIS_MODULE,
>> +        .of_match_table = of_match_ptr(ma35d1_serial_of_match),
>> +    },
>> +};
>> +
>> +static int __init ma35d1serial_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = uart_register_driver(&ma35d1serial_reg);
>> +    if (ret)
>> +        return ret;
>> +    ret = platform_driver_register(&ma35d1serial_driver);
>> +    if (ret)
>> +        uart_unregister_driver(&ma35d1serial_reg);
>> +    return ret;
>> +}
>> +
>> +static void __exit ma35d1serial_exit(void)
>> +{
>> +    platform_driver_unregister(&ma35d1serial_driver);
>> +    uart_unregister_driver(&ma35d1serial_reg);
>> +}
>> +
>> +module_init(ma35d1serial_init);
>> +module_exit(ma35d1serial_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("MA35D1 serial driver");
>
>
>> +MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
>
> Why is this needed? How are other platform drivers autoloaded?
>
> thanks,

Yes, it's not needed. I will remove it.


Best regards,
Jacky Huang



