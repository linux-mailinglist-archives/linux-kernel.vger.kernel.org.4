Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CF6C0E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCTKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCTKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:05:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5C21951;
        Mon, 20 Mar 2023 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679306677; x=1710842677;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=089CF72/jASKJqoqvGhxZDa0esoCSdvFUSdgI5zns3Y=;
  b=K8+4QBJrk6k1pPh6BNN5m2N1yO2DLXMmqXYmsAcvRPDpT9uEMJHs5ZEu
   Fxxg6W0Pei3CXOnrI4Gw8OL0VJLm7iCcsVLgy6lGSm8YCyt69KbDfEVEM
   KwatX9wfr0TVdPsFo9nTugYu5J5Ec7ZgWykGmFV84CtXKPqy69xx66hE+
   bbvJwHB5L+ygWxlqNCBxVVpCtdKa52QNvfTke9imL1P/HGSe46Fr8P+Zx
   +gxIDHFqSyVthJgkZQr3Bn1N0g4/UZNUGG4EpkH/Z8e6TiCiZl5bgulSZ
   a4mULGgj9ASdpmJ751TZVXFfAaYH8dobtdlOBS8vDX1xcob0XyMrd3xoO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="336124734"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336124734"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713520158"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713520158"
Received: from mbouhaou-mobl1.ger.corp.intel.com ([10.252.61.151])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:04:11 -0700
Date:   Mon, 20 Mar 2023 12:04:08 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>, mjchen@nuvoton.com
Subject: Re: [PATCH 14/15] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <c755e596-9187-8de1-5769-9c67c1f01c48@gmail.com>
Message-ID: <b6995749-4b54-59d1-99d2-6b64b438f22f@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-15-ychuang570808@gmail.com> <24ce3334-b535-f6d5-70dd-3ba9be991252@linux.intel.com> <c755e596-9187-8de1-5769-9c67c1f01c48@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-286954288-1679306062=:2177"
Content-ID: <e72f080-5a39-cbae-939d-47658ab1940@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-286954288-1679306062=:2177
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <9e48e57-5483-8748-822b-8ba6f3ef356@linux.intel.com>

On Mon, 20 Mar 2023, Jacky Huang wrote:

> Dear Ilpo,
> 
> 
> Thanks for your advice.
> 
> On 2023/3/16 下午 10:54, Ilpo Järvinen wrote:
> > Hi,
> > 
> > I'll not note all things below because others have already seemingly
> > commented many things.
> > 
> > On Wed, 15 Mar 2023, Jacky Huang wrote:
> > 
> > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > 
> > > This adds UART and console driver for Nuvoton ma35d1 Soc.

> > > +		}
> > > +		ch = (u8)serial_in(up, UART_REG_RBR);
> > Drop the case.
> 
> I  will fix it.

I meant "cast" in case it wasn't obvious.

