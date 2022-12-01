Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A722763F8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLAUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiLAUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:19:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B08BEE2B;
        Thu,  1 Dec 2022 12:19:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f13so4255952lfa.6;
        Thu, 01 Dec 2022 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vM/6I3RlWg58q21m6y9a2XDoh5fe7wURme2mx7tiD2E=;
        b=HOcvEDA7SfVykatT/VAAScywl6orZ9fbmqEtx6+5OuiZ2nXE0GiMN10pCnmvtAHvJq
         t+0pAXEOpxT+D4LhpMibd0F8lzLd9VCCnzrLVTZdTIcLUCqK/vZuEeVprkQXkrox8CL3
         QYmjQ33rfj7GOmHEFkXp5F2GAiTbCTXoZ5M5Na6ykjWTnscgoqNemf5N8Id5SHpCq/nx
         DgOA8/4RktQHwqKEe3fryr5vtuXM6vLLSSjzwnIFr71yhg0UAf6d9cohKq23+v3UO8qK
         992VK53sovAg18eOwxoOpWtc4xZbrI7RUPHd2UfSFhn6nhsCpu0bZ3P/mRsWslaCNUj7
         KI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vM/6I3RlWg58q21m6y9a2XDoh5fe7wURme2mx7tiD2E=;
        b=tw8JGRVRWOd2wysSTEfKgrTTdntwYJJr1P1GOKm9FRnsm0ikszJCcVPqd70j7c/gnz
         oMaJ3A/Mi2wx+tZuypg6H2CqMBdN/rUw5rOVv8h42pNc8zDgwbFObB/TIeR9PEmaOoGh
         nVj/Q+UYZzSpU1KcRECHINpYbYVCF3HF8l79w2c5Y9amxZkVbeKBdq7NuXyvPEaecmYe
         tzlNJ0rsR7hKhbD2GOgK7AyuEaekzUGHVnIOdEiyaj4lntHFsHHUZzoKdTA1t9CpaCDO
         i4lKNEABcCi6hO9JHTzYETjKYQyrFZoXY9B5JR4D80NJ7RjNFeycalGm6ApV2py8Wybg
         n7QQ==
X-Gm-Message-State: ANoB5pnK5Z/n2A4M0YX+dT2TtFZ2u8t7FmmpRFZoLjlxdAEnsdeM4qV4
        Y1XWMIqqJZeGfJehXKSnvLNlZMG4MTcULmA3b2U=
X-Google-Smtp-Source: AA0mqf4qCuGQVLo7QFZrGVuJS6oVoG/p0Upt/GlnlXd3epT/S6eHdPMB6O1WS3UXplMRNpqulDMco/ij2MvOuMGVR9I=
X-Received: by 2002:ac2:46cc:0:b0:4b4:f43d:6b4d with SMTP id
 p12-20020ac246cc000000b004b4f43d6b4dmr11817816lfo.251.1669925944859; Thu, 01
 Dec 2022 12:19:04 -0800 (PST)
MIME-Version: 1.0
References: <1669207413-9637-1-git-send-email-neeraj.sanjaykale@nxp.com>
In-Reply-To: <1669207413-9637-1-git-send-email-neeraj.sanjaykale@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Dec 2022 12:18:53 -0800
Message-ID: <CABBYNZL=_sFuaR79GVpn9FUC7U_Jvrw_rfarm4qxREiimZkxfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: Add hci_nxp to hci_uart module to
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

