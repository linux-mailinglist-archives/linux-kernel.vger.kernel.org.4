Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069F6619C7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjAHVMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjAHVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:12:20 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE09DED3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:12:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so4163918otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1kKJBYwNUCt9hGCKqI4KeCLjdPj9gRmHwnMJ2E9g1g=;
        b=qAApsNIDWS6FSUNZDU7BqB1YSIGG77YQ87rZpEcF7vNpMTCF+4gPVg88/ZkZA24h/l
         RO34JejkpdSUZ8fVC7Ahhm+XsD37GzbJPG7RZIUITTHjQajm6FeUP+twINU8GoqBPzvT
         KEOdkiEt4hAq/qlk35kjk015U5usJnMQTfL6uysKRAHkB7vCjQHKjpRLAQRSmljEbNHx
         Ml7QWfp/OMPkNLvXRlrUV/pA4O+YRMttXRC7ywezUBYqUodb7bHlaNKcPBvRG/MwAvbS
         l3kV+HyK4XlkPu73PuJZTTc62yKXF+axOJoSr6J15sptfGHK5l3AfUsP59UbCRIiWv+O
         Fh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1kKJBYwNUCt9hGCKqI4KeCLjdPj9gRmHwnMJ2E9g1g=;
        b=8Gu4loaJ/GZVtjhWB2ymiti1CW1FHPoUR2iwXzGC1iQfvmsUN3NkpdVMJ3kNpkvgXp
         zQTceNjEoSXqk35ctzjBF7Lov9VGaWf26tgIEzoq3kHSv9TrZmGpyPrZSEfUgJ2nUxPa
         L7RGq3VD+4pSzEfgT3S0lhsKJyhQKDvxXZkB2a6tTahotGyy3CsLj6YSZC1FgeQbDhcP
         9SIKz7DcADFWldDy0HuWVpTD/H/bkiA9r8dcXwbeHm5eDF8w1e3UiYTCQbnLLTDw0muC
         IZbcXYuZJIArIVTSVbq2/OCZ/irn8Gu40SgK07pTNnv5MXfKYPo5UMPEvVicl9suVXBt
         MqOg==
X-Gm-Message-State: AFqh2krtz948LPz9yeaPKBZZ6nwlz3yRbcb/5UkMzYRdPBC0T7FQ6LMG
        EMhSgtpyvXo0tuYEEbiXnyKDh64Dl3MMOnTXwROj1PlV
X-Google-Smtp-Source: AMrXdXsxK3XffnNPw0pOKvIoo+NZr0mLOpsn2OYmE+jz/ZZvJLI2y/SUEl4pGC3C4C6SoDqwGJCTVyIdW2YsfpUtEOc=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr3901033otm.237.1673212334960; Sun, 08
 Jan 2023 13:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20230105134622.254560-1-arnd@kernel.org> <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com> <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com> <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
 <7a57b319-a774-4f97-af06-fe1a637a45ce@app.fastmail.com>
In-Reply-To: <7a57b319-a774-4f97-af06-fe1a637a45ce@app.fastmail.com>
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Sun, 8 Jan 2023 23:12:02 +0200
Message-ID: <CALT56yOu=Kxxc=xUYvRpy5bD5XGB01cky_ppK8LbS4AC_ra5Bw@mail.gmail.com>
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

=D0=B2=D1=81, 8 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 23:05, Arnd Bergman=
n <arnd@arndb.de>:
>
> On Fri, Jan 6, 2023, at 11:06, Dmitry Baryshkov wrote:
> > =D0=BF=D1=82, 6 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 11:47, Arnd Ber=
gmann <arnd@arndb.de>:
> >> > Is there any conversion to DT you can easily point at as an example =
of
> >> > the kinds of changes needed?
> >>
> >> Robert Jarzmik and Daniel Mack worked on the conversion of the
> >> PXA platform to DT. Daniel contributed the port for Raumfeld,
> >> which should be complete, while Robert worked on more driver
> >> conversions and mentioned[1] that he had converted additional
> >> boards in the past but did not merge it upstream. They
> >> can probably point you to whatever is missing. I would expect
> >> the generic PXA drivers (spi, mmc, nand, i2c, audio, fb, gpio,
> >> keypad) to  basically work work a correct DT description,
> >> while the machine specific drivers (scoop and pcmcia mainly)
> >> will need DT support in the driver.
> >>
> >> In addition, Linus Walleij and Marc Zyngier have both expressed
> >> interest in keeping sa1100 (h3600, collie, assabet, jornada720)
> >> alive, but those don't have any DT support yet and require
> >> much more work. Also note that while you can now build a kernel
> >> that includes support for all little-endian ARMv4T and ARMv5
> >> machines, StrongARM machine still require a separate kernel
> >> build.
> >
> > I looked into converting collie to use DT several years ago. The major
> > problem was not in the StrongARM itself , but rather in the locomo
> > (platform-specific ASIC) and PCMCIA. Unfortunately I abandoned that
> > work ages ago. RMK didn't seem to be very interested, if I remember
> > correclty.
>
> At least locomo and sa1111 are both private to mach-sa1100
> now and no longer shared with pxa, so this should get
> a little easier. When I had last looking into cleaning up
> sa1100, my impression was that the main work would be converting
> most of the drivers to use dynamic resources instead of
> hardcoded addresses and interrupts. Looking at locomo again,
> my feeling is that this could remain largely unchanged,
> as the locomo downstream drivers (led, keyboard, lcd)
> are already abstracted enough and locomo itself can
> just be an mfd or soc driver.

locomo has been used on Sharp Poodle, if I'm not mistaken. And sa1111
is used on the lubbock, one of the crazy devkits.

>
> > I suspect that the platforms might need to be rebootstrapped from the
> > ground up. This sounds like a fun project for the next Connect demo :D
> >
> > BTW: collie is also supported by the qemu (in fact at some point I
> > mostly used qemu for debugging collie). I don't think that the LCD
> > emulation works, but the rest should be mostly good.
>
> Good to know about the LCD. The qemu support was clearly a
> strong reason for keeping this machine vs the others.

sa1100 LCD controller was significantly different and it used some
special format for the buffers, so I just skipped it at that point.

>
>      Arnd



--=20
With best wishes
Dmitry
