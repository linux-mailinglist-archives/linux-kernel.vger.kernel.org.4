Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729FA65FE82
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAFKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjAFKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:06:22 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761EBB4B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:06:19 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id c133so725310oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vufhYyKuaM03yzwyLMKdSrHc0Jyyt0go6IFE+aYx5dU=;
        b=Hkg2tWf2nul5raHY81iILW9SldIJIHR0iMD+w1OYUblUXpgfikANdxK766z1lQ/Blz
         veRzfO4RCvWthPsOLc9nHfupXTqlLxSt3u5qgBcQ0dJZwYgjGhvWmjbglPUrSsGnpph9
         q6RYskKV426R+2RAkuzXWQ2p1MsGxNsgaiGk7OJdm9IAxeJtDsipI0TE80JSGCsduCFx
         1NzEJbWAmuhBJCiT82mQE8es7EEyjd8prt1rBIE36ewo9YmWTYmC7Sf2PWEO3FW2Uopd
         UzC6GZoWWlZtDBfoXnvZ6+qoieJgb5FOXoKgwp2c6hzufGQJxbfKUQEN6GgRbb8xgOTN
         GPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vufhYyKuaM03yzwyLMKdSrHc0Jyyt0go6IFE+aYx5dU=;
        b=NA/dTKGOzebGSidM7XCh6gAR7uBIDuUENEy0Cq8sPIPLv6Zo9cf852i20yXM5q/lDw
         5M7yE3lIIc3eAPoaqn2PCQBsOgycyptPWe6HSI3ITrikGa4x2RUzpf3IwURK+wQq1DEq
         QqCio2BY9QQIvRuqmIsvD2BLbEXZ7SGUf87Pn3Ru3bQoG9Gt2g7KftQnlcb+R6KRg7it
         40NMpBw3vReuybXfdh730KdDhUqZu13ZWmHnCJFsIK8Xiqo2ibYwSZsBvL/UCtrMSdW9
         zTdX1SqbDbzZsAYLGe3IIxlyeMPFbgjF5PKR4qWw6CVqcOFTUwFlx3vp/e+L6PIed9iI
         L+kA==
X-Gm-Message-State: AFqh2ko/Nq7zA+7/cFmSHTiKTdtvQCo+nHqOqawFV1MxM0sQjql8IToZ
        ZAu7Dqf/t2h+9NYA6AozqF9HgR6tZwNe1bCPO+8=
X-Google-Smtp-Source: AMrXdXvdAL5g2CE927QCMVfyav+Kv3AHw3P1Vq/STIgBO9k+FPdRQ0H8BubgC1khqKQL9ngNukr7niskbCm6QaX4jm8=
X-Received: by 2002:a05:6808:310:b0:35e:1a37:7e52 with SMTP id
 i16-20020a056808031000b0035e1a377e52mr4083389oie.179.1672999578849; Fri, 06
 Jan 2023 02:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20230105134622.254560-1-arnd@kernel.org> <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com> <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
In-Reply-To: <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Fri, 6 Jan 2023 12:06:06 +0200
Message-ID: <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>, Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>,
        Linus Walleij <linusw@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 6 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 11:47, Arnd Bergman=
n <arnd@arndb.de>:
>
> On Thu, Jan 5, 2023, at 23:45, Richard Purdie wrote:
> > On Thu, 2023-01-05 at 23:16 +0100, Arnd Bergmann wrote:
> >> On Thu, Jan 5, 2023, at 18:05, Richard Purdie wrote:
> >> > On Thu, 2023-01-05 at 17:50 +0200, Dmitry Baryshkov wrote:
> >>
> >> In the long run, I expect we will remove all the remaining
> >> legacy boardfiles and only keep the DT support. Ideally
> >> if someone is motivated to convert spitz to DT, supporting
> >> corgi the same way is also easy.
> >
> > Personally, I'm not that interested in tosa (or poodle/collie).

I think I was one of the last devs having interest in tosa. It worked
mostly fine except the offline charging.

> >
> > The other zaurus devices are interesting for me as I know the platform,
> > they have qemu emulation, there are set of devices which are similar
> > but also have differences and there were one of the original targets
> > for OpenEmbedded and Yocto Project. I did quite a bit of work to get
> > one kernel which could run on multiple devices, as best you could at
> > the time! I'd actually forgotten about the qemu emulation.
> >
> > There is a need for better automated testing around DT in OE/YP and
> > this is making me wonder about a few potential ideas.
>
> Ok
>
> > Is there any conversion to DT you can easily point at as an example of
> > the kinds of changes needed?
>
> Robert Jarzmik and Daniel Mack worked on the conversion of the
> PXA platform to DT. Daniel contributed the port for Raumfeld,
> which should be complete, while Robert worked on more driver
> conversions and mentioned[1] that he had converted additional
> boards in the past but did not merge it upstream. They
> can probably point you to whatever is missing. I would expect
> the generic PXA drivers (spi, mmc, nand, i2c, audio, fb, gpio,
> keypad) to  basically work work a correct DT description,
> while the machine specific drivers (scoop and pcmcia mainly)
> will need DT support in the driver.
>
> In addition, Linus Walleij and Marc Zyngier have both expressed
> interest in keeping sa1100 (h3600, collie, assabet, jornada720)
> alive, but those don't have any DT support yet and require
> much more work. Also note that while you can now build a kernel
> that includes support for all little-endian ARMv4T and ARMv5
> machines, StrongARM machine still require a separate kernel
> build.

I looked into converting collie to use DT several years ago. The major
problem was not in the StrongARM itself , but rather in the locomo
(platform-specific ASIC) and PCMCIA. Unfortunately I abandoned that
work ages ago. RMK didn't seem to be very interested, if I remember
correclty.

I suspect that the platforms might need to be rebootstrapped from the
ground up. This sounds like a fun project for the next Connect demo :D

BTW: collie is also supported by the qemu (in fact at some point I
mostly used qemu for debugging collie). I don't think that the LCD
emulation works, but the rest should be mostly good.

>
>      Arnd
>
> [1] https://lore.kernel.org/all/803778517.2279639.1667493436959.JavaMail.=
open-xchange@opme11oxm02aub.pom.fr.intraorange/

--=20
With best wishes
Dmitry
