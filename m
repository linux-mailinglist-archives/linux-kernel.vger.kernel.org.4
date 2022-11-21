Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C113632C58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiKUSvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiKUSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:50:56 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D830D0DDA;
        Mon, 21 Nov 2022 10:50:55 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z17so8660633qki.11;
        Mon, 21 Nov 2022 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VWI6I/Alt68l7BZGxCkgeVUPoAdWAp4ukv15NEWA5cQ=;
        b=T0F23lAjgJ+j/89QUwR82zQ3aIwGc1ERSH8cA9gqbbFEVdq8us13t1cVtfnmPwi6kE
         7stUrNXqe8F8iqKL3opIeWXMGIHksvaICpkXGkhEJ3QpPL9F42CWoVviNxNEdh46h6jO
         wwnJHeY33x/N3Y74xCTWyYMma+7bGeiEjQLGDOC1iMpzETVL0kX1g4iAl1K1r0BH5lTl
         UhaHUpsBg4qq6ezx/rXNSV8VEBPSQshjWde17f2Hogz+YqCT5nWEo/Vq6/bDmwt1nEFu
         tfg2+HDa/qTFfCpZGH3PchYAjKGMsEPzYDeVMfOtwRGxQ/cXEjM/jaBS7P8x2J344OOp
         08fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWI6I/Alt68l7BZGxCkgeVUPoAdWAp4ukv15NEWA5cQ=;
        b=tjA84/8/NZ/u4OwqvvrKpzjZDfGYOCNKMTB1zRtU+bGeeUnUExp491x6DFhNQbapz0
         yUF9AziRpsOvio3v+kUqbiHua/LXJmABYus1h+uMUUHMjpze3VEGg0LRlV8VoHTrOEEb
         LwINJzyrQyqSOVhdwVrHKCQHpjIwwz4X6A1WfhDvB/xe8JJqBqmBhrJN98Mki/vSSB4n
         aXnOR+Cvdkl33agtwYyT6lrKq0CxmFRnvYm+RNNBPEYhXA8Owx2a9DPLMlA/Dz7gj1FY
         aassT1OePPhYxF5GiiNl/BSZa+4IaXE+UZbM9zjtx08EvDJD/izY5vM8GAlDYS7djiPW
         yjBg==
X-Gm-Message-State: ANoB5pktBxU4auWRfA4N3nz1tjbuFBzG5HchpqP123h0yF3FaHIH4IV9
        Nw/D1n0woOySAudl84JOpWQ=
X-Google-Smtp-Source: AA0mqf7A7UsUQFyB87tgBERj79ph4C0iNZ6VIfFLcWGkKanD8UXBC6NGBkNX2G0f5zuGvZ0TtoOojA==
X-Received: by 2002:a05:620a:16ad:b0:6ee:7a66:beb2 with SMTP id s13-20020a05620a16ad00b006ee7a66beb2mr1486835qkj.17.1669056654573;
        Mon, 21 Nov 2022 10:50:54 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006fbdeecad51sm6230796qkn.48.2022.11.21.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 10:50:53 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:50:51 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX
 path
Message-ID: <Y3vIi2OF5t4IrCS1@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-13-gsomlo@gmail.com>
 <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org>
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

Hi Jiri,

