Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E493626BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKLVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:00:16 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4ADFA1;
        Sat, 12 Nov 2022 13:00:14 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j6so5624137qvn.12;
        Sat, 12 Nov 2022 13:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STjvMWYAsL+noLrHNxVjcJMidYYojzqz+eFneOGh7ac=;
        b=lFi4p41JqA2nJ8nC9YLCR6IoRcolevIzQxJPScLttGHEoVYd66XJBBJFGfUbKOfyh/
         oq6LW8kITseidXXCLWy8ktgxehKE7YIkt69LRjFZL6ORawlunJ8jZj7l1Ifoozdd27TR
         uH6AMa/OZBHtLlEN6dLTYQ0Vh70rVFrd86iIM/NQePl4N9o6Tci4L7piL046VbSrW7G8
         3novVjPUjbTAfm3jK2TzgFtCPHZalc7GVk0IqzedSNKCSm92ZHtdsgU0JiN/iwCH9g93
         08NXvIvKX2SevzwvIAkVaVZQI0oIRtyZwNCWN0lCEcWL5rmswuGH0ZQyaVMuaYRpZOMN
         SlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STjvMWYAsL+noLrHNxVjcJMidYYojzqz+eFneOGh7ac=;
        b=gjfAuwVHpEt1Z0KUCgXo9NNadb2DLcDKxWNA5+ex5VeUuuGg1MKnkwbvJP78HO78LW
         sTJ4yV9ncZ1LE/949bC37gJ5/fqUpn89iT90Flr1gGGQGPqgVFguNHsY8St+mrnyrWI0
         qDVLesAYSoiRwXySnRoninERZjla2M6PZrxV2A852F/SEYu/d89yoIjgZ7vd6IfPSXDZ
         JEjAtrB8lGpXdOLbAAj38gT/YqBLrAqoq6W6gk8dgX4j3AiDhBDcXRfB0v157RJWqZs+
         AHlQrdf15VPL6hMVRyG+yLS4/wFvvv30HiDEvPkcnkbGX1Wdv9ednlXx3KvdWnA1kPCV
         iEPQ==
X-Gm-Message-State: ANoB5pn9ObRqRyU7RsETGH9vjxsxkNbHrwdxqanSew5Twq0JWsx7CDmB
        pGTHBJ5HXPiOTadENFWcSRk=
X-Google-Smtp-Source: AA0mqf7pNIdnXYoxN9Utrshlkdq33VEit4aQ7HO+LkFo5wa3yHVCDY2by1jc1bt5XB9NQOIqIyZFQg==
X-Received: by 2002:a05:6214:5247:b0:4bb:9358:2a1e with SMTP id kf7-20020a056214524700b004bb93582a1emr6982844qvb.97.1668286813535;
        Sat, 12 Nov 2022 13:00:13 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a288300b006ed138e89f2sm3678531qkp.123.2022.11.12.13.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:00:12 -0800 (PST)
Date:   Sat, 12 Nov 2022 16:00:10 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: Re: [PATCH v1 3/3] serial: liteuart: add IRQ support
Message-ID: <Y3AJWtmDIOZhX37/@errol.ini.cmu.edu>
References: <20221107171500.2537938-1-gsomlo@gmail.com>
 <20221107171500.2537938-4-gsomlo@gmail.com>
 <CACPK8XePY_nYo5OduxOAdAyUqtXju+9vAb+iXZqi6rmvR7Fp=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XePY_nYo5OduxOAdAyUqtXju+9vAb+iXZqi6rmvR7Fp=Q@mail.gmail.com>
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

