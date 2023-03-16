Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365346BD2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCPOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCPOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:54:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F619B2558;
        Thu, 16 Mar 2023 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678978489; x=1710514489;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IlKyP/cTSE8JtA4veB5BE+VL49L7N1SPG9tBTgeCkeY=;
  b=fyxuBjYEgDDHQN9ITwQBH0B0Kv2Nbam40yZoOB2D0CzM1pAt6sqkhfgU
   J7qsJW3b6vaWz6X6u0OISRGVvbH3mXD/FbvF7TiKaz5pKrEToa6z3nBVc
   DfBW5fzcNL3Tu6GPd9deKW2myANVb3C3DgUvKouGXNAelAeA0UhXjWMbL
   QAm7j3f4jJZilFXQYiW20mkAY0OU7OZKEYKrAExZGoch86SnRUkFH/LFy
   s0uQ1oO3kLznxju3aqfJa7q5RPKj4ntDsAdug08NUyIRs4zosMGKz6OUQ
   VI5mOsYaU8omypaT3npezqUDPJ+iFhv/mQz9Kh+St/3EWhUpBccEjSGkh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="402895747"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="402895747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 07:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657202679"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657202679"
Received: from trybicki-mobl1.ger.corp.intel.com ([10.252.63.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 07:54:43 -0700
Date:   Thu, 16 Mar 2023 16:54:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230315072902.9298-15-ychuang570808@gmail.com>
Message-ID: <24ce3334-b535-f6d5-70dd-3ba9be991252@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-15-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-688001410-1678975832=:2328"
Content-ID: <70d4a094-a2d3-c857-8bf-2d789c68215a@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-688001410-1678975832=:2328
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <133ace5-f616-e378-c7bb-7d3cb8f14428@linux.intel.com>

Hi,

I'll not note all things below because others have already seemingly 
commented many things.

On Wed, 15 Mar 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> 
> MA35D1 SoC provides up to 17 UART controllers, each with one uart port.
> The ma35d1 uart controller is not compatible with 8250.
> The uart controller supports:
>   - Full-duplex asynchronous communications
>   - Separates tx and tx 32/32 bytes entry FIFO for data payloads
>   - Hardware auto-flow control
>   - Programmable rx buffer trigger level (1/4/8/14/30 bytes)
>   - Individual programmable baud rate generator for each channel
>   - Supports nCTS, incoming data, rx FIFO reached threshold and
>     RS-485 Address Match (AAD mode) wake-up function
>   - Supports 8-bit rx buffer time-out detection function
>   - Programmable tx data delay time
>   - Supports Auto-Baud Rate measurement and baud rate compensation
>   - Supports break error, frame error, parity error and rx/tx buffer
>     overflow detection function
>   – Programmable number of data bit, 5-, 6-, 7-, 8- bit character
>   – Programmable parity bit, even, odd, no parity or stick parity bit
>     generation and detection
>   – Programmable stop bit, 1, 1.5, or 2 stop bit generation
>   - Supports IrDA SIR function mode
>   - Supports RS-485 function mode
>   – Supports RS-485 9-bit mode
>   – Supports hardware or software enables to program nRTS pin to control
>     RS-485 transmission direction
>   - Supports PDMA transfer function
>   - Support Single-wire function mode.

This list is probably copy-pasted from somewhere but it doesn't match what 
you implemented in the driver.

> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/tty/serial/Kconfig         |  18 +
>  drivers/tty/serial/Makefile        |   1 +
>  drivers/tty/serial/ma35d1_serial.c | 842 +++++++++++++++++++++++++++++
>  drivers/tty/serial/ma35d1_serial.h |  93 ++++
>  include/uapi/linux/serial_core.h   |   3 +
>  5 files changed, 957 insertions(+)
>  create mode 100644 drivers/tty/serial/ma35d1_serial.c
>  create mode 100644 drivers/tty/serial/ma35d1_serial.h
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 625358f44419..cb47fe804595 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1562,6 +1562,24 @@ config SERIAL_SUNPLUS_CONSOLE
>  	  you can alter that using a kernel command line option such as
>  	  "console=ttySUPx".
>  
> +config SERIAL_NUVOTON_MA35D1
> +	tristate "Nuvoton MA35D1 family UART support"
> +	depends on ARCH_NUVOTON || COMPILE_TEST
> +	select SERIAL_CORE
> +	help
> +	  This driver supports Nuvoton MA35D1 family UART ports. If you would
> +	  like to use them, you must answer Y or M to this option. Note that
> +	  for use as console, it must be included in kernel and not as a
> +	  module
> +
> +config SERIAL_NUVOTON_MA35D1_CONSOLE
> +	bool "Console on a Nuvotn MA35D1 family UART port"
> +	depends on SERIAL_NUVOTON_MA35D1=y
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  Select this options if you'd like to use the UART port0 of the
> +	  Nuvoton MA35D1 family as a console.
> +
>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index cd9afd9e3018..71ebeba06ff2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
>  
>  obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
>  obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
> +obj-$(CONFIG_SERIAL_NUVOTON_MA35D1)	+= ma35d1_serial.o
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> new file mode 100644
> index 000000000000..8940d07c3777
> --- /dev/null
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -0,0 +1,842 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  MA35D1 serial driver
> + *  Copyright (C) 2023 Nuvoton Technology Corp.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/clk.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/nmi.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +#include <asm/serial.h>
> +#include "ma35d1_serial.h"
> +
> +#define UART_NR			17
> +
> +static struct uart_driver ma35d1serial_reg;
> +struct clk *clk;
> +
> +struct uart_ma35d1_port {
> +	struct uart_port port;
> +	u16 capabilities; /* port capabilities */
> +	u8 ier;
> +	u8 lcr;
> +	u8 mcr;
> +	u8 mcr_mask;   /* mask of user bits */
> +	u8 mcr_force;  /* mask of forced bits */
> +	struct serial_rs485 rs485; /* rs485 settings */
> +	u32 baud_rate;
> +	int rx_count;
> +	u32 console_baud_rate;
> +	u32 console_line;
> +	u32 console_int;
> +};
> +
> +static struct device_node *ma35d1serial_uart_nodes[UART_NR];
> +static struct uart_ma35d1_port ma35d1serial_ports[UART_NR] = { 0 };
> +static void __stop_tx(struct uart_ma35d1_port *p);
> +static void transmit_chars(struct uart_ma35d1_port *up);

Try to rearrange such that forward declarations are not necessary for 
functions.

> +static struct uart_ma35d1_port *to_ma35d1_uart_port(struct uart_port *uart)

static inline

> +{
> +	return container_of(uart, struct uart_ma35d1_port, port);
> +}
> +
> +static u32 serial_in(struct uart_ma35d1_port *p, int offset)
> +{
> +	return __raw_readl(p->port.membase + offset);
> +}
> +
> +static void serial_out(struct uart_ma35d1_port *p, int offset, int value)
> +{
> +	__raw_writel(value, p->port.membase + offset);
> +}
> +
> +static void __stop_tx(struct uart_ma35d1_port *p)
> +{
> +	u32 ier;
> +
> +	ier = serial_in(p, UART_REG_IER);
> +	if (ier & THRE_IEN)
> +		serial_out(p, UART_REG_IER, ier & ~THRE_IEN);
> +}
> +
> +static void ma35d1serial_stop_tx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +
> +	__stop_tx(up);
> +}
> +
> +static void ma35d1serial_start_tx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	u32 ier;
> +	struct circ_buf *xmit = &up->port.state->xmit;
> +
> +	ier = serial_in(up, UART_REG_IER);
> +	serial_out(up, UART_REG_IER, ier & ~THRE_IEN);
> +	if (uart_circ_chars_pending(xmit) <
> +	    (16 - ((serial_in(up, UART_REG_FSR) >> 16) & 0x3F)))
> +		transmit_chars(up);
> +	serial_out(up, UART_REG_IER, ier | THRE_IEN);
> +}
> +
> +static void ma35d1serial_stop_rx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +
> +	serial_out(up, UART_REG_IER, serial_in(up, UART_REG_IER) & ~RDA_IEN);
> +}
> +
> +static void
> +receive_chars(struct uart_ma35d1_port *up)
> +{
> +	u8 ch;
> +	u32 fsr;
> +	u32 isr;
> +	u32 dcnt;
> +	char flag;
> +
> +	isr = serial_in(up, UART_REG_ISR);
> +	fsr = serial_in(up, UART_REG_FSR);
> +
> +	while (!(fsr & RX_EMPTY)) {
> +		flag = TTY_NORMAL;
> +		up->port.icount.rx++;
> +
> +		if (unlikely(fsr & (BIF | FEF | PEF | RX_OVER_IF))) {
> +			if (fsr & BIF) {
> +				serial_out(up, UART_REG_FSR, BIF);
> +				up->port.icount.brk++;
> +				if (uart_handle_break(&up->port))
> +					continue;
> +			}
> +			if (fsr & FEF) {
> +				serial_out(up, UART_REG_FSR, FEF);
> +				up->port.icount.frame++;
> +			}
> +			if (fsr & PEF) {
> +				serial_out(up, UART_REG_FSR, PEF);
> +				up->port.icount.parity++;
> +			}
> +			if (fsr & RX_OVER_IF) {
> +				serial_out(up, UART_REG_FSR, RX_OVER_IF);
> +				up->port.icount.overrun++;
> +			}

Do you need to write each of those individually to clear(?) them or could 
you just do one write here after the accounting is done:
			serial_out(up, UART_REG_FSR, fsr & (BIF|FEF|PEF|RX_OVER_IF));
?

Also, add some driver specific prefix for the flag naming (all driver 
specific ones, not just these if you have others besides these).


> +			if (fsr & BIF)
> +				flag = TTY_BREAK;
> +			if (fsr & PEF)
> +				flag = TTY_PARITY;
> +			if (fsr & FEF)
> +				flag = TTY_FRAME;

Are you sure this is the right prioritization or do you perhaps want else 
ifs like in some other serial drivers?

> +		}
> +		ch = (u8)serial_in(up, UART_REG_RBR);

Drop the case.

> +		if (uart_handle_sysrq_char(&up->port, ch))
> +			continue;
> +
> +		uart_insert_char(&up->port, fsr, RX_OVER_IF, ch, flag);
> +		up->rx_count++;
> +		dcnt = (serial_in(up, UART_REG_FSR) >> 8) & 0x3f;
> +		if (up->rx_count > 1023) {
> +			spin_lock(&up->port.lock);
> +			tty_flip_buffer_push(&up->port.state->port);
> +			spin_unlock(&up->port.lock);
> +			up->rx_count = 0;

Why is all this ->rx_count trickery necessary? What's so special with the 
size in question?

> +			if ((isr & RXTO_IF) && (dcnt == 0))
> +				goto tout_end;
> +		}
> +		if (isr & RDA_IF) {
> +			if (dcnt == 1)

Merge to the same comdition.

dcnt could probably have a more descriptive name.

> +				return;
> +		}
> +		fsr = serial_in(up, UART_REG_FSR);
> +	}
> +	spin_lock(&up->port.lock);
> +	tty_flip_buffer_push(&up->port.state->port);
> +	spin_unlock(&up->port.lock);
> +tout_end:
> +	up->rx_count = 0;
> +}
> +
> +static void transmit_chars(struct uart_ma35d1_port *up)
> +{
> +	struct circ_buf *xmit = &up->port.state->xmit;
> +	int count = 16 - ((serial_in(up, UART_REG_FSR) >> 16) & 0xF);
> +
> +	if (serial_in(up, UART_REG_FSR) & TX_FULL)
> +		count = 0;
> +	if (up->port.x_char) {
> +		serial_out(up, UART_REG_THR, up->port.x_char);
> +		up->port.icount.tx++;
> +		up->port.x_char = 0;
> +		return;
> +	}
> +	if (uart_tx_stopped(&up->port)) {
> +		ma35d1serial_stop_tx(&up->port);
> +		return;
> +	}
> +	if (uart_circ_empty(xmit)) {
> +		__stop_tx(up);
> +		return;
> +	}
> +	while (count > 0) {
> +		serial_out(up, UART_REG_THR, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		up->port.icount.tx++;
> +		count--;
> +		if (uart_circ_empty(xmit))
> +			break;
> +	}
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&up->port);
> +	if (uart_circ_empty(xmit))
> +		__stop_tx(up);
> +}
> +
> +static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)dev_id;
> +	u32 isr, fsr;
> +
> +	isr = serial_in(up, UART_REG_ISR);
> +	fsr = serial_in(up, UART_REG_FSR);
> +	if (isr & (RDA_IF | RXTO_IF))
> +		receive_chars(up);
> +	if (isr & THRE_INT)
> +		transmit_chars(up);
> +	if (fsr & (BIF | FEF | PEF | RX_OVER_IF | TX_OVER_IF))
> +		serial_out(up, UART_REG_FSR,
> +			   (BIF | FEF | PEF | RX_OVER_IF | TX_OVER_IF));

