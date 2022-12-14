Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989164D246
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLNWUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLNWU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:20:29 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D245EDB;
        Wed, 14 Dec 2022 14:20:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l8so8125811ljh.13;
        Wed, 14 Dec 2022 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiucK2+40q3hFOO74rool3ZEFfO1NkbMNjStmtonXG4=;
        b=XSFNj0/kRNpk/x6W8+tsz9n622XwfG1JSIqFGqewL0I4CwhtsAmppEef6A8CWePLLW
         uQH1f2xsGQxwlfgMlijxK6WlTynMiQUIyi8lnP95H7MGW0MHOc76rEVZVOFJf1kCmF/x
         fksVjiZZhIMc6QoOMnYmo8oZN/0KZ6YyvYzfYVlzwu8my6DQqGL7dPCy3MH62iVi6/ea
         TNcaG8XSx2MuY2U/UDFFTKZhUoguo0TDfjrDKu4uYPGSnkMcPqMvVJhv+tKd5ahS9BQQ
         yHnKnaS2mGP4Gsk/ue2yEopPJXWa1/JDETsdGv9g3iWIEqNJvoZZCFNPC+lvWbluDuLk
         ts6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiucK2+40q3hFOO74rool3ZEFfO1NkbMNjStmtonXG4=;
        b=eqvB86CkufmUbnHRUhjZsIgKsXQ0BHXDAlXX00TLN+h5nF1Y0fXU5CxnepBVtB7V93
         Zg4duYsoRTEvjWxhFdePIYkQs9uqq1atCGehYdXL8PFhGlVmQY27nytn+vOpy5by8rjr
         hfYP/Lj246xY5l9SXYuCKC1JvI3licwz/f3MNgYqEkeUfvhmCidaa/pclh0XSrmk+zWY
         6K1FLViPWNRO3B/XKB9nNGw6j+YTIdAeRuQAxg98OsUGtSaU0tSkFUKzECLn/iiZ6ph8
         eH4FRPbUgVSSKe5luJytxvW5d4C2iK9tmxSLqTfoUg/OZciyIQMy3VMo4EP7oCAWm9pv
         ldhg==
X-Gm-Message-State: ANoB5plBn3HBdFtFfEwMjDIQKgDXPBzAg/g0DuRMGOfGPcVYNxciAwZ4
        GGAksMSuxniHJmPYvCEkoN6F3wcIycBTysGhcEM=
X-Google-Smtp-Source: AA0mqf5huuz6HTjHj6lT0ocrmeimFXDSIGeWm1/X2kLf9UV9Tc3xgoFttUBBt9Qjum1CIHbAzddoLSuVprcSBh+P5xU=
X-Received: by 2002:a05:651c:c8b:b0:277:f8b:bb4f with SMTP id
 bz11-20020a05651c0c8b00b002770f8bbb4fmr27873406ljb.161.1671056423077; Wed, 14
 Dec 2022 14:20:23 -0800 (PST)
MIME-Version: 1.0
References: <1670931569-3566-1-git-send-email-neeraj.sanjaykale@nxp.com>
In-Reply-To: <1670931569-3566-1-git-send-email-neeraj.sanjaykale@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Dec 2022 14:20:11 -0800
Message-ID: <CABBYNZLNOv=5otLYKgSxMNTQ2rYHYn7wi=u99d9qqbUdBiEFJQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add hci_nxp to hci_uart module to
 support NXP BT chipsets
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neeraj,

