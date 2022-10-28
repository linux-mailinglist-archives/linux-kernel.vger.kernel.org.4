Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8774F6109B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ1FXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ1FXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:23:12 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0D1B4C7E;
        Thu, 27 Oct 2022 22:23:11 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso642860ooq.6;
        Thu, 27 Oct 2022 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DIEC4JEAxWqSHyr0NfID2CGIjpJnu67Kcbdtfp2ii0E=;
        b=nHVLKWTtLs7M+bEpFXa7CzUuzOhWLF/7zSrWkpG8I21gehQjcaRnC6Wt7ObAUjXe5S
         wYim4BP0ZOtRQt9supq+L2ehlSjg+SS1V5N9mx/Zl3zchCa9ELEkgcwPaivqRC0wZ89F
         /9pqnKMGu4C8HC4Ft1ViCFY9vL7mKtne3W2N0d+CZdrjYM8W2WL5E8V35oBywUDC5j4+
         z/2gWWW7axn8yAxlnAkNahgoNeCaFZe5Mj+kZ9XBO5vmcNpF6eDqo+qYuR8zRZn6ExNf
         QU8F4712Op71PIohaqHZk4JC6egmNltio8jZEeAWgYR38GjpnueiIsVkBJ8QfcNbyymx
         g33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIEC4JEAxWqSHyr0NfID2CGIjpJnu67Kcbdtfp2ii0E=;
        b=K1y3q7lY9MU62sZGfbMarFBNXQ4HGFopJJvYFU/urxSPrzBgyFTr1/szieRw9/8k6Q
         ago391lwsAl2HG5IWOqZjQPYl76jC52B/ZbOV9yIx6m3068X1G0i2Umy89rtDCeDDkwZ
         XGNEBIa9MRsKoxcYD2e4KWL9yGq2qwki8iXqQKH1AydQLdcqZ8oigIWc4MtTwdStOq7+
         KQO7t/ToSnTM4siH9QeBFFfh+sX/GMFKYPJu2JJc7sc0WpOPjo+bIKTcE8po3ypeklgq
         F/WO4B/uu920E753B7cs0dztHgaucllqudIG7/slVoae3u/eFXhaVyHcIi3ZKYp9vj+G
         S/jw==
X-Gm-Message-State: ACrzQf2RNARDzil6rz0dqWVU8A7TBg+XBlwptwMoB20aDJeJj35sKnjk
        tGCSrM4jdVwKUDnF92xQ3v0=
X-Google-Smtp-Source: AMsMyM4fbBOAZeSxCq4AzAu+Oze4l7i1gLi8DggbSUZCX1Ai68QFePj5UmD1t64lJY42gWpP0I4MfQ==
X-Received: by 2002:a4a:94a6:0:b0:435:f61e:d7a1 with SMTP id k35-20020a4a94a6000000b00435f61ed7a1mr22718453ooi.82.1666934590801;
        Thu, 27 Oct 2022 22:23:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020a056830000b00b0066ab23e37f6sm1300675otp.10.2022.10.27.22.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 22:23:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
Date:   Thu, 27 Oct 2022 22:23:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027150928.983388020@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 08:05, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Cc: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   drivers/usb/core/hub.c              | 3 +++
>   drivers/usb/gadget/udc/m66592-udc.c | 2 +-
>   drivers/usb/serial/garmin_gps.c     | 2 +-
>   drivers/usb/serial/mos7840.c        | 2 +-
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bbab424b0d55..397f263ab7da 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1261,6 +1261,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
>   
>   		/* Don't do a long sleep inside a workqueue routine */
>   		if (type == HUB_INIT2) {
> +			/* Timers must be shutdown before they are re-initialized */
> +			if (hub->init_work.work.func)
> +				del_timer_shutdown(&hub->init_work.timer);
>   			INIT_DELAYED_WORK(&hub->init_work, hub_init_func3);

A similar call to INIT_DELAYED_WORK() around line 1085 needs the same change.

It would be great if that can somehow be hidden in INIT_DELAYED_WORK().

Thanks,
Guenter

>   			queue_delayed_work(system_power_efficient_wq,
>   					&hub->init_work,
> diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
> index 931e6362a13d..a6e2f8358adf 100644
> --- a/drivers/usb/gadget/udc/m66592-udc.c
> +++ b/drivers/usb/gadget/udc/m66592-udc.c
> @@ -1519,7 +1519,7 @@ static int m66592_remove(struct platform_device *pdev)
>   
>   	usb_del_gadget_udc(&m66592->gadget);
>   
> -	del_timer_sync(&m66592->timer);
> +	del_timer_shutdown(&m66592->timer);
>   	iounmap(m66592->reg);
>   	free_irq(platform_get_irq(pdev, 0), m66592);
>   	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index f1a8d8343623..2a53f26468bd 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -1405,7 +1405,7 @@ static void garmin_port_remove(struct usb_serial_port *port)
>   
>   	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
>   	usb_kill_urb(port->interrupt_in_urb);
> -	del_timer_sync(&garmin_data_p->timer);
> +	del_timer_shutdown(&garmin_data_p->timer);
>   	kfree(garmin_data_p);
>   }
>   
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index 6b12bb4648b8..a90a706d27de 100644
> --- a/drivers/usb/serial/mos7840.c
> +++ b/drivers/usb/serial/mos7840.c
> @@ -1726,7 +1726,7 @@ static void mos7840_port_remove(struct usb_serial_port *port)
>   		mos7840_set_led_sync(port, MODEM_CONTROL_REGISTER, 0x0300);
>   
>   		del_timer_sync(&mos7840_port->led_timer1);
> -		del_timer_sync(&mos7840_port->led_timer2);
> +		del_timer_shutdown(&mos7840_port->led_timer2);
>   
>   		usb_kill_urb(mos7840_port->led_urb);
>   		usb_free_urb(mos7840_port->led_urb);