Hmm... Why write these again here... Didn't receive_chars() already 
clear(?) most of these bits??

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 ma35d1serial_tx_empty(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	u32 fsr;
> +
> +	fsr = serial_in(up, UART_REG_FSR);
> +	return (fsr & (TE_FLAG | TX_EMPTY)) == (TE_FLAG | TX_EMPTY) ?
> +		TIOCSER_TEMT : 0;
> +}
> +
> +static u32 ma35d1serial_get_mctrl(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	u32 status;
> +	u32 ret = 0;
> +
> +	status = serial_in(up, UART_REG_MSR);
> +	if (!(status & 0x10))
> +		ret |= TIOCM_CTS;
> +	return ret;
> +}
> +
> +static void ma35d1serial_set_mctrl(struct uart_port *port, u32 mctrl)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	u32 mcr = 0;
> +	u32 ier = 0;
> +
> +	if (mctrl & TIOCM_RTS) {
> +		/* set RTS high level trigger */
> +		mcr = serial_in(up, UART_REG_MCR);
> +		mcr |= 0x200;
> +		mcr &= ~(0x2);
> +	}
> +	if (up->mcr & UART_MCR_AFE) {
> +		/* set RTS high level trigger */
> +		mcr = serial_in(up, UART_REG_MCR);
> +		mcr |= 0x200;
> +		mcr &= ~(0x2);
> +
> +		/* enable CTS/RTS auto-flow control */
> +		serial_out(up, UART_REG_IER,
> +			   (serial_in(up, UART_REG_IER) | (0x3000)));

Once you have named the bits probably with defines, most of the comments 
such as the one above are rendered redundant and should be dropped.

> +
> +		/* Set hardware flow control */
> +		up->port.flags |= UPF_HARD_FLOW;
> +	} else {
> +		/* disable CTS/RTS auto-flow control */
> +		ier = serial_in(up, UART_REG_IER);
> +		ier &= ~(0x3000);
> +		serial_out(up, UART_REG_IER, ier);
> +
> +		/* un-set hardware flow control */
> +		up->port.flags &= ~UPF_HARD_FLOW;
> +	}
> +
> +	/* set CTS high level trigger */
> +	serial_out(up, UART_REG_MSR, (serial_in(up, UART_REG_MSR) | (0x100)));
> +	serial_out(up, UART_REG_MCR, mcr);
> +}
> +
> +static void ma35d1serial_break_ctl(struct uart_port *port, int break_state)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	unsigned long flags;
> +	u32 lcr;
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	lcr = serial_in(up, UART_REG_LCR);
> +	if (break_state != 0)
> +		lcr |= BCB; /* set break */
> +	else
> +		lcr &= ~BCB; /* clr break */

