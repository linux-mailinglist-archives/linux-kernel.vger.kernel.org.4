Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849F6629E99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKOQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKOQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:15:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE321269;
        Tue, 15 Nov 2022 08:15:00 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id hh9so8986902qtb.13;
        Tue, 15 Nov 2022 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2wwNC8AzSIcgJJ1r5NpmplMzxcfDYGJztpKEBfjt9o=;
        b=e2YvQIUicaJ33Vg33oY4sQ2Yz71K/YXengR3tCjYLt/TbdDJFE6kmVghCRcXDrz47x
         juN6TiHE0MiXcrzksnKv/e2maSitly0Iq10rzegLbh88GXnKbsbpxtLoc6so/IQHdM7K
         G9vNWxmq2CxgMe99WoMBOl3AosE8i/xWoJSEDidrru17Xj974DTjapO3qKk38CcndUC1
         vQ11byYolyUgNuqhU/cQ0LxHFTcWakrNAkClK56xW5tB1s8ko3D3YYQhMfMlAgCYmMmb
         yMDrNt4UmlnyokDfsZvyZnUj0DjRZvl2p2R/TELlDlO0djSHwuOs7vb0hxr5hptKUFXY
         Pv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2wwNC8AzSIcgJJ1r5NpmplMzxcfDYGJztpKEBfjt9o=;
        b=HRalwpTrZ33kOqQ9mTJmd7F+oR/6rRsIg8yrZF8JiXK1irfB7BIjG5aEful5mkVok0
         hBOYwLjhsCeH+DDjnB4iQgbFotrR91A+UxdeOA8RATyvy8DyaV/B+271K8Qs7bS9cnUY
         /TtOxp0D7FtVu+omK/XR9wNFAgFSavDKkpsTmWAwgZCzOW6uppRzDGWf5fMNIC+Et9dF
         A4rRdjmF1jZQ+iummvfXnPvzrDZzmYjV11JoCWm25HjcJGVtgTuoHKyN7gohVyd1g8Mp
         Ltx8z0qZAes7EUm8MpNtxis6oNQm2Ru8aMdvK9IYSKMRfLQH0kiKb94RtqS1iT04Ul3J
         +3Vg==
X-Gm-Message-State: ANoB5pnGfdO2c66YP240Q7/+NPKjuP10GnjlfbREPAow5nYcj+saekFt
        wrvCHow4dnQFO9RHNkAiS0g=
X-Google-Smtp-Source: AA0mqf4bi1ybWe1H8s3nvtV8h1eJ/e0GMQxKjI90MnDcbQhSqv8/O+kwicM26Emh3M6HJjMNtM231w==
X-Received: by 2002:ac8:5e88:0:b0:398:353c:fe2e with SMTP id r8-20020ac85e88000000b00398353cfe2emr17152361qtx.507.1668528899271;
        Tue, 15 Nov 2022 08:14:59 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id fp1-20020a05622a508100b0039ee562799csm7357183qtb.59.2022.11.15.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:14:58 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:14:56 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 12/14] serial: liteuart: add IRQ support for the RX
 path
Message-ID: <Y3O7AKVuY3/n6I5K@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-13-gsomlo@gmail.com>
 <a914ebd3-5eb8-6c53-3f58-3371fdabf7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a914ebd3-5eb8-6c53-3f58-3371fdabf7@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:00:11PM +0200, Ilpo Järvinen wrote:
> On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> 
> > Add support for IRQ-driven RX. Support for the TX path will be added
> > in a separate commit.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 61 +++++++++++++++++++++++++++++++----
> >  1 file changed, 54 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index cf1ce597b45e..e30adb30277f 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -6,6 +6,7 @@
> >   */
> >  
> >  #include <linux/console.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/litex.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -130,13 +131,29 @@ static void liteuart_rx_chars(struct uart_port *port)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >  
> > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > +{
> > +	struct liteuart_port *uart = data;
> > +	struct uart_port *port = &uart->port;
> > +	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> > +
> > +	/* for now, only rx path triggers interrupts */
> 
> Please don't add comment like this at all when your series removes it in a 
> later patch.

OK, I will remove it in v4.

> > +	isr &= EV_RX;
> > +
> > +	spin_lock(&port->lock);
> > +	if (isr & EV_RX)
> > +		liteuart_rx_chars(port);
> > +	spin_unlock(&port->lock);
> > +
> > +	return IRQ_RETVAL(isr);
> > +}
> > +
> >  static void liteuart_timer(struct timer_list *t)
> >  {
> >  	struct liteuart_port *uart = from_timer(uart, t, timer);
> >  	struct uart_port *port = &uart->port;
> >  
> > -	liteuart_rx_chars(port);
> > -
> > +	liteuart_interrupt(0, port);
> >  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> >  
> > @@ -162,19 +179,42 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> >  static int liteuart_startup(struct uart_port *port)
> >  {
> >  	struct liteuart_port *uart = to_liteuart_port(port);
> > +	int ret;
> > +	u8 irq_mask = 0;
> >  
> > -	/* disable events */
> > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +	if (port->irq) {
> > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > +				  KBUILD_MODNAME, uart);
> > +		if (ret == 0) {
> > +			/* only enable rx interrupts at this time */
> 
> This comment seems pretty useless. Your code says very much the same.

The comment was meant to let the reader know that the code is doing it
*intentionally* (rather than forgetting to enable tx irqs by mistake).
But I'm OK with removing this comment in v4 as well if you think
that's an overly paranoid and redundant thing to do... :)

Thanks,
--Gabriel
 
> -- 
>  i.
> 
> > +			irq_mask = EV_RX;
> > +		} else {
> > +			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
> > +				port->line, port->irq);
> > +			port->irq = 0;
> > +		}
> > +	}
> >  
> > -	/* prepare timer for polling */
> > -	timer_setup(&uart->timer, liteuart_timer, 0);
> > -	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +	if (!port->irq) {
> > +		timer_setup(&uart->timer, liteuart_timer, 0);
> > +		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +	}
> > +
> > +	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
> >  
> >  	return 0;
> >  }
> >  
> >  static void liteuart_shutdown(struct uart_port *port)
> >  {
> > +	struct liteuart_port *uart = to_liteuart_port(port);
> > +
> > +	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +
> > +	if (port->irq)
> > +		free_irq(port->irq, port);
> > +	else
> > +		del_timer_sync(&uart->timer);
> >  }
> >  
> >  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> > @@ -263,6 +303,13 @@ static int liteuart_probe(struct platform_device *pdev)
> >  		goto err_erase_id;
> >  	}
> >  
> > +	/* get irq */
> > +	ret = platform_get_irq_optional(pdev, 0);
> > +	if (ret < 0 && ret != -ENXIO)
> > +		return ret;
> > +	if (ret > 0)
> > +		port->irq = ret;
> > +
> >  	/* values not from device tree */
> >  	port->dev = &pdev->dev;
> >  	port->iotype = UPIO_MEM;
> > 
> 
