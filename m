Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58374745C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGDOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGDOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:46:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6210CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:46:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so55615885e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688482002; x=1691074002;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r7WGfX3NpjGNse8P3RuikUKmRu8m7xgJ3of97xkU49E=;
        b=i9YcYKPOfsLQ3niBBhdfPaZKeZPgqqUCoYcehPFwuct4jJsABISY69FRIRgs+wfaS3
         mdlP7IMcdZ41bBAvDMpAsjRdl+qg9vpZM1+0OoJhtmWQCCWOZMSHIRhQDYh45xjBIuz4
         fWTBMTVLhjAvKHOijYdsPdpGi+BSp2BSa4+gNcxxNJO4Pru4JsMFjnBuDx1Bvsn+W6OP
         XhQthXsMSbPcGLgH12xS4uklCYDsP18I+dZTN6SlCN+ckRU6ecQ4Tavh9zX/shB4jdLV
         ci+lpRymsAevsov610L90br7B/PDjb8Eo8C0QgWZQC99bsHUTLk3jlwi90Y082Uj7HEr
         YgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482002; x=1691074002;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7WGfX3NpjGNse8P3RuikUKmRu8m7xgJ3of97xkU49E=;
        b=cEQLRT8tkN1CJy9zK9fdrU2vvMZoiaU5I1Hjpsa2PDGMnMJmiLb0w1Qr4bDOZZrsoo
         SH89Yi/r8XejgCZuonm8wsaJ0zAMu8A95UQ6xrMoCS8qJqIB0ZmdQKnEFyJ2tGbUb4Lk
         AHMDmDVyvguWDYzMaNxZ0vi+POTqgBZNUDJ5aF/dNV2FRhPNO4PHGejLs+GCUHD6VaUS
         qk+rHN0/qRhmPeCNcC7+7vfwkZ0ZhlpW/uc95YINBoBA7a+OrEeSbgzIwaKiE221hSgj
         qNHjzJo4ru9KukfgPw12Zhy9uOi/o4nwTJ31RzyHPF0twkH9nAg99gc07nRD/mYon/LZ
         +HzQ==
X-Gm-Message-State: AC+VfDyYfQp1Cp0fXx88QUTLULoPsS3JMpx6hle3Rt51YxH2DhwghTRQ
        NdOSe2+pnFTSsyh00/ZNpdzfig==
X-Google-Smtp-Source: ACHHUZ6DxPRtPj06HNSQ0M6tH7Rc+DJD0V1yEFbDTRUyabbyWc40rx10HmYSfjlu9jjVdFYAOm5PMw==
X-Received: by 2002:a05:600c:219a:b0:3fb:a1d9:ede8 with SMTP id e26-20020a05600c219a00b003fba1d9ede8mr11046299wme.10.1688482002355;
        Tue, 04 Jul 2023 07:46:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003fbaade072dsm19987380wmk.23.2023.07.04.07.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:46:41 -0700 (PDT)
Message-ID: <7b06b8cd-f4c9-7636-0f73-48b2f695d7ba@linaro.org>
Date:   Tue, 4 Jul 2023 16:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/5] tty: serial: meson: redesign the module to
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
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-3-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230704135936.14697-3-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 15:59, Dmitry Rokosov wrote:
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
>   drivers/tty/serial/meson_uart.c | 46 +++++++--------------------------
>   1 file changed, 10 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 169f028956ae..87c0eb5f2dba 100644
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
> +				      "failed to register meson-uart driver\n");
> +	}

PL010 protects this in a mutex, and I think you should do the same otherwise
if multiple uart probes at the same it will do weird stuff.

> +
>   	port->iotype = UPIO_MEM;
>   	port->mapbase = res_mem->start;
>   	port->mapsize = resource_size(res_mem);
> @@ -776,6 +774,8 @@ static int meson_uart_remove(struct platform_device *pdev)
>   	uart_remove_one_port(&meson_uart_driver, port);
>   	meson_ports[pdev->id] = NULL;
>   
> +	uart_unregister_driver(&meson_uart_driver);
> +

This is dangerous, it will remove the driver even if some uart are still attached to it.

You should probably do like in pl010_remove() and remove only if the last one is removed.

>   	return 0;
>   }
>   
> @@ -809,33 +809,7 @@ static  struct platform_driver meson_uart_platform_driver = {
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

Only pl010 uses this scheme, and I don't know why... if it works then it's ok for me.

Thanks,
Neil

>   
>   MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
>   MODULE_DESCRIPTION("Amlogic Meson serial port driver");

