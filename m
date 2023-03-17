Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53326BF5E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCQXCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCQXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:02:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86939B8B;
        Fri, 17 Mar 2023 16:01:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so8283085lfa.7;
        Fri, 17 Mar 2023 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679094076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d64VTS3H/hQCVevs/K9IeMjwa0xROsZzOzjIMd4x2oU=;
        b=SxEVbnhanveHZI9x3fHndaJXQjU7fI0Wu6oJkUwGwqc+U54VM+UGnJkJQEUGTYiUa9
         SwRD8lN6GQXMq23Ph1tisvU0zs+1MEQbaSWXh1di8XJAtRMeJutW0OD5t3nsNhpipbUW
         iLpSF/BCmtMjEaJzhPh6/ExCROoO4KZA503t/C/iA+p06i2lKf5Xm89UvELeweoD9PBy
         IfnkY853vwjX9HmbgFbOO3MFnq+PYGWaZnk2vB3tNj96UxmAyANeyhJV1Gt3qTDEk0Ue
         8BXx+rjtdl5G4A/ILcsCKQfwgPz1HvuvbAwA+xp4nO9U2+YgwCy5GFjtZ3O1MP+E72bQ
         CapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d64VTS3H/hQCVevs/K9IeMjwa0xROsZzOzjIMd4x2oU=;
        b=C9PcX+fxXdKsBZZq4qLzRzDUgTBUPWffX+qUHebU4NBqLMvdIgLu8BCO7+EVQNz03U
         uIHof9+CxZPwpSHJfDlt9ZaUIkiodQGNWny9MrJEO34fXWel3rRd8/qSmuyXULbimChw
         bx/UsEEtGPbXGwfmvHhWH9Xc454cD6HSgiMYpz6uG8V5TFAIb/AqEvPJKRBy7owhOE+o
         nVahu2KU6mgWN8+q+2UgrriX5BUBKyWPP61c8VdDKbg1kWA46EAkt0GXVryfyNAWOLyC
         dAbWRhDdXPP97yb4vqYPYwyLLUCZTs4CQjyhcdpnf6qUg7IeFF92Mbgd4SA8ZRZYgEGN
         E5HA==
X-Gm-Message-State: AO0yUKU9Z26Yf0V/trp+DHq6YjnE7jjAuAccXAILLZhB5mdcidpAiN2R
        pe1NEGYfMUOhwKycOOV8qkQ=
X-Google-Smtp-Source: AK7set9BBDltTB7cBFgGTU3bs76lcrf8MXOaI8rjoUKS9r2h+JanNA82K1hMMr9cav2//1HgQtl2xQ==
X-Received: by 2002:a05:6512:218b:b0:4dc:260e:6b59 with SMTP id b11-20020a056512218b00b004dc260e6b59mr4433595lft.40.1679094076034;
        Fri, 17 Mar 2023 16:01:16 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y1-20020a197501000000b004dcf20843efsm558585lfe.239.2023.03.17.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:01:15 -0700 (PDT)
Date:   Sat, 18 Mar 2023 02:01:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jack Chen <zenghuchen@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>
Subject: Re: [PATCH] spi: dw: remove delay between write and read
Message-ID: <20230317230113.w42ro62xkkjk2kpa@mobilestation>
References: <20230310153151.293608-1-zenghuchen@google.com>
 <20230311022334.he6ev6tswfc2xcwo@mobilestation>
 <CALvyBcWewTs5pRwXktKcAuCOogXgQ8jkiwp5ToG7T+Dr2qaJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvyBcWewTs5pRwXktKcAuCOogXgQ8jkiwp5ToG7T+Dr2qaJjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack

On Wed, Mar 15, 2023 at 02:06:36PM -0400, Jack Chen wrote:
> Hi Serge,
> 
> > On Fri, Mar 10, 2023 at 10:31:51AM -0500, Jack Chen wrote:
> > > Delay between write and read in polling mode is not necessary in dw spi
> > > driver. It was added assuming that dw spi controller need the delay to
> > > send data from tx fifo to spi devices. But it is not needed because
> > > following reasons:
> > > 1) dw spi datasheet claims transfer begins when first data word is
> > >    present in the transmit FIFO and a slave is enabled. So at least we
> > >    do not need the full fifo-size-transfer time delay.
> > > 2) in practice, due to spi devices implementation, spi full-duplex
> > >    (write and read real data) is always split into two transfers.
> 
> > In practice the delay is specifically added to minimize the dummy
> > loops in the poll-based transfer. It's calculated based on the number
> > of bytes pushed to the Tx FIFO and the SPI-bus clock rate (that's why
> > the spi_transfer.effective_speed_hz field is initialized in the
> > driver). So after all of them are transferred we get to start reading
> > data from the Rx FIFO. Until then the kernel thread is supposed to
> > sleep giving up the CPU for another tasks.
> 

