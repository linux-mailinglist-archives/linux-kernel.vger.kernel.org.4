Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0D7495FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjGFHAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjGFG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:59:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0D171A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:59:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so354227e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688626796; x=1691218796;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ekCygdP574MvHjOEcOXc7gCddg3fyvdxIoCepPcTFCQ=;
        b=giQdojI1VDIYHQKpiPkPYNZPgbveNNf5P9cKjKO3yo4PktUIwPs5/nySuYYV7lqkeL
         5A4ELiPNYIuY/z6vW9ihSmwxniYQ9qphy9TOALeAmDxe8AtjXHZwmhnAoJfrVSCgqd9d
         9HSkPSUdNvWugDG/EqJpsigc7QUgS6XAewvnsuf+WqxAr+adB8J3QSPl0LzytcH0k5TR
         fYvSMaMxKb+7LVjCrcKxPBy04zlviMztD4PnmBs5firNH+o6u8bKiW7e4l+tzt7Oh0V5
         R7NyO2S879cNjJJ2CMe1RexDpHj9hpTt9Au8tbVXwWqXZaoErLEKcNFsXJMSa13Dx20Q
         yyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688626796; x=1691218796;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekCygdP574MvHjOEcOXc7gCddg3fyvdxIoCepPcTFCQ=;
        b=gNUET6Otxypw8IqtFtg9bR6Q14Tdf+5/lLBLmgHKKpxLNlQwrsBZ/uN/nt1cV7Tlia
         LeNpHvn2xdD4kRgfn9RIE5xSEQH8U5xElbeqCkCXXhDCD0BBkSSqiYNbANrXqJP79OIf
         0doeJmlrNjVFlSX2UucJ12QrlUj/KZJu4U306Z0omUcMT2NvMOvLJuErHWChF+jKy3cG
         KQqKTAoqwg1sXA8YxK+58CTXkCebncJBJ7JucqwJx1EVRrYxjqkSqaVOQDE1AB3HIsYF
         aXGC3CPZ86V6/zkxbOFP9iUjWw610qIPVqP144gNsCPcYr6OjPPGJlWdfohwT5N9tWXX
         5haA==
X-Gm-Message-State: ABy/qLZqSqWNS8QiNHl5IWNDEh6eNcZbRj0EJgvj3uFGIm0qWQWCJBme
        iRT9y7JlkkvHd0MVF74nzC2h3w==
X-Google-Smtp-Source: APBJJlEsz6Fhpg12b102ApIe1RIyCXh4cNJ1O9HJo8CHhGB8sIkBqYMirtS3Gcv3aAz1DsYthrYKkw==
X-Received: by 2002:a05:6512:3703:b0:4f8:7697:5207 with SMTP id z3-20020a056512370300b004f876975207mr641642lfr.23.1688626795843;
        Wed, 05 Jul 2023 23:59:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003fbd9e390e1sm4147027wmj.47.2023.07.05.23.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:59:55 -0700 (PDT)
Message-ID: <60927fc6-2819-a01a-6ea8-f1af301b1bad@linaro.org>
Date:   Thu, 6 Jul 2023 08:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/7] tty: serial: meson: redesign the module to
 platform_driver
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kelvin.zhang@amlogic.com, xianwei.zhao@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-3-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-3-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> Actually, the meson_uart module is already a platform_driver, but it is
> currently registered manually and the uart core registration is run
> outside the probe() scope, which results in some restrictions. For
> instance, it is not possible to communicate with the OF subsystem
> because it requires an initialized device object.
> 
> To address this issue, apply module_platform_driver() instead of direct
> module init/exit routines. Additionally, move uart_register_driver() to
> the driver probe(), and destroy manual console registration because it's
> already run in the uart_register_driver() flow.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 51 ++++++++++-----------------------
>   1 file changed, 15 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index bca54f3d92a1..dcf994a11a21 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -621,12 +621,6 @@ static struct console meson_serial_console = {
>   	.data		= &meson_uart_driver,
>   };
>   
> -static int __init meson_serial_console_init(void)
> -{
> -	register_console(&meson_serial_console);
> -	return 0;
> -}
> -
>   static void meson_serial_early_console_write(struct console *co,
>   					     const char *s,
>   					     u_int count)
> @@ -652,9 +646,6 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   
>   #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>   #else
> -static int __init meson_serial_console_init(void) {
> -	return 0;
> -}
>   #define MESON_SERIAL_CONSOLE	NULL
>   #endif
>   
> @@ -738,6 +729,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	if (!meson_uart_driver.state) {
> +		ret = uart_register_driver(&meson_uart_driver);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "can't register uart driver\n");
> +	}
> +
>   	port->iotype = UPIO_MEM;
>   	port->mapbase = res_mem->start;
>   	port->mapsize = resource_size(res_mem);
> @@ -776,6 +774,13 @@ static int meson_uart_remove(struct platform_device *pdev)
>   	uart_remove_one_port(&meson_uart_driver, port);
>   	meson_ports[pdev->id] = NULL;
>   
> +	for (int id = 0; id < AML_UART_PORT_NUM; id++)
> +		if (meson_ports[id])
> +			return 0;
> +
> +	/* No more available uart ports, unregister uart driver */
> +	uart_unregister_driver(&meson_uart_driver);
> +
>   	return 0;
>   }
>   
> @@ -809,33 +814,7 @@ static  struct platform_driver meson_uart_platform_driver = {
>   	},
>   };
>   
> -static int __init meson_uart_init(void)
> -{
> -	int ret;
> -
> -	ret = meson_serial_console_init();
> -	if (ret)
> -		return ret;
> -	
> -	ret = uart_register_driver(&meson_uart_driver);
> -	if (ret)
> -		return ret;
> -
> -	ret = platform_driver_register(&meson_uart_platform_driver);
> -	if (ret)
> -		uart_unregister_driver(&meson_uart_driver);
> -
> -	return ret;
> -}
> -
> -static void __exit meson_uart_exit(void)
> -{
> -	platform_driver_unregister(&meson_uart_platform_driver);
> -	uart_unregister_driver(&meson_uart_driver);
> -}
> -
> -module_init(meson_uart_init);
> -module_exit(meson_uart_exit);
> +module_platform_driver(meson_uart_platform_driver);
>   
>   MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
>   MODULE_DESCRIPTION("Amlogic Meson serial port driver");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
