Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FA5BA702
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIPGwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIPGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:52:11 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39920A344D;
        Thu, 15 Sep 2022 23:52:10 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id e18so30133635edj.3;
        Thu, 15 Sep 2022 23:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v+opaeaI9VpfwC19hC5ba/VNJ9z9PATWt8b6OHLFwXc=;
        b=hsaXTEP2nCJylB5rO07kdOOgO10yyMgwIPnBzDSHjRjz4ObQZK7aCgvskd+KSeCvW3
         hjHQcl2qs0olMFKm4hv9BRPvI56MdGGka9DZj4RmEYdTd8SZn+tTHj2cEmLBgPw1r0nb
         ClH7dVGBhDKPlgljKzv7Lj5GzpbCjfONfAy1mP9v3ePeGNlm1ukSyLIrukySD66cVjmR
         IdYv+7IH2jeIUp4HL+8liMHnD2+qCdFP588YV4B5j1gvmE0gK4kFx2eLpMVm6Y2g9WO/
         pfRV3nl+XDp92gxwpqWm0t5Q9tbByHAMVMMyMIvwV6BTg9ufdqX8+XeaA/hfE0W9gSP0
         XP+A==
X-Gm-Message-State: ACrzQf1T3fp+ov5dH1sD3SRv6tfzQAvvgSNnZpZexgfw+RuIZzmKTm9Y
        Nhrc5mRC6nmGQ/q47lmwY78=
X-Google-Smtp-Source: AMsMyM6xkUmcOkfacgE+/eTa/6ohE3NQJtHPYHE2htpgBi7IMgMweQfQTk682flmPt+X6hfjm7D1rg==
X-Received: by 2002:a05:6402:10cc:b0:446:491f:d6dd with SMTP id p12-20020a05640210cc00b00446491fd6ddmr2722621edu.360.1663311128750;
        Thu, 15 Sep 2022 23:52:08 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id kw22-20020a170907771600b0077b2b0563f4sm9420143ejc.173.2022.09.15.23.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 23:52:08 -0700 (PDT)
Message-ID: <ea128c38-b71a-52f8-2642-122688c9cc7a@kernel.org>
Date:   Fri, 16 Sep 2022 08:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 4/5] tty: synclink_gt: remove MGSL_MAGIC
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
 <3d82b3c864970cdec6717c56dd906b54e78694d7.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <3d82b3c864970cdec6717c56dd906b54e78694d7.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
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
>   drivers/tty/synclink_gt.c                                 | 8 --------
>   5 files changed, 12 deletions(-)
> 
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index fdaa3e4b1953..2326c3be94fc 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -83,7 +83,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index 1898f98875de..1803497816f1 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -89,7 +89,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index 911cdaeaf698..9780bf710eeb 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -72,7 +72,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
> index ac87f188235f..933545e92137 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -75,7 +75,6 @@ SLIP_MAGIC            0x5302           slip                     ``drivers/net/sl
>   STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
>   SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/net/hamradio/6pack.h``
>   AX25_MAGIC            0x5316           ax_disp                  ``drivers/net/mkiss.h``
> -MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 9bc2a9265277..19e3dd470fc2 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -91,7 +91,6 @@ static char *driver_name     = "SyncLink GT";
>   static char *slgt_driver_name = "synclink_gt";
>   static char *tty_dev_prefix  = "ttySLG";
>   MODULE_LICENSE("GPL");
> -#define MGSL_MAGIC 0x5401
>   #define MAX_DEVICES 32
>   
>   static const struct pci_device_id pci_table[] = {
> @@ -215,8 +214,6 @@ struct slgt_info {
>   
>   	struct slgt_info *next_device;	/* device list link */
>   
> -	int magic;
> -
>   	char device_name[25];
>   	struct pci_dev *pdev;
>   
> @@ -554,10 +551,6 @@ static inline int sanity_check(struct slgt_info *info, char *devname, const char
>   		printk("null struct slgt_info for (%s) in %s\n", devname, name);
>   		return 1;
>   	}
> -	if (info->magic != MGSL_MAGIC) {
> -		printk("bad magic number struct slgt_info (%s) in %s\n", devname, name);
> -		return 1;
> -	}
>   #else
>   	if (!info)
>   		return 1;
> @@ -3498,7 +3491,6 @@ static struct slgt_info *alloc_dev(int adapter_num, int port_num, struct pci_dev
>   	} else {
>   		tty_port_init(&info->port);
>   		info->port.ops = &slgt_port_ops;
> -		info->magic = MGSL_MAGIC;
>   		INIT_WORK(&info->task, bh_handler);
>   		info->max_frame_size = 4096;
>   		info->base_clock = 14745600;

-- 
js
suse labs