> Thanks so much for your feedback. I understand the purpose of the specifically
> calculated delay now. However, whether freeing cpu to other threads actually
> depends on the size of delay. If the delay is smaller than 10 us, normally it
> will cause busy-looping in cpu instead of freeing it.

Of course it will, but the delay-based busy-loop in a lot of archs
adds the cpu_relax() call (or something arch-specific) which reduces
the CPU power consumption or yield it to a hyperthreaded twin
processor. In this particular case there is another positive side
effect of busy-looping instead of clobbering the device CSR. Since the
DW SSI device normally resides on the APB bus which isn't that
performant (in our case for instance it's just of 50MHz clock rate) to
begin with, but also may have several devices attached. In the later
case all the accesses would be serialized. Thus reducing the amount of
accesses to our controller we leaving a wider access window for the
concurrent threads reaching the devices on the same APB bus. So having
the delays in the poll-loop here is surely useful.

> And the delay does not work in all cases.

I wouldn't say "it doesn't work". It works but based on what you say
the actual delay isn't always as requested. That indeed might be a
problem.

> For example:
> if I am running the spi at 20M with a fifo size to be 8, and transfering a huge
> chunk of data (4096 bytes) in one transfer, based on the delay calculation, it
> would add a 3200 ns delay between each sub-transfer, which is transformed to
> 4us delay and in most cases on most platforms, udelay is not precise enough and
> I measured >= 5 us delay in most cases on my platform. So at least 1.8 us extra
> delay is added. Considering the time to fill tx_fifo, let's round it to 2us.
> The actual time needed to transfer 8 bytes at 20M speed is just 3.2 us but we
> added an extra delay of 2 us on average. When we consider the whole chunk of
> data (4096 bytes) in the whole transfer, we added more than 1 ms delay. 

Nice observation BTW. Indeed the extra delay gets to be relatively
significant for the high-speed transfers performed on the devices with
the shallow FIFO. But you shouldn't have added the tx/rx fifo
write/read duration to the extra delay. It is persistent in anyway. So
the extra delay in your case is 1.8us. After removing the udelay lag
you measured there is only 0.8us left. So the certain extra delay
indeed causes a bit less than 20% overhead in the example. Seeing the
spi_delay_exec() rounds up the ns-us translated value, the worst case
would be of the 50% overhead (for 1.001 us delay if I am not mistaken).

Getting back to the extra-extra delay you measured. Indeed udelay
guarantees the minimal delay to perform. In practice it can be greater
than requested due to multiple reasons (IRQs, CPU freq scaling, etc).

> This
> extra delay is long enough to fail a big chunk of data transfer applications (
> e.g. image, audio.).

What do you mean by "fail"? For example using an audio device with the
DW SSI controller in the example (shallow FIFO, no interrupts/polling
mode) wouldn't work well anyway but mainly due to another reason -
possible rescheduling may cause random audio stream jitter. For the
same reason the live image transferred for instance to a display/LCD
controller may look as lagging or having random artifacts. Moreover if
the platform is designed to use the DW SSI native CS, none of the above
devices would work well at all. So to speak I just wouldn't recommend
to use such weakly capable DW SSI controller driving these peripheral
devices.

BTW in the example above are you talking about a real hardware you
have or just hypothetical? Because having DW SSI with FIFO of just 8
bytes deep is a very rear case. In a well-design platforms I doubt it
would be used to work with the peripheral devices requiring
heavy-traffic. In our platform it's used for the boot SPI-flash. For
which the extra delay you detected isn't that critical since it's used
only for the system firmware bootup and in the EEPROM mode. Yes, we do
support the firmware update from Linux, but having extra seconds in
that procedure doesn't hurt at all.

> 
> To overcome the extra delay, maybe we can consider the following two
> proposals:

> 1) add a node in dts and allow users to enable the delay in polling mode.

Certainly no. The delay is the SPI-xfer implementation specific
feature. It shouldn't be tuned up in the device tree, which
is supposed to describe the platform hardware only.

