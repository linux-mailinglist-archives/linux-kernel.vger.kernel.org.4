Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE57E70B66A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjEVHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjEVHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:24:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A067E6;
        Mon, 22 May 2023 00:23:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25566708233so704305a91.0;
        Mon, 22 May 2023 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684740232; x=1687332232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS6AzZq/eSvoo+m0IoyOP5UM3Gjpfap163FVSuhiXd8=;
        b=Ln3eNirwAtv1zul806XpV4fAQioNpIEplszABiZzthjJ8PxZ5mJVuRzJKm4E/NL6KH
         16BZWAUSOgkBbxXR0sr4Inh8moESzS3IfSxtuMq43QJmWPpqajGj/MATMJkoIcmkUaXs
         3Id8Y6e0Ax1Jfz23luxoJtMj02oxEIaET17vbme6v83loAQ2maeLGCtPRM67UMeIlAmh
         3pRpPdGfph18DA5LH6HYzhC2sMoHZeAXrQ1clBgAmWd//TSGmjv8Syplubi2oxQdpgSh
         a5TapJjVuRayP1XQ7pW+wQS53HIepu9b/yHykizx6vuu/zmtCwSJgFkk2IzMR3QmdWHy
         +GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740232; x=1687332232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS6AzZq/eSvoo+m0IoyOP5UM3Gjpfap163FVSuhiXd8=;
        b=SPiJrDlKDaWl4LwzJjHdjy8VPAPQWFtfJQN2Q3EP97fbqfyNEwnLDvgY6yp3AB0lck
         qD+jwICimmm5WCJod/vP4yHtsPXwiM/7DH3OMC6Ws9Q4u1ktwoiDejgVKA8R6shvGO8z
         fmtxrSYJtqWb278VbDkVmCIn25+bSJBsZKowL1DrhuJbvMJmDv7NsHzstFZTi7w+AM+0
         ah8hbkaavSgMnLN38K4CYeIgkK3h86P8i1A9wZetdCKPiEGKN3nEZUqpnOSTGuxucaSy
         OpscMaUmV8+beQEU6wjR5hYGR3pAmqSdqaLUj4jZh5FEPtdprasYtQvIg6gW5Mz1BUYP
         x7tg==
X-Gm-Message-State: AC+VfDxFP/x3s/9V0957GROE6XznljRF+WilTaG9GZe3u0T29z20VzM/
        twy81tMYYrkCFTaPKTmHtyTUvZMm6vBhAoe1nzHGw/Jd5QU=
X-Google-Smtp-Source: ACHHUZ610KsH/Mta+xkSSXeXx1Rl7AR0V4W+tCjVwzcr4X1pnus3NHO0cEiccXXj8UVorkMn28ZI5+7sSXvN4F8pBoU=
X-Received: by 2002:a17:90a:f68a:b0:24d:ea7f:9ea2 with SMTP id
 cl10-20020a17090af68a00b0024dea7f9ea2mr9738747pjb.15.1684740232044; Mon, 22
 May 2023 00:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
 <20230520190856.34720-5-boerge.struempfel@gmail.com> <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
 <CAEktqcv3NEZKmxBdCjf29JbSbFfTzZB9p0yXF+btVrNYO5XU4w@mail.gmail.com> <CAHp75Vf37xb=yMeUM6exPaZDvrzQzwD53MGU2uR4aC0rPeTzAw@mail.gmail.com>
In-Reply-To: <CAHp75Vf37xb=yMeUM6exPaZDvrzQzwD53MGU2uR4aC0rPeTzAw@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Mon, 22 May 2023 09:23:41 +0200
Message-ID: <CAEktqcuuM=P7p-Y4k9Z+721SCA6i1QiCebWZL3BMqh6Q7jX+4A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Am So., 21. Mai 2023 um 21:26 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Sun, May 21, 2023 at 2:35=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
> <boerge.struempfel@gmail.com> wrote:
> >
> > Am So., 21. Mai 2023 um 11:00 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > >
> > > On Sat, May 20, 2023 at 10:09=E2=80=AFPM Boerge Struempfel
> > > <boerge.struempfel@gmail.com> wrote:
> > > >
> > > > Added the three missing spi mode bits SPI_3WIRE_HIZ, SPI_RX_CPHA_FL=
IP,
> > > > and SPI_MOSI_IDLE_LOW. Due to the length of the new options, the
> > > > indentation of the options in the help message was also adjusted fo=
r all
> > > > other options.
> > >
> > > Actually since you are touching all of them in the user-visible
> > > output, you may also reshuffle them to be grouped logically. I'm not
> > > sure if the switch-case ordering would be nice to have shuffled as
> > > well. If so, in this case it might be better to have it as a
> > > preparatory patch before you adding new options (and hence take care
> > > of indentation in the first patch). That said, just think about it,
> > > I'm not insisting.
> > >
> >
> > Thanks for the suggestion. I tried coming up with a logical way of
> > ordering, but I am having some difficulties deciding. What do you
> > think of the following order?
> >
> > general device settings
> > " -D --device device to use (default /dev/spidev1.1)\n"
> > " -s --speed max speed (Hz)\n"
> > " -d --delay delay (usec)\n"
> > " -l --loop loopback\n"
> >
> > spi mode
> > " -H --cpha clock phase\n"
> > " -O --cpol clock polarity\n"
> > " -F --rx-cpha-flip flip CPHA on Rx only xfer\n"
> >
> > number of wires for transmission
> > " -2 --dual dual transfer\n"
> > " -4 --quad quad transfer\n"
> > " -8 --octal octal transfer\n"
> > " -3 --3wire SI/SO signals shared\n"
> > " -Z --3wire-hiz high impedance turnaround\n"
> >
> > additional parameters
> > " -b --bpw bits per word\n"
> > " -L --lsb least significant bit first\n"
> > " -C --cs-high chip select active high\n"
> > " -N --no-cs no chip select\n"
> > " -R --ready slave pulls low to pause\n"
> > " -M --mosi-idle-low leave mosi line low when idle\n"
> >
> > data
> > " -i --input input data from a file (e.g. \"test.bin\")\n"
> > " -o --output output data to a file (e.g. \"results.bin\")\n"
> > " -p Send data (e.g. \"1234\\xde\\xad\")\n"
> > " -S --size transfer size\n"
> > " -I --iter iterations\n");
> >
> > misc
> > " -v --verbose Verbose (show tx buffer)\n"
>
> Looks great to me, thank you for doing that!
>
You are welcome.
Should I only reorder the flags, or actually introduce the
"group"-headers to visibly distinguish the options?
 --
With best regards,
Boerge Struempfel
