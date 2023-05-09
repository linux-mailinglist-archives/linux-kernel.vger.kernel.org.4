Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD46FC3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjEIKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjEIKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:17:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D654D07E;
        Tue,  9 May 2023 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683627454; x=1715163454;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=k1RGquzdiXpIzje30n1OWxw+cdkgeVK4Fv2mqqks1k0=;
  b=k6dx2qm/+OaSiHZGY45fd0xS0FW0GWBO73Z7AFLUfRe5dADJ/6wxD0BT
   WpMClzl4UaBHD4TEXLcwRUHXhSgjadj/3gzX0pff33j+IutZ/MprsPxsR
   P0YVIF5ZVBwn5PgSdiePw4axD6mQSeeyiGlS9zlFn+C87J33qbO44Bfi7
   4uw+4NP0Ijf0wgT65ydsav0oc7O2HQDBoxgPcAdZFAT8sTCQRXbgZZyhu
   BB9Du/eEkPTk5UKs5qtQh6CR4Nc7mNyY6VODkd/3eIdmxShCE5VkT6cMb
   d//30a8ukFT0Q2PhAK+m19wlGs39c97gRshs3B4JIgJF9fciztfg67zKE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329511379"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="329511379"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 03:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="676412030"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="676412030"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 03:17:27 -0700
Date:   Tue, 9 May 2023 13:17:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v10 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230508025936.36776-11-ychuang570808@gmail.com>
Message-ID: <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com> <20230508025936.36776-11-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-785755061-1683544159=:1790"
Content-ID: <3fb88577-aee-9a89-2aff-59718aca137@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-785755061-1683544159=:1790
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <7ef3bf6e-edbd-049-4a5f-9d77e6a11825@linux.intel.com>

On Mon, 8 May 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> It supports full-duplex communication, FIFO control, and
> hardware flow control.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/tty/serial/Kconfig         |  18 +
>  drivers/tty/serial/Makefile        |   1 +
>  drivers/tty/serial/ma35d1_serial.c | 796 +++++++++++++++++++++++++++++
>  3 files changed, 815 insertions(+)
>  create mode 100644 drivers/tty/serial/ma35d1_serial.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 398e5aac2e77..85ac6fc1ff1d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1555,6 +1555,24 @@ config SERIAL_SUNPLUS_CONSOLE
>  	  you can alter that using a kernel command line option such as
>  	  "console=ttySUPx".
>  
> +config SERIAL_NUVOTON_MA35D1
> +	tristate "Nuvoton MA35D1 family UART support"
> +	depends on ARCH_MA35 || COMPILE_TEST
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
> index cd9afd9e3018..0e823851c42c 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
>  
>  obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
>  obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
> +obj-$(CONFIG_SERIAL_NUVOTON_MA35D1) += ma35d1_serial.o
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> new file mode 100644
> index 000000000000..4eca34ba01c9
> --- /dev/null
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -0,0 +1,796 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  MA35D1 serial driver
> + *  Copyright (C) 2023 Nuvoton Technology Corp.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty_flip.h>
> +
> +#define UART_NR			17
> +
> +#define UART_REG_RBR		0x00
> +#define UART_REG_THR		0x00
> +#define UART_REG_IER		0x04
> +#define UART_REG_FCR		0x08
> +#define UART_REG_LCR		0x0C
> +#define UART_REG_MCR		0x10

These duplicate include/uapi/linux/serial_reg.h ones, use the std ones 
directly.

Setup regshift too and use it in serial_in.

> +#define UART_REG_MSR		0x14
> +#define UART_REG_FSR		0x18
> +#define UART_REG_ISR		0x1C
> +#define UART_REG_TOR		0x20
> +#define UART_REG_BAUD		0x24
> +#define UART_REG_ALTCTL		0x2C
> +#define UART_FUN_SEL		0x30
> +#define UART_REG_WKCTL		0x40
> +#define UART_REG_WKSTS		0x44

It would be better to prefix HW specific defines with something HW related 
such as MA35D1. This applies to most of the below ones too:

> +/* UART_REG_IER - Interrupt Enable Register */
> +#define IER_RDA_IEN		BIT(0)  /* RBR Available Interrupt Enable */
> +#define IER_THRE_IEN		BIT(1)  /* THR Empty Interrupt Enable */
> +#define IER_RLS_IEN		BIT(2)  /* RX Line Status Interrupt Enable */