While BCB might come from HW naming, a better name for would make these 
very obvious (and the comments unnecessary).

> +	serial_out(up, UART_REG_LCR, lcr);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static int ma35d1serial_startup(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	struct tty_struct *tty = port->state->port.tty;
> +	int retval;
> +
> +	/* Reset FIFO */
> +	serial_out(up, UART_REG_FCR, TFR | RFR /* | RX_DIS */);
> +
> +	/* Clear pending interrupts */
> +	serial_out(up, UART_REG_ISR, 0xFFFFFFFF);

~0 is another option.

> +
> +	retval = request_irq(port->irq, ma35d1serial_interrupt, 0,
> +			     tty ? tty->name : "ma35d1_serial", port);

Why such exceptional name trickery?

> +	if (retval) {
> +		dev_err(up->port.dev, "request irq failed.\n");
> +		return retval;
> +	}
> +
> +	/* Now, initialize the UART */
> +	/* FIFO trigger level 4 byte */
> +	/* RTS trigger level 8 bytes */
> +	serial_out(up, UART_REG_FCR,
> +		   serial_in(up, UART_REG_FCR) | 0x10 | 0x20000);
> +	serial_out(up, UART_REG_LCR, 0x7); /* 8 bit */
> +	serial_out(up, UART_REG_TOR, 0x40);
> +	serial_out(up, UART_REG_IER,
> +		   RTO_IEN | RDA_IEN | TIME_OUT_EN | BUFERR_IEN);
> +	return 0;
> +}
> +
> +static void ma35d1serial_shutdown(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +
> +	free_irq(port->irq, port);
> +
> +	/* Disable interrupts from this port */
> +	serial_out(up, UART_REG_IER, 0);
> +}
> +
> +static u32 ma35d1serial_get_divisor(struct uart_port *port, u32 baud)
> +{
> +	u32 quot;
> +
> +	quot = (port->uartclk / baud) - 2;

Unnecessary parenthesis. (+Somebody already commented about the 
unnecessary variable.)

> +	return quot;
> +}
> +
> +static void ma35d1serial_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     const struct ktermios *old)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +	u32 lcr = 0;
> +	unsigned long flags;
> +	u32 baud, quot;
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		lcr = 0;
> +		break;
> +	case CS6:
> +		lcr |= 1;
> +		break;
> +	case CS7:
> +		lcr |= 2;
> +		break;
> +	case CS8:
> +	default:
> +		lcr |= 3;
> +		break;
> +	}
> +
> +	if (termios->c_cflag & CSTOPB)
> +		lcr |= NSB;
> +	if (termios->c_cflag & PARENB)
> +		lcr |= PBE;
> +	if (!(termios->c_cflag & PARODD))
> +		lcr |= EPE;
> +	if (termios->c_cflag & CMSPAR)
> +		lcr |= SPE;
> +
> +	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 0xffff,
> +				  port->uartclk / 11);
> +
> +	quot = ma35d1serial_get_divisor(port, baud);
> +
> +	/*
> +	 * Ok, we're now changing the port state.  Do it with
> +	 * interrupts disabled.
> +	 */
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	up->port.read_status_mask = RX_OVER_IF;
> +	if (termios->c_iflag & INPCK)
> +		up->port.read_status_mask |= FEF | PEF;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		up->port.read_status_mask |= BIF;
> +
> +	/*
> +	 * Characteres to ignore
> +	 */
> +	up->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		up->port.ignore_status_mask |= FEF | PEF;
> +	if (termios->c_iflag & IGNBRK) {
> +		up->port.ignore_status_mask |= BIF;
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			up->port.ignore_status_mask |= RX_OVER_IF;
> +	}
> +	if (termios->c_cflag & CRTSCTS)
> +		up->mcr |= UART_MCR_AFE;
> +	else
> +		up->mcr &= ~UART_MCR_AFE;
> +
> +	ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
> +	serial_out(up, UART_REG_BAUD, quot | 0x30000000);
> +	serial_out(up, UART_REG_LCR, lcr);

