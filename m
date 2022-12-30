Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2E8659899
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiL3NOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3NOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:14:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998E1ADA3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:14:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so17785950wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZODiERr2nILpNR045ZQJNrA0TwmM8JmrarYNMEwpKfw=;
        b=PcuU+Eu2EzRD/xeuVTSTpoXSI9BqWaqrPLjBZrA7RN4y/D6His70PGn3AtCaURZWhJ
         HBKmIoZkRErlH9ZynGnGyymXGZQBF/0pqn1zrLxXKZa8g2D52VQ0o3JCeeiJEPMF0yQ5
         +DUe9e8HQhp1+9zYN1EWYL8VAeKnXjFqIUoDCZpizC7yQg5oKsFZrXNEhlBOxVf+6BPY
         pi8R91e3j3D4zGFgo8552jJXJuL5smd/q2VBfSLPinHl6HCSb/ZgKZAE8mQkl/lhNMXX
         f45kvYIn+SITtTYonQzqJS/QHu6iPDYEP0VxHwMaySnLhHoXZBLle2CniH3S6Feaoytf
         M3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZODiERr2nILpNR045ZQJNrA0TwmM8JmrarYNMEwpKfw=;
        b=aNQdgO1k1u19j9DkFtOXp9G5b4Ct/Yi7r6zMCcRphGJArDBl1JiZ8p/whU/wJQ+4AN
         b8V3b38QdcKNiONnHtU7DCYEac3uBwXqP0gI/ASWqv39Lm9FC/D2e/hMW7V9XB4n6xEl
         eksNQMw8tCwpZxXUz1NtgBYsoHq7YsdurA+85vfUcn0ljZJfZTKqiivZjfSst7S6vAFu
         Kf2YEPqEVH0ZFgzDZJxPc2O1IzLcQ7pVMPAkP5FVg9jmVnLIAOtlsdbm7SbKCewU2V+O
         yYCIzeytXMAuFHlab0qFoVPs+ExHzFkBgNWOUkujBdk0yCEB+mjC4mmPzC1mY1DEgPSa
         ZjNA==
X-Gm-Message-State: AFqh2koXKQxBuh6yKSCKnBASD3KuA3yjkhCPqlPW8SZR1ewgM8sgiISp
        Qap4YRCs1n1cuJitLnEiclr3oH0Fp/AD4KB5
X-Google-Smtp-Source: AMrXdXtW/nGYu4K7UXZK7l+hzu45xTsVCAYKoS4RQEPtXBP8fMRfHqA5H7N4MOQWXQqL9qaYgLMXBA==
X-Received: by 2002:adf:e383:0:b0:242:3cb6:36b8 with SMTP id e3-20020adfe383000000b002423cb636b8mr21138209wrm.44.1672406071838;
        Fri, 30 Dec 2022 05:14:31 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d618d000000b002425dc49024sm20519086wru.43.2022.12.30.05.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 05:14:30 -0800 (PST)
Message-ID: <9ad399f9-7d27-b541-2379-355f3a8258ae@linaro.org>
Date:   Fri, 30 Dec 2022 14:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] serial: 8250_rt288x: Remove unnecessary
 UART_REG_UNMAPPED
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org
References: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
 <20221230114603.16946-4-ilpo.jarvinen@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221230114603.16946-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 30/12/22 12:46, Ilpo Järvinen wrote:
> As unmapped registers are at the tail of the array, the ARRAY_SIZE()
> condition will catch them just fine. No need to define special
> value for them.

True but fragile example...

> Also, let the compiler to calculate the size of the array instead of
> providing it manually.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_rt288x.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
> index 3015afb99722..da8be9a802c1 100644
> --- a/drivers/tty/serial/8250/8250_rt288x.c
> +++ b/drivers/tty/serial/8250/8250_rt288x.c
> @@ -14,10 +14,8 @@
>   
>   #define RT288X_DL	0x28
>   
> -#define UART_REG_UNMAPPED	-1


> -static const s8 au_io_out_map[8] = {
> +static const s8 au_io_out_map[] = {
>   	[UART_TX]	= 1,
>   	[UART_IER]	= 2,
>   	[UART_FCR]	= 4,
>   	[UART_LCR]	= 5,
>   	[UART_MCR]	= 6,
> -	[UART_LSR]	= UART_REG_UNMAPPED,
> -	[UART_MSR]	= UART_REG_UNMAPPED,
> -	[UART_SCR]	= UART_REG_UNMAPPED,

If someone were to re-add an unlikely single

         [UART_SCR] = 42,

The array will also contain these hidden entries:

         [UART_LSR] = 0,
         [UART_MSR] = 0,

And these 2 registers end mapped.

>   };

Trying to 'optimize' array size when the array is index-initialized
can be bug-prone.

>   static unsigned int au_serial_in(struct uart_port *p, int offset)
> @@ -44,8 +38,7 @@ static unsigned int au_serial_in(struct uart_port *p, int offset)
>   	if (offset >= ARRAY_SIZE(au_io_in_map))
>   		return UINT_MAX;
>   	offset = au_io_in_map[offset];
> -	if (offset == UART_REG_UNMAPPED)
> -		return UINT_MAX;
> +
>   	return __raw_readl(p->membase + (offset << p->regshift));
>   }
Regards,

Phil.