These look same as UART_IER bits, use the std ones.

> +#define IER_RTO_IEN		BIT(4)  /* RX Time-out Interrupt Enable */
> +#define IER_BUFERR_IEN		BIT(5)  /* Buffer Error Interrupt Enable */
> +#define IER_TIME_OUT_EN		BIT(11) /* RX Buffer Time-out Counter Enable */
> +#define IER_AUTO_RTS		BIT(12) /* nRTS Auto-flow Control Enable */
> +#define IER_AUTO_CTS		BIT(13) /* nCTS Auto-flow Control Enable */
> +
> +/* UART_REG_FCR - FIFO Control Register */
> +#define FCR_RFR			BIT(1)  /* RX Field Software Reset */
> +#define FCR_TFR			BIT(2)  /* TX Field Software Reset */

Are these same as UART_FCR_CLEAR_* functionality wise? If they're use std 
ones.

> +#define FCR_RFITL_MASK		GENMASK(7, 4) /* RX FIFO Interrupt Trigger Level */
> +#define FCR_RFITL_1BYTE		FIELD_PREP(FCR_RFITL_MASK, 0)
> +#define FCR_RFITL_4BYTES	FIELD_PREP(FCR_RFITL_MASK, 1)
> +#define FCR_RFITL_8BYTES	FIELD_PREP(FCR_RFITL_MASK, 2)
> +#define FCR_RFITL_14BYTES	FIELD_PREP(FCR_RFITL_MASK, 3)
> +#define FCR_RFITL_30BYTES	FIELD_PREP(FCR_RFITL_MASK, 4)
> +#define FCR_RTSTRGLV_MASK	GENMASK(19, 16) /* nRTS Trigger Level */
> +#define FCR_RTSTRGLV_1BYTE	FIELD_PREP(FCR_RTSTRGLV_MASK, 0)
> +#define FCR_RTSTRGLV_4BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 1)
> +#define FCR_RTSTRGLV_8BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 2)
> +#define FCR_RTSTRGLV_14BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 3)
> +#define FCR_RTSTRGLVL_30BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 4)
> +
> +/* UART_REG_LCR - Line Control Register */
> +#define	LCR_NSB			BIT(2) /* Number of “STOP Bit” */
> +#define LCR_PBE			BIT(3) /* Parity Bit Enable */
> +#define LCR_EPE			BIT(4) /* Even Parity Enable */
> +#define LCR_SPE			BIT(5) /* Stick Parity Enable */
> +#define LCR_BREAK		BIT(6) /* Break Control */
> +#define LCR_WLS_MASK		GENMASK(1, 0) /* Word Length Selection */
> +#define LCR_WLS_5BITS		FIELD_PREP(LCR_WLS_MASK, 0)
> +#define LCR_WLS_6BITS		FIELD_PREP(LCR_WLS_MASK, 1)
> +#define LCR_WLS_7BITS		FIELD_PREP(LCR_WLS_MASK, 2)
> +#define LCR_WLS_8BITS		FIELD_PREP(LCR_WLS_MASK, 3)

These look exact copies of UART_LCR_* bits.

> +/* UART_REG_MCR - Modem Control Register */
> +#define MCR_RTS_CTRL		BIT(1)  /* nRTS Signal Control */

Is this same as UART_MCR_RTS?