On Tue, Dec 13, 2022 at 3:39 AM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Add hci_nxp to the hci_uart module which adds support for the NXP BT
> chips. This driver has Power Save feature that will put the NXP bluetooth
> chip into sleep state, whenever there is no activity for certain duration
> of time (2000ms), and will be woken up when any activity is to be
> initiated.
>
> The Power Save feature can be configured with the following set
> of commands (optional):
> hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
> hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
> where,
> OGF = 0x3F (vendor specific command)
> OCF = 0x23 (command to set Power Save state)
> arg[0] = 0x02 (disable Power Save)
> arg[0] = 0x03 (enable Power Save)
> arg[1,2,...] = XX (don't care)
>
> The sleep/wake-up source can be configured with the following set
> of commands (optional):
> hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
> hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
> where,
> OGF = 0x3F (vendor specific command)
> OCF = 0x53 (command to set sleep and wake-up source)
> arg[0] = 0x00 (Chip to host method NONE)
> arg[0] = 0x01 (Chip to host method UART DTR)
> arg[0] = 0x02 (Chip to host method UART BREAK)
> arg[0] = 0x03 (Chip to host method GPIO)
> arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
> arg[2] = 0x00 (Host to chip method UART DSR)
> arg[2] = 0x01 (Host to chip method UART BREAK)
> arg[3] = 0xXX (Reserved for future use)
>
> By default, the hci_nxp sets power save enable, chip to host wake-up
> source as GPIO and host to chip sleep and wake-up source as UART
> break during driver initialization, by sending the respective
> commands to the chip.
>
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Changed the subject/summary lines and added more details in the description. (Paul Menzel)
> v3: Made internal functions static, optimized the code, added few comments. (Sherry Sun)
> v4: Reworked entire code to send vendor commands cmd23 and cmd53 by using __hci_cmd_sync (Luiz Augusto von Dentz)
> ---
>  MAINTAINERS                   |   6 +
>  drivers/bluetooth/Kconfig     |  10 +
>  drivers/bluetooth/Makefile    |   1 +
>  drivers/bluetooth/hci_ldisc.c |   6 +
>  drivers/bluetooth/hci_nxp.c   | 595 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_nxp.h   |  99 +++++++
>  drivers/bluetooth/hci_uart.h  |   8 +-
>  7 files changed, 724 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/hci_nxp.c
>  create mode 100644 drivers/bluetooth/hci_nxp.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e55a4d4..a234bf3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22591,6 +22591,12 @@ L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     mm/zswap.c
>
> +NXP BLUETOOTH WIRELESS DRIVERS
> +M:     Amitkumar Karwar <amitkumar.karwar@nxp.com>
> +M:     Neeraj Kale <neeraj.sanjaykale@nxp.com>
> +S:     Maintained
> +F:     drivers/bluetooth/hci_nxp*
> +
>  THE REST
>  M:     Linus Torvalds <torvalds@linux-foundation.org>
>  L:     linux-kernel@vger.kernel.org
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 89b4d47..7f6d1dc 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -273,6 +273,16 @@ config BT_HCIUART_MRVL
>
>           Say Y here to compile support for HCI MRVL protocol.
>
> +config BT_HCIUART_NXP
> +        bool "NXP protocol support"
> +        depends on BT_HCIUART
> +        help
> +          NXP is serial protocol for communication between Bluetooth
> +          device and host. This protocol is required for most NXP Bluetooth
> +          devices with UART interface.
> +
> +          Say Y here to compile support for HCI NXP protocol.
> +
>  config BT_HCIBCM203X
>         tristate "HCI BCM203x USB driver"
>         depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 3321a8a..bc80329 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -48,4 +48,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)     += hci_bcm.o
>  hci_uart-$(CONFIG_BT_HCIUART_QCA)      += hci_qca.o
>  hci_uart-$(CONFIG_BT_HCIUART_AG6XX)    += hci_ag6xx.o
>  hci_uart-$(CONFIG_BT_HCIUART_MRVL)     += hci_mrvl.o
> +hci_uart-$(CONFIG_BT_HCIUART_NXP)      += hci_nxp.o
>  hci_uart-objs                          := $(hci_uart-y)
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 865112e..f3c85c2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -882,6 +882,9 @@ static int __init hci_uart_init(void)
>  #ifdef CONFIG_BT_HCIUART_MRVL
>         mrvl_init();
>  #endif
> +#ifdef CONFIG_BT_HCIUART_NXP
> +       nxp_init();
> +#endif
>
>         return 0;
>  }
> @@ -918,6 +921,9 @@ static void __exit hci_uart_exit(void)
>  #ifdef CONFIG_BT_HCIUART_MRVL
>         mrvl_deinit();
>  #endif
> +#ifdef CONFIG_BT_HCIUART_NXP
> +       nxp_deinit();
> +#endif
>
>         tty_unregister_ldisc(&hci_uart_ldisc);
>  }
> diff --git a/drivers/bluetooth/hci_nxp.c b/drivers/bluetooth/hci_nxp.c
> new file mode 100644
> index 0000000..81418e0
> --- /dev/null
> +++ b/drivers/bluetooth/hci_nxp.c
> @@ -0,0 +1,595 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  Bluetooth HCI UART driver
> + *  Copyright 2018-2022 NXP
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/fcntl.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/poll.h>
> +
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/signal.h>
> +#include <linux/ioctl.h>
> +#include <linux/skbuff.h>
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "hci_uart.h"
> +#include "hci_nxp.h"
> +
> +/* NXP Power Save Feature */
> +struct BT_CMD {
> +       u16     ocf_ogf;
> +       u8      length;
> +       u8      data[4];
> +} __packed;

