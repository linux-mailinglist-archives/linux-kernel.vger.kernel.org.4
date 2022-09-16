Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2A5BA6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIPGvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIPGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:51:37 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E7A2DA1;
        Thu, 15 Sep 2022 23:51:36 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id kr11so1174205ejc.8;
        Thu, 15 Sep 2022 23:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MIEvmJs9PGWUCOXLWwebd81kiO1jWI7UhidOPKjMWP4=;
        b=b6tCahN8ZvI1xhX/yyQB0bWv1VUmjo43L3SZ6qYZKkc9WNn2r1VGvRfG+lYlCdoL/n
         EUdkehjuhfoqTrJcdfPSwCD6aO9A8dSquTGNwvyjs+fxr0mdnLetzyy1TDBGt6fE6PGt
         H3XiHQT6K4vjF9Zx3YkzP7Vi8aSiwZ8IL+aMiuKaTRFdWj7gp2KxpWfFqHC6j2Zn96S3
         OFSpAiZ2bFizyXfmN3wgE62pxgUd5S3NxyZ2rvZ9VBxPkEcpQJVZz4/6vZ38gszW0hVt
         8GLtgsLWBCFURi4hY/+Rz3zxUQUbMO3MF6+sSS1sfhTmjFVNFIwGN7e1Q0sDhMMocQGx
         Z2gQ==
X-Gm-Message-State: ACrzQf35+9WDzKPItL38Dg5PgKX50NDvZ3HrJfKfflXjgN8wnr9YEZOd
        4o+PkfOlGEhlPrhbPTGAfMM=
X-Google-Smtp-Source: AMsMyM6/5T3ETKKBQpw3D3ZfUfL2Y3uSKXjQpWI2lfn201+jWH2NuCOgb37KjblkC/vhdILWLDNTNQ==
X-Received: by 2002:a17:907:2da2:b0:77c:1599:b3ad with SMTP id gt34-20020a1709072da200b0077c1599b3admr2450954ejc.213.1663311094530;
        Thu, 15 Sep 2022 23:51:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b0077f5e96129fsm6087900ejo.158.2022.09.15.23.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 23:51:33 -0700 (PDT)
Message-ID: <2469c582-3532-2a11-d874-5ac6cbdeb499@kernel.org>
Date:   Fri, 16 Sep 2022 08:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/5] tty: remove TTY_DRIVER_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
 <723478a270a3858f27843cbec621df4d5d44efcc.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <723478a270a3858f27843cbec621df4d5d44efcc.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 09. 22, 3:55, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   Documentation/process/magic-number.rst                    | 1 -
>   Documentation/translations/it_IT/process/magic-number.rst | 1 -
>   Documentation/translations/zh_CN/process/magic-number.rst | 1 -
>   Documentation/translations/zh_TW/process/magic-number.rst | 1 -
>   drivers/tty/tty_io.c                                      | 1 -
>   include/linux/tty_driver.h                                | 5 -----
>   6 files changed, 10 deletions(-)
> 
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index b4c7ec61437e..d47799ba0ca4 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -85,7 +85,6 @@ STRIP_MAGIC           0x5303           strip                    ``drivers/net/st
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
> -TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index bcb23384fefd..24022ab52ebb 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -91,7 +91,6 @@ STRIP_MAGIC           0x5303           strip                    ``drivers/net/st
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
> -TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index 6250087d36c5..811804996283 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -74,7 +74,6 @@ STRIP_MAGIC           0x5303           strip                    ``drivers/net/st
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
> -TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
> index fd169d760bbd..8e37e00590f5 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -77,7 +77,6 @@ STRIP_MAGIC           0x5303           strip                    ``drivers/net/st
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
> -TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 33962109bd10..d036fc59a2e8 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3321,7 +3321,6 @@ struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
>   		return ERR_PTR(-ENOMEM);
>   
>   	kref_init(&driver->kref);
> -	driver->magic = TTY_DRIVER_MAGIC;
>   	driver->num = lines;
>   	driver->owner = owner;
>   	driver->flags = flags;
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index 4841d8069c07..b0421f5de8a6 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -396,7 +396,6 @@ struct tty_operations {
>   /**
>    * struct tty_driver -- driver for TTY devices
>    *
> - * @magic: set to %TTY_DRIVER_MAGIC in __tty_alloc_driver()
>    * @kref: reference counting. Reaching zero frees all the internals and the
>    *	  driver.
>    * @cdevs: allocated/registered character /dev devices
> @@ -432,7 +431,6 @@ struct tty_operations {
>    * @driver_name, @name, @type, @subtype, @init_termios, and @ops.
>    */
>   struct tty_driver {
> -	int	magic;
>   	struct kref kref;
>   	struct cdev **cdevs;
>   	struct module	*owner;
> @@ -489,9 +487,6 @@ static inline void tty_set_operations(struct tty_driver *driver,
>   	driver->ops = op;
>   }
>   
> -/* tty driver magic number */
> -#define TTY_DRIVER_MAGIC		0x5402
> -
>   /**
>    * DOC: TTY Driver Flags
>    *

-- 
js
suse labs

