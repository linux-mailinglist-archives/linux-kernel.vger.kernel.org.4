Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD06DDF77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDKPU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjDKPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:20:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FDD618C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:19:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54ee9ad5eb3so159530037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681226344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z94otRoELhdDX5XF9P0xb9HDaaQqnlDiYK8q9SP6aro=;
        b=UpBGglSeP63l5QlpJKeJHo4nVkt21GvEkWyhznZJusGTIhe+dwVyIYuUHxJWcsc4Du
         fIDWf9esNmo9621znGhhDSOz3HNq96kOl4DOL/f9gzfmq8940P3axMUrrbRZ//T3qxlG
         DBaYb6lGx9hIEAJcAvTmgnMJryYakBPD7NmaTTjW8K6ta8VP/73QfHJVrkV5LOMqtl/E
         97oP6ukPJeHv405yKxTW6XeSJA8ypa3QLr/y643SvaIYPIrcP8ufTJTGGdG78fzPWc+j
         cXFXgwibNtP45tTG2oQoxOC3lGrqPTW0f5e9oyLWHPUwZ2bjEA+vP0+LYTYQpRPK7Cyt
         hHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681226344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z94otRoELhdDX5XF9P0xb9HDaaQqnlDiYK8q9SP6aro=;
        b=yq8XmYSN6W6jJTMPE6tesTeZKD3i6CVUnrIx1+lHKsiU2UB5ytWi/o1ZDzOJZWbinI
         0yYh3fH0eSM6a99HopUruJpQTl75EuScU552fmiAxJTj9fcWRa2msW6et+8mUP3++1KJ
         UlAd8DjJLMl5bIQYFIMmWAodYkG2wSyT+1Gdjmw4QZvDkLNuFlUk1PHl+R8rSA3F3umL
         lZW6MTacDfRIvmLVfzVXYenJFWpHqXj+na2kYAAQn15Sp1mV0ZBMdlGpbMm4ZL52+fSx
         kZn3DaEYo540QPOE7+ylKuQy1l8GdXqnJwfITdG0w8IDnyh10wFI3DrdqsUGKAL6JCEb
         o17Q==
X-Gm-Message-State: AAQBX9fZFGzhh7fMd3X2pkOlVKSoljoaYwOO+x2aOL7UrAXz3nQYtkR5
        l+CC1eqHIC6dLU5YJQtCMdUNkH8eZ9R8NrEc8Ba7zw==
X-Google-Smtp-Source: AKy350Y9ToOppF+h7+vGzOwUOJZKMX1FepajMnDzQWPf2kAQy23tMaEpy36JLNuiWchIPHQvzoiiFuLEBY3yfShEVoI=
X-Received: by 2002:a81:a744:0:b0:54f:69a4:151e with SMTP id
 e65-20020a81a744000000b0054f69a4151emr1863888ywh.8.1681226344267; Tue, 11 Apr
 2023 08:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com> <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com> <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com> <20230411150916.24vagjzbhshaujse@mobilestation>
 <ZDV6FKd/TupHEPMf@smile.fi.intel.com>
In-Reply-To: <ZDV6FKd/TupHEPMf@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 11 Apr 2023 20:48:52 +0530
Message-ID: <CAOSNQF3JQKVgvp5M17SzeyF5LB85_ZvkRpp3PZkCYcGcqm8V2g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 8:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote:
> > On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> > > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
>
> ...
>
> > > > > > -     if (n_bytes =3D=3D 1)
> > > > > > +     switch (n_bytes) {
> > > > > > +     case 1:
> > > > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > > -     else if (n_bytes =3D=3D 2)
> > > > > > +     case 2:
> > > > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > > -
> > > > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > >
> > > > > > +     case 3:
> > > > >
> > > > > I'm not sure about this.
> > > >
> > > > This actually makes sense seeing the function argument can have val=
ues
> > > > 1, 2, _3_ and 4:
> > > > dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYT=
E);
> > > > transfer->bits_per_word =3D __F__(master->bits_per_word_mask =3D SP=
I_BPW_RANGE_MASK(4, 32));
> > > > ...
> > > > dw_spi_dma_convert_width(dws->n_bytes)
> > > >
> > > > The spi_transfer.bits_per_word field value depends on the
> > > > SPI peripheral device communication protocol requirements which may
> > > > imply the 3-bytes word xfers (even though it's indeed unluckily).
> > > >
> > > > This semantic will also match to what we currently have in the
> > > > IRQ-based SPI-transfer implementation (see dw_writer() and
> > > > dw_reader()).
> >
> > > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that. Why=
 we don't
> > > use it?
> >
> > We could but there are two more-or-less firm reasons not to do
> > that:
> > 1. There aren't that much DMA-engines with the
> > DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SSI just
> > ignores the upper bits if CTRLR0.DFS is less than the value actual
> > written to the DR registers. Note DW DMAC engine isn't one of such
> > controllers. So if we get to meet a peripheral SPI-device with 3-bytes
> > word protocol transfers and the DMA-engine doesn't support it the
> > DMA-based transfers may fail (depending on the DMA-engine driver
> > implementation).
> > 2. The DW APB SSIs (3.x and 4.x) can be synthesized with the APB Data
> > Bus Width of 8, 16 and 32. So no matter whether DMA-engine supports
> > the 3-bytes bus width the system bus most likely will either convert
> > the transfers to the proper sized bus-transactions or fail.
> >
> > So taking all of the above into account not using the
> > DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using it with
> > a risk to fail some of the platform setups especially seeing the DW
> > APB SSI ignores the upper bits anyway.
>
> But this is not about SPI host hardware, it's about the consumers.
> They should know about supported sizes. Either we add the corresponding s=
upport
> to the driver or remove 3 case as I suggested. I don't think it's correct=
 to
> use 3 as 4.

Another thing to add is that as per spi.h even if bits per word is a
not a power of 2 the buffer should be formatted in memory as a power
of 2
...
 * @bits_per_word: Data transfers involve one or more words; word sizes
 * like eight or 12 bits are common.  In-memory wordsizes are
 * powers of two bytes (e.g. 20 bit samples use 32 bits).
 * This may be changed by the device's driver, or left at the
 * default (0) indicating protocol words are eight bit bytes.
 * The spi_transfer.bits_per_word can override this for each transfer.
...
Hence for n_bytes =3D 3 or 24 bits/per word we expect the client SW to
format it to 4 byte buffers hence the transaction generated should
also be of size 4 from the DMA.

>
> > > > > > +     case 4:
> > > > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > > +     default:
> > > > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Thanks
Joy
