Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7465E55D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjAEGDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjAEGDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:03:16 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77351334;
        Wed,  4 Jan 2023 22:03:11 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id m7so682449wrn.10;
        Wed, 04 Jan 2023 22:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEzpVC3EeI3l8U0Cs59v9D4ORssORPtMVrh6A+hHqD8=;
        b=UN8aRaQTYD0gF3pJjwv1rAi3ku5i6XaplYRfdEahqjKUKIH534pYNojCl+Fr4+79lB
         gDDXNJEVVwa5InWjuOYP+PlctVMllMvYBz1k5y+tvphZKqqfXXYEn6AJ2qMYRdPWCOMc
         BA7Lu5wx2w5PRUkfYAlY5e/xr6hh35OpOQ/fOxOK9aOadHmChdll6pkOHPhxi/W2j+3F
         ube+3xjYZJjaQ3vAu9AVF2QVowWDvf4PGGQsRC/aXZ7qOr2p8AuQy+JrQgfN6esbj2wG
         gfIOPrvdm0s3h3FmZLj2aJI50oVOtIJKsv5peC2z4HhRaeeLYnGuPvFXtrGXjNJVOkJB
         e7og==
X-Gm-Message-State: AFqh2kq20X7Rmw06TbQpiyJ5hQzvvWVofP5G3414ZEUT5Q1bnRAG00WS
        y+zC6uiheO5sgQhcC9fCPPs=
X-Google-Smtp-Source: AMrXdXtYSS045iYCmsuam/MFCvIwTCDCWKpw4YN9wPe+Q9TkwRxS0+Nw4ah9Gwg0+9Nnpkbd5s52cw==
X-Received: by 2002:adf:e103:0:b0:26a:6e7d:5782 with SMTP id t3-20020adfe103000000b0026a6e7d5782mr30616611wrz.35.1672898590071;
        Wed, 04 Jan 2023 22:03:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id d11-20020adffd8b000000b00236545edc91sm35375917wrr.76.2023.01.04.22.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:03:09 -0800 (PST)
Message-ID: <ea88d9a2-9bf3-0ced-bc9c-c5bdbeec1517@kernel.org>
Date:   Thu, 5 Jan 2023 07:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 01/10] tty: Cleanup tty_port_set_initialized() bool
 parameter
