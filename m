Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB95BA6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIPGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIPGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:51:16 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2394AD6F;
        Thu, 15 Sep 2022 23:51:15 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id l14so47276519eja.7;
        Thu, 15 Sep 2022 23:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sKhXGktHtVUqarBdZl5rD7qLU05ZsSVPmeioTFprB5I=;
        b=PjL4bS+6SyxaBDoJkugH2ucgU1x79qUEsgR9Dd3QZN2tO5kJ5951XrLGv0Yw/njDbE
         MO/hakfaPl2nwlAdNH2+IDRMLdXT0r96+TKMJDpdIk3CoKueEWpHNEGN6TUCIjYUQLsY
         8XYs4S8isgy7XikrghQzVkigzyVeeWvp/3v19aDyR1nXoVNasopVaF7OcuODKJRl0eu4
         ei9oSZUijrJr46+HtNA9cm11+p3Lo1cxHEyuI5XRfukwH26TwvdFgirgD9c2usVz7gZ8
         Yj1jFh0pc0NkYaAU+53/0tkmBAQw3J5hCJcRnm4rLhqNRHSLRRNVusu0ai3sDKVJtKnO
         7D7Q==
X-Gm-Message-State: ACrzQf0Z8ITsFZilWcJvBOhrMz3rFDdN+hWnIIsXb+ZTVz1F04hBJ2yX
        mAO+TWDFGn1wcf/ltAmwQGA=
X-Google-Smtp-Source: AMsMyM6J/Av1o2NM87UqRj1frJfsuwLMBWlH/VwswPodcHMVqXUKL4fknDltnkTnC228PWmfeaywCA==
X-Received: by 2002:a17:907:2d89:b0:77f:cc16:f3fe with SMTP id gt9-20020a1709072d8900b0077fcc16f3femr2444310ejc.610.1663311073896;
        Thu, 15 Sep 2022 23:51:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b0073d6d6e698bsm10091336ejx.187.2022.09.15.23.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 23:51:13 -0700 (PDT)
Message-ID: <c950647b-1570-7630-4754-611c06511a8f@kernel.org>
Date:   Fri, 16 Sep 2022 08:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] tty: remove TTY_MAGIC
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 09. 22, 3:54, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

What a good riddance! We have by far better debugging techniques nowadays.

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> Whole series: amd64 allyesconfig builds; amd64 Debian config boots and
> appears to work; naturally, the HVC stuff is S/390 only, but it's a
> constant offset
> 
>   Documentation/process/magic-number.rst                    | 1 -
>   Documentation/translations/it_IT/process/magic-number.rst | 1 -
>   Documentation/translations/zh_CN/process/magic-number.rst | 1 -
>   Documentation/translations/zh_TW/process/magic-number.rst | 1 -
>   drivers/tty/tty_io.c                                      | 8 --------
>   drivers/tty/tty_mutex.c                                   | 6 ------
>   include/linux/tty.h                                       | 6 ------
>   7 files changed, 24 deletions(-)
> 
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index f5ba36e96461..b4c7ec61437e 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -84,7 +84,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index f452fafb1e84..bcb23384fefd 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -90,7 +90,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index 42f0635ca70a..6250087d36c5 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -73,7 +73,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
> index ae321a9aaece..fd169d760bbd 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -76,7 +76,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -TTY_MAGIC             0x5401           tty_struct               ``include/linux/tty.h``
>   MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 82a8855981f7..33962109bd10 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -170,7 +170,6 @@ static void free_tty_struct(struct tty_struct *tty)
>   	tty_ldisc_deinit(tty);
>   	put_device(tty->dev);
>   	kvfree(tty->write_buf);
> -	tty->magic = 0xDEADDEAD;
>   	kfree(tty);
>   }
>   
> @@ -265,11 +264,6 @@ static int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
>   			imajor(inode), iminor(inode), routine);
>   		return 1;
>   	}
> -	if (tty->magic != TTY_MAGIC) {
> -		pr_warn("(%d:%d): %s: bad magic number\n",
> -			imajor(inode), iminor(inode), routine);
> -		return 1;
> -	}
>   #endif
>   	return 0;
>   }
> @@ -1533,7 +1527,6 @@ static void release_one_tty(struct work_struct *work)
>   	if (tty->ops->cleanup)
>   		tty->ops->cleanup(tty);
>   
> -	tty->magic = 0;
>   	tty_driver_kref_put(driver);
>   	module_put(owner);
>   
> @@ -3093,7 +3086,6 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
>   		return NULL;
>   
>   	kref_init(&tty->kref);
> -	tty->magic = TTY_MAGIC;
>   	if (tty_ldisc_init(tty)) {
>   		kfree(tty);
>   		return NULL;
> diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
> index 393518a24cfe..784e46a0a3b1 100644
> --- a/drivers/tty/tty_mutex.c
> +++ b/drivers/tty/tty_mutex.c
> @@ -14,8 +14,6 @@
>   
>   void tty_lock(struct tty_struct *tty)
>   {
> -	if (WARN(tty->magic != TTY_MAGIC, "L Bad %p\n", tty))
> -		return;
>   	tty_kref_get(tty);
>   	mutex_lock(&tty->legacy_mutex);
>   }
> @@ -25,8 +23,6 @@ int tty_lock_interruptible(struct tty_struct *tty)
>   {
>   	int ret;
>   
> -	if (WARN(tty->magic != TTY_MAGIC, "L Bad %p\n", tty))
> -		return -EIO;
>   	tty_kref_get(tty);
>   	ret = mutex_lock_interruptible(&tty->legacy_mutex);
>   	if (ret)
> @@ -36,8 +32,6 @@ int tty_lock_interruptible(struct tty_struct *tty)
>   
>   void tty_unlock(struct tty_struct *tty)
>   {
> -	if (WARN(tty->magic != TTY_MAGIC, "U Bad %p\n", tty))
> -		return;
>   	mutex_unlock(&tty->legacy_mutex);
>   	tty_kref_put(tty);
>   }
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 7b0a5d478ef6..ba65043e9029 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -122,8 +122,6 @@ struct tty_operations;
>   /**
>    * struct tty_struct - state associated with a tty while open
>    *
> - * @magic: magic value set early in @alloc_tty_struct to %TTY_MAGIC, for
> - *	   debugging purposes
>    * @kref: reference counting by tty_kref_get() and tty_kref_put(), reaching zero
>    *	  frees the structure
>    * @dev: class device or %NULL (e.g. ptys, serdev)
> @@ -193,7 +191,6 @@ struct tty_operations;
>    * &struct tty_port.
>    */
>   struct tty_struct {
> -	int	magic;
>   	struct kref kref;
>   	struct device *dev;
>   	struct tty_driver *driver;
> @@ -260,9 +257,6 @@ struct tty_file_private {
>   	struct list_head list;
>   };
>   
> -/* tty magic number */
> -#define TTY_MAGIC		0x5401
> -
>   /**
>    * DOC: TTY Struct Flags
>    *

-- 
js
suse labs

