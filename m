Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B9690B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBIOQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjBIOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:16:50 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525A10AA4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:16:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 139so1038334ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3LhjlGAoOIaNmMnea1gJTwjbr7JWRXAi3r+eUWSseo=;
        b=Wp0LBviDkRG9btkeltk0cs+U7e6O8uvQJHsH/Y1H8T8Cg3U4/SotkUq9opub8jPnhb
         qsCb13jrVjPFtwcxqjzBQ5GuhfzaiCs3lNNBciAlAVrNhGn8Pl2fLsLOjD9BE3B8n2VJ
         2t5PoifwBruK/wJ/GrG+/jBnYzDKubpdIKwRtS6XxozEzNUuUGfqbvwanK9SZWfTihQ5
         UEUjX7mXUogbVYme4EmtsBquQy5Zod8jXWrb7TclLuCHWLuBg6PC7T6X3uUuLyq/CtBF
         ipzgcJIU/G8ckejMV+KkAoX4/sEmTX1VF9gsZE4UwazrNJHcWJx043hf/FcrqmOMRUmS
         VcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3LhjlGAoOIaNmMnea1gJTwjbr7JWRXAi3r+eUWSseo=;
        b=x44ZjjNh9qfSIIo4O2xpLOUgtKSFiZs7y2u1wuNT8MbeNiHf3KX2Kk6+vatnpyWGoS
         iUhU1Ns1KbU98RaojtHwSokLAOXuzdMhbFFzB8bY90f+NJ52UGUa16z57mEMHuM+fawC
         nDorTNyyjZyk+sqgmvD1AxzpBU9mAoLfYmR3vWDjkrzR+i1OMjrrlT1Jz80t7BBbD5MD
         wbz3cgz7LL2lJjJC1Q487cCtokha0MKiji+zAiQ8sW/vYPu0aXe7COvwuwbNfd+JyEzQ
         uHXEUyaTxXZqqw9+VqZTJVUAPK8cBy1DRXtiNUWPmGx2mpDJOWmDNr5zN+yb/PkbQQAe
         wDnQ==
X-Gm-Message-State: AO0yUKUmFCGWr92QV87eOqxDfqALVG+OrvuOdcYmkBMlvOcBWf7+KE2v
        EmOwVZqytrOttp3lKhK+1SKcXvc77TVLysOWNOxWoA==
X-Google-Smtp-Source: AK7set+8s6alxg2Gdtgth43zuRJPxNL8Sj2DVgRo67+4nX4VEDIS4u4HMQ4H6bGKYl/BVbVUuNp0v17FjA/IAhzukxg=
X-Received: by 2002:a25:f301:0:b0:859:2acc:deb6 with SMTP id
 c1-20020a25f301000000b008592accdeb6mr1205990ybs.79.1675952207653; Thu, 09 Feb
 2023 06:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20230208175253.117714-1-mauro.lima@eclypsium.com> <Y+SHH2+VqLoQ+6Ss@black.fi.intel.com>
In-Reply-To: <Y+SHH2+VqLoQ+6Ss@black.fi.intel.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Thu, 9 Feb 2023 11:16:36 -0300
Message-ID: <CAArk9MM4ZBL=_+xcJzb3X7yGyKQ6knbbsKAS+y_09Vs6pD4W=w@mail.gmail.com>
Subject: Re: [PATCH] spi: intel: Update help text of PCI driver
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Thu, Feb 9, 2023 at 2:39 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Feb 08, 2023 at 02:52:53PM -0300, Mauro Lima wrote:
> > Modern intel hardware uses controllers that work in hardware
> > sequencing mode. In this mode, the controller exposes a subset
> > of operations, like read, write and erase, making it easier
> > and less error-prone for use.
> > On the other hand, most of the controllers handled by the
> > platform driver use software sequencing that exposes the
> > entire set of opcodes i.e. include the low-level operations
> > available from the controller.
> >
> > Since the PCI driver works with modern controllers, remove the
> > DANGEROUS tag from it.
> > Update the driver's help text and leave the DANGEROUS tag of
> > the platform driver.
>
> This is not done in this commit. You just update the help texts, right?
Yes, you are right, I will update it.

> > Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
> > ---
> >  For the record of the base commit:
> >
> >  Given that the PCI driver handles controllers that only work with
> >  hardware sequencing, we can remove the dangerous tag.
> >  This patch is the second part of Mika's suggestion [1].
> >  The first part was accepted in [2].
> >
> >  [1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
> >  [2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/
> >
> >  This patch continues the work addressing the comments in the previous
> >  patch adding information about hardware and software sequencing.
> >  Discussion: https://lore.kernel.org/r/20230206183143.75274-1-mauro.lima@eclypsium.com/
> >
> >  drivers/spi/Kconfig | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 3a362c450cb6..9eb3c72d7cd8 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -454,13 +454,16 @@ config SPI_INTEL_PCI
> >       select SPI_INTEL
> >       help
> >         This enables PCI support for the Intel PCH/PCU SPI controller in
> > -       master mode. This controller is present in modern Intel hardware
> > -       and is used to hold BIOS and other persistent settings. This
> > -       driver only supports hardware sequencing mode. Using this
> > -       driver it is possible to upgrade BIOS directly from Linux.
> > +       master mode. This controller is used to hold BIOS and other
> > +       persistent settings. Controllers present in modern Intel hardware
> > +       only work in hardware sequencing mode, this means that the
> > +       controller exposes a subset of operations that makes it easier
> > +       and safer to use. Using this driver it is possible to upgrade BIOS
>
> I would remove the "easier" part because from user perspective there is
> really no difference.
Will do, thanks.

> > +       directly from Linux.
> >
> > -       Say N here unless you know what you are doing. Overwriting the
> > -       SPI flash may render the system unbootable.
> > +       Say N here unless you want to overwrite the flash memory and
>
> Putting it like this surely scares all distro folks from ever enabling
> this ;-)
>
>   "Say N here unless you want to overwrite the flash memory.."
>
> At least to me this means that if you enable this option your flash
> memory will be overwritten.
Do you have a suggestion for the "Say N here" text? Maybe remove it
since this is safe for use now? I found it difficult to rephrase it

> > +       know what you are doing or you want to read the memory's content.
> > +       Overwriting the SPI flash may render the system unbootable.
> >
> >         To compile this driver as a module, choose M here: the module
> >         will be called spi-intel-pci.
> > @@ -473,8 +476,10 @@ config SPI_INTEL_PLATFORM
> >       help
> >         This enables platform support for the Intel PCH/PCU SPI
> >         controller in master mode that is used to hold BIOS and other
> > -       persistent settings. Most of these controllers are using
> > -       software sequencing mode. Using this driver it is possible to
> > +       persistent settings. Most of these controllers work in
> > +       software sequencing mode, which means that the controller
> > +       exposes the full set of operations that supports, making it
> > +       more complex for use. Using this driver it is possible to
>
> Here,
>
> exposes the low level SPI-NOR opcodes to the software
Ok
>
> I think is better. Also here too drop the "complex" as it looks similar
> from user perspective.
I agree
> >         upgrade BIOS directly from Linux.
> >
> >         Say N here unless you know what you are doing. Overwriting the
> >
> > base-commit: 7db738b5fea4533fa217dfb05c506c15bd0964d9
> > --
> > 2.39.1

Thanks