You need to do uart_update_timeout() in the set_termios function.

> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static void ma35d1serial_release_port(struct uart_port *port)
> +{
> +	iounmap(port->membase);
> +	port->membase = NULL;
> +}
> +
> +static int ma35d1serial_request_port(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
> +{
> +	int ret;
> +
> +	/*
> +	 * Find the region that we can probe for.  This in turn
> +	 * tells us whether we can probe for the type of port.
> +	 */
> +	ret = ma35d1serial_request_port(port);
> +	if (ret < 0)
> +		return;
> +	port->type = PORT_MA35D1;
> +}
> +
> +static int ma35d1serial_verify_port(struct uart_port *port,
> +				    struct serial_struct *ser)
> +{
> +	if (ser->type != PORT_UNKNOWN && ser->type != PORT_MA35D1)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static const char *ma35d1serial_type(struct uart_port *port)
> +{
> +	return (port->type == PORT_MA35D1) ? "MA35D1" : NULL;
> +}
> +
> +/* Enable or disable the rs485 support */
> +static int ma35d1serial_config_rs485(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     struct serial_rs485 *rs485conf)
> +{
> +	struct uart_ma35d1_port *p = to_ma35d1_uart_port(port);
> +
> +	p->rs485 = *rs485conf;
> +
> +	if (p->rs485.delay_rts_before_send >= 1000)
> +		p->rs485.delay_rts_before_send = 1000;

Don't do this in driver, the core handles the delay limits. You don't seem 
to be using the value anyway for anything???

Please separate the RS485 support into its own patch.

> +	serial_out(p, UART_FUN_SEL,
> +		   (serial_in(p, UART_FUN_SEL) & ~FUN_SEL_MASK));
> +
> +	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		serial_out(p, UART_FUN_SEL,
> +			   (serial_in(p, UART_FUN_SEL) | FUN_SEL_RS485));

Does this pair of serial_out()s glitch the RS485 line if ->rs485_config() 
is called while RS485 mode is already set?

Why you need to do serial_in() from the UART_FUN_SEL twice?

> +
> +		if (rs485conf->flags & SER_RS485_RTS_ON_SEND)
> +			serial_out(p, UART_REG_MCR,
> +				   (serial_in(p, UART_REG_MCR) & ~0x200));
> +		else
> +			serial_out(p, UART_REG_MCR,
> +				   (serial_in(p, UART_REG_MCR) | 0x200));
> +
> +		/* set auto direction mode */
> +		serial_out(p, UART_REG_ALT_CSR,
> +			   (serial_in(p, UART_REG_ALT_CSR) | (1 << 10)));
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_ioctl(struct uart_port *port, u32 cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +	return 0;
> +}
> +
> +static const struct uart_ops ma35d1serial_ops = {
> +	.tx_empty     = ma35d1serial_tx_empty,
> +	.set_mctrl    = ma35d1serial_set_mctrl,
> +	.get_mctrl    = ma35d1serial_get_mctrl,
> +	.stop_tx      = ma35d1serial_stop_tx,
> +	.start_tx     = ma35d1serial_start_tx,
> +	.stop_rx      = ma35d1serial_stop_rx,
> +	.break_ctl    = ma35d1serial_break_ctl,
> +	.startup      = ma35d1serial_startup,
> +	.shutdown     = ma35d1serial_shutdown,
> +	.set_termios  = ma35d1serial_set_termios,
> +	.type         = ma35d1serial_type,
> +	.release_port = ma35d1serial_release_port,
> +	.request_port = ma35d1serial_request_port,
> +	.config_port  = ma35d1serial_config_port,
> +	.verify_port  = ma35d1serial_verify_port,
> +	.ioctl        = ma35d1serial_ioctl,
> +};
> +
> +static const struct of_device_id ma35d1_serial_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-uart" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_serial_of_match);
> +
> +#ifdef CONFIG_SERIAL_NUVOTON_MA35D1_CONSOLE
> +
> +static void ma35d1serial_console_putchar(struct uart_port *port,
> +					 unsigned char ch)
> +{
> +	struct uart_ma35d1_port *up = (struct uart_ma35d1_port *)port;
> +
> +	do {
> +	} while ((serial_in(up, UART_REG_FSR) & TX_FULL));
> +	serial_out(up, UART_REG_THR, ch);
> +}
> +
> +/*
> + *  Print a string to the serial port trying not to disturb
> + *  any possible real use of the port...
> + *
> + *  The console_lock must be held when we get here.
> + */
> +static void ma35d1serial_console_write(struct console *co,
> +				       const char *s, u32 count)
> +{
> +	struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
> +	unsigned long flags;
> +	u32 ier;
> +
> +	local_irq_save(flags);
> +
> +	/*
> +	 *  First save the IER then disable the interrupts
> +	 */
> +	ier = serial_in(up, UART_REG_IER);
> +	serial_out(up, UART_REG_IER, 0);
> +
> +	uart_console_write(&up->port, s, count, ma35d1serial_console_putchar);
> +
> +	/*
> +	 *  Finally, wait for transmitter to become empty
> +	 *  and restore the IER
> +	 */
> +	do {
> +	} while (!(serial_in(up, UART_REG_FSR) & TX_EMPTY));
> +	serial_out(up, UART_REG_IER, ier);
> +	local_irq_restore(flags);
> +}
> +
> +static int __init ma35d1serial_console_setup(struct console *co,
> +					     char *options)
> +{
> +	struct device_node *np = ma35d1serial_uart_nodes[co->index];
> +	struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
> +	u32 val32[4];
> +	struct uart_port *port;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';
> +
> +	/*
> +	 * Check whether an invalid uart number has been specified, and
> +	 * if so, search for the first available port that does have
> +	 * console support.
> +	 */
> +	if ((co->index < 0) || (co->index >= UART_NR)) {
> +		pr_debug("Console Port%x out of range\n", co->index);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
> +		return -EINVAL;
> +	p->port.iobase = val32[1];
> +	p->port.membase = ioremap(p->port.iobase, 0x10000);
> +	p->port.ops = &ma35d1serial_ops;
> +	p->port.line = 0;
> +	p->port.uartclk = 24000000;
> +
> +	port = &ma35d1serial_ports[co->index].port;
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct console ma35d1serial_console = {
> +	.name    = "ttyS",
> +	.write   = ma35d1serial_console_write,
> +	.device  = uart_console_device,
> +	.setup   = ma35d1serial_console_setup,
> +	.flags   = CON_PRINTBUFFER | CON_ENABLED,
> +	.index   = -1,
> +	.data    = &ma35d1serial_reg,
> +};
> +
> +static void
> +ma35d1serial_console_init_port(void)
> +{
> +	int i = 0;
> +	struct device_node *np;
> +
> +	for_each_matching_node(np, ma35d1_serial_of_match) {
> +		if (ma35d1serial_uart_nodes[i] == NULL) {
> +			ma35d1serial_uart_nodes[i] = np;
> +			i++;
> +		}
> +	}
> +}
> +
> +static int __init ma35d1serial_console_init(void)
> +{
> +	ma35d1serial_console_init_port();
> +	register_console(&ma35d1serial_console);
> +	return 0;
> +}
> +console_initcall(ma35d1serial_console_init);
> +
> +#define MA35D1SERIAL_CONSOLE    (&ma35d1serial_console)
> +#else
> +#define MA35D1SERIAL_CONSOLE    NULL
> +#endif
> +
> +static struct uart_driver ma35d1serial_reg = {
> +	.owner        = THIS_MODULE,
> +	.driver_name  = "serial",
> +	.dev_name     = "ttyS",
> +	.major        = TTY_MAJOR,
> +	.minor        = 64,
> +	.cons         = MA35D1SERIAL_CONSOLE,
> +	.nr           = UART_NR,
> +};
> +
> +/**
> + *  Suspend one serial port.
> + */
> +void ma35d1serial_suspend_port(int line)
> +{
> +	uart_suspend_port(&ma35d1serial_reg, &ma35d1serial_ports[line].port);
> +}
> +EXPORT_SYMBOL(ma35d1serial_suspend_port);
> +
> +/**
> + *  Resume one serial port.
> + */
> +void ma35d1serial_resume_port(int line)
> +{
> +	struct uart_ma35d1_port *up = &ma35d1serial_ports[line];
> +
> +	uart_resume_port(&ma35d1serial_reg, &up->port);
> +}
> +EXPORT_SYMBOL(ma35d1serial_resume_port);
> +
> +/*
> + * Register a set of serial devices attached to a platform device.
> + * The list is terminated with a zero flags entry, which means we expect
> + * all entries to have at least UPF_BOOT_AUTOCONF set.
> + */
> +static int ma35d1serial_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_ma35d1_port *up;
> +	int ret;
> +	struct clk *clk;
> +	int err;
> +
> +	if (pdev->dev.of_node) {
> +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get alias/pdev id, errno %d\n",
> +				ret);

Just put error prints to one line if you don't break 100 chars limit.

> +		return ret;

Misaligned line.

> +		}
> +	}
> +	up = &ma35d1serial_ports[ret];
> +	up->port.line = ret;
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_mem)
> +		return -ENODEV;
> +
> +	up->port.iobase = res_mem->start;
> +	up->port.membase = ioremap(up->port.iobase, 0x10000);

Define for the literal.

> +	up->port.ops = &ma35d1serial_ops;
> +
> +	spin_lock_init(&up->port.lock);
> +
> +	clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +		return -ENOENT;
> +	}
> +	err = clk_prepare_enable(clk);
> +	if (err)
> +		return -ENOENT;
> +
> +	if (up->port.line != 0)
> +		up->port.uartclk = clk_get_rate(clk);
> +	up->port.irq = platform_get_irq(pdev, 0);
> +	up->port.dev = &pdev->dev;
> +	up->port.flags = UPF_BOOT_AUTOCONF;
> +	up->port.rs485_config = ma35d1serial_config_rs485;

Please provide also .rs485_supported for the serial core to handle the 
supported features for you.

> +	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
> +	platform_set_drvdata(pdev, up);
> +	return 0;
> +}
> +
> +/*
> + * Remove serial ports registered against a platform device.
> + */
> +static int ma35d1serial_remove(struct platform_device *dev)
> +{
> +	int i;
> +	struct uart_port *port = platform_get_drvdata(dev);
> +
> +	free_irq(port->irq, port);
> +	for (i = 0; i < UART_NR; i++) {
> +		struct uart_ma35d1_port *up = &ma35d1serial_ports[i];
> +
> +		if (up->port.dev == &dev->dev)
> +			uart_remove_one_port(&ma35d1serial_reg, &up->port);
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_suspend(struct platform_device *dev,
> +				pm_message_t state)
> +{
> +	int i;
> +	struct uart_ma35d1_port *up;
> +
> +	if (dev->dev.of_node)
> +		i = of_alias_get_id(dev->dev.of_node, "serial");
> +	if (i < 0) {
> +		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n",
> +			i);

Just put this to the same line with the rest.

> +		return i;
> +	}
> +	up = &ma35d1serial_ports[i];
> +	if (i == 0) {
> +		up->console_baud_rate = serial_in(up, UART_REG_BAUD);
> +		up->console_line = serial_in(up, UART_REG_LCR);
> +		up->console_int = serial_in(up, UART_REG_IER);
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_resume(struct platform_device *dev)
> +{
> +	int i;
> +	struct uart_ma35d1_port *up;
> +
> +	if (dev->dev.of_node)
> +		i = of_alias_get_id(dev->dev.of_node, "serial");
> +	if (i < 0) {
> +		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n",
> +			i);

Same line.

> +		return i;
> +	}
> +	up = &ma35d1serial_ports[i];
> +	if (i == 0) {
> +		serial_out(up, UART_REG_BAUD, up->console_baud_rate);
> +		serial_out(up, UART_REG_LCR, up->console_line);
> +		serial_out(up, UART_REG_IER, up->console_int);
> +	}
> +	return 0;
> +}
> +
> +static struct platform_driver ma35d1serial_driver = {
> +	.probe      = ma35d1serial_probe,
> +	.remove     = ma35d1serial_remove,
> +	.suspend    = ma35d1serial_suspend,
> +	.resume     = ma35d1serial_resume,
> +	.driver     = {
> +		.name   = "ma35d1-uart",
> +		.owner  = THIS_MODULE,
> +		.of_match_table = of_match_ptr(ma35d1_serial_of_match),
> +	},
> +};
> +
> +static int __init ma35d1serial_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&ma35d1serial_reg);
> +	if (ret)
> +		return ret;
> +	ret = platform_driver_register(&ma35d1serial_driver);
> +	if (ret)
> +		uart_unregister_driver(&ma35d1serial_reg);
> +	return ret;
> +}
> +
> +static void __exit ma35d1serial_exit(void)
> +{
> +	platform_driver_unregister(&ma35d1serial_driver);
> +	uart_unregister_driver(&ma35d1serial_reg);
> +}
> +
> +module_init(ma35d1serial_init);
> +module_exit(ma35d1serial_exit);
> +
> +MODULE_LICENSE("GPL v2");

