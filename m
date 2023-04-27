Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E356F019E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjD0HXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0HXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:23:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A304EF5;
        Thu, 27 Apr 2023 00:22:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a69f686345so63306315ad.2;
        Thu, 27 Apr 2023 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682580135; x=1685172135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXJHDR+uvigrdqjtItsF0amUfeR/xcg4WFinveNN2RY=;
        b=jWDo3kzPfX9uZTI+RJ06zG503kFpbG0icTs3PBkudav0w7nbVWnlOxeJU2R+UhPp6o
         1MGmtg9T4ZoK+1Tlm1TteFyd3QcicOpretq9RxJhFW0ssm4ZxbfFWLkTj7hNzAzETYuM
         ML2L0nSOWD/Aolznnh+z2NndUoCz7kGW6BnXzkf3p6E3O36fnst6lYDyXQMNL5/+QMKF
         +rS9PR2tUgLTVL7cRVIUh1M4QifkRcC+6AKuaCUID5vcQEAl8f31ObgZXZ6hKnKB9Q7D
         TVoT7XeLnyjhE2q0u6Cxalk/o+FLNOObIU5ngguKmQ7jRSRk/TBqh0NKtZv9Lqb4lfms
         EJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682580135; x=1685172135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXJHDR+uvigrdqjtItsF0amUfeR/xcg4WFinveNN2RY=;
        b=V5TFRGDCfbwVktVYpgHVEPhwngPbKHYhhNPyLGOVsM0U5FYt7vtQnZmJrOp7w4vz7f
         S8A2dqcLEFxgvaW+mqEDox3VK6G4FXpS1653cxKAxAF5p/xVFq+C84BzVzzcBR4fL2JD
         /+vmpbvlpoGGUU8oCeH2gxK7t1Tsgi6p6F3D2eQX+2sZTFXXX1DQ+HM0A0dhg4B4S2ay
         LZzuI4cXQWRTadcHjSdI8dc7202uEUSt53epMymC70sHX03LWwA7IEql1cOtaC6R4a4K
         xPs/XyiwV5zDAnOlyRWBILZTjHXxFKB5ZjCi4v83L4pUguKR8LNnTagT9+oG1OX8j52r
         svwg==
X-Gm-Message-State: AC+VfDxdx1/J1u7zUpJHpZXN590xQRXa7H1OGoIbt+vgKGeuSgoWaOn4
        lfJA2RNVi/L/chNLHjoprH4=
X-Google-Smtp-Source: ACHHUZ7QFbzk6DipZKj1VayaE1oZ/33TmkMvLk6ABtMS3XNELvyeMZtBaXjFmGh0CryDFiwMa2QPLg==
X-Received: by 2002:a17:903:2095:b0:1a5:309e:d205 with SMTP id d21-20020a170903209500b001a5309ed205mr594702plc.21.1682580135198;
        Thu, 27 Apr 2023 00:22:15 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902bd4a00b001a95aef9728sm8009094plx.19.2023.04.27.00.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:22:14 -0700 (PDT)
Message-ID: <d2d42bf5-fc7e-7a88-7e62-f35e16401012@gmail.com>
Date:   Thu, 27 Apr 2023 15:22:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 10/11] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-11-ychuang570808@gmail.com>
 <46933536-2999-c3b0-f3d3-60e8830f50a6@wanadoo.fr>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <46933536-2999-c3b0-f3d3-60e8830f50a6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/25 下午 06:38, Christophe JAILLET wrote:
> Le 25/04/2023 à 12:24, Jacky Huang a écrit :
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>> It supports full-duplex communication, FIFO control, and
>> hardware flow control.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   drivers/tty/serial/Kconfig         |  18 +
>>   drivers/tty/serial/Makefile        |   1 +
>>   drivers/tty/serial/ma35d1_serial.c | 781 +++++++++++++++++++++++++++++
>>   3 files changed, 800 insertions(+)
>>   create mode 100644 drivers/tty/serial/ma35d1_serial.c
>>
>
> [...]
>
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
>> +    up->port.membase = devm_ioremap(&pdev->dev, up->port.iobase, 
>> UART_REG_SIZE);
>> +    up->port.ops = &ma35d1serial_ops;
>> +
>> +    spin_lock_init(&up->port.lock);
>> +
>> +    clk = of_clk_get(pdev->dev.of_node, 0);
>
> Does this...
>
>> +    if (IS_ERR(clk)) {
>> +        err = PTR_ERR(clk);
>> +        dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
>> +        return -ENOENT;
>> +    }
>> +
>> +    err = clk_prepare_enable(clk);
>
> ... and this be undone in the remove function?
>
> CJ
>

I will add clk_disable_unprepare() in the remove function.

>> +    if (err)
>> +        return -ENOENT;
>> +
>> +    if (up->port.line != 0)
>> +        up->port.uartclk = clk_get_rate(clk);
>> +
>> +    ret = platform_get_irq(pdev, 0);
>> +    if (ret < 0)
>> +        return ret;
>> +    up->port.irq = ret;
>> +    up->port.dev = &pdev->dev;
>> +    up->port.flags = UPF_BOOT_AUTOCONF;
>> +
>> +    platform_set_drvdata(pdev, up);
>> +
>> +    return uart_add_one_port(&ma35d1serial_reg, &up->port);
>> +}
>
> [...]
>

Best Regards,
Jacky Huang