On Thu, Nov 10, 2022 at 01:08:55AM +0000, Joel Stanley wrote:
> On Mon, 7 Nov 2022 at 17:15, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > Add support for IRQ-driven RX. The TX path remains "polling" based,
> > which is fine since TX is synchronous.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 65 +++++++++++++++++++++++++++++++----
> >  1 file changed, 58 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 90a29ed79bff..47ce3ecc50f2 100644
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
> > @@ -90,13 +91,27 @@ static void liteuart_rx_chars(struct uart_port *port)
> >         tty_flip_buffer_push(&port->state->port);
> >  }
> >
> > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > +{
> > +       struct uart_port *port = data;
> > +       unsigned int isr;
> > +
> > +       isr = litex_read32(port->membase + OFF_EV_PENDING);
> > +
> > +       spin_lock(&port->lock);
> > +       if (isr & EV_RX)
> > +               liteuart_rx_chars(port);
> > +       spin_unlock(&port->lock);
> > +
> > +       return IRQ_RETVAL(isr);
> 
> I don't follow this. If you've handled the RX IRQ, you want to return
> IRQ_HANDLED. And if it's a different bit set you haven't handled it.

Since I only enabled RX IRQs, it didn't occur to me that events would
still be generated for the TX path, regardless. I've made that clearer
(as an intermediate step) in the RX-path irq patch.
 
> > +}
> > +
> >  static void liteuart_timer(struct timer_list *t)
> >  {
> >         struct liteuart_port *uart = from_timer(uart, t, timer);
> >         struct uart_port *port = &uart->port;
> >
> > -       liteuart_rx_chars(port);
> > -
> > +       liteuart_interrupt(0, port);
> >         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> >
> > @@ -165,19 +180,48 @@ static void liteuart_stop_rx(struct uart_port *port)
> >  static int liteuart_startup(struct uart_port *port)
> >  {
> >         struct liteuart_port *uart = to_liteuart_port(port);
> > +       unsigned long flags;
> > +       int ret;
> > +       u8 irq_mask = 0;
> >
> > -       /* disable events */
> > -       litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +       if (port->irq) {
> > +               ret = request_irq(port->irq, liteuart_interrupt, 0,
> > +                                 DRV_NAME, port);
> > +               if (ret == 0) {
> > +                       /* we only need interrupts on the rx path! */
> 
> Why not use the tx interrupts too?

I've added another commit that also handles TX-mode IRQs (had to
rewrite the entire TX path to be compatible with both IRQ mode and
callable from the poll timer if IRQs are not supported).

> > +                       irq_mask = EV_RX;
> > +               } else {
> > +                       pr_err(DRV_NAME ": can't attach LiteUART %d irq=%d; "
> > +                              "switching to polling\n", port->line, port->irq);
> 
> put the string on the one line so it's grepable.
> 
> Take a look a the help for pr_fmt in include/linux/printk.h. This way
> you get the driver name prefix for all pr_ messages.

Got it, thanks!

> > +                       port->irq = 0;
> > +               }
> > +       }
> >
> > -       /* prepare timer for polling */
> > -       timer_setup(&uart->timer, liteuart_timer, 0);
> > -       mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +       if (!port->irq) {
> > +               timer_setup(&uart->timer, liteuart_timer, 0);
> > +               mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +       }
> > +
> > +       spin_lock_irqsave(&port->lock, flags);
> 
> Are you sure we need to take a lock and disable interrupts here?
> 
> > +       litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
> > +       spin_unlock_irqrestore(&port->lock, flags);
> >
> >         return 0;
> >  }
> >
> >  static void liteuart_shutdown(struct uart_port *port)
> >  {
> > +       struct liteuart_port *uart = to_liteuart_port(port);
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&port->lock, flags);
> 
> same as above. I think the reason for doing this might have been if
> you had a set of registers to change inside the critical section that
> you needed to appear atomic. But this hardware only has one register
> to flip, so we can do without the locking.

Got rid of the locks in v3.

Thanks,
--Gabriel

> > +       litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +       spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +       if (port->irq)
> > +               free_irq(port->irq, port);
> > +       else
> > +               del_timer_sync(&uart->timer);
> >  }
> >
> >  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> > @@ -266,6 +310,13 @@ static int liteuart_probe(struct platform_device *pdev)
> >                 goto err_erase_id;
> >         }
> >
> > +       /* get irq */
> > +       ret = platform_get_irq_optional(pdev, 0);
> > +       if (ret < 0 && ret != -ENXIO)
> > +               return ret;
> > +       if (ret > 0)
> > +               port->irq = ret;
> > +
> >         /* values not from device tree */
> >         port->dev = &pdev->dev;
> >         port->iotype = UPIO_MEM;
> > --
> > 2.37.3
> >
