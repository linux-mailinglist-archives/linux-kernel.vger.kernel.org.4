Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44F6A48A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjB0RxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjB0RxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:53:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7ACA0D;
        Mon, 27 Feb 2023 09:53:07 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mxm7U-1oYYZO2PV8-00zDHf; Mon, 27 Feb 2023 18:52:20 +0100
Message-ID: <33714d4c-31a9-527c-f80a-1f51c9a37f98@i2se.com>
Date:   Mon, 27 Feb 2023 18:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] gpio: mxs: use dynamic allocation of base
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20230226205357.1013504-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230226205357.1013504-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:438/indqxA0wz+A48d5x+Ar4wbk6fsKIwESw7PNpKTzJUaVqVPZ
 f+FuQAyTfeIgdm1FnOmrjwMNDU0qsEXSvXy63mS2JmonKCN3OW6Hq2dBYw9aCoBfUc30Wal
 2RRSHBxQpMfBLqEKFFNUufgZr9Ig22hkpz1aiRqP3q/RpztIgP5wTBpsUXv411Fni7lwxFX
 XXdyliySUyOVvGt3XvOmQ==
UI-OutboundReport: notjunk:1;M01:P0:DboHxGtGDjU=;E+xbUL9UKkffgJ/+JApI7AFjgFU
 eVNusggoQN7OuIG0FW97uXxX/AiSR3Md64/HXhlpHAN6LF/IhQlTyZsXiEafF0WbBUPtFL92v
 S1x1fL+1Co2uTq+wuotZGIClY+w9XNFllRYdfrYjt/03nQp9p+cMGbTNvqixVDK7q6Noxh6Ns
 Q+f8ltXfd4QMhpeMU8ITAyzZfRRr6k0PDIJa88NSyt8GwN5TS7/P5Pr1DMLaaVUrB87nGMw7A
 g+AD0rdMUIBSdb4UKEZh3OK7i5to2Dxg7uxUEcQkORbh0JRBtTWxR6L0XMJf+LNMkcGBmPYDO
 QpdbNn2mrTMu7xWOjihZF2iJBQ1nEJG00rZtzVFNj99Casga779L0zzHE5R13FGq3PkWyfE5m
 PFviUa8QUtUhclXYRoQ5He/XAnBTceCPt6KMXVCzd/Ij43p7u69YjL29hTYV4lDmsWq48JB3N
 eCmllkf7PtuIBHnBPVMVQFyB1C/wnrUCCNMKBJ0nnPJee2q0v8sF6kKZX5iSdhXBjTtxIN8PN
 xHAVrlowdQC7gh/PZgMy/jnzbakKIRvllv5SXAP0wTopuLUCe6mwZmC+juRVQlc4fuO/dH8KW
 3oPWVVDnkM3Z7lyp0Pud6p5rj2ua8vBCCXQqXY5Fa1ef3VbddiXtGnhzXpDx8ByAEFntwTOyn
 ejxu+FXXqW1S6yhoLNPlHKHbT8HUsw6mCDoJYdFg1A==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

Am 26.02.23 um 21:53 schrieb Dario Binacchi:
> Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using static
> gpiobase allocation"), one or more warnings are printed during boot on
> systems where static allocation of GPIO base is used:
>
> [    0.136834] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.142753] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.148452] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.154341] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.160097] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
>
> So let's follow the suggestion and use dynamic allocation.

i understand the motivation of avoiding these warnings.

AFAIK the MXS platform is older than the dynamic allocation of GPIO 
base. In the perfect world all applications has been migrated to 
libgpiod / chardev GPIO. But i'm really concerned this hasn't happend 
yet, at least for this platform. So i believe this change break 
applications, since it affects userspace.

Best regards

>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>   drivers/gpio/gpio-mxs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 7f59e5d936c2..b48a7c1fb7c1 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -330,7 +330,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
>   
>   	port->gc.to_irq = mxs_gpio_to_irq;
>   	port->gc.get_direction = mxs_gpio_get_direction;
> -	port->gc.base = port->id * 32;
> +	port->gc.base = -1;
>   
>   	err = gpiochip_add_data(&port->gc, port);
>   	if (err)