> > > +/* Enable or disable the rs485 support */
> > > +static int ma35d1serial_config_rs485(struct uart_port *port,
> > > +				     struct ktermios *termios,
> > > +				     struct serial_rs485 *rs485conf)
> > > +{
> > > +	struct uart_ma35d1_port *p = to_ma35d1_uart_port(port);
> > > +
> > > +	p->rs485 = *rs485conf;
> > > +
> > > +	if (p->rs485.delay_rts_before_send >= 1000)
> > > +		p->rs485.delay_rts_before_send = 1000;
> > Don't do this in driver, the core handles the delay limits. You don't seem
> > to be using the value anyway for anything???
> > 
> > Please separate the RS485 support into its own patch.
> 
> 
> OK, we will remove RS485 support from this initial patch.
> Once this initial patch was merged, we will submit the patch for RS485
> support.

You could do that but you could just as well include it into the same 
series as another patch after the main patch.

> > > +	serial_out(p, UART_FUN_SEL,
> > > +		   (serial_in(p, UART_FUN_SEL) & ~FUN_SEL_MASK));
> > > +
> > > +	if (rs485conf->flags & SER_RS485_ENABLED) {
> > > +		serial_out(p, UART_FUN_SEL,
> > > +			   (serial_in(p, UART_FUN_SEL) | FUN_SEL_RS485));
> > Does this pair of serial_out()s glitch the RS485 line if ->rs485_config()
> > is called while RS485 mode is already set?
> > 
> > Why you need to do serial_in() from the UART_FUN_SEL twice?
> 
> UART_FUN_SEL (2 bits) definition:
> 00 - UART function
> 01 - IrDA function
> 11 - RS485 function
> 
> The first searial_in() is used to clear set as UART function.
> The second one is used to set RS485 function if SER_RS485_ENABLED is true.

I got that, but it doesn't answer either of my questions which are:

Can you clear the UART function without causing a glitch in the RS485?
->rs485_config() can be called while already in RS485 mode so does it 
cause the UART to temporarily switch away from RS485 mode to "UART 
function" until the second write.

Also, you didn't explain why you need to read the register again, does 
the HW play with other bits when you do the clearing or to they remain 
the same (in which case you can just use a temporary variable to store 
the value)? ...It would be better to just write once too so this question 
might not matter in the end.

> > > +	if (pdev->dev.of_node) {
> > > +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> > > +		if (ret < 0) {
> > > +			dev_err(&pdev->dev,
> > > +				"failed to get alias/pdev id, errno %d\n",
> > > +				ret);
> > Just put error prints to one line if you don't break 100 chars limit.
> 
> But the checkpatch limitation is 80 characters.

No, it isn't. It was changed years ago already.

> > > +++ b/drivers/tty/serial/ma35d1_serial.h
> > > @@ -0,0 +1,93 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + *  MA35D1 serial driver header file
> > > + *  Copyright (C) 2023 Nuvoton Technology Corp.
> > > + */
> > > +#ifndef __MA35D1_SERIAL_H__
> > > +#define __MA35D1_SERIAL_H__
> > > +
> > > +/* UART Receive/Transmit Buffer Register */
> > > +#define UART_REG_RBR	0x00
> > > +#define UART_REG_THR	0x00
> > > +
> > > +/* UART Interrupt Enable Register */
> > > +#define UART_REG_IER	0x04
> > > +#define RDA_IEN		0x00000001 /* RBR Available Interrupt Enable
> > > */
> > > +#define THRE_IEN	0x00000002 /* THR Empty Interrupt Enable */
> > > +#define RLS_IEN		0x00000004 /* RX Line Status Interrupt Enable
> > > */
> > > +#define RTO_IEN		0x00000010 /* RX Time-out Interrupt Enable */
> > > +#define BUFERR_IEN	0x00000020 /* Buffer Error Interrupt Enable */
> > > +#define TIME_OUT_EN	0x00000800 /* RX Buffer Time-out Counter
> > > Enable */
> > > +
> > > +/* UART FIFO Control Register */
> > > +#define UART_REG_FCR	0x08
> > > +#define RFR		0x00000002 /* RX Field Software Reset */
> > > +#define TFR		0x00000004 /* TX Field Software Reset */
> > > +
> > > +/* UART Line Control Register */
> > > +#define UART_REG_LCR	0x0C
> > > +#define	NSB		0x00000004 /* Number of “STOP Bit” */
> > > +#define PBE		0x00000008 /* Parity Bit Enable */
> > > +#define EPE		0x00000010 /* Even Parity Enable */
> > > +#define SPE		0x00000020 /* Stick Parity Enable */
> > > +#define BCB		0x00000040 /* Break Control */
> > > +
> > > +/* UART Modem Control Register */
> > > +#define UART_REG_MCR	0x10
> > > +#define RTS		0x00000020 /* nRTS Signal Control */
> > > +#define RTSACTLV	0x00000200 /* nRTS Pin Active Level */
> > > +#define RTSSTS		0x00002000 /* nRTS Pin Status (Read Only) */
> > > +
> > > +/* UART Modem Status Register */
> > > +#define UART_REG_MSR	0x14
> > > +#define CTSDETF		0x00000001 /* Detect nCTS State Change Flag */
> > > +#define CTSSTS		0x00000010 /* nCTS Pin Status (Read Only) */
> > > +#define CTSACTLV	0x00000100 /* nCTS Pin Active Level */
> > > +
> > > +/* UART FIFO Status Register */
> > > +#define UART_REG_FSR	0x18
> > > +#define RX_OVER_IF	0x00000001 /* RX Overflow Error Interrupt Flag */
> > > +#define PEF		0x00000010 /* Parity Error Flag*/
> > > +#define FEF		0x00000020 /* Framing Error Flag */
> > > +#define BIF		0x00000040 /* Break Interrupt Flag */
> > > +#define RX_EMPTY	0x00004000 /* Receiver FIFO Empty (Read Only) */
> > > +#define RX_FULL		0x00008000 /* Receiver FIFO Full (Read Only)
> > > */
> > > +#define TX_EMPTY	0x00400000 /* Transmitter FIFO Empty (Read Only) */
> > > +#define TX_FULL		0x00800000 /* Transmitter FIFO Full (Read
> > > Only) */
> > > +#define TX_OVER_IF	0x01000000 /* TX Overflow Error Interrupt Flag */
> > > +#define TE_FLAG		0x10000000 /* Transmitter Empty Flag (Read
> > > Only) */
> > > +
> > > +/* UART Interrupt Status Register */
> > > +#define UART_REG_ISR	0x1C
> > > +#define RDA_IF		0x00000001 /* RBR Available Interrupt Flag */
> > > +#define THRE_IF		0x00000002 /* THR Empty Interrupt Flag */
> > > +#define RLSIF		0x00000004 /* Receive Line Interrupt Flag */
> > > +#define MODEMIF		0x00000008 /* MODEM Interrupt Flag */
> > > +#define RXTO_IF		0x00000010 /* RX Time-out Interrupt Flag */
> > > +#define BUFEIF		0x00000020 /* Buffer Error Interrupt Flag */
> > > +#define WK_IF		0x00000040 /* UART Wake-up Interrupt Flag */
> > > +#define RDAINT		0x00000100 /* RBR Available Interrupt
> > > Indicator */
> > > +#define THRE_INT	0x00000200 /* THR Empty Interrupt Indicator */

I forgot to mention earlier, there are many defines above which should use 
BIT().


-- 
 i.
--8323329-286954288-1679306062=:2177--