> +#define MCR_RTSACTLV		BIT(9)  /* nRTS Pin Active Level */
> +#define MCR_RTSSTS		BIT(13) /* nRTS Pin Status (Read Only) */
> +
> +/* UART_REG_MSR - Modem Status Register */
> +#define MSR_CTSDETF		BIT(0)  /* Detect nCTS State Change Flag */
> +#define MSR_CTSSTS		BIT(4)  /* nCTS Pin Status (Read Only) */
> +#define MSR_CTSACTLV		BIT(8)  /* nCTS Pin Active Level */
> +
> +/* UART_REG_FSR - FIFO Status Register */
> +#define FSR_RX_OVER_IF		BIT(0)  /* RX Overflow Error Interrupt Flag */
> +#define FSR_PEF			BIT(4)  /* Parity Error Flag*/
> +#define FSR_FEF			BIT(5)  /* Framing Error Flag */
> +#define FSR_BIF			BIT(6)  /* Break Interrupt Flag */
> +#define FSR_RX_EMPTY		BIT(14) /* Receiver FIFO Empty (Read Only) */
> +#define FSR_RX_FULL		BIT(15) /* Receiver FIFO Full (Read Only) */
> +#define FSR_TX_EMPTY		BIT(22) /* Transmitter FIFO Empty (Read Only) */
> +#define FSR_TX_FULL		BIT(23) /* Transmitter FIFO Full (Read Only) */
> +#define FSR_TX_OVER_IF		BIT(24) /* TX Overflow Error Interrupt Flag */
> +#define FSR_TE_FLAG		BIT(28) /* Transmitter Empty Flag (Read Only) */
> +#define FSR_RXPTR_MSK		GENMASK(13, 8) /* TX FIFO Pointer mask */
> +#define FSR_TXPTR_MSK		GENMASK(21, 16) /* RX FIFO Pointer mask */
> +
> +/* UART_REG_ISR - Interrupt Status Register */
> +#define ISR_RDA_IF		BIT(0) /* RBR Available Interrupt Flag */
> +#define ISR_THRE_IF		BIT(1) /* THR Empty Interrupt Flag */
> +#define ISR_RLSIF		BIT(2) /* Receive Line Interrupt Flag */
> +#define ISR_MODEMIF		BIT(3) /* MODEM Interrupt Flag */
> +#define ISR_RXTO_IF		BIT(4) /* RX Time-out Interrupt Flag */
> +#define ISR_BUFEIF		BIT(5) /* Buffer Error Interrupt Flag */
> +#define UART_ISR_WK_IF		BIT(6) /* UART Wake-up Interrupt Flag */
> +#define UART_ISR_RDAINT		BIT(8) /* RBR Available Interrupt Indicator */
> +#define ISR_THRE_INT		BIT(9) /* THR Empty Interrupt Indicator */
> +#define ISR_ALL			0xFFFFFFFF
> +
> +/* UART_REG_BAUD - Baud Rate Divider Register */
> +#define	BAUD_MODE_MASK		GENMASK(29, 28)
> +#define BAUD_MODE0		FIELD_PREP(BAUD_MODE_MASK, 0)
> +#define BAUD_MODE1		FIELD_PREP(BAUD_MODE_MASK, 2)
> +#define BAUD_MODE2		FIELD_PREP(BAUD_MODE_MASK, 3)
> +
> +/* UART_REG_ALTCTL - Alternate Control/Status Register */
> +#define ALTCTL_RS485AUD		BIT(10) /* RS-485 Auto Direction Function */
> +
> +/* UART_FUN_SEL - Function Select Register */
> +#define FUN_SEL_MASK		GENMASK(2, 0)
> +#define FUN_SEL_UART		FIELD_PREP(FUN_SEL_MASK, 0)
> +#define FUN_SEL_RS485		FIELD_PREP(FUN_SEL_MASK, 3)
> +
> +/* UART FIFO depth */
> +#define UART_FIFO_DEPTH		32
> +/* UART console clock */
> +#define UART_CONSOLE_CLK	24000000

* HZ_PER_MHZ ?

> +/* UART register ioremap size */
> +#define UART_REG_SIZE		0x100
> +/* Rx Timeout */
> +#define UART_RX_TOUT		0x40
> +
> +#define UART_ISR_IF_CHECK (ISR_RDA_IF | ISR_RXTO_IF | ISR_THRE_INT | ISR_BUFEIF)
> +
> +#define LOOP_TIMEOUT		1000

Unused.