Just use struct hci_command_hdr instead of declaring BT_CMD like above.

> +/* Power Save feature will be enabled and wakeup method will be break signal by default */
> +int wakeupmode = WAKEUP_METHOD_BREAK;
> +int ps_mode = PS_MODE_ENABLE;
> +
> +static int is_device_ready(struct hci_uart *hu)
> +{
> +       struct hci_dev *hdev = NULL;
> +
> +       if (!hu) {
> +               BT_ERR("hu is NULL");
> +               return -ENODEV;
> +       }
> +       if (!hu->proto || !hu->hdev || !hu->tty) {
> +               BT_ERR("Device not ready! proto=%p, hdev=%p, tty=%p", hu->proto, hu->hdev, hu->tty);
> +               return -ENODEV;
> +       }
> +       hdev = hu->hdev;
> +       if (!test_bit(HCI_RUNNING, &hdev->flags)) {
> +               BT_ERR("HCI_RUNNING is not set");
> +               return -EBUSY;
> +       }
> +       return 0;
> +}
> +
> +static void ps_start_timer(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +
> +       if (psdata->cur_psmode ==  PS_MODE_ENABLE) {
> +               psdata->timer_on = 1;
> +               mod_timer(&psdata->ps_timer, jiffies + (psdata->interval * HZ) / 1000);
> +       }
> +}
> +
> +static void ps_timeout_func(struct timer_list *t)
> +{
> +       struct ps_data *data = from_timer(data, t, ps_timer);
> +       struct tty_struct *tty = data->tty;
> +       struct hci_uart *hu = NULL;
> +
> +       data->timer_on = 0;
> +       if (!data->tty)
> +               return;
> +
> +       hu = (struct hci_uart *)tty->disc_data;
> +       if (!hu)
> +               return;
> +
> +       if (test_bit(HCI_UART_SENDING, &hu->tx_state)) {
> +               ps_start_timer(hu);
> +       } else {
> +               data->ps_cmd = PS_CMD_ENTER_PS;
> +               schedule_work(&data->work);
> +       }
> +}
> +
> +static void set_dtr(struct tty_struct *tty, int on_off)
> +{
> +       u32 old_state = 0;
> +       u32 new_state = 0;
> +
> +       if (TTY_FUNC->tiocmget) {
> +               old_state = TTY_FUNC->tiocmget(tty);
> +               if (on_off)
> +                       new_state = old_state | TIOCM_DTR;
> +               else
> +                       new_state = old_state & ~TIOCM_DTR;
> +               if (new_state == old_state)
> +                       return;
> +               if (TTY_FUNC->tiocmset) {
> +                       if (on_off)
> +                               TTY_FUNC->tiocmset(tty, TIOCM_DTR, 0);  /* DTR ON */
> +                       else
> +                               TTY_FUNC->tiocmset(tty, 0, TIOCM_DTR);  /* DTR OFF */
> +               }
> +       }
> +}
> +
> +static void set_break(struct tty_struct *tty, int on_off)
> +{
> +       if (TTY_FUNC->break_ctl) {
> +               if (on_off)
> +                       TTY_FUNC->break_ctl(tty, -1); /* turn on break */
> +               else
> +                       TTY_FUNC->break_ctl(tty, 0);  /* turn off break */
> +       }
> +}
> +
> +static int get_cts(struct tty_struct *tty)
> +{
> +       u32 state = 0;
> +       int ret = -1;
> +
> +       if (TTY_FUNC->tiocmget) {
> +               state = TTY_FUNC->tiocmget(tty);
> +               if (state & TIOCM_CTS)
> +                       ret = 1;   /* CTS LOW */
> +               else
> +                       ret = 0;   /* CTS HIGH */
> +       }
> +       return ret;
> +}
> +
> +static void set_rts(struct tty_struct *tty, int on_off)
> +{
> +       u32 old_state = 0;
> +       u32 new_state = 0;
> +
> +       if (TTY_FUNC->tiocmget) {
> +               old_state = TTY_FUNC->tiocmget(tty);
> +               if (on_off)
> +                       new_state = old_state | TIOCM_RTS;
> +               else
> +                       new_state = old_state & ~TIOCM_RTS;
> +               if (new_state == old_state)
> +                       return;
> +               if (TTY_FUNC->tiocmset) {
> +                       if (on_off)
> +                               TTY_FUNC->tiocmset(tty, TIOCM_RTS, 0);    /* RTS ON */
> +                       else
> +                               TTY_FUNC->tiocmset(tty, 0, TIOCM_RTS);    /* RTS OFF */
> +               }
> +       }
> +}
> +
> +static void ps_control(struct ps_data *data, u8 ps_state)
> +{
> +       struct hci_uart *hu = NULL;
> +
> +       if (data->ps_state == ps_state)
> +               return;
> +
> +       if (data->tty) {
> +               switch (data->cur_wakeupmode) {
> +               case WAKEUP_METHOD_DTR:
> +                       if (ps_state == PS_STATE_AWAKE)
> +                               set_dtr(data->tty, 1);  /* DTR ON */
> +                       else
> +                               set_dtr(data->tty, 0);  /* DTR OFF */
> +                       break;
> +               case WAKEUP_METHOD_BREAK:
> +                       if (ps_state == PS_STATE_AWAKE)
> +                               set_break(data->tty, 0); /* break OFF */
> +                       else
> +                               set_break(data->tty, 1); /* break ON */
> +                       break;
> +               default:
> +                       break;
> +               }
> +               data->ps_state = ps_state;
> +
> +               if (ps_state == PS_STATE_AWAKE) {
> +                       hu = (struct hci_uart *)data->tty->disc_data;
> +                       if (hu)
> +                               hci_uart_tx_wakeup(hu);
> +               }
> +       }
> +}
> +
> +static void ps_work_func(struct work_struct *work)
> +{
> +       struct ps_data *data = container_of(work, struct ps_data, work);
> +
> +       if (data->tty) {
> +               if (data->ps_cmd == PS_CMD_ENTER_PS && data->cur_psmode == PS_MODE_ENABLE)
> +                       ps_control(data, PS_STATE_SLEEP);
> +               else  if (data->ps_cmd == PS_CMD_EXIT_PS)
> +                       ps_control(data, PS_STATE_AWAKE);
> +       }
> +}
> +
> +static int ps_init_work(struct hci_uart *hu)
> +{
> +       struct ps_data *psdata = kzalloc(sizeof(*psdata), GFP_KERNEL);
> +       struct nxp_struct *nxp = hu->priv;
> +
> +       if (!psdata) {
> +               BT_ERR("Can't allocate control structure");
> +               return -ENFILE;
> +       }
> +       nxp->psdata = psdata;
> +
> +       memset(psdata, 0, sizeof(*psdata));
> +       psdata->interval = DEFAULT_TIME_PERIOD;
> +       psdata->tty = NULL;
> +       psdata->ps_state = PS_STATE_AWAKE;
> +       psdata->ps_mode = ps_mode;
> +       switch (wakeupmode) {
> +       case WAKEUP_METHOD_DTR:
> +               psdata->wakeupmode =  WAKEUP_METHOD_DTR;
> +               break;
> +       case  WAKEUP_METHOD_BREAK:
> +       default:
> +               psdata->wakeupmode =  WAKEUP_METHOD_BREAK;
> +               break;
> +       }
> +
> +       psdata->cur_psmode = PS_MODE_DISABLE;
> +       psdata->cur_wakeupmode = WAKEUP_METHOD_INVALID;
> +
> +       INIT_WORK(&psdata->work, ps_work_func);
> +       return 0;
> +}
> +
> +static void ps_init_timer(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +
> +       psdata->timer_on = 0;
> +       psdata->tty = hu->tty;
> +       timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
> +}
> +
> +static void ps_cancel_timer(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +
> +       if (psdata) {
> +               flush_scheduled_work();
> +       if (psdata->timer_on)
> +               del_timer(&psdata->ps_timer);
> +       psdata->tty = NULL;
> +       kfree(psdata);
> +       }
> +}
> +
> +static int ps_wakeup(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       int ret = 1;
> +
> +       if (psdata->ps_state == PS_STATE_AWAKE)
> +               ret = 0;
> +       psdata->ps_cmd = PS_CMD_EXIT_PS;
> +       schedule_work(&psdata->work);
> +       return ret;
> +}
> +
> +/* Builds and sends a PS command packet to chip */
> +static int send_ps_cmd(struct hci_dev *hdev, void *data)
> +{
> +       struct hci_uart *hu = (struct hci_uart *)data;
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       u8 pcmd;
> +       struct sk_buff *skb;
> +       u8 *status;
> +
> +       if (psdata->ps_mode ==  PS_MODE_ENABLE)
> +               pcmd = BT_PS_ENABLE;
> +       else
> +               pcmd = BT_PS_DISABLE;
> +
> +       psdata->driver_sent_cmd = 1;    /* set flag to prevent re-sending command in nxp_enqueue */
> +       skb = __hci_cmd_sync(hdev, (OGF << 10) | BT_CMD_AUTO_SLEEP_MODE, 1, &pcmd, HCI_CMD_TIMEOUT);

Not sure why you don't have the resulting opcode instead of defining
the OGF and OFC separately.

> +       psdata->driver_sent_cmd = 0;
> +
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Setting Power Save mode failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +
> +       status = skb_pull_data(skb, 1);
> +
> +       if (status) {
> +               if (!*status)
> +                       psdata->cur_psmode = psdata->ps_mode;
> +               else
> +                       psdata->ps_mode = psdata->cur_psmode;
> +               if (psdata->cur_psmode == PS_MODE_ENABLE)
> +                       ps_start_timer(hu);
> +               else
> +                       ps_wakeup(hu);
> +               BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
> +                       *status, psdata->cur_psmode);
> +       }
> +
> +       return 0;
> +}
> +
> +/* Builds and sends an wake up method command packet to chip */
> +static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
> +{
> +       struct hci_uart *hu = (struct hci_uart *)data;
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       u8 pcmd[4];
> +       struct sk_buff *skb;
> +       u8 *status;
> +
> +       pcmd[0] = BT_HOST_WAKEUP_METHOD_NONE;
> +       pcmd[1] = BT_HOST_WAKEUP_DEFAULT_GPIO;
> +       switch (psdata->wakeupmode) {
> +       case WAKEUP_METHOD_DTR:
> +               pcmd[2] = BT_CTRL_WAKEUP_METHOD_DSR;
> +               break;
> +       case WAKEUP_METHOD_BREAK:
> +       default:
> +               pcmd[2] = BT_CTRL_WAKEUP_METHOD_BREAK;
> +               break;
> +       }
> +       pcmd[3] = 0xFF;
> +
> +       psdata->driver_sent_cmd = 1;    /* set flag to prevent re-sending command in nxp_enqueue */
> +       skb = __hci_cmd_sync(hdev, (OGF << 10) | BT_CMD_WAKEUP_METHOD, 4, pcmd, HCI_CMD_TIMEOUT);

Ditto, BT_CMD_WAKEUP_METHOD could be the resulting opcode.

> +       psdata->driver_sent_cmd = 0;
> +
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Setting wake-up method failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +
> +       status = skb_pull_data(skb, 1);
> +
> +       if (status) {
> +               if (!*status)
> +                       psdata->cur_wakeupmode = psdata->wakeupmode;
> +               else
> +                       psdata->wakeupmode = psdata->cur_wakeupmode;
> +               BT_INFO("Set Wakeup Method response: status=%d, wakeupmode=%d",
> +                       *status, psdata->cur_wakeupmode);
> +       }
> +
> +       return 0;
> +}
> +
> +static void ps_init(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       int mode = 0;
> +
> +       if (!psdata || !psdata->tty)
> +               return;
> +       if (get_cts(psdata->tty) != 1) {
> +               /* CTS is not low, chip is either sleeping
> +                * or flow control is not enabled
> +                */
> +               hci_uart_set_flow_control(hu, false);
> +               hci_uart_set_flow_control(hu, true);
> +
> +               /* Wake up the chip */
> +               mode = psdata->cur_wakeupmode;
> +               if (mode == WAKEUP_METHOD_INVALID)
> +                       mode =  wakeupmode;
> +               switch (mode) {
> +               case WAKEUP_METHOD_BREAK:
> +                       set_rts(psdata->tty, 1);        /* set RTS */
> +                       set_break(psdata->tty, 1);      /* break on */
> +                       set_break(psdata->tty, 0);      /* break off */
> +                       mdelay(5);
> +                       break;
> +               case WAKEUP_METHOD_DTR:
> +                       set_rts(psdata->tty, 1);        /* set RTS */
> +                       set_dtr(psdata->tty, 0);        /* dtr off */
> +                       set_dtr(psdata->tty, 1);        /* dtr on */
> +                       mdelay(5);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       if (!is_device_ready(hu)) {
> +               if (psdata->cur_wakeupmode != psdata->wakeupmode)
> +                       hci_cmd_sync_queue(hu->hdev, send_wakeup_method_cmd, hu, NULL);
> +               if (psdata->cur_psmode != psdata->ps_mode)
> +                       hci_cmd_sync_queue(hu->hdev, send_ps_cmd, hu, NULL);
> +       }
> +}
> +
> +/* NXP proto */
> +
> +/* Initialize protocol */
> +static int nxp_open(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp;
> +
> +       BT_DBG("hu %p", hu);
> +
> +       nxp = kzalloc(sizeof(*nxp), GFP_KERNEL);
> +       if (!nxp)
> +               return -ENOMEM;
> +
> +       skb_queue_head_init(&nxp->txq);
> +
> +       hu->priv = nxp;
> +
> +       if (ps_init_work(hu) == 0)
> +               ps_init_timer(hu);
> +
> +       return 0;
> +}
> +
> +/* Flush protocol data */
> +static int nxp_flush(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +
> +       BT_DBG("hu %p", hu);
> +
> +       skb_queue_purge(&nxp->txq);
> +
> +       return 0;
> +}
> +
> +/* Close protocol */
> +static int nxp_close(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +
> +       BT_DBG("hu %p", hu);
> +
> +       ps_cancel_timer(hu);
> +
> +       skb_queue_purge(&nxp->txq);
> +
> +       kfree_skb(nxp->rx_skb);
> +
> +       hu->priv = NULL;
> +       kfree(nxp);
> +
> +       return 0;
> +}
> +
> +/* Enqueue frame for transmission (padding, crc, etc) */
> +static int nxp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       struct BT_CMD *pcmd = (struct BT_CMD *)skb->data;
> +
> +       BT_DBG("hu %p skb %p", hu, skb);
> +
> +       /* if commands are received from user space (e.g. hcitool), update
> +        *  psdata flags accordingly and ask driver to re-send the command
> +        */
> +       if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT && !psdata->driver_sent_cmd) {
> +               if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_AUTO_SLEEP_MODE)) {

Ditto, if you need to access the OGF and OCF separaly just use
hci_opcode_ogf nad hci_opcode_ocf respectively, but the again using
the resulting opcode is better normally since you can do a direct
comparison or even use a switch.

> +                       if (pcmd->data[0] == BT_PS_ENABLE)
> +                               psdata->ps_mode = PS_MODE_ENABLE;
> +                       else if (pcmd->data[0] == BT_PS_DISABLE)
> +                               psdata->ps_mode = PS_MODE_DISABLE;
> +                       hci_cmd_sync_queue(hu->hdev, send_ps_cmd, hu, NULL);
> +                       kfree_skb(skb);
> +                       return 0;
> +               }
> +               if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_WAKEUP_METHOD)) {
> +                       switch (pcmd->data[2]) {
> +                       case BT_CTRL_WAKEUP_METHOD_DSR:
> +                               psdata->wakeupmode = WAKEUP_METHOD_DTR;
> +                               break;
> +                       case BT_CTRL_WAKEUP_METHOD_BREAK:
> +                       default:
> +                               psdata->wakeupmode = WAKEUP_METHOD_BREAK;
> +                               break;
> +                       }
> +                       hci_cmd_sync_queue(hu->hdev, send_wakeup_method_cmd, hu, NULL);
> +                       kfree_skb(skb);
> +                       return 0;
> +               }
> +       }
> +
> +       /* Prepend skb with frame type */
> +       memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> +       skb_queue_tail(&nxp->txq, skb);
> +
> +       return 0;
> +}
> +
> +static const struct h4_recv_pkt nxp_recv_pkts[] = {
> +       { H4_RECV_ACL,   .recv = hci_recv_frame },
> +       { H4_RECV_SCO,   .recv = hci_recv_frame },
> +       { H4_RECV_EVENT, .recv = hci_recv_frame },
> +       { H4_RECV_ISO,   .recv = hci_recv_frame },
> +};
> +
> +static int nxp_recv(struct hci_uart *hu, const void *data, int count)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +
> +       if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> +               return -EUNATCH;
> +
> +       ps_start_timer(hu);
> +
> +       nxp->rx_skb = h4_recv_buf(hu->hdev, nxp->rx_skb, data, count,
> +                                 nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
> +       if (IS_ERR(nxp->rx_skb)) {
> +               int err = PTR_ERR(nxp->rx_skb);
> +
> +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> +               nxp->rx_skb = NULL;
> +               return err;
> +       }
> +
> +       return count;
> +}
> +
> +static struct sk_buff *nxp_dequeue(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +
> +       if (ps_wakeup(hu)) {
> +               clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +               return 0;
> +       }
> +       ps_start_timer(hu);
> +       return skb_dequeue(&nxp->txq);
> +}
> +
> +static int nxp_setup(struct hci_uart *hu)
> +{
> +       ps_init(hu);
> +       return 0;
> +}
> +
> +static const struct hci_uart_proto nxpp = {
> +       .id             = HCI_UART_NXP,
> +       .name           = "NXP",
> +       .open           = nxp_open,
> +       .close          = nxp_close,
> +       .recv           = nxp_recv,
> +       .enqueue        = nxp_enqueue,
> +       .dequeue        = nxp_dequeue,
> +       .flush          = nxp_flush,
> +       .setup          = nxp_setup,
> +};
> +
> +int __init nxp_init(void)
> +{
> +       return hci_uart_register_proto(&nxpp);
> +}
> +
> +int __exit nxp_deinit(void)
> +{
> +       return hci_uart_unregister_proto(&nxpp);
> +}
> diff --git a/drivers/bluetooth/hci_nxp.h b/drivers/bluetooth/hci_nxp.h
> new file mode 100644
> index 0000000..cb3ecf5
> --- /dev/null
> +++ b/drivers/bluetooth/hci_nxp.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  Bluetooth HCI UART driver
> + *  Copyright 2018-2022 NXP
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +#ifndef _HCI_NXP_H_
> +#define _HCI_NXP_H_
> +
> +#define TTY_FUNC tty->ops
> +
> +struct ps_data {
> +       u8    ps_mode;
> +       u8    cur_psmode;
> +       u8    ps_state;
> +       u8    ps_cmd;
> +       u8    wakeupmode;
> +       u8    cur_wakeupmode;
> +       u8    driver_sent_cmd;
> +       u8    timer_on;
> +       u32   interval;
> +       struct work_struct work;
> +       struct tty_struct *tty;
> +       struct timer_list ps_timer;
> +};
> +
> +struct nxp_struct {
> +       struct sk_buff      *rx_skb;
> +       struct sk_buff_head  txq;
> +       struct list_head     nxp_list_head;
> +       unsigned char        id;
> +       struct ps_data      *psdata;
> +};
> +
> +/* Default ps timeout period in milli-second */
> +#define DEFAULT_TIME_PERIOD     2000
> +
> +/* wakeup methods */
> +#define WAKEUP_METHOD_DTR       0
> +#define WAKEUP_METHOD_BREAK     1
> +#define WAKEUP_METHOD_EXT_BREAK 2
> +#define WAKEUP_METHOD_RTS       3
> +#define WAKEUP_METHOD_INVALID   0xff
> +
> +/* ps mode disable */
> +#define PS_MODE_DISABLE         0
> +/* ps mode enable */
> +#define PS_MODE_ENABLE          1
> +
> +/* PS Commands to ps_work_func  */
> +#define PS_CMD_EXIT_PS          1
> +#define PS_CMD_ENTER_PS         2
> +
> +/* ps state */
> +#define PS_STATE_AWAKE          0
> +#define PS_STATE_SLEEP          1
> +
> +/* OGF */
> +#define OGF                                    0x3F
> +/* Bluetooth vendor command : Sleep mode */
> +#define BT_CMD_AUTO_SLEEP_MODE         0x23
> +/* Bluetooth vendor command : Wakeup method */
> +#define BT_CMD_WAKEUP_METHOD    0x53
> +
> +/* Bluetooth Power State : Vendor cmd params */
> +#define BT_PS_ENABLE                   0x02
> +#define BT_PS_DISABLE                  0x03
> +
> +/* Bluetooth Host Wakeup Methods */
> +#define BT_HOST_WAKEUP_METHOD_NONE      0x00
> +#define BT_HOST_WAKEUP_METHOD_DTR       0x01
> +#define BT_HOST_WAKEUP_METHOD_BREAK     0x02
> +#define BT_HOST_WAKEUP_METHOD_GPIO      0x03
> +#define BT_HOST_WAKEUP_DEFAULT_GPIO     20
> +
> +/* Bluetooth Chip Wakeup Methods */
> +#define BT_CTRL_WAKEUP_METHOD_DSR       0x00
> +#define BT_CTRL_WAKEUP_METHOD_BREAK     0x01
> +#define BT_CTRL_WAKEUP_METHOD_GPIO      0x02
> +#define BT_CTRL_WAKEUP_METHOD_EXT_BREAK 0x04
> +#define BT_CTRL_WAKEUP_METHOD_RTS       0x05
> +#define BT_CTRL_WAKEUP_DEFAULT_GPIO     4
> +
> +#define  HCI_OP_AUTO_SLEEP_MODE         0xfc23
> +#define  HCI_OP_WAKEUP_METHOD           0xfc53
> +
> +#endif /* _HCI_UART_H_ */
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index fb4a2d0..17d271c 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -20,7 +20,7 @@
>  #define HCIUARTGETFLAGS                _IOR('U', 204, int)
>
>  /* UART protocols */
> -#define HCI_UART_MAX_PROTO     12
> +#define HCI_UART_MAX_PROTO     13
>
>  #define HCI_UART_H4    0
>  #define HCI_UART_BCSP  1
> @@ -34,6 +34,7 @@
>  #define HCI_UART_AG6XX 9
>  #define HCI_UART_NOKIA 10
>  #define HCI_UART_MRVL  11
> +#define HCI_UART_NXP   12
>
>  #define HCI_UART_RAW_DEVICE    0
>  #define HCI_UART_RESET_ON_INIT 1
> @@ -200,3 +201,8 @@ int ag6xx_deinit(void);
>  int mrvl_init(void);
>  int mrvl_deinit(void);
>  #endif
> +
> +#ifdef CONFIG_BT_HCIUART_NXP
> +int nxp_init(void);
> +int nxp_deinit(void);
> +#endif
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz
