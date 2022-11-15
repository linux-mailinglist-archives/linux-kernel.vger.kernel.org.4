Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B27629E04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKOPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiKOPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:48:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667822CCAE;
        Tue, 15 Nov 2022 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668527287; x=1700063287;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=esQYanLlOvexoYc53n1hkKiLmuXm7gaBOcFvaSRa3d8=;
  b=Yiw1R6rKl7UHPaOjlEY0isC9k5q1JS/hMghfUvBOGmRR0IXfPnblVV9c
   2DoH0YNG5C9aesQNNT2dc0jjRhI6GJb6cA38mnc4X0FctSg9MRbAJLxQK
   ssYD1bfcZ6441krMuGAw2ShbjEuGjWW7gM6Qd5hqtX57kjIteHaZNGVXY
   +MvfdWLxmJogCxKaN8SnXU8pSy0uqVXbqQcQ6pD7N7AeN3HCCn+i67QE3
   44tEypr8HBLmot+7ZbFWeBQ3VfIKqMY96wqfYffbW4RY28mFYULpG9oEf
   GBcUSFRWqRAEtrOFVcZTxOnYX3NyDJ74puXRq00UEg0+OX2Ok2QggPDq8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="291995132"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="291995132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:48:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781382824"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="781382824"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:48:03 -0800
Date:   Tue, 15 Nov 2022 17:48:01 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 11/14] serial: liteuart: move function definitions
In-Reply-To: <20221112212125.448824-12-gsomlo@gmail.com>
Message-ID: <4acd99f5-86eb-e0c8-a9ca-a4f5c7e07393@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-12-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-931260506-1668527287=:2268"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-931260506-1668527287=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Move definitions for liteuart_[stop|start]_tx(), liteuart_stop_rx(),
> and liteuart_putchar() to a more convenient location in preparation
> for adding IRQ support. This patch contains no functional changes.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 98 +++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 172ac190ba2f..cf1ce597b45e 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -67,36 +67,6 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>  
> -static void liteuart_rx_chars(struct uart_port *port)
> -{
> -	unsigned char __iomem *membase = port->membase;
> -	unsigned int status, ch;
> -
> -	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
> -		ch = litex_read8(membase + OFF_RXTX);
> -		port->icount.rx++;
> -
> -		/* necessary for RXEMPTY to refresh its value */
> -		litex_write8(membase + OFF_EV_PENDING, EV_RX);
> -
> -		/* no overflow bits in status */
> -		if (!(uart_handle_sysrq_char(port, ch)))
> -			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
> -	}
> -
> -	tty_flip_buffer_push(&port->state->port);
> -}
> -
> -static void liteuart_timer(struct timer_list *t)
> -{
> -	struct liteuart_port *uart = from_timer(uart, t, timer);
> -	struct uart_port *port = &uart->port;
> -
> -	liteuart_rx_chars(port);
> -
> -	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> -}
> -
>  static void liteuart_putchar(struct uart_port *port, unsigned char ch)
>  {
>  	while (litex_read8(port->membase + OFF_TXFULL))
> @@ -105,25 +75,6 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
>  	litex_write8(port->membase + OFF_RXTX, ch);
>  }
>  
> -static unsigned int liteuart_tx_empty(struct uart_port *port)
> -{
> -	/* not really tx empty, just checking if tx is not full */
> -	if (!litex_read8(port->membase + OFF_TXFULL))
> -		return TIOCSER_TEMT;
> -
> -	return 0;
> -}
> -
> -static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> -{
> -	/* modem control register is not present in LiteUART */
> -}
> -
> -static unsigned int liteuart_get_mctrl(struct uart_port *port)
> -{
> -	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> -}
> -
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
>  	/* not used in LiteUART, but called unconditionally from serial_core */
> @@ -159,6 +110,55 @@ static void liteuart_stop_rx(struct uart_port *port)
>  	del_timer(&uart->timer);
>  }
>  
> +static void liteuart_rx_chars(struct uart_port *port)
> +{
> +	unsigned char __iomem *membase = port->membase;
> +	unsigned int status, ch;
> +
> +	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
> +		ch = litex_read8(membase + OFF_RXTX);
> +		port->icount.rx++;
> +
> +		/* necessary for RXEMPTY to refresh its value */
> +		litex_write8(membase + OFF_EV_PENDING, EV_RX);
> +
> +		/* no overflow bits in status */
> +		if (!(uart_handle_sysrq_char(port, ch)))
> +			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
> +	}
> +
> +	tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static void liteuart_timer(struct timer_list *t)
> +{
> +	struct liteuart_port *uart = from_timer(uart, t, timer);
> +	struct uart_port *port = &uart->port;
> +
> +	liteuart_rx_chars(port);
> +
> +	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +}
> +
> +static unsigned int liteuart_tx_empty(struct uart_port *port)
> +{
> +	/* not really tx empty, just checking if tx is not full */
> +	if (!litex_read8(port->membase + OFF_TXFULL))
> +		return TIOCSER_TEMT;
> +
> +	return 0;
> +}
> +
> +static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/* modem control register is not present in LiteUART */
> +}
> +
> +static unsigned int liteuart_get_mctrl(struct uart_port *port)
> +{
> +	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
>  static int liteuart_startup(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-931260506-1668527287=:2268--