> +static struct uart_driver ma35d1serial_reg;
> +
> +struct uart_ma35d1_port {
> +	struct uart_port port;
> +	struct clk *clk;
> +	u16 capabilities; /* port capabilities */
> +	u8 ier;
> +	u8 lcr;
> +	u8 mcr;
> +	u32 baud_rate;
> +	u32 console_baud_rate;
> +	u32 console_line;
> +	u32 console_int;
> +};
> +
> +static struct uart_ma35d1_port ma35d1serial_ports[UART_NR];
> +
> +static struct uart_ma35d1_port *to_ma35d1_uart_port(struct uart_port *uart)
> +{
> +	return container_of(uart, struct uart_ma35d1_port, port);
> +}
> +
> +static u32 serial_in(struct uart_ma35d1_port *p, u32 offset)
> +{
> +	return readl_relaxed(p->port.membase + offset);
> +}
> +
> +static void serial_out(struct uart_ma35d1_port *p, u32 offset, u32 value)
> +{
> +	writel_relaxed(value, p->port.membase + offset);
> +}
> +
> +static void __stop_tx(struct uart_ma35d1_port *p)
> +{
> +	u32 ier;
> +
> +	ier = serial_in(p, UART_REG_IER);
> +	if (ier & IER_THRE_IEN)
> +		serial_out(p, UART_REG_IER, ier & ~IER_THRE_IEN);
> +}
> +
> +static void ma35d1serial_stop_tx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	__stop_tx(up);
> +}
> +
> +static void transmit_chars(struct uart_ma35d1_port *up)
> +{
> +	u32 count;
> +	u8 ch;
> +
> +	if (uart_tx_stopped(&up->port)) {
> +		ma35d1serial_stop_tx(&up->port);
> +		return;
> +	}
> +	count = UART_FIFO_DEPTH - FIELD_GET(FSR_TXPTR_MSK, serial_in(up, UART_REG_FSR));
> +	uart_port_tx_limited(&up->port, ch, count,
> +			     !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
> +			     serial_out(up, UART_REG_THR, ch),
> +			     ({}));
> +}
> +
> +static void ma35d1serial_start_tx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 ier;
> +
> +	ier = serial_in(up, UART_REG_IER);
> +	serial_out(up, UART_REG_IER, ier & ~IER_THRE_IEN);
> +	transmit_chars(up);
> +	serial_out(up, UART_REG_IER, ier | IER_THRE_IEN);
> +}
> +
> +static void ma35d1serial_stop_rx(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	serial_out(up, UART_REG_IER, serial_in(up, UART_REG_IER) & ~IER_RDA_IEN);
> +}
> +
> +static void receive_chars(struct uart_ma35d1_port *up)
> +{
> +	u8 ch, flag;
> +	u32 fsr;
> +	int max_count = 256;
> +
> +	fsr = serial_in(up, UART_REG_FSR);
> +	do {
> +		flag = TTY_NORMAL;
> +		up->port.icount.rx++;
> +
> +		if (unlikely(fsr & (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF))) {
> +			if (fsr & FSR_BIF) {
> +				up->port.icount.brk++;
> +				if (uart_handle_break(&up->port))
> +					continue;
> +			}
> +			if (fsr & FSR_FEF)
> +				up->port.icount.frame++;
> +			if (fsr & FSR_PEF)
> +				up->port.icount.parity++;
> +			if (fsr & FSR_RX_OVER_IF)
> +				up->port.icount.overrun++;
> +
> +			serial_out(up, UART_REG_FSR, fsr &
> +				   (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF));
> +
> +			if (fsr & FSR_BIF)
> +				flag = TTY_BREAK;
> +			else if (fsr & FSR_PEF)
> +				flag = TTY_PARITY;
> +			else if (fsr & FSR_FEF)
> +				flag = TTY_FRAME;
> +		}
> +
> +		ch = serial_in(up, UART_REG_RBR);
> +		if (uart_handle_sysrq_char(&up->port, ch))
> +			continue;
> +
> +		spin_lock(&up->port.lock);
> +		uart_insert_char(&up->port, fsr, FSR_RX_OVER_IF, ch, flag);
> +		spin_unlock(&up->port.lock);
> +
> +		fsr = serial_in(up, UART_REG_FSR);
> +	} while (!(fsr & FSR_RX_EMPTY) && (max_count-- > 0));
> +
> +	spin_lock(&up->port.lock);
> +	tty_flip_buffer_push(&up->port.state->port);
> +	spin_unlock(&up->port.lock);
> +}
> +
> +static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 isr, fsr;
> +
> +	isr = serial_in(up, UART_REG_ISR);
> +	fsr = serial_in(up, UART_REG_FSR);
> +
> +	if (!(isr & UART_ISR_IF_CHECK))
> +		return IRQ_NONE;
> +
> +	if (isr & (ISR_RDA_IF | ISR_RXTO_IF))
> +		receive_chars(up);
> +	if (isr & ISR_THRE_INT)
> +		transmit_chars(up);
> +	if (fsr & FSR_TX_OVER_IF)
> +		serial_out(up, UART_REG_FSR, FSR_TX_OVER_IF);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 ma35d1serial_tx_empty(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 fsr;
> +
> +	fsr = serial_in(up, UART_REG_FSR);
> +	return (fsr & (FSR_TE_FLAG | FSR_TX_EMPTY)) ==
> +		(FSR_TE_FLAG | FSR_TX_EMPTY) ? TIOCSER_TEMT : 0;
> +}
> +
> +static u32 ma35d1serial_get_mctrl(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 status;
> +	u32 ret = 0;
> +
> +	status = serial_in(up, UART_REG_MSR);
> +	if (!(status & MSR_CTSSTS))
> +		ret |= TIOCM_CTS;
> +	return ret;
> +}
> +
> +static void ma35d1serial_set_mctrl(struct uart_port *port, u32 mctrl)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 mcr = 0;
> +	u32 ier = 0;
> +
> +	if (mctrl & TIOCM_RTS) {
> +		mcr = serial_in(up, UART_REG_MCR);
> +		mcr |= MCR_RTSACTLV;
> +		mcr &= ~MCR_RTS_CTRL;
> +	}
> +	if (up->mcr & UART_MCR_AFE) {
> +		mcr = serial_in(up, UART_REG_MCR);
> +		mcr |= MCR_RTSACTLV;
> +		mcr &= ~MCR_RTS_CTRL;
> +
> +		serial_out(up, UART_REG_IER,
> +			   (serial_in(up, UART_REG_IER) | IER_AUTO_RTS | IER_AUTO_CTS));

Split to 3 lines.

> +
> +		up->port.flags |= UPF_HARD_FLOW;
> +	} else {
> +		ier = serial_in(up, UART_REG_IER);
> +		ier &= ~(IER_AUTO_RTS | IER_AUTO_CTS);
> +		serial_out(up, UART_REG_IER, ier);
> +
> +		up->port.flags &= ~UPF_HARD_FLOW;
> +	}
> +	serial_out(up, UART_REG_MSR, (serial_in(up, UART_REG_MSR) | MSR_CTSACTLV));

