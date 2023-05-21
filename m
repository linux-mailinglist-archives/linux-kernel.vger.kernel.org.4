Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751170AFE2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEUT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEUT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:26:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D7CF;
        Sun, 21 May 2023 12:26:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-623a5f60355so19747256d6.1;
        Sun, 21 May 2023 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684697170; x=1687289170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSIX8vDwByGiuf9XImtsgY4eRRMEysR78L9JAlMu3Ig=;
        b=JhJPm73vwxrNwqGw0lFx34J+HuCdkAC0hAlaQN+NE+UazII5iVDxH0EKTyCA7YVJAJ
         Z22N+zxfIi5TAbcO6U2Wlo6ET46oWfKY5wT9fqksxHEMZH6b4/t1a+/bGcP+IItVPqP8
         bc5cs5dhUv310p+AwqeH5XlIZjddeVflFYVaEpu0HF/dCVcLPQmotRWCkzAUW55gzhMI
         nkSGdM7DTl6rujnPaRbBI40NfLUsb05stdoL9PlMOIaq/UaUd2IvyusiueCu9m0kSX73
         2We10Xl8xGemp0mGjHtWQNJGIpT0tewztpU7dbGw3MROP2Q1DaR0d2vS0UJnOCmGT2z1
         PWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684697170; x=1687289170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSIX8vDwByGiuf9XImtsgY4eRRMEysR78L9JAlMu3Ig=;
        b=S43H2tHUURH9Lkn30whnvNb7YE+MyKi0+VBAihnoaRjk7wLJuumth6E9w0mOt2nhMq
         ryEY0RHd79fKA3qROUAanA91r2TtyZ8RSnsuzAGV/KOl5FZxSzyyQaLCc2ggjoZqa1t8
         CadthehDBkr5luVCa5wimdzHbzUazwbE9qTAWnCvUOwVR0jnTCglked84nW5HX6HlzLY
         VnYNeaLKr4aqhINLyRR8B53CCBb+mRX3Qi+cV/qWwL1LWBkk9IhP5R0i5HsTjTedvTJP
         I+mxc9fyaPz7PrZCg7xtu4eqGVRSzAbPIt0p/P/Km129G39OPQqSqN81773ey1vJOGKH
         CZgQ==
X-Gm-Message-State: AC+VfDw3cLrtocdDZW5qtt0Hzbhm25sEi+AywPcsamviqi8hIpOVSn/p
        jtWIHY9xg2AGe2sXtOLAMbBPMdc4HZFyrW8M5Xs=
X-Google-Smtp-Source: ACHHUZ4YUR2yJgEr53znAfdqjDPeNjt8PiCTyNjYiBm5U+dqZXoLOxTtPvHBLVYa2NXsclfIUE/eT/Y0hWhAePqVxz0=
X-Received: by 2002:a05:6214:d4b:b0:616:5c8b:582 with SMTP id
 11-20020a0562140d4b00b006165c8b0582mr17824485qvr.37.1684697169751; Sun, 21
 May 2023 12:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
 <20230520190856.34720-5-boerge.struempfel@gmail.com> <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
 <CAEktqcv3NEZKmxBdCjf29JbSbFfTzZB9p0yXF+btVrNYO5XU4w@mail.gmail.com>
In-Reply-To: <CAEktqcv3NEZKmxBdCjf29JbSbFfTzZB9p0yXF+btVrNYO5XU4w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 May 2023 22:25:33 +0300
Message-ID: <CAHp75Vf37xb=yMeUM6exPaZDvrzQzwD53MGU2uR4aC0rPeTzAw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
To:     =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 2:35=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
<boerge.struempfel@gmail.com> wrote:
>
> Am So., 21. Mai 2023 um 11:00 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> >
> > On Sat, May 20, 2023 at 10:09=E2=80=AFPM Boerge Struempfel
> > <boerge.struempfel@gmail.com> wrote:
> > >
> > > Added the three missing spi mode bits SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP=
,
> > > and SPI_MOSI_IDLE_LOW. Due to the length of the new options, the
> > > indentation of the options in the help message was also adjusted for =
all
> > > other options.
> >
> > Actually since you are touching all of them in the user-visible
> > output, you may also reshuffle them to be grouped logically. I'm not
> > sure if the switch-case ordering would be nice to have shuffled as
> > well. If so, in this case it might be better to have it as a
> > preparatory patch before you adding new options (and hence take care
> > of indentation in the first patch). That said, just think about it,
> > I'm not insisting.
> >
>
> Thanks for the suggestion. I tried coming up with a logical way of
> ordering, but I am having some difficulties deciding. What do you
> think of the following order?
>
> general device settings
> " -D --device device to use (default /dev/spidev1.1)\n"
> " -s --speed max speed (Hz)\n"
> " -d --delay delay (usec)\n"
> " -l --loop loopback\n"
>
> spi mode
> " -H --cpha clock phase\n"
> " -O --cpol clock polarity\n"
> " -F --rx-cpha-flip flip CPHA on Rx only xfer\n"
>
> number of wires for transmission
> " -2 --dual dual transfer\n"
> " -4 --quad quad transfer\n"
> " -8 --octal octal transfer\n"
> " -3 --3wire SI/SO signals shared\n"
> " -Z --3wire-hiz high impedance turnaround\n"
>
> additional parameters
> " -b --bpw bits per word\n"
> " -L --lsb least significant bit first\n"
> " -C --cs-high chip select active high\n"
> " -N --no-cs no chip select\n"
> " -R --ready slave pulls low to pause\n"
> " -M --mosi-idle-low leave mosi line low when idle\n"
>
> data
> " -i --input input data from a file (e.g. \"test.bin\")\n"
> " -o --output output data to a file (e.g. \"results.bin\")\n"
> " -p Send data (e.g. \"1234\\xde\\xad\")\n"
> " -S --size transfer size\n"
> " -I --iter iterations\n");
>
> misc
> " -v --verbose Verbose (show tx buffer)\n"

Looks great to me, thank you for doing that!

--=20
With Best Regards,
Andy Shevchenko
