Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003974960A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjGFHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGFHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:08:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC1173F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:08:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso386829e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688627330; x=1691219330;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfUnFpPoxbpXv4hVJaj/V4G1uyk5fRMTk74kU76zNRE=;
        b=opLG3C30StFnwtw2D97WUC/wpqBCKDqOkpxCn2ZjWHH1DI9CqWF2MkuNRXM0D4sHq1
         14hRCu53BXAkqA6ujinqHTgRvfUnJ69sE+ruRVmkyAB3kBn8PbFyaj8w6OAMP0ziR7OK
         HH0Ucda7K92gzF9wbeMHlu1HA0Mv/C2PVhA7FfFwZNZqDlpcKCkSIOvWW7thEFf7kX2X
         wBHXTi39sIeF2srEeWeejyXvkseNNrBwtBqs5txl7ZPFS7a6QNhggsrLVTqU9HR4XRkH
         W+ePmuSWpPtVKH35Ljoi+0DKfB9DaVOwXnfwNCMqN8HaCQJAqqMwkaMhh/kX2ZYH99/c
         rZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627330; x=1691219330;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JfUnFpPoxbpXv4hVJaj/V4G1uyk5fRMTk74kU76zNRE=;
        b=ClM05B1M74yWg89K2MzASBsNMGq6ydoDX/ClkTwa1lKp6UkS7Uc9eMnngbT6LdYr22
         qN2d2xMnyo/b9wJT7kcjDsIRtXx9OJosbSAAVVzb4a22a5odb4J75kRMMbIMN1f8kqK3
         fVgXcldc+4zeVDDw7q2HG1W637BDd/5RlT1wDbXw21eAbRU7WV06TAkSaBEq0mQ36LLz
         sZSKqUKt8wBXYoTlhxiqObFCftyUi5asyHp4GrPEiWsCYjhhzJLPzJkvyG15IxABoBSP
         wmtEXF+Qhe7bFgNPmroaWUeQlTG1csjmD8oxM1SazUutyR63UAkymIvk6iZ2C/J80oDo
         vnPw==
X-Gm-Message-State: ABy/qLaIzyAFxRWx6sx3DS5OInBMM1HCVMieYMbnL4YCRV3vlLG5BqlE
        FeUUhFoxMrbV2fdLKEkirHhnIQ==
X-Google-Smtp-Source: APBJJlEpQZSUA4W58M9O4l4VjBT094yF6YRPsfEHrtX798/vAbVQPcSOV3yudV2XWJ0JAbY/LXpa1Q==
X-Received: by 2002:ac2:4f06:0:b0:4f6:2a02:fc1a with SMTP id k6-20020ac24f06000000b004f62a02fc1amr1013870lfr.17.1688627330440;
        Thu, 06 Jul 2023 00:08:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id l25-20020a7bc459000000b003fbe0da2a06sm1155369wmi.28.2023.07.06.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:08:49 -0700 (PDT)
Message-ID: <606ed182-14b8-4c8f-37d3-21971ec71f38@linaro.org>
Date:   Thu, 6 Jul 2023 09:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
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
 <20230705181833.16137-4-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
Subject: Re: [PATCH v2 3/7] tty: serial: meson: apply ttyS devname instead of
 ttyAML for new SoCs
In-Reply-To: <20230705181833.16137-4-ddrokosov@sberdevices.ru>
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

Hi,

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> It is worth noting that the devname ttyS is a widely recognized tty name
> and is commonly used by many uart device drivers. Given the established
> usage and compatibility concerns, it may not be feasible to change the
> devname for older SoCs. However, for new definitions, it is acceptable
> and even recommended to use a new devname to help ensure clarity and
> avoid any potential conflicts on lower or upper software levels.
> 
> For more information please refer to IRC discussion at [1].
> 
> Links:
>      [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 82 ++++++++++++++++++++++-----------
>   1 file changed, 56 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index dcf994a11a21..ad0748a10db7 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -72,16 +72,22 @@
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> -#define AML_UART_DEV_NAME		"ttyAML"
>   
>   #define AML_UART_POLL_USEC		5
>   #define AML_UART_TIMEOUT_USEC		10000
>   
> -static struct uart_driver meson_uart_driver;
> +#define MESON_UART_DRIVER(_devname) meson_uart_driver_##_devname
> +
> +#define MESON_UART_DRIVER_DECLARE(_devname) \
> +	static struct uart_driver MESON_UART_DRIVER(_devname)
> +
> +MESON_UART_DRIVER_DECLARE(ttyAML);
> +MESON_UART_DRIVER_DECLARE(ttyS);

Not sure those macros are useful:
MESON_UART_DRIVER_DECLARE(ttyAML)
vs
static struct uart_driver meson_uart_driver_ttyAML

I prefer the second...

>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>   
>   struct meson_uart_data {
> +	struct uart_driver *uart_driver;
>   	bool has_xtal_div2;
>   };
>   
> @@ -611,15 +617,21 @@ static int meson_serial_console_setup(struct console *co, char *options)
>   	return uart_set_options(port, co, baud, parity, bits, flow);
>   }

I think the uart_driver meson_uart_driver_ttyXXX should be declared here instead or..