On Wed, Nov 23, 2022 at 4:44 AM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Add hci_nxp to the hci_uart module which adds support for the NXP BT
> chips. This driver has Power Save feature that will put the NXP bluetooth
> chip into sleep state, whenever there is no activity for certain duration
> of time (2000ms), and will be woken up when any activity is to be
> initiated.
>
> The Power Save feature can (optionally) be configured with the following
> set of commands:
> hcitool -i hci0 cmd 3F 23 02 00 00    (disable Power Save)
> hcitool -i hci0 cmd 3F 23 03 00 00    (enable Power Save)
> where,
> OGF = 0x3F (vendor specific command)
> OCF = 0x23 (command to set Power Save state)
> arg[0] = 0x02 (disable Power Save)
> arg[0] = 0x03 (enable Power Save)
> arg[1,2,...] = XX (don't care)
>
> The sleep/wake-up source can be configured with the following set
> of commands:
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
> ---
>  MAINTAINERS                   |   6 +
>  drivers/bluetooth/Kconfig     |  10 +
>  drivers/bluetooth/Makefile    |   1 +
>  drivers/bluetooth/hci_ldisc.c |   6 +
>  drivers/bluetooth/hci_nxp.c   | 764 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_nxp.h   | 110 ++++++
>  drivers/bluetooth/hci_uart.h  |   8 +-
>  7 files changed, 904 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/hci_nxp.c
>  create mode 100644 drivers/bluetooth/hci_nxp.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e55a4d4..70f802d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22591,6 +22591,12 @@ L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     mm/zswap.c
>
> +NXP BLUETOOTH WIRELESS DRIVERS
> +M:     Amitkumar Karwar <amitkumar.karwar@nxp.com>
> +M:     Neeraj Kale <neeraj.sanjaykale@nxp.co>m
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
> index 0000000..1508edd
> --- /dev/null
> +++ b/drivers/bluetooth/hci_nxp.c
> @@ -0,0 +1,764 @@
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
> +/** NXP Power Save Feature **/
> +struct BT_CMD {
> +       u16     ocf_ogf;
> +       u8      length;
> +       u8      data[4];
> +} __packed;
> +
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
> +/* Builds and sends a PS command packet to chip */
> +static int send_ps_cmd(u8 cmd, struct hci_uart *hu)
> +{
> +       int err = 0;
> +       struct sk_buff *skb = NULL;
> +       struct BT_CMD *pcmd;

Why are you using BT_CMD when we do have the likes hci_send_cmd, or
__hci_cmd_sync, to encode HCI commands?

> +
> +       /* allocate packet */
> +       skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
> +       if (!skb) {
> +               BT_ERR("cannot allocate memory for HCILL packet");
> +               err = -ENOMEM;
> +               goto out;
> +       }
> +
> +       pcmd = (struct BT_CMD *)skb->data;
> +       pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_AUTO_SLEEP_MODE;
> +       pcmd->length = 1;
> +       if (cmd ==  PS_MODE_ENABLE)
> +               pcmd->data[0] = BT_PS_ENABLE;
> +       else
> +               pcmd->data[0] = BT_PS_DISABLE;
> +
> +       bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> +       skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
> +       skb->dev = (void *)hu->hdev;
> +
> +       /* send packet */
> +       hu->proto->enqueue(hu, skb);
> +       hci_uart_tx_wakeup(hu);
> +
> +out:
> +       return err;
> +}
> +
> +/* Builds and sends an wake up method command packet to chip */
> +static int send_wakeup_method_cmd(u8 cmd, struct hci_uart *hu)
> +{
> +       int err = 0;
> +       struct sk_buff *skb = NULL;
> +       struct BT_CMD *pcmd;
> +
> +       /* allocate packet */
> +       skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
> +       if (!skb) {
> +               BT_ERR("cannot allocate memory for HCILL packet");
> +               err = -ENOMEM;
> +               goto out;
> +       }
> +
> +       pcmd = (struct BT_CMD *)skb->data;
> +       pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_WAKEUP_METHOD;
> +       pcmd->length = 4;
> +       pcmd->data[0] = BT_HOST_WAKEUP_METHOD_NONE;
> +       pcmd->data[1] = BT_HOST_WAKEUP_DEFAULT_GPIO;
> +       switch (cmd) {
> +       case WAKEUP_METHOD_DTR:
> +               pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_DSR;
> +               break;
> +       case WAKEUP_METHOD_BREAK:
> +       default:
> +               pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_BREAK;
> +               break;
> +       }
> +       pcmd->data[3] = 0xFF;
> +
> +       bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> +
> +       skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
> +       skb->dev = (void *)hu->hdev;
> +
> +       /* send packet */
> +       hu->proto->enqueue(hu, skb);
> +       hci_uart_tx_wakeup(hu);
> +
> +out:
> +       return err;
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
> +       psdata->timer_on    = 0;
> +       psdata->tty = NULL;
> +       psdata->ps_state = PS_STATE_AWAKE;
> +       psdata->ps_mode = ps_mode;
> +       psdata->ps_cmd = 0;
> +       psdata->send_cmd = 0;
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
> +       if (psdata->cur_psmode == PS_MODE_ENABLE) {
> +               switch (psdata->cur_wakeupmode) {
> +               case WAKEUP_METHOD_BREAK:
> +                       set_break(psdata->tty, 0);      /* set_break off */
> +                       break;
> +               case WAKEUP_METHOD_DTR:
> +                       set_dtr(psdata->tty, 1);        /* dtr on */
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
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
> +static void ps_init(struct hci_uart *hu)
> +{
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +       int mode = 0;
> +       struct ktermios old_termios;
> +
> +       if (!psdata || !psdata->tty)
> +               return;
> +       if (get_cts(psdata->tty) != 1) {
> +               /* CTS is not low, chip is either sleeping */
> +               /* or flow control is not enabled */
> +               old_termios = psdata->tty->termios;
> +               psdata->tty->termios.c_cflag &= ~CRTSCTS;  /* Clear the flow control */
> +               psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
> +               old_termios = psdata->tty->termios;
> +               psdata->tty->termios.c_cflag |= CRTSCTS;  /* Enable the flow control */
> +               psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
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
> +       psdata->send_cmd = 0;
> +       if (!is_device_ready(hu)) {
> +               if (psdata->cur_wakeupmode != psdata->wakeupmode) {
> +                       psdata->send_cmd |= SEND_WAKEUP_METHOD_CMD;
> +                       send_wakeup_method_cmd(psdata->wakeupmode, hu);
> +               }
> +               if (psdata->cur_psmode != psdata->ps_mode) {
> +                       psdata->send_cmd |= SEND_AUTO_SLEEP_MODE_CMD;
> +                       send_ps_cmd(psdata->ps_mode, hu);
> +               }
> +       }
> +}
> +
> +static void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *hdr = (void *)skb->data;
> +       struct hci_ev_cmd_complete *ev = NULL;
> +       u8 event = hdr->evt;
> +       u16 opcode;
> +       u8 status = 0;
> +       struct nxp_struct *nxp = hu->priv;
> +       struct ps_data *psdata = nxp->psdata;
> +
> +       if (event == HCI_EV_CMD_COMPLETE) {
> +               ev = (void *)(skb->data + sizeof(struct hci_event_hdr));

Don't access the skb->data like that, you probably want to take a look
at skb_pull_data which does check the length.

> +               opcode = __le16_to_cpu(ev->opcode);
> +               switch (opcode) {
> +               case HCI_OP_AUTO_SLEEP_MODE:
> +                       status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
> +                       if (!status)
> +                               psdata->cur_psmode = psdata->ps_mode;
> +                       else
> +                               psdata->ps_mode = psdata->cur_psmode;
> +                       /* if driver has sent the command internally */
> +                       if (psdata->send_cmd)
> +                               psdata->send_cmd &= ~SEND_AUTO_SLEEP_MODE_CMD;
> +                       if (psdata->cur_psmode == PS_MODE_ENABLE)
> +                               ps_start_timer(hu);
> +                       else
> +                               ps_wakeup(hu);
> +                       BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
> +                               status, psdata->cur_psmode);
> +                       break;
> +               case HCI_OP_WAKEUP_METHOD:
> +                       status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
> +                       if (!status)
> +                               psdata->cur_wakeupmode = psdata->wakeupmode;
> +                       else
> +                               psdata->wakeupmode = psdata->cur_wakeupmode;
> +                       /* if driver has sent the command internally */
> +                       if (psdata->send_cmd)
> +                               psdata->send_cmd &= ~SEND_WAKEUP_METHOD_CMD;
> +                       BT_INFO("Set Wakeup Method response: status=%d, wakeupmode=%d",
> +                               status, psdata->cur_wakeupmode);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +/** NXP proto **/
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
> +       if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
> +               if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_AUTO_SLEEP_MODE)) {
> +                       if (pcmd->data[0] == BT_PS_ENABLE)
> +                               psdata->ps_mode = PS_MODE_ENABLE;
> +                       else if (pcmd->data[0] == BT_PS_DISABLE)
> +                               psdata->ps_mode = PS_MODE_DISABLE;
> +               }
> +               if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_WAKEUP_METHOD))
> +                       psdata->wakeupmode = pcmd->data[2];
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
> +static struct sk_buff *nxp_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
> +                                   const unsigned char *buffer, int count,
> +                                               const struct h4_recv_pkt *pkts,
> +                                               int pkts_count)
> +{
> +       struct hci_uart *hu = hci_get_drvdata(hdev);
> +       u8 alignment = hu->alignment ? hu->alignment : 1;
> +
> +       /* Check for error from previous call */
> +       if (IS_ERR(skb))
> +               skb = NULL;
> +
> +       while (count) {
> +               int i, len;
> +
> +               /* remove padding bytes from buffer */
> +               for (; hu->padding && count > 0; hu->padding--) {
> +                       count--;
> +                       buffer++;
> +               }
> +               if (!count)
> +                       break;
> +
> +               if (!skb) {
> +                       for (i = 0; i < pkts_count; i++) {
> +                               if (buffer[0] != (&pkts[i])->type)
> +                                       continue;
> +
> +                               skb = bt_skb_alloc((&pkts[i])->maxlen,
> +                                                  GFP_ATOMIC);
> +                               if (!skb)
> +                                       return ERR_PTR(-ENOMEM);
> +
> +                               hci_skb_pkt_type(skb) = (&pkts[i])->type;
> +                               hci_skb_expect(skb) = (&pkts[i])->hlen;
> +                               break;
> +                       }
> +
> +                       /* Check for invalid packet type */
> +                       if (!skb)
> +                               return ERR_PTR(-EILSEQ);
> +
> +                       count -= 1;
> +                       buffer += 1;
> +               }
> +
> +               len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
> +               skb_put_data(skb, buffer, len);
> +
> +               count -= len;
> +               buffer += len;
> +
> +               /* Check for partial packet */
> +               if (skb->len < hci_skb_expect(skb))
> +                       continue;
> +
> +               for (i = 0; i < pkts_count; i++) {
> +                       if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
> +                               break;
> +               }
> +
> +               if (i >= pkts_count) {
> +                       kfree_skb(skb);
> +                       return ERR_PTR(-EILSEQ);
> +               }
> +
> +               if (skb->len == (&pkts[i])->hlen) {
> +                       u16 dlen;
> +
> +                       switch ((&pkts[i])->lsize) {
> +                       case 0:
> +                               /* No variable data length */
> +                               dlen = 0;
> +                               break;
> +                       case 1:
> +                               /* Single octet variable length */
> +                               dlen = skb->data[(&pkts[i])->loff];
> +                               hci_skb_expect(skb) += dlen;
> +
> +                               if (skb_tailroom(skb) < dlen) {
> +                                       kfree_skb(skb);
> +                                       return ERR_PTR(-EMSGSIZE);
> +                               }
> +                               break;
> +                       case 2:
> +                               /* Double octet variable length */
> +                               dlen = get_unaligned_le16(skb->data +
> +                                                         (&pkts[i])->loff);
> +                               hci_skb_expect(skb) += dlen;
> +
> +                               if (skb_tailroom(skb) < dlen) {
> +                                       kfree_skb(skb);
> +                                       return ERR_PTR(-EMSGSIZE);
> +                               }
> +                               break;
> +                       default:
> +                               /* Unsupported variable length */
> +                               kfree_skb(skb);
> +                               return ERR_PTR(-EILSEQ);
> +                       }
> +
> +                       if (!dlen) {
> +                               hu->padding = (skb->len - 1) % alignment;
> +                               hu->padding = (alignment - hu->padding) % alignment;
> +
> +                               /* No more data, complete frame */
> +                               if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
> +                                       ps_check_event_packet(hu, skb);
> +                               (&pkts[i])->recv(hdev, skb);

If you are going to handle certain events directly by the driver it is
probably a good idea to clone it, that said there exists some means to
actually handle the events generated as response to commands, just use
hci_cmd_sync_queue then use __hci_cmd_sync which will return you the
skb of the event, that way you don't have to keep extra logic to
intercept certain events.

> +                               skb = NULL;
> +                       }
> +               } else {
> +                       hu->padding = (skb->len - 1) % alignment;
> +                       hu->padding = (alignment - hu->padding) % alignment;
> +
> +                       /* Complete frame */
> +                       if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
> +                               ps_check_event_packet(hu, skb);
> +                       (&pkts[i])->recv(hdev, skb);
> +                       skb = NULL;
> +               }
> +       }
> +
> +       return skb;
> +}
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
> +       nxp->rx_skb = nxp_recv_buf(hu->hdev, nxp->rx_skb, data, count,
> +                                  nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
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
> index 0000000..0ed5158
> --- /dev/null
> +++ b/drivers/bluetooth/hci_nxp.h
> @@ -0,0 +1,110 @@
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
> +       u32    ps_mode;
> +       u32    cur_psmode;
> +       u32    ps_state;
> +       u32    ps_cmd;
> +       u32    interval;
> +       u32    wakeupmode;
> +       u32    cur_wakeupmode;
> +       u32    send_cmd;
> +       struct work_struct work;
> +       struct tty_struct *tty;
> +       struct timer_list ps_timer;
> +       u32    timer_on;
> +};
> +
> +struct nxp_struct {
> +       struct sk_buff *rx_skb;
> +       struct sk_buff_head txq;
> +       struct list_head        nxp_list_head;
> +       unsigned char           id;
> +       struct ps_data          *psdata;
> +};
> +
> +/** Default ps timeout period in milli-second */
> +#define DEFAULT_TIME_PERIOD     2000
> +
> +/** wakeup method DTR */
> +#define WAKEUP_METHOD_DTR       0
> +/** wakeup method break */
> +#define WAKEUP_METHOD_BREAK     1
> +/** wake up method EX break */
> +#define WAKEUP_METHOD_EXT_BREAK  2
> +/** wake up method RTS */
> +#define WAKEUP_METHOD_RTS       3
> +/** wakeup method invalid */
> +#define  WAKEUP_METHOD_INVALID  0xff
> +
> +/** ps mode disable */
> +#define PS_MODE_DISABLE         0
> +/** ps mode enable */
> +#define PS_MODE_ENABLE          1
> +
> +/** ps cmd exit ps  */
> +#define PS_CMD_EXIT_PS          1
> +/** ps cmd enter ps */
> +#define PS_CMD_ENTER_PS         2
> +
> +/** ps state awake */
> +#define PS_STATE_AWAKE          0
> +/** ps state SLEEP */
> +#define PS_STATE_SLEEP          1
> +
> +/** OGF */
> +#define OGF                                    0x3F
> +/** Bluetooth command : Sleep mode */
> +#define BT_CMD_AUTO_SLEEP_MODE         0x23
> +/** Bluetooth command: Wakeup method */
> +#define BT_CMD_WAKEUP_METHOD    0x53
> +
> +/** Bluetooth Power State : Enable */
> +#define BT_PS_ENABLE                   0x02
> +/** Bluetooth Power State : Disable */
> +#define BT_PS_DISABLE                  0x03
> +
> +/** Bluetooth Host Wakeup Methods **/
> +#define BT_HOST_WAKEUP_METHOD_NONE      0x00
> +#define BT_HOST_WAKEUP_METHOD_DTR       0x01
> +#define BT_HOST_WAKEUP_METHOD_BREAK     0x02
> +#define BT_HOST_WAKEUP_METHOD_GPIO      0x03
> +#define BT_HOST_WAKEUP_DEFAULT_GPIO     5
> +
> +/** Bluetooth Chip Wakeup Methods **/
> +#define BT_CTRL_WAKEUP_METHOD_DSR       0x00
> +#define BT_CTRL_WAKEUP_METHOD_BREAK     0x01
> +#define BT_CTRL_WAKEUP_METHOD_GPIO      0x02
> +#define BT_CTRL_WAKEUP_METHOD_EXT_BREAK  0x04
> +#define BT_CTRL_WAKEUP_METHOD_RTS       0x05
> +#define BT_CTRL_WAKEUP_DEFAULT_GPIO     4
> +
> +#define  HCI_OP_AUTO_SLEEP_MODE         0xfc23
> +#define  HCI_OP_WAKEUP_METHOD           0xfc53
> +
> +/** send cmd flags **/
> +#define SEND_WAKEUP_METHOD_CMD          0x01
> +#define SEND_AUTO_SLEEP_MODE_CMD        0x02
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
