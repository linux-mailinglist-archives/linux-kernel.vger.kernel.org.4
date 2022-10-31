Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846C6613923
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiJaOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJaOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:37:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4F133;
        Mon, 31 Oct 2022 07:37:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b22so1899526qtr.12;
        Mon, 31 Oct 2022 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdNQvvz/TcjuSLSWR6z7pC8eGlQDZ2fUoLnJ0hIn9JM=;
        b=FQkKnTetxtaJNkeLJ1/dTkWTe/GIK0eXJQKhWTKJvbQCO0WmoDUF3BLTB0hiObZOHJ
         BoEmo0qtTH8KjB1nvoLElLDFErGiH9+LhT6AYrTdeSD0XtNek8qOvDm0Y8kEHU5eJKi+
         8VMiddJh+9Gwy5IWG0hHZ8SmkcpUy7wZ5KQVxdJWj/O7GIlgCp93GfsQ0lM1D/jzgv9h
         IbCOmrv+CQP1MY8f5CIfVheEE1TvAlk5vSimz707iVNb6GeOhyVjmZbzASEK4bmKWl4g
         tbJTAFeXcfs+XNpP6PiWfmGE7k9JgMSFi1ltFTtg1cGhLS8ZUvifQmMyGPe+ydqmchD/
         Jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdNQvvz/TcjuSLSWR6z7pC8eGlQDZ2fUoLnJ0hIn9JM=;
        b=TjTS1zQzkrDoqLwrZbHxTjM4WhfbIpJQZSzrgsrAoApjV71VE4PL08ujUH8/Tlm1eT
         gHa0e1j7cEbIwLWygDdG3frSwhu6tNcMMZOlIxHusxX80Lh8e9qdBIvQE+15Vfxjte28
         NmW8UYKVq75P2hty+SdW235wIRk+EKXTg7c1bT7b1AJpCwZw7WG07H89jlWwSurUfYAm
         gKeJyB41dNZuW4HMxJQGH82PrXtg4DecZ5J6kSegf0tvZpnal36T47RIBIobTz8UIuQV
         4CFLZ313RDdVCBsQEzdbbhZZrk+63fsSAPQz9+j4j8CCsu6JbbnYppidIhQt233lV3Yx
         eA1Q==
X-Gm-Message-State: ACrzQf2utbiDBgDGduvqfk/zAfm8oMTjd84flsTJHdpoEnHnEd9cJrcu
        lclWoo4omsCcos8hhwW2x8od21pxJWB3QKumPUs=
X-Google-Smtp-Source: AMsMyM7Q3JYrAfRHj1F7hs4HJFdbvm4TAnI00K6PSiRyknLbZ6h33UPqd4RjNvJR8IEKNcoe+8nN/oXgDoFFrcf4yIw=
X-Received: by 2002:a05:622a:491:b0:39c:e770:2813 with SMTP id
 p17-20020a05622a049100b0039ce7702813mr10991684qtx.384.1667227077088; Mon, 31
 Oct 2022 07:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com> <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Oct 2022 16:37:20 +0200
Message-ID: <CAHp75Vf5sBJiNQckCxDGCzFWBYnVs4BhP9+m77_6guZYC+Cybg@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:24 AM <Tharunkumar.Pasumarthi@microchip.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, October 3, 2022 2:53 PM

...

> > > +       [PORT_MCHP16550A] = {
> > > +               .name           = "MCHP16550A",
> > > +               .fifo_size      = 256,
> > > +               .tx_loadsz      = 256,
> > > +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> > > +               .rxtrig_bytes   = {2, 66, 130, 194},
> > > +               .flags          = UART_CAP_FIFO,
> > > +       },
> >
> > Can you assign this in ->setup() or so instead of adding a new port type?
>
> If I understand correctly, you suggest doing something like this inside pci1xxxx_setup() API:
>
> pci1xxxx_setup(.., uart_8250_port *port, ..) {
> ..
> port->port.fifosize = 256;
> port->tx_loadsz = 256;
> port->capabilities = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01;
> ..
> }
>
> instead of adding new port type PORT_MCHP16550A.

Yes, something like this.

> But, if I do this, I cannot use sysfs interface for updating rx_trig_bytes right?

Maybe, I don't remember by heart that part of the code. But why do you
need that ABI in the first place?

-- 
With Best Regards,
Andy Shevchenko