"GPL" is enough for MODULE_LICENSE, the SPDX at the start of file covers 
more specific license variations.

> +MODULE_DESCRIPTION("MA35D1 serial driver");
> +MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
> +
> diff --git a/drivers/tty/serial/ma35d1_serial.h b/drivers/tty/serial/ma35d1_serial.h
> new file mode 100644
> index 000000000000..5fd845c31b29
> --- /dev/null
> +++ b/drivers/tty/serial/ma35d1_serial.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  MA35D1 serial driver header file
> + *  Copyright (C) 2023 Nuvoton Technology Corp.
> + */
> +#ifndef __MA35D1_SERIAL_H__
> +#define __MA35D1_SERIAL_H__
> +
> +/* UART Receive/Transmit Buffer Register */
> +#define UART_REG_RBR	0x00
> +#define UART_REG_THR	0x00
> +
> +/* UART Interrupt Enable Register */
> +#define UART_REG_IER	0x04
> +#define RDA_IEN		0x00000001 /* RBR Available Interrupt Enable */
> +#define THRE_IEN	0x00000002 /* THR Empty Interrupt Enable */
> +#define RLS_IEN		0x00000004 /* RX Line Status Interrupt Enable */
> +#define RTO_IEN		0x00000010 /* RX Time-out Interrupt Enable */
> +#define BUFERR_IEN	0x00000020 /* Buffer Error Interrupt Enable */
> +#define TIME_OUT_EN	0x00000800 /* RX Buffer Time-out Counter Enable */
> +
> +/* UART FIFO Control Register */
> +#define UART_REG_FCR	0x08
> +#define RFR		0x00000002 /* RX Field Software Reset */
> +#define TFR		0x00000004 /* TX Field Software Reset */
> +
> +/* UART Line Control Register */
> +#define UART_REG_LCR	0x0C
> +#define	NSB		0x00000004 /* Number of “STOP Bit” */
> +#define PBE		0x00000008 /* Parity Bit Enable */
> +#define EPE		0x00000010 /* Even Parity Enable */
> +#define SPE		0x00000020 /* Stick Parity Enable */
> +#define BCB		0x00000040 /* Break Control */
> +
> +/* UART Modem Control Register */
> +#define UART_REG_MCR	0x10
> +#define RTS		0x00000020 /* nRTS Signal Control */
> +#define RTSACTLV	0x00000200 /* nRTS Pin Active Level */
> +#define RTSSTS		0x00002000 /* nRTS Pin Status (Read Only) */
> +
> +/* UART Modem Status Register */
> +#define UART_REG_MSR	0x14
> +#define CTSDETF		0x00000001 /* Detect nCTS State Change Flag */
> +#define CTSSTS		0x00000010 /* nCTS Pin Status (Read Only) */
> +#define CTSACTLV	0x00000100 /* nCTS Pin Active Level */
> +
> +/* UART FIFO Status Register */
> +#define UART_REG_FSR	0x18
> +#define RX_OVER_IF	0x00000001 /* RX Overflow Error Interrupt Flag */
> +#define PEF		0x00000010 /* Parity Error Flag*/
> +#define FEF		0x00000020 /* Framing Error Flag */
> +#define BIF		0x00000040 /* Break Interrupt Flag */
> +#define RX_EMPTY	0x00004000 /* Receiver FIFO Empty (Read Only) */
> +#define RX_FULL		0x00008000 /* Receiver FIFO Full (Read Only) */
> +#define TX_EMPTY	0x00400000 /* Transmitter FIFO Empty (Read Only) */
> +#define TX_FULL		0x00800000 /* Transmitter FIFO Full (Read Only) */
> +#define TX_OVER_IF	0x01000000 /* TX Overflow Error Interrupt Flag */
> +#define TE_FLAG		0x10000000 /* Transmitter Empty Flag (Read Only) */
> +
> +/* UART Interrupt Status Register */
> +#define UART_REG_ISR	0x1C
> +#define RDA_IF		0x00000001 /* RBR Available Interrupt Flag */
> +#define THRE_IF		0x00000002 /* THR Empty Interrupt Flag */
> +#define RLSIF		0x00000004 /* Receive Line Interrupt Flag */
> +#define MODEMIF		0x00000008 /* MODEM Interrupt Flag */
> +#define RXTO_IF		0x00000010 /* RX Time-out Interrupt Flag */
> +#define BUFEIF		0x00000020 /* Buffer Error Interrupt Flag */
> +#define WK_IF		0x00000040 /* UART Wake-up Interrupt Flag */
> +#define RDAINT		0x00000100 /* RBR Available Interrupt Indicator */
> +#define THRE_INT	0x00000200 /* THR Empty Interrupt Indicator */
> +
> +/* UART Time-out Register */
> +#define UART_REG_TOR	0x20
> +
> +/* UART Baud Rate Divider Register */
> +#define UART_REG_BAUD	0x24
> +
> +/* UART Alternate Control/Status Register */
> +#define UART_REG_ALT_CSR 0x2C
> +
> +/* UART Function Select Register */
> +#define UART_FUN_SEL	0x30
> +#define FUN_SEL_UART	0x00000000
> +#define FUN_SEL_RS485	0x00000003
> +#define FUN_SEL_MASK	0x00000007

GENMASK(), then use FIELD_PREP() for the values. 

> +
> +/* UART Wake-up Control Register */
> +#define UART_REG_WKCTL	0x40
> +
> +/* UART Wake-up Status Register */
> +#define UART_REG_WKSTS	0x44
> +
> +#endif /* __MA35D1_SERIAL_H__ */
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 281fa286555c..c6d53db17042 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -279,4 +279,7 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Nuvoton MA35D1 UART */
> +#define PORT_MA35D1	124
> +
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> 

-- 
 i.
--8323329-688001410-1678975832=:2328--