In-Reply-To: <20230104151531.73994-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> Make callers pass true/false consistently for bool val.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/char/pcmcia/synclink_cs.c | 4 ++--
>   drivers/ipack/devices/ipoctal.c   | 4 ++--
>   drivers/s390/char/con3215.c       | 4 ++--
>   drivers/tty/amiserial.c           | 4 ++--
>   drivers/tty/moxa.c                | 2 +-
>   drivers/tty/mxser.c               | 2 +-
>   drivers/tty/n_gsm.c               | 4 ++--
>   drivers/tty/serial/serial_core.c  | 6 +++---
>   drivers/tty/synclink_gt.c         | 4 ++--
>   drivers/tty/tty_port.c            | 4 ++--
>   drivers/usb/serial/console.c      | 2 +-
>   11 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index b2735be81ab2..baa46e8a094b 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -1309,7 +1309,7 @@ static int startup(MGSLPC_INFO * info, struct tty_struct *tty)
>   	if (tty)
>   		clear_bit(TTY_IO_ERROR, &tty->flags);
>   
> -	tty_port_set_initialized(&info->port, 1);
> +	tty_port_set_initialized(&info->port, true);
>   
>   	return 0;
>   }
> @@ -1359,7 +1359,7 @@ static void shutdown(MGSLPC_INFO * info, struct tty_struct *tty)
>   	if (tty)
>   		set_bit(TTY_IO_ERROR, &tty->flags);
>   
> -	tty_port_set_initialized(&info->port, 0);
> +	tty_port_set_initialized(&info->port, false);
>   }
>   
>   static void mgslpc_program_hw(MGSLPC_INFO *info, struct tty_struct *tty)
> diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
> index fc00274070b6..103fce0c49e6 100644
> --- a/drivers/ipack/devices/ipoctal.c
> +++ b/drivers/ipack/devices/ipoctal.c
> @@ -647,7 +647,7 @@ static void ipoctal_hangup(struct tty_struct *tty)
>   	tty_port_hangup(&channel->tty_port);
>   
>   	ipoctal_reset_channel(channel);
> -	tty_port_set_initialized(&channel->tty_port, 0);
> +	tty_port_set_initialized(&channel->tty_port, false);
>   	wake_up_interruptible(&channel->tty_port.open_wait);
>   }
>   
> @@ -659,7 +659,7 @@ static void ipoctal_shutdown(struct tty_struct *tty)
>   		return;
>   
>   	ipoctal_reset_channel(channel);
> -	tty_port_set_initialized(&channel->tty_port, 0);
> +	tty_port_set_initialized(&channel->tty_port, false);
>   }
>   
>   static void ipoctal_cleanup(struct tty_struct *tty)
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 72ba83c1bc79..0b05cd76b7d0 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -629,7 +629,7 @@ static int raw3215_startup(struct raw3215_info *raw)
>   	if (tty_port_initialized(&raw->port))
>   		return 0;
>   	raw->line_pos = 0;
> -	tty_port_set_initialized(&raw->port, 1);
> +	tty_port_set_initialized(&raw->port, true);
>   	spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
>   	raw3215_try_io(raw);
>   	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
> @@ -659,7 +659,7 @@ static void raw3215_shutdown(struct raw3215_info *raw)
>   		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
>   		remove_wait_queue(&raw->empty_wait, &wait);
>   		set_current_state(TASK_RUNNING);
> -		tty_port_set_initialized(&raw->port, 1);
> +		tty_port_set_initialized(&raw->port, true);
>   	}
>   	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
>   }
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index f52266766df9..f8cdce1626cb 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -502,7 +502,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
>   	 */
>   	change_speed(tty, info, NULL);
>   
> -	tty_port_set_initialized(port, 1);
> +	tty_port_set_initialized(port, true);
>   	local_irq_restore(flags);
>   	return 0;
>   
> @@ -556,7 +556,7 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
>   
>   	set_bit(TTY_IO_ERROR, &tty->flags);
>   
> -	tty_port_set_initialized(&info->tport, 0);
> +	tty_port_set_initialized(&info->tport, false);
>   	local_irq_restore(flags);
>   }
>   
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index 35b6fddf0341..bc474f3c3f8f 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -1484,7 +1484,7 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
>   		MoxaPortLineCtrl(ch, 1, 1);
>   		MoxaPortEnable(ch);
>   		MoxaSetFifo(ch, ch->type == PORT_16550A);
> -		tty_port_set_initialized(&ch->port, 1);
> +		tty_port_set_initialized(&ch->port, true);
>   	}
>   	mutex_unlock(&ch->port.mutex);
>   	mutex_unlock(&moxa_openlock);
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 2436e0b10f9a..2926a831727d 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -1063,7 +1063,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
>   	} else {
>   		retval = mxser_activate(port, tty);
>   		if (retval == 0)
> -			tty_port_set_initialized(port, 1);
> +			tty_port_set_initialized(port, true);
>   	}
>   	mutex_unlock(&port->mutex);
>   	return retval;
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index daf12132deb1..631539c17d85 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2059,7 +2059,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
>   		tty_port_tty_hangup(&dlci->port, false);
>   		gsm_dlci_clear_queues(dlci->gsm, dlci);
>   		/* Ensure that gsmtty_open() can return. */
> -		tty_port_set_initialized(&dlci->port, 0);
> +		tty_port_set_initialized(&dlci->port, false);
>   		wake_up_interruptible(&dlci->port.open_wait);
>   	} else
>   		dlci->gsm->dead = true;
> @@ -3880,7 +3880,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>   	dlci->modem_rx = 0;
>   	/* We could in theory open and close before we wait - eg if we get
>   	   a DM straight back. This is ok as that will have caused a hangup */
> -	tty_port_set_initialized(port, 1);
> +	tty_port_set_initialized(port, true);
>   	/* Start sending off SABM messages */
>   	if (gsm->initiator)
>   		gsm_dlci_begin_open(dlci);
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b9fbbee598b8..e049c760b738 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -290,7 +290,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>   		set_bit(TTY_IO_ERROR, &tty->flags);
>   
>   	if (tty_port_initialized(port)) {
> -		tty_port_set_initialized(port, 0);
> +		tty_port_set_initialized(port, false);
>   
>   		/*
>   		 * Turn off DTR and RTS early.
> @@ -2347,7 +2347,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>   		unsigned int mctrl;
>   
>   		tty_port_set_suspended(port, 1);
> -		tty_port_set_initialized(port, 0);
> +		tty_port_set_initialized(port, false);
>   
>   		spin_lock_irq(&uport->lock);
>   		ops->stop_tx(uport);
> @@ -2458,7 +2458,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>   					uart_rs485_config(uport);
>   				ops->start_tx(uport);
>   				spin_unlock_irq(&uport->lock);
> -				tty_port_set_initialized(port, 1);
> +				tty_port_set_initialized(port, true);
>   			} else {
>   				/*
>   				 * Failed to resume - maybe hardware went away?
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 72b76cdde534..2b96bf0ecafb 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -2354,7 +2354,7 @@ static int startup(struct slgt_info *info)
>   	if (info->port.tty)
>   		clear_bit(TTY_IO_ERROR, &info->port.tty->flags);
>   
> -	tty_port_set_initialized(&info->port, 1);
> +	tty_port_set_initialized(&info->port, true);
>   
>   	return 0;
>   }
> @@ -2401,7 +2401,7 @@ static void shutdown(struct slgt_info *info)
>   	if (info->port.tty)
>   		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
>   
> -	tty_port_set_initialized(&info->port, 0);
> +	tty_port_set_initialized(&info->port, false);
>   }
>   
>   static void program_hw(struct slgt_info *info)
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index dce08a6d7b5e..0c00d5bd6c88 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -367,7 +367,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
>   		goto out;
>   
>   	if (tty_port_initialized(port)) {
> -		tty_port_set_initialized(port, 0);
> +		tty_port_set_initialized(port, false);
>   		/*
>   		 * Drop DTR/RTS if HUPCL is set. This causes any attached
>   		 * modem to hang up the line.
> @@ -788,7 +788,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
>   				return retval;
>   			}
>   		}
> -		tty_port_set_initialized(port, 1);
> +		tty_port_set_initialized(port, true);
>   	}
>   	mutex_unlock(&port->mutex);
>   	return tty_port_block_til_ready(port, tty, filp);
> diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
> index da19a5fa414f..c3ea3a46ed76 100644
> --- a/drivers/usb/serial/console.c
> +++ b/drivers/usb/serial/console.c
> @@ -169,7 +169,7 @@ static int usb_console_setup(struct console *co, char *options)
>   			tty_save_termios(tty);
>   			tty_kref_put(tty);
>   		}
> -		tty_port_set_initialized(&port->port, 1);
> +		tty_port_set_initialized(&port->port, true);
>   	}
>   	/* Now that any required fake tty operations are completed restore
>   	 * the tty port count */

-- 
js
suse labs

