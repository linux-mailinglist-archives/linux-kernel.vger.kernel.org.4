Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2736009E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJQJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJQJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:05:07 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F733A4A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:05:04 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id d187so10787441vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y08BEzM6DYxdnl2qnEG/br3gYbPALZULbaElMWZPm6A=;
        b=owqU7fm1s2j12IEDft/JDsVc22SaszQ8Nr/Jqw+665feERL9Pgle2zBej1aIuf9MfK
         bQiAHpB+/KdA+86G3/NAY/mNQjPMexqiwL62j3U0y3MbvBJ5BQlmegskGxKn7uDdJjSR
         xmOt/N/TqXsAaryinyTWWPY3X2zpMCQVlD6leE8JRbl+k0bdzff6p7xU42oqNO44xE90
         aRy8MKjnDY+XH33Ut4mEvoaC+OfyX6sPbNLIK1OIPVYr4bbxBMDyxDFgWaI07gCEwh4+
         1BnqiXXedgdCaKJmrqc4e5MwJyQwzFluDReccwc3+ncM7Kx4blWXvUAAvvoIZrxcjmxs
         5Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y08BEzM6DYxdnl2qnEG/br3gYbPALZULbaElMWZPm6A=;
        b=xnpe07cJEGnkzpEy8AiiZkO3Tp87GrjiUC3m0h32oPseXijZiO6Eg5y44mmSvJQDim
         VogEu4KG605btuBFAptY7dU7xzdgX6iNxOBGcOGZGGtcyBiyOmvrpESoLPoV9XC7XUeq
         MZYalMK9PVqpV1lAq9AY4ykKd1yn46jVeeCQDmBweJwsWvis3+aduE8pxy8Lu7rfulxx
         37cVpeVY0ghEzTihgfwl1Aqp4VfQqOIUglgQN1vX2tc9hGlft2jhJ2gSh2lcKo7I7qAM
         VveuQAh7DNJ27rgtj72YIDWRyvk5D6ijvlPfngHz55icaz40vpP55F4nPP1eAZ04bRRr
         e2ig==
X-Gm-Message-State: ACrzQf1fnnyEXSMIZaO9zH0ffmenkZrR3gVJtvmxaJ7A6HAc+cH7kCrw
        sk0VMnMH+s83koK+VazIUY7x8WEGM3RljZhZZ4VE5Q==
X-Google-Smtp-Source: AMsMyM5H7wjhZ2SfnPL+DgBR4vQWcXymrvWDmK0+/tG6rD0Ctq0lVpYpH41QUP9UKOzDFcuWrlXSz6JRhwihdhHs9r8=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr3689598vse.9.1665997502795; Mon, 17 Oct
 2022 02:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com> <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
 <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com> <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
 <CAMRc=MdNnUS72cSARv8dAVUsujkUM9jyjutJsty9o+=LOkOefg@mail.gmail.com>
In-Reply-To: <CAMRc=MdNnUS72cSARv8dAVUsujkUM9jyjutJsty9o+=LOkOefg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Oct 2022 11:04:51 +0200
Message-ID: <CAMRc=MeZUap-h=NZm1L0BfN2=ms6VeOJA+05HPyLq_hE8kVuEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 4:22 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Fri, Oct 14, 2022 at 4:13 PM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > Hi Linus,
> >
> > Le 14/09/2022 =C3=A0 15:03, Arnd Bergmann a =C3=A9crit :
> > > On Wed, Sep 14, 2022, at 2:38 PM, Linus Walleij wrote:
> > >> On Wed, Sep 7, 2022 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >>>>>   drivers/gpio/gpio-sta2x11.c              | 411 ----------------=
-------
> > >> (...)
> > >>> sta2x11 is an x86 driver, so not my area, but I think it would be
> > >>> best to kill off the entire platform rather than just its gpio
> > >>> driver, since everything needs to work together and it's clearly
> > >>> not functional at the moment.
> > >>>
> > >>> $ git grep -l STA2X11
> > >>> Documentation/admin-guide/media/pci-cardlist.rst
> > >>> arch/x86/Kconfig
> > >>> arch/x86/include/asm/sta2x11.h
> > >>> arch/x86/pci/Makefile
> > >>> arch/x86/pci/sta2x11-fixup.c
> > >>> drivers/ata/ahci.c
> > >>> drivers/gpio/Kconfig
> > >>> drivers/gpio/Makefile
> > >>> drivers/gpio/gpio-sta2x11.c
> > >>> drivers/i2c/busses/Kconfig
> > >>> drivers/media/pci/Makefile
> > >>> drivers/media/pci/sta2x11/Kconfig
> > >>> drivers/media/pci/sta2x11/Makefile
> > >>> drivers/media/pci/sta2x11/sta2x11_vip.c
> > >>> drivers/media/pci/sta2x11/sta2x11_vip.h
> > >>> drivers/mfd/Kconfig
> > >>> drivers/mfd/Makefile
> > >>> drivers/mfd/sta2x11-mfd.c
> > >>> include/linux/mfd/sta2x11-mfd.h
> > >>>
> > >>> Removing the other sta2x11 bits (mfd, media, x86) should
> > >>> probably be done through the respective tree, but it would
> > >>> be good not to forget those.
> > >>
> > >> Andy is pretty much default x86 platform device maintainer, maybe
> > >> he can ACK or brief us on what he knows about the status of
> > >> STA2x11?
> > >
> > > I think the explanation given by Davide and Alessandro
> > > was rather detailed already:
> > >
> > > https://lore.kernel.org/lkml/Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com/
> > > https://lore.kernel.org/lkml/Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com/
> > >
> >
> > I can't see this series in neither linus tree nor linux-next.
> >
> > Following the ACK from Andy + the above explanations from Arnd, do you
> > plan to merge this series anytime soon ?
> >
> > Do you need anything more from me ?
> >
> > Thanks
> > Christophe
>
> I will take it after v6.1-rc1 is tagged.
>
> Bart

Now queued.

Bart