Split this to 3 lines.

> +	serial_out(up, UART_REG_MCR, mcr);

Is it okay to write 0 to MCR here (when neither of the branches that read 
the previous value above are taken)?

> +}
> +
> +static void ma35d1serial_break_ctl(struct uart_port *port, int break_state)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	unsigned long flags;
> +	u32 lcr;
> +
> +	spin_lock_irqsave(&up->port.lock, flags);
> +	lcr = serial_in(up, UART_REG_LCR);
> +	if (break_state != 0)
> +		lcr |= LCR_BREAK;
> +	else
> +		lcr &= ~LCR_BREAK;
> +	serial_out(up, UART_REG_LCR, lcr);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static int ma35d1serial_startup(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	int retval;
> +
> +	/* Reset FIFO */
> +	serial_out(up, UART_REG_FCR, FCR_TFR | FCR_RFR);
> +
> +	/* Clear pending interrupts */
> +	serial_out(up, UART_REG_ISR, ISR_ALL);
> +
> +	retval = request_irq(port->irq, ma35d1serial_interrupt, 0,
> +			     dev_name(port->dev), port);
> +	if (retval) {
> +		dev_err(up->port.dev, "request irq failed.\n");
> +		return retval;
> +	}
> +
> +	serial_out(up, UART_REG_FCR, serial_in(up, UART_REG_FCR) |
> +		   FCR_RFITL_4BYTES | FCR_RTSTRGLV_8BYTES);
> +	serial_out(up, UART_REG_LCR, LCR_WLS_8BITS);
> +	serial_out(up, UART_REG_TOR, UART_RX_TOUT);
> +	serial_out(up, UART_REG_IER, IER_RTO_IEN | IER_RDA_IEN |
> +		   IER_TIME_OUT_EN | IER_BUFERR_IEN);
> +	return 0;
> +}
> +
> +static void ma35d1serial_shutdown(struct uart_port *port)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	serial_out(up, UART_REG_IER, 0);
> +	free_irq(port->irq, port);
> +}
> +
> +static u32 ma35d1serial_get_divisor(struct uart_port *port, u32 baud)
> +{
> +	return (port->uartclk / baud) - 2;

What is the magic 2?

> +}
> +
> +static void ma35d1serial_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     const struct ktermios *old)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +	u32 lcr = 0;
> +	unsigned long flags;
> +	u32 baud, quot;
> +
> +	lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
> +
> +	if (termios->c_cflag & CSTOPB)
> +		lcr |= LCR_NSB;
> +	if (termios->c_cflag & PARENB)
> +		lcr |= LCR_PBE;
> +	if (!(termios->c_cflag & PARODD))
> +		lcr |= LCR_EPE;
> +	if (termios->c_cflag & CMSPAR)
> +		lcr |= LCR_SPE;
> +
> +	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 0xffff,

