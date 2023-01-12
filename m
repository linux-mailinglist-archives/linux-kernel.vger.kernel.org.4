Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A05667A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjALQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjALQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:18:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36B1CB06;
        Thu, 12 Jan 2023 08:15:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso11145175wms.0;
        Thu, 12 Jan 2023 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHGKsGfjuxBNZeCDD82bELPKj131qyJQ2Bd7A7NbU7Q=;
        b=Ww9qNjvgkREaAu0zU9cwlii9y7ovC6P0Q9rSF5TqJXOMJ5ER7HUQamdRJ4LMaAIq0p
         Hjx7K8W9OccmfOxB0CxwH55NaO0rnYgttspggkk5fXr43yIH2bXmVygin0nSKasSs+jO
         tE3IMYmWSTT1r0oya7L/6HsK8f/FcNuBSaDYt9exM5yoxIWTUmzuhxzU5AzlLDOBIDOV
         2/qJmgcb03SeXWcTOIsYyXHRPZA38+kfqATLpo9MRxsTqsVAcGmX2D99ZRJAAiiMCRtV
         Ukgz4qD0ZkxDJ35+Sbyl8kHi9lr8kd482xtuDRqJNgQIGQdGoJRSdre+OydLPICnd/Bg
         jSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHGKsGfjuxBNZeCDD82bELPKj131qyJQ2Bd7A7NbU7Q=;
        b=2u5exSTEDmXYhYBVLRCG9K65eQeWMEAC7T78Qgmzv/ck/G7cycaUFtmGX5HOT885BX
         r7G/dTC5ofTq7xNf74Lac9cF2pHtK8SO0FnGQo1f0ovAHen9whjd2nyQvPtczDVL5Vir
         c6Ssk51n92zqCQs6WgBgXKb8Y2K7Qkc8MjnzwUXZSCCUdWSZGJt+UH0I5EhZTXBEayiH
         bmoNFef+bBQFV6sSgEAYXbICdTy3MLFy6eTAgHs/JJZmNwllxiLDfvakHzl7qwudT10C
         UOuG75kkOpXz6t98tmWbf2FUQYt1RgPS+4/9aGo6v3pmSoM1xyseQwO6PkbPueAyEjyq
         hOYA==
X-Gm-Message-State: AFqh2ko3F8q65+yBR8/BSSQxQmLZKMfVLB0ocCSc2Hi/AN7UYyAshBvq
        Ok8DBQ5yFsohlc84WBkqAWA59HRkXdY=
X-Google-Smtp-Source: AMrXdXsUlAv4+Kk/nAWfqgFCh6Fdg4bI6Crndu/JHl81fSX9vtPAEFWb+zlE2PjU1jowl8VhoAp9rw==
X-Received: by 2002:a7b:c449:0:b0:3d1:e1f4:21dc with SMTP id l9-20020a7bc449000000b003d1e1f421dcmr55886195wmi.14.1673540112150;
        Thu, 12 Jan 2023 08:15:12 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003c6b7f5567csm10425907wmq.0.2023.01.12.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:15:11 -0800 (PST)
Message-ID: <97b5621c-f75c-a19d-0759-b19a8a7eb83f@gmail.com>
Date:   Thu, 12 Jan 2023 17:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] serial: atmel: fix incorrect baudrate setup
Content-Language: fr
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230109072940.202936-1-t.schramm@manjaro.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20230109072940.202936-1-t.schramm@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/01/2023 à 08:29, Tobias Schramm a écrit :
> Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
> setup") changed uart_set_options to select the correct baudrate
> configuration based on the absolute error between requested baudrate and
> available standard baudrate settings.
> Prior to that commit the baudrate was selected based on which predefined
> standard baudrate did not exceed the requested baudrate.
> This change of selection logic was never reflected in the atmel serial
> driver. Thus the comment left in the atmel serial driver is no longer
> accurate.
> Additionally the manual rounding up described in that comment and applied
> via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
> tty_termios_encode_baud_rate to determine the appropriate baudrate flags
> this can cause baudrate selection to fail entirely because
> tty_termios_encode_baud_rate will only select a baudrate if relative error
> between requested and selected baudrate does not exceed +/-2%.
> Fix that by requesting actual, exact baudrate used by the serial.
> 
> Fixes: ba47f97a18f2 ("serial: core: remove baud_rates when serial console setup")
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

Tested-on sam9g35
> ---
>  drivers/tty/serial/atmel_serial.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index f1c06e12efa0..9cd7479b03c0 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2657,13 +2657,7 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
>  	else if (mr == ATMEL_US_PAR_ODD)
>  		*parity = 'o';
>  
> -	/*
> -	 * The serial core only rounds down when matching this to a
> -	 * supported baud rate. Make sure we don't end up slightly
> -	 * lower than one of those, as it would make us fall through
> -	 * to a much lower baud rate than we really want.
> -	 */
> -	*baud = port->uartclk / (16 * (quot - 1));
> +	*baud = port->uartclk / (16 * quot);
>  }
>  
>  static int __init atmel_console_setup(struct console *co, char *options)
Thanks !


Regards,
Richard
