Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B836A057F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjBWJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBWJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:58:50 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FDA35BD;
        Thu, 23 Feb 2023 01:58:48 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536bbef1c5eso173498617b3.9;
        Thu, 23 Feb 2023 01:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQXyU9aqprtIrOITCHfSd392PrwvkOblOpb+a1D8YlQ=;
        b=CzEm/omA6DWjcC35rQff3w8Bv5R9VlO1Xp6TNrDnhP4AuXktvAoysPRoFYj4VtYOGP
         47doCR+dWGXJFAWfy3hjlv38TNfX7oTS9t8Ez5M5awhFS1tXfKmIm9fpHLNrZUCZ84wG
         +EWY53ORCzTgU5L+JlTLx4rm3+6x5a0tJhzRVmtGu61P2podHrLh6yK4kSAi4QG0dsx3
         b/YOdbTnEhIIdCzfSwZAes4IsoiqVGPm3ti72++2moLG/to9pyCh+rO3hr62DUEvPUCC
         8+DEW6pg9zILO6JO1nW8/+Z/X2WR6vhj26Oyi9PqbAdXfRjW85meF5hFlXdxPQ2T/22C
         lwNQ==
X-Gm-Message-State: AO0yUKXs+E1HzcRqoh/7XZ9J3bs1a4HtYDGZNAS9Ouk3c8PpdlFqouIk
        +xA8zbO989P7EWOTygdUbfEEHD7LUGBLfA72Oz+FqFRV
X-Google-Smtp-Source: AK7set+szEZeobfmVyemPx9mqzw4kw9oAbz7SR0CZxyY00AD3J0LYnMCO9v1m3LefSWiaiO6brBL4fopBL1eExPTt+o=
X-Received: by 2002:a5b:14c:0:b0:a1e:de8e:76b with SMTP id c12-20020a5b014c000000b00a1ede8e076bmr998132ybp.1.1677146328124;
 Thu, 23 Feb 2023 01:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20230216124004.2be84a01@canb.auug.org.au> <20230223111342.7177513b@canb.auug.org.au>
In-Reply-To: <20230223111342.7177513b@canb.auug.org.au>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 23 Feb 2023 10:58:36 +0100
Message-ID: <CANBLGcxRJ+Hd2eqB7NFBCZEwV2CnLhkL3L1NCTvm5_fMt7PFPA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the mmc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 01:13, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Thu, 16 Feb 2023 12:40:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the pinctrl tree got a conflict in:
> >
> >   MAINTAINERS
> >
> > between commit:
> >
> >   9e622229bbf4 ("mmc: starfive: Add sdio/emmc driver support")
> >
> > from the mmc tree and commit:
> >
> >   d6e0a660097d ("dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl")
> >
> > from the pinctrl tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc MAINTAINERS
> > index 1208b0380fa5,8a851eb053ca..000000000000
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@@ -19914,19 -19890,15 +19914,21 @@@ F:      Documentation/devicetree/bindings/cl
> >   F:  drivers/clk/starfive/clk-starfive-jh7100*
> >   F:  include/dt-bindings/clock/starfive-jh7100*.h
> >
> >  +STARFIVE JH7110 MMC/SD/SDIO DRIVER
> >  +M:  William Qiu <william.qiu@starfivetech.com>
> >  +S:  Supported
> >  +F:  Documentation/devicetree/bindings/mmc/starfive*
> >  +F:  drivers/mmc/host/dw_mmc-starfive.c
> >  +
> > - STARFIVE JH7100 PINCTRL DRIVER
> > + STARFIVE JH71X0 PINCTRL DRIVERS
> >   M:  Emil Renner Berthing <kernel@esmil.dk>
> > + M:  Jianlong Huang <jianlong.huang@starfivetech.com>
> >   L:  linux-gpio@vger.kernel.org
> >   S:  Maintained
> > - F:  Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
> > - F:  drivers/pinctrl/starfive/
> > + F:  Documentation/devicetree/bindings/pinctrl/starfive,jh71*.yaml
> > + F:  drivers/pinctrl/starfive/pinctrl-starfive-jh71*
> >   F:  include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
> > + F:  include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
> >
> >   STARFIVE JH7100 RESET CONTROLLER DRIVER
> >   M:  Emil Renner Berthing <kernel@esmil.dk>
>
> This is now a conflict between the mmc tree and Linus' tree.

Hi Stephen,

I don't control any of the trees, but fwiw your fixup looks correct to me:
Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>

/Emil