>   
> -static struct console meson_serial_console = {
> -	.name		= AML_UART_DEV_NAME,
> -	.write		= meson_serial_console_write,
> -	.device		= uart_console_device,
> -	.setup		= meson_serial_console_setup,
> -	.flags		= CON_PRINTBUFFER,
> -	.index		= -1,
> -	.data		= &meson_uart_driver,
> -};
> +#define MESON_SERIAL_CONSOLE(_devname) meson_serial_console_##_devname
> +
> +#define MESON_SERIAL_CONSOLE_DEFINE(_devname)				\
> +	static struct console MESON_SERIAL_CONSOLE(_devname) = {	\
> +		.name		= __stringify(_devname),		\
> +		.write		= meson_serial_console_write,		\
> +		.device		= uart_console_device,			\
> +		.setup		= meson_serial_console_setup,		\
> +		.flags		= CON_PRINTBUFFER,			\
> +		.index		= -1,					\
> +		.data		= &MESON_UART_DRIVER(_devname),		\
> +	}

... you could even declare the meson_uart_driver_ttyXXX in this macro instead.

> +
> +MESON_SERIAL_CONSOLE_DEFINE(ttyAML);
> +MESON_SERIAL_CONSOLE_DEFINE(ttyS);
>   
>   static void meson_serial_early_console_write(struct console *co,
>   					     const char *s,
> @@ -644,18 +656,22 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
>   
> -#define MESON_SERIAL_CONSOLE	(&meson_serial_console)
> +#define MESON_SERIAL_CONSOLE_PTR(_devname) (&MESON_SERIAL_CONSOLE(_devname))
>   #else
> -#define MESON_SERIAL_CONSOLE	NULL
> +#define MESON_SERIAL_CONSOLE_PTR(_devname)	(NULL)
>   #endif
>   
> -static struct uart_driver meson_uart_driver = {
> -	.owner		= THIS_MODULE,
> -	.driver_name	= "meson_uart",
> -	.dev_name	= AML_UART_DEV_NAME,
> -	.nr		= AML_UART_PORT_NUM,
> -	.cons		= MESON_SERIAL_CONSOLE,
> -};
> +#define MESON_UART_DRIVER_DEFINE(_devname)  \
> +	static struct uart_driver MESON_UART_DRIVER(_devname) = {	\
> +		.owner		= THIS_MODULE,				\
> +		.driver_name	= "meson_uart",				\
> +		.dev_name	= __stringify(_devname),		\
> +		.nr		= AML_UART_PORT_NUM,			\
> +		.cons		= MESON_SERIAL_CONSOLE_PTR(_devname),	\
> +	}
> +
> +MESON_UART_DRIVER_DEFINE(ttyAML);
> +MESON_UART_DRIVER_DEFINE(ttyS);

Those macros are fine, but drop the MESON_UART_DRIVER & MESON_SERIAL_CONSOLE macros and drop the _DEFINE in those macros.

>   
>   static int meson_uart_probe_clocks(struct platform_device *pdev,
>   				   struct uart_port *port)
> @@ -681,8 +697,16 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
>   	return 0;
>   }
>   
> +static struct uart_driver *meson_uart_current(const struct meson_uart_data *pd)
> +{
> +	return (pd && pd->uart_driver) ?
> +		pd->uart_driver : &MESON_UART_DRIVER(ttyAML);

I'll definitely prefer if you use the real variable name everywhere and in the 2 following patches

> +}
> +
>   static int meson_uart_probe(struct platform_device *pdev)
>   {
> +	const struct meson_uart_data *priv_data;
> +	struct uart_driver *uart_driver;
>   	struct resource *res_mem;
>   	struct uart_port *port;
>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
> @@ -729,8 +753,12 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	if (!meson_uart_driver.state) {
> -		ret = uart_register_driver(&meson_uart_driver);
> +	priv_data = device_get_match_data(&pdev->dev);
> +
> +	uart_driver = meson_uart_current(priv_data);
> +
> +	if (!uart_driver->state) {
> +		ret = uart_register_driver(uart_driver);
>   		if (ret)
>   			return dev_err_probe(&pdev->dev, ret,
>   					     "can't register uart driver\n");
> @@ -748,7 +776,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = fifosize;
> -	port->private_data = (void *)device_get_match_data(&pdev->dev);
> +	port->private_data = (void *)priv_data;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
> @@ -759,7 +787,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   		meson_uart_release_port(port);
>   	}
>   
> -	ret = uart_add_one_port(&meson_uart_driver, port);
> +	ret = uart_add_one_port(uart_driver, port);
>   	if (ret)
>   		meson_ports[pdev->id] = NULL;
>   
> @@ -768,10 +796,12 @@ static int meson_uart_probe(struct platform_device *pdev)
>   
>   static int meson_uart_remove(struct platform_device *pdev)
>   {
> +	struct uart_driver *uart_driver;
>   	struct uart_port *port;
>   
>   	port = platform_get_drvdata(pdev);
> -	uart_remove_one_port(&meson_uart_driver, port);
> +	uart_driver = meson_uart_current(port->private_data);
> +	uart_remove_one_port(uart_driver, port);
>   	meson_ports[pdev->id] = NULL;
>   
>   	for (int id = 0; id < AML_UART_PORT_NUM; id++)
> @@ -779,7 +809,7 @@ static int meson_uart_remove(struct platform_device *pdev)
>   			return 0;
>   
>   	/* No more available uart ports, unregister uart driver */
> -	uart_unregister_driver(&meson_uart_driver);
> +	uart_unregister_driver(uart_driver);
>   
>   	return 0;
>   }

Anyway this looks much better :-)

Thanks,
Neil


