Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08986344C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiKVTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiKVTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:41:33 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2716903AB;
        Tue, 22 Nov 2022 11:41:30 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g10so11032364qkl.6;
        Tue, 22 Nov 2022 11:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WN1Z8b2npo9zrcc7Ye3tJUfPHpOwBCPYefSwPRJW7pk=;
        b=FSWzI2FQbl+j/4kon7wpjHSzJdGTF8yPNOk58HShrQ4wmDgw2J34ym+0iwIN3Q+4BW
         514Ys3B2UmkNk9GnnIceg/6AIeXqxeXja2W+mQSo6sACvuOHTQDFVSKi4cgWc8gxUGdW
         bVTTPOr5S/9UwHKSuRNSSuIBYIbMx9dafDSu75ANNKnDM1SW68D0WOfn0ujUUt0dCDrP
         9YvyYZSEcKSVd0UW4grXcjBecoeq7n/I679JROcprqcXVXfCrRs1/+2l88PRm92bqlN8
         rzZ1+dhsFp/xya57GGmlzjhLWHRXxdrg0c1xF8rUwfjZx5fGPo9DdeQ5N0B4atARklGD
         TCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN1Z8b2npo9zrcc7Ye3tJUfPHpOwBCPYefSwPRJW7pk=;
        b=bNEZNdjDt7gUxVILDvCo+jBsL6eFwZDEAENzfW5nGZyuk1FqFk0iZHQkThMVUl/Bmz
         JqVVj5Cvy1fUz3Kch1y0JFAP4l44R2PeosCp4eTyVzl6QsimOtqX60pyQuP8KFbFTQ1w
         VaBLf+5fxE6VlCK3Jgky8AsyNwmKD6QDww9rT0af0cJoBlyFgfFc6fwW3DlVWnPsoMiO
         qjfbz6XmTG0j+TAxFF/5a/bGioWcELEhQnDknQ79xvv+Qn/ufKi9DjG3SoQsSydZ+IhK
         ZBxZf/3BKP5NQJYti3Dtga0Myvt8A++BpwmJLVCjGITy+wk74ibfV2DG8kjbkCXa5h0+
         INIg==
X-Gm-Message-State: ANoB5pkwaB0cbctgogcHOr7NVh7b0knB/3xwAC0tue42PWMHvgCskXQU
        s4eZbSDByd4X990rClLBnjQ=
X-Google-Smtp-Source: AA0mqf655e1XgJg6QxPsCpvhZuW2dH6rseugSp2pLwMxwVgulJYI60p77mAGbK4Krp/Zb5mmNjeo0g==
X-Received: by 2002:a37:a807:0:b0:6f1:9cb:deda with SMTP id r7-20020a37a807000000b006f109cbdedamr5323092qke.589.1669146089938;
        Tue, 22 Nov 2022 11:41:29 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a404500b006fb11eee465sm10791017qko.64.2022.11.22.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:41:29 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:41:27 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX
 path
Message-ID: <Y30l53r3SJCHiXjj@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-13-gsomlo@gmail.com>
 <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org>
 <Y3vIi2OF5t4IrCS1@errol.ini.cmu.edu>
 <8dd90e39-087e-984c-c289-dbfa766359a8@kernel.org>
 <CAMuHMdV3_YhF454J3ixRjOgWzJhL_Qr_XqxtSqxjF0qxGotFQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV3_YhF454J3ixRjOgWzJhL_Qr_XqxtSqxjF0qxGotFQw@mail.gmail.com>
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

On Tue, Nov 22, 2022 at 10:54:45AM +0100, Geert Uytterhoeven wrote:
> On Tue, Nov 22, 2022 at 8:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 21. 11. 22, 19:50, Gabriel L. Somlo wrote:
> > >>>    static void liteuart_timer(struct timer_list *t)
> > >>>    {
> > >>>     struct liteuart_port *uart = from_timer(uart, t, timer);
> > >>>     struct uart_port *port = &uart->port;
> > >>> -   liteuart_rx_chars(port);
> > >>> -
> > >>> +   liteuart_interrupt(0, port);
> > >>
> > >> Are you sure spin_lock() is safe from this path? I assume so, but have you
> > >> thought about it?
> > >
> > > I checked and at that point `in_serving_softirq()` is true.
> > >
> > > *However*, after studying spin_lock() and friends for a while, I'm
> > > not quite clear on whether that unequivocally translates
> > > to "yes, we're safe" :)
> >
> > Depends whether some hard irq context is grabbing the port lock too. If
> > it does, it will spin forever waiting for this soft irq to finish (never
> > happens as it was interrupted).
> >
> > > As such, I'm inclined to switch to `spin_lock_irqsave()` and
> > > `spin_unlock_irqrestore()` even in the interrupt handler, which is
> > > explicitly stated to be "safe from any context":
> > > https://www.kernel.org/doc/html/v4.15/kernel-hacking/locking.html#cheat-sheet-for-locking
> >
> >
> >
> > > The alternative could be to set `TIMER_IRQSAFE` in `timer_setup()`,
> > > but no other tty driver seems to be doing that, so I'd be a bit off
> > > the beaten path there... :)
> >
> > Ah, no.
> >
> > > Please do let me know what you think about this, particularly if you
> > > consider going the spin_lock_irqsave-everywhere-just-to-be-safe route
> > > overkill... :)
> >
> > If you are unsure about the other contexts, irqsave/restore is the way
> > to go. It can be lifted later, if someone investigates harder.
> 
> Inside the interrupt handler, plain spin_lock() should be OK.
> Inside the timer handler, I think you need to use spin_lock_irqsave(),
> as e.g. liteuart_set_termios() (and lots of code in serial_core.c)
> already uses spin_lock_irqsave().
> Besides, on non-SMP, spin_lock() doesn't do anything, so you need
> to rely on disabling the local interrupt.

Thanks Geert for the clarification! I could write two wrappers around
the actual code doing the interrupt handler work, one with spin_lock()
for the actual irq handler and another with spin_lock_irqsave() for
the timer codepath. But to keep things simple I'm inclined to simply
use spin_lock_irqsave() and add a comment saying it's because we need
it when polling and it's not actually harmful when using IRQ.

Thanks,
--Gabriel
 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
