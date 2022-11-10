Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333A8624BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKJU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKJU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:29:39 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F21CFFC;
        Thu, 10 Nov 2022 12:29:34 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id k2so1875372qkk.7;
        Thu, 10 Nov 2022 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ih5vbeDEAFzKplO982fNJrgyD80A/aFIEJ2OMUT2j4o=;
        b=HOuepxNdSz8sxgRYf9mKW4vLXN5T3uEH0aRUCqJEv/AB62lWjI4i5TMKwNPOUhH/ed
         7406HkAIQaMjQvrpGVc2HcPwB/dYW9ntnv5XnbCtGqyJWvJXVZm57N9mkC42v8I5Yg52
         7BtW/4Xhsc7yzFn6GqAtLykuIS8YyFY9VUGF/FlyP5OMUbmDXHUCpmjcvXr/iCv5B/S2
         c4z1/qCuzTgtb3eyL532GFYVzuOfKjhzmFOq5VsAqKNlnvF+tRFlBe5/R2M39yT9rNUT
         8o9RnxIZjWJn0vKXvP99chZedwebr2VL7hf92RbGwYIcoSzMPpamrnW5fUQLiHEobpZu
         zKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ih5vbeDEAFzKplO982fNJrgyD80A/aFIEJ2OMUT2j4o=;
        b=3hNQGJRYPkJRdPXRrmGCZmqQWFUX5IXWpNJF7hyFPYNafUwN15pqsNzTeMKEFWZahQ
         M5ydm3b2oI4gzm7ZK1DySaHfXa+FLo1NDBIyqPMIH+6LcgxnQbkp4yxGVSJKEZ+0RNLm
         KSLCdRkbjXonEamVBkrU9B76j2PqTSE3jyT7z7jEdT+l++ZOi28Ro0H6Tio0rsT904SP
         WEsmGS9lgL42ipuOlF49JqojrYLXXFBQtb8lcrT234yBEDat/KDL2VfEsdsqoHMrtZEh
         Lful8iWmIatAZKg7MpHz6jOTEw09IyjzeRSUTdAuCR3Si0rFmwkcko1RpetwlSyxbBs9
         0vRg==
X-Gm-Message-State: ACrzQf3zaA4a17KhMK/nvzebbSohIVS1mhwtNdIaMwC3cEOLyGw13XmC
        /XU5lhL/wfU95tkR6ztjc2SQvGmQ6y8eog==
X-Google-Smtp-Source: AMsMyM70iuhbVvo3+cuEcWfteZfe6ZXwUOabi8j35ocMFTt8YEzGCaGRlyR5Wg24nm/WVJe/GJBktg==
X-Received: by 2002:a37:e301:0:b0:6fa:4749:cb8c with SMTP id y1-20020a37e301000000b006fa4749cb8cmr1782662qki.335.1668112173211;
        Thu, 10 Nov 2022 12:29:33 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b006bbf85cad0fsm207937qkb.20.2022.11.10.12.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:29:32 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:29:30 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 6/7] serial: liteuart: separate RX loop from poll timer
Message-ID: <Y21fKt+mGKvQ8yMF@glsvmlin.ini.cmu.edu>
References: <20221110004450.772768-1-gsomlo@gmail.com>
 <20221110004450.772768-7-gsomlo@gmail.com>
 <1c902ee8-d33d-c2d0-7eef-719f59f3a64@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c902ee8-d33d-c2d0-7eef-719f59f3a64@linux.intel.com>
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

On Thu, Nov 10, 2022 at 01:01:47PM +0200, Ilpo Järvinen wrote:
> On Wed, 9 Nov 2022, Gabriel Somlo wrote:
> 
> > Move the character-receive (RX) loop to its own dedicated function,
> > and (for now) call that from the poll timer, liteuart_timer().
> > 
> > This is in preparation for adding IRQ support to the receive path.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 047d5ad32e13..aa7052280197 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -67,29 +67,34 @@ static struct uart_driver liteuart_driver = {
> >  #endif
> >  };
> >  
> > -static void liteuart_timer(struct timer_list *t)
> > +static void liteuart_rx_chars(struct uart_port *port)
> >  {
> > -	struct liteuart_port *uart = from_timer(uart, t, timer);
> > -	struct uart_port *port = &uart->port;
> >  	unsigned char __iomem *membase = port->membase;
> > -	unsigned int flg = TTY_NORMAL;
> > -	int ch;
> > -	unsigned long status;
> > +	unsigned int status;
> > +	unsigned char ch;
> >  
> >  	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
> >  		ch = litex_read8(membase + OFF_RXTX);
> >  		port->icount.rx++;
> >  
> >  		/* necessary for RXEMPTY to refresh its value */
> > -		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
> > +		litex_write8(membase + OFF_EV_PENDING, EV_RX);
> >  
> >  		/* no overflow bits in status */
> >  		if (!(uart_handle_sysrq_char(port, ch)))
> > -			uart_insert_char(port, status, 0, ch, flg);
> > -
> > -		tty_flip_buffer_push(&port->state->port);
> > +			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
> >  	}
> >  
> > +	tty_flip_buffer_push(&port->state->port);
> 
> This change is doing extra stuff besides moving rx to a dedicated 
> function.
> 
> I see no reason why those other changes couldn't be put into an entirely 
> separate patch. Also, please described those changes properly in the 
> commit message (answer the why? question).
 
You're right, calling `tty_flip_buffer_push()` as each character is
received is overkill, we only need to call it once per interrupt once
all available characters have been received.

I forgot I noticed (and fixed) that as part of the move -- I'll split
it out into its own separate patch (probably *before* moving all of rx
to a dedicated function).

Should show up in v3, once I also address all the other feedback I
received.

Thanks again for catching it!

Cheers,
-Gabriel

> -- 
>  i.
> 
> > +}
> > +
> > +static void liteuart_timer(struct timer_list *t)
> > +{
> > +	struct liteuart_port *uart = from_timer(uart, t, timer);
> > +	struct uart_port *port = &uart->port;
> > +
> > +	liteuart_rx_chars(port);
> > +
> >  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> >  
> > 
> 
> 