> 2) Let's compare the needed delay time (bytes to transfer in tx fifo) to 10 us,
>         and only call spi_delay_exec when the delay is bigger than 10 us. Since
>         When the delay is smaller than 10 us, short delay calls
> (ndelay/udelay)
>         are just busy-loops, even calling delay won't freeing cpu to
> other tasks.
> What is your opinion?

Recalculating delay just in order to then call spi_delay_exec() which
would calculate the same delay again doesn't seem like the best
choice. What about reducing the amount of xfer words participating in
the delay calculation? Like this:

/*
 * Let the delay expire a bit earlier in order to start refilling FIFO
 * approximately at the moment of getting it empty.
 */
delay.value = nbits * min(dws->fifo_len - X, dws->rx_len - dws->tx_len);

-Serge(y)

> Thanks
> Jack Chen
> 
> On Fri, Mar 10, 2023 at 9:23 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Jack
> >
> > On Fri, Mar 10, 2023 at 10:31:51AM -0500, Jack Chen wrote:
> > > Delay between write and read in polling mode is not necessary in dw spi
> > > driver. It was added assuming that dw spi controller need the delay to
> > > send data from tx fifo to spi devices. But it is not needed because
> > > following reasons:
> > > 1) dw spi datasheet claims transfer begins when first data word is
> > >    present in the transmit FIFO and a slave is enabled. So at least we
> > >    do not need the full fifo-size-transfer time delay.
> > > 2) in practice, due to spi devices implementation, spi full-duplex
> > >    (write and read real data) is always split into two transfers.
> >
> > In practice the delay is specifically added to minimize the dummy
> > loops in the poll-based transfer. It's calculated based on the number
> > of bytes pushed to the Tx FIFO and the SPI-bus clock rate (that's why
> > the spi_transfer.effective_speed_hz field is initialized in the
> > driver). So after all of them are transferred we get to start reading
> > data from the Rx FIFO. Until then the kernel thread is supposed to
> > sleep giving up the CPU for another tasks.
> >
> > > Delay between spi transfers may be needed. But this can be introduced by
> > > using a more formal helper function "spi_transfer_delay_exec", in which
> > > the delay time is passed by users through spi_ioc_transfer.
> >
> > This is wrong. spi_transfer.delay is supposed to be executed after the
> > whole transfer is completed. You suggest to to do that in between some
> > random data chunks pushed and pulled from the controller FIFO.
> > Moreover that delay is already performed by the SPI-core:
> > https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L1570
> >
> > -Serge(y)
> >
> > >
> > > Signed-off-by: Jack Chen <zenghuchen@google.com>
> > > ---
> > >  drivers/spi/spi-dw-core.c | 20 +++++++-------------
> > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index c3bfb6c84cab..7c10fb353567 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -379,9 +379,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
> > >
> > >  /*
> > >   * The iterative procedure of the poll-based transfer is simple: write as much
> > > - * as possible to the Tx FIFO, wait until the pending to receive data is ready
> > > - * to be read, read it from the Rx FIFO and check whether the performed
> > > - * procedure has been successful.
> > > + * as possible to the Tx FIFO, then read from the Rx FIFO and check whether the
> > > + * performed procedure has been successful.
> > > + *
> > > + * Delay is introduced in the end of each transfer before (optionally) changing
> > > + * the chipselect status, then starting the next transfer or completing the
> > > + * list of @spi_message.
> > >   *
> > >   * Note this method the same way as the IRQ-based transfer won't work well for
> > >   * the SPI devices connected to the controller with native CS due to the
> > > @@ -390,21 +393,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
> > >  static int dw_spi_poll_transfer(struct dw_spi *dws,
> > >                               struct spi_transfer *transfer)
> > >  {
> > > -     struct spi_delay delay;
> > > -     u16 nbits;
> > >       int ret;
> > >
> > > -     delay.unit = SPI_DELAY_UNIT_SCK;
> > > -     nbits = dws->n_bytes * BITS_PER_BYTE;
> > > -
> > >       do {
> > >               dw_writer(dws);
> > > -
> > > -             delay.value = nbits * (dws->rx_len - dws->tx_len);
> > > -             spi_delay_exec(&delay, transfer);
> > > -
> > >               dw_reader(dws);
> > > -
> > > +             spi_transfer_delay_exec(transfer);
> > >               ret = dw_spi_check_status(dws, true);
> > >               if (ret)
> > >                       return ret;
> > > --
> > > 2.40.0.rc1.284.g88254d51c5-goog
> > >