UART_DIV_MAX ?

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
> +	up->port.read_status_mask = FSR_RX_OVER_IF;
> +	if (termios->c_iflag & INPCK)
> +		up->port.read_status_mask |= FSR_FEF | FSR_PEF;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		up->port.read_status_mask |= FSR_BIF;
> +
> +	/* Characteres to ignore */
> +	up->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		up->port.ignore_status_mask |= FSR_FEF | FSR_PEF;
> +	if (termios->c_iflag & IGNBRK) {
> +		up->port.ignore_status_mask |= FSR_BIF;
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			up->port.ignore_status_mask |= FSR_RX_OVER_IF;
> +	}
> +	if (termios->c_cflag & CRTSCTS)
> +		up->mcr |= UART_MCR_AFE;
> +	else
> +		up->mcr &= ~UART_MCR_AFE;
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +	ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
> +	serial_out(up, UART_REG_BAUD, quot | BAUD_MODE2);
> +	serial_out(up, UART_REG_LCR, lcr);
> +	spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static const char *ma35d1serial_type(struct uart_port *port)
> +{
> +	return "ma35d1-uart";
> +}
> +
> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
> +{
> +	/*
> +	 * Driver core for serial ports forces a non-zero value for port type.
> +	 * Write an arbitrary value here to accommodate the serial core driver,
> +	 * as ID part of UAPI is redundant.
> +	 */
> +	port->type = 1;
> +}
> +
> +static int ma35d1serial_verify_port(struct uart_port *port,
> +				struct serial_struct *ser)
> +{
> +	if (port->type != PORT_UNKNOWN && ser->type != 1)
> +		return -EINVAL;
> +
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
> +	.config_port  = ma35d1serial_config_port,
> +	.verify_port  = ma35d1serial_verify_port,
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
> +static struct device_node *ma35d1serial_uart_nodes[UART_NR];
> +
> +static void wait_for_xmitr(struct uart_ma35d1_port *up)
> +{
> +	unsigned int tmout;
> +
> +	/* Wait up to 10ms for the character(s) to be sent. */
> +	tmout = 10000;
> +	while (--tmout) {
> +		if (serial_in(up, UART_REG_FSR) & FSR_TX_EMPTY)
> +			break;
> +		udelay(1);
> +	}
> +}
> +
> +static void ma35d1serial_console_putchar(struct uart_port *port, unsigned char ch)
> +{
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	wait_for_xmitr(up);
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
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
> +	/*
> +	 *  First save the IER then disable the interrupts
> +	 */
> +	ier = serial_in(up, UART_REG_IER);
> +	serial_out(up, UART_REG_IER, 0);
> +
> +	uart_console_write(&up->port, s, count, ma35d1serial_console_putchar);
> +
> +	wait_for_xmitr(up);
> +	serial_out(up, UART_REG_IER, ier);
> +
> +	spin_unlock_irqrestore(&up->port.lock, flags);
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
> +	p->port.membase = ioremap(p->port.iobase, UART_REG_SIZE);
> +	p->port.ops = &ma35d1serial_ops;
> +	p->port.line = 0;
> +	p->port.uartclk = UART_CONSOLE_CLK;
> +
> +	port = &ma35d1serial_ports[co->index].port;
> +
> +	if (options)
> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +
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
> +static void ma35d1serial_console_init_port(void)
> +{
> +	u32 i = 0;
> +	struct device_node *np;
> +
> +	for_each_matching_node(np, ma35d1_serial_of_match) {
> +		if (ma35d1serial_uart_nodes[i] == NULL) {
> +			of_node_get(np);
> +			ma35d1serial_uart_nodes[i] = np;
> +			i++;
> +			if (i == UART_NR)
> +				break;
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

This doesn't seem necessary, 8250 core will have the uart_driver for you
and most of the console stuff too. You just need to setup a few things 
correctly (see the setup functions in 8250_early for ideas/examples).

> +/*
> + * Register a set of serial devices attached to a platform device.
> + * The list is terminated with a zero flags entry, which means we expect
> + * all entries to have at least UPF_BOOT_AUTOCONF set.
> + */
> +static int ma35d1serial_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_ma35d1_port *up;
> +	int ret = 0;
> +
> +	if (pdev->dev.of_node) {
> +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	up = &ma35d1serial_ports[ret];
> +	up->port.line = ret;
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_mem)
> +		return -ENODEV;
> +
> +	up->port.iobase = res_mem->start;
> +	up->port.membase = ioremap(up->port.iobase, UART_REG_SIZE);
> +	up->port.ops = &ma35d1serial_ops;
> +
> +	spin_lock_init(&up->port.lock);
> +
> +	up->clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(up->clk)) {
> +		ret = PTR_ERR(up->clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
> +		goto err_iounmap;
> +	}
> +
> +	ret = clk_prepare_enable(up->clk);
> +	if (ret)
> +		goto err_iounmap;
> +
> +	if (up->port.line != 0)
> +		up->port.uartclk = clk_get_rate(up->clk);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		goto err_clk_disable;
> +
> +	up->port.irq = ret;
> +	up->port.dev = &pdev->dev;
> +	up->port.flags = UPF_BOOT_AUTOCONF;
> +
> +	platform_set_drvdata(pdev, up);
> +
> +	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);

For 8250, you should be using serial8250_register_8250_port(). See the 
other drivers how to setup the console functions.

> +	if (ret < 0)
> +		goto err_free_irq;
> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(up->port.irq, &up->port);
> +
> +err_clk_disable:
> +	clk_disable_unprepare(up->clk);
> +
> +err_iounmap:
> +	iounmap(up->port.membase);
> +	return ret;
> +}
> +
> +/*
> + * Remove serial ports registered against a platform device.
> + */
> +static int ma35d1serial_remove(struct platform_device *dev)
> +{
> +	struct uart_port *port = platform_get_drvdata(dev);
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	uart_remove_one_port(&ma35d1serial_reg, port);

serial8250_unregister_port()

> +	clk_disable_unprepare(up->clk);
> +	return 0;
> +}
> +
> +static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct uart_port *port = platform_get_drvdata(dev);
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	uart_suspend_port(&ma35d1serial_reg, &up->port);
> +	if (up->port.line == 0) {
> +		up->console_baud_rate = serial_in(up, UART_REG_BAUD);
> +		up->console_line = serial_in(up, UART_REG_LCR);
> +		up->console_int = serial_in(up, UART_REG_IER);
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1serial_resume(struct platform_device *dev)
> +{
> +	struct uart_port *port = platform_get_drvdata(dev);
> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
> +
> +	if (up->port.line == 0) {
> +		serial_out(up, UART_REG_BAUD, up->console_baud_rate);
> +		serial_out(up, UART_REG_LCR, up->console_line);
> +		serial_out(up, UART_REG_IER, up->console_int);
> +	}
> +	uart_resume_port(&ma35d1serial_reg, &up->port);
> +	return 0;
> +}
> +
> +static struct platform_driver ma35d1serial_driver = {
> +	.probe      = ma35d1serial_probe,
> +	.remove     = ma35d1serial_remove,

> +	.suspend    = ma35d1serial_suspend,
> +	.resume     = ma35d1serial_resume,

Shouldn't these be under .driver.pm instead?

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
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MA35D1 serial driver");
> +
> 

-- 
 i.
--8323329-785755061-1683544159=:1790--
