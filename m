Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7806329E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKUQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiKUQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:44:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C315734;
        Mon, 21 Nov 2022 08:44:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d18so4834452qvs.6;
        Mon, 21 Nov 2022 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lc2AiilXzsJ4srtdqUbRnjiRFuaullWUwryQV98QYlw=;
        b=ErUDbKbZDArACkJm04zLdU6+XehiahbA4EnNpZfoat672z9DlpCqhcCN8MmWm1mUWz
         C7x0Oudsri6s61pyuKH6DH5f2ykHuOyrRDawEjsZT72LDnHDt0sAXuPFU/5D7QRHmFEa
         QPXKcB6s09VmjbBsFFASyo/UWdQe7z7lYwn3c5uE135oOcj4llQskttnIBNy4kVZD8/D
         a2lm6G2QwazsKtZqt44BGC0pt0oo3K8IVqjxNeaJWsJjhr/oJ1F7YQITVmN0JHB5PI8p
         bD2pugquGKB/LWw0tvr19EvsUBPTFdicWEfTBFQ2ADlYRIhylzj79/xALl89PL/ZukI5
         tomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc2AiilXzsJ4srtdqUbRnjiRFuaullWUwryQV98QYlw=;
        b=VRmmarNZBHdlAmsv9SDiI89mI3UpcjFvkbPIX6amJsmdeTXKdZDa4lKrt/5/9c1iuo
         eJUhIwXHt+hFSJOpgbAEPlYdrKlNAbpE+rod4y6LoHlNRZ2c2Uyass3KCtENql/QXxch
         ZAmmjKwhBkvj8L7Wy3C9RbIuMpXHN0bw/PAvgE0O8iFb26Be5hXLagkNcaYktOMxArZy
         sAhHtuZ3ZvX9ytDIQYNqy78Gp4jIUcdOQ408B7ZgCSKolG3Kp00z6OJ7oI0A2ZXbV2QA
         96WzwKH6Lnle/+DkG0aabqNCq/2z8APd4dHayVJr9/E+uqJ9yppka/HmNx8FlXoB7+TY
         RI3Q==
X-Gm-Message-State: ANoB5pmhtQF9d45EayNVjASHh2vDrKVhvhAKzmwlRviEieYWDN8TjYk8
        W5TTjUABeCniDZUDZgibRHY=
X-Google-Smtp-Source: AA0mqf4N/CvzY8UKKr5r/ZzANZZ8+P3Pm6Z/y0X6zpXor51VaPrfSZtHU+wVhGOM0BAL4T81Zsb6+w==
X-Received: by 2002:a0c:c582:0:b0:4af:b750:b569 with SMTP id a2-20020a0cc582000000b004afb750b569mr1334123qvj.83.1669049072221;
        Mon, 21 Nov 2022 08:44:32 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id ga17-20020a05622a591100b003a6328ee7acsm5227384qtb.87.2022.11.21.08.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 08:44:31 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:44:29 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 10/14] serial: liteuart: separate rx loop from poll
 timer
Message-ID: <Y3uq7fDycHuanwkP@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-11-gsomlo@gmail.com>
 <CAMuHMdVCc5xtnRoprtdgt_ZH42j=+ivS4aD+Uceg9pny-FpzYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVCc5xtnRoprtdgt_ZH42j=+ivS4aD+Uceg9pny-FpzYQ@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 11:16:14AM +0100, Geert Uytterhoeven wrote:
> Hi Gabriel,
> 
> On Fri, Nov 18, 2022 at 3:57 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > Convert the rx loop into its own dedicated function, and (for now)
> > call it from the poll timer. This is in preparation for adding irq
> > support to the receive path.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Thanks for your patch!
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -68,10 +68,8 @@ static struct uart_driver liteuart_driver = {
> >  #endif
> >  };
> >
> > -static void liteuart_timer(struct timer_list *t)
> > +static void liteuart_rx_chars(struct uart_port *port)
> 
> So first you spin this off into a separate function, so it can be
> called from both the interrupt and polling paths.
> Later, in "[PATCH v5 12/14] serial: liteuart: add IRQ support for the
> RX path", you remove the call from the polling path...
 
That's right -- the polling path now calls the IRQ handler,
which, in turn, calls `liteuart_rx_chars()` (and later `*_tx_chars()`
as well).

The polling timer becomes just an alternative way to invoke the irq
handler, giving it a chance to take care of any pending transfers in
either/both directions.

Thanks,
--Gabriel
 
> >  {
> > -       struct liteuart_port *uart = from_timer(uart, t, timer);
> > -       struct uart_port *port = &uart->port;
> >         unsigned char __iomem *membase = port->membase;
> >         unsigned int status, ch;
> >
> > @@ -88,6 +86,14 @@ static void liteuart_timer(struct timer_list *t)
> >         }
> >
> >         tty_flip_buffer_push(&port->state->port);
> > +}
> > +
> > +static void liteuart_timer(struct timer_list *t)
> > +{
> > +       struct liteuart_port *uart = from_timer(uart, t, timer);
> > +       struct uart_port *port = &uart->port;
> > +
> > +       liteuart_rx_chars(port);
> >
> >         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> 
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