On Mon, Nov 21, 2022 at 09:54:34AM +0100, Jiri Slaby wrote:
> On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> > Add support for IRQ-driven RX. Support for the TX path will be added
> > in a separate commit.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > 
> > Changes from v4:
> >    - using dev_err() instead of a combo of pr_err() and pr_fmt()
> >    - dropped "get irq" comment in probe()
> > 
> > > Changes from v3:
> > >    - add shadow irq register to support polling mode and avoid reading
> > >      hardware mmio irq register to learn which irq flags are enabled
> > >      - this also simplifies both liteuart_interrupt() and liteuart_startup()
> > 
> >   drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
> >   1 file changed, 69 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 8a6e176be08e..678c37c952cf 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/bits.h>
> >   #include <linux/console.h>
> > +#include <linux/interrupt.h>
> >   #include <linux/litex.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> > @@ -46,6 +47,7 @@ struct liteuart_port {
> >   	struct uart_port port;
> >   	struct timer_list timer;
> >   	u32 id;
> > +	u8 irq_reg;
> >   };
> >   #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> > @@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> >   	litex_write8(port->membase + OFF_RXTX, ch);
> >   }
> > +static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
> > +{
> > +	struct liteuart_port *uart = to_liteuart_port(port);
> > +
> > +	if (set)
> > +		uart->irq_reg |= mask;
> > +	else
> > +		uart->irq_reg &= ~mask;
> > +
> > +	if (port->irq)
> > +		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
> > +}
> > +
> >   static void liteuart_stop_tx(struct uart_port *port)
> >   {
> >   }
> > @@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
> >   	tty_flip_buffer_push(&port->state->port);
> >   }
> > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > +{
> > +	struct liteuart_port *uart = data;
> > +	struct uart_port *port = &uart->port;
> > +	u8 isr;
> > +
> > +	spin_lock(&port->lock);
> > +	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
> > +	if (isr & EV_RX)
> > +		liteuart_rx_chars(port);
> > +	spin_unlock(&port->lock);
> > +
> > +	return IRQ_RETVAL(isr);
> > +}
> > +
> >   static void liteuart_timer(struct timer_list *t)
> >   {
> >   	struct liteuart_port *uart = from_timer(uart, t, timer);
> >   	struct uart_port *port = &uart->port;
> > -	liteuart_rx_chars(port);
> > -
> > +	liteuart_interrupt(0, port);
> 
> Are you sure spin_lock() is safe from this path? I assume so, but have you
> thought about it?

I checked and at that point `in_serving_softirq()` is true.

*However*, after studying spin_lock() and friends for a while, I'm
not quite clear on whether that unequivocally translates
to "yes, we're safe" :)

As such, I'm inclined to switch to `spin_lock_irqsave()` and
`spin_unlock_irqrestore()` even in the interrupt handler, which is
explicitly stated to be "safe from any context":
https://www.kernel.org/doc/html/v4.15/kernel-hacking/locking.html#cheat-sheet-for-locking

The alternative could be to set `TIMER_IRQSAFE` in `timer_setup()`,
but no other tty driver seems to be doing that, so I'd be a bit off
the beaten path there... :)

Please do let me know what you think about this, particularly if you
consider going the spin_lock_irqsave-everywhere-just-to-be-safe route 
overkill... :)
 
> >   	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >   }
> > @@ -161,19 +190,46 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> >   static int liteuart_startup(struct uart_port *port)
> >   {
> >   	struct liteuart_port *uart = to_liteuart_port(port);
> > +	unsigned long flags;
> > +	int ret;
> > -	/* disable events */
> > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +	if (port->irq) {
> > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > +				  KBUILD_MODNAME, uart);
> 
> Just asking: cannot the irq be shared?

Given the way LiteX gateware is currently generated, each
irq-triggering device is given its own separate line. I don't think
setting the IRQF_SHARED flag actually *hurts* anything (no difference
in behavior while testing), but I don't think it's needed ATM.

> > +		if (ret) {
> > +			dev_err(port->dev,
> > +				"line %d irq %d failed: switch to polling\n",
> > +				port->line, port->irq);
> 
> That is, it should be only dev_warn(), or?

Makes sense, will use dev_warn() in v6.

Please LMK what you think about spin_lock[_irqsave] (and IRQF_SHARED),
and I'll send out v6 with all the necessary chances right after that.

Thanks much,
--Gabriel

> > +			port->irq = 0;
> > +		}
> > +	}
> 
> thanks,
> -- 
> js
> suse labs
> 
