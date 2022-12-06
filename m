Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37902643D52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLFGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiLFGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:52:17 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637A1A83A;
        Mon,  5 Dec 2022 22:52:16 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id c17so10410106edj.13;
        Mon, 05 Dec 2022 22:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMTUgjfzyyWTmD7y/UtJYvOT87qBLK9RluPkgoZ6OBU=;
        b=obB2Hb+oCi8AEy40JSR49oI6EgmQJ4plwPPZI1RdnuY3ps80qyjsQRNQtoIy6qsE0V
         haO6AOaFCHWxBQd2bjCcsmU6SF2Gu0bFwxkgmAJ0vEt/X1l1m7ZcypYUmVq+52P5y52t
         KmhgGzrKbP6s8pAEIwUZoUy785RgnIGKAkOfOK7g/lCmmNi1Dx/YJYbedVgZExZrJRFs
         J7lqn2sGRgYg6OVXlO6bXDUZcfmhIkfrEmfCwT363dcPWxikEY35D6xjoaFdCQQS0RKg
         j8F+ksbAEJFX07lALWoYTHsZtxERD9fAqIIXO9Qn6hO3y9zZ5QeLo3NtyZaTNYnbE+SK
         vyyg==
X-Gm-Message-State: ANoB5plvzfn7aPbWZizcjH5p0fTMMMxZdRgYFPvGXc4aO7cHvwr9kg59
        UK1ZcNwbLpMxgbVRiVdU14+U5OL6hAo=
X-Google-Smtp-Source: AA0mqf580R470q9lP4FNtIa85kztRpzJgRpl2SFp7WJ4mom5ZtAz2Sy+gJFG7CT9EUHXdT4LsDo80A==
X-Received: by 2002:a05:6402:3807:b0:45c:a651:87f1 with SMTP id es7-20020a056402380700b0045ca65187f1mr60139045edb.359.1670309534847;
        Mon, 05 Dec 2022 22:52:14 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906180600b007c0c679ca2fsm4628858eje.26.2022.12.05.22.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:52:14 -0800 (PST)
Message-ID: <7117060e-9081-2bb2-823b-a1a311c8cb72@kernel.org>
Date:   Tue, 6 Dec 2022 07:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] earlycon: Let users set the clock frequency
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
 <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 11. 22, 13:39, Ricardo Ribalda wrote:
> Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
> witch makes it impossible to use with earlycon.
> 
> Let the user select its own frequency.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..9efb6c3b0486 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1182,10 +1182,10 @@
>   			specified, the serial port must already be setup and
>   			configured.
>   
> -		uart[8250],io,<addr>[,options]
> -		uart[8250],mmio,<addr>[,options]
> -		uart[8250],mmio32,<addr>[,options]
> -		uart[8250],mmio32be,<addr>[,options]
> +		uart[8250],io,<addr>[,options[,uartclk]]
> +		uart[8250],mmio,<addr>[,options[,uartclk]]
> +		uart[8250],mmio32,<addr>[,options[,uartclk]]
> +		uart[8250],mmio32be,<addr>[,options[,uartclk]]
>   		uart[8250],0x<addr>[,options]
>   			Start an early, polled-mode console on the 8250/16550
>   			UART at the specified I/O port or MMIO address.
> @@ -1194,7 +1194,9 @@
>   			If none of [io|mmio|mmio32|mmio32be], <addr> is assumed
>   			to be equivalent to 'mmio'. 'options' are specified
>   			in the same format described for "console=ttyS<n>"; if
> -			unspecified, the h/w is not initialized.
> +			unspecified, the h/w is not initialized. 'uartclk' is
> +			the uart clock frequency; if unspecified, it is set
> +			to 'BASE_BAUD' * 16.
>   
>   		pl011,<addr>
>   		pl011,mmio32,<addr>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a5f380584cda..3a0c88419b6c 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -120,7 +120,13 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>   	}
>   
>   	if (options) {
> +		char *uartclk;
> +
>   		device->baud = simple_strtoul(options, NULL, 0);
> +		uartclk = strchr(options, ',');
> +		if (uartclk && kstrtouint(uartclk + 1, 0, &port->uartclk) < 0)
> +			pr_warn("[%s] unsupported earlycon uart clkrate option\n",
> +				options);
>   		length = min(strcspn(options, " ") + 1,
>   			     (size_t)(sizeof(device->options)));
>   		strscpy(device->options, options, length);
> @@ -139,7 +145,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>   		buf = NULL;
>   
>   	spin_lock_init(&port->lock);
> -	port->uartclk = BASE_BAUD * 16;
> +	if (!port->uartclk)
> +		port->uartclk = BASE_BAUD * 16;
>   	if (port->mapbase)
>   		port->membase = earlycon_map(port->mapbase, 64);
>   
> 

-- 
js
suse labs

