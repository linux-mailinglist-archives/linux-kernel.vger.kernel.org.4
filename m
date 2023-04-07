Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A046DAC53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDGLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDGLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:46:52 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC787EC6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:46:51 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i10so36696070vss.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680868010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnmTifiw6y4PL2ZMki5aELLg6CiGyYU6AAKyqZKSDHk=;
        b=j+Buql+8cz8/30DcNwK6aKGX5E7RY8HVLMISxrJb+fyBiMtLob+6kL9NvDLvdlO53w
         CSviY0OlLHbOjWqNkEydx8YZEXcO9l4nsgyaJ45dhQbxB/IiX+IcTZ2gltSkaztSRqnr
         xiQq8nYCGb0NcmKdtDPtPlukzmnU06mePVBbmZCBSi/UZmBQbIBLc60BiVnN43aL4R4F
         ddQa0pTktntHNl2DpYuWpJyCwwWtIg7Gfo9afJlT7NvrBVuKKaXPuFjlOqnp16vjv3uh
         OWNc7uPCEz1zBIWpiSakXfm9bV6H07StanfCpcWR6PKUCaAnYFAs6gZyYomumfWyYvga
         c1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnmTifiw6y4PL2ZMki5aELLg6CiGyYU6AAKyqZKSDHk=;
        b=YXKPfRcQ/+WQZLjRyhuQ/c6o2YjahMAjslbPTyESan+K9Uo27/QwmjfnthegZGUdsf
         m4CbrNrPLyfgxZPqKjZ0JiGBvvT51HF7cA6BvqgFM/6YICGF6zvCuNSfEHxzY5h1Pbp3
         9A7xjb5d5642aHy45rX37FOZiKmwi4VB8bIfLMtYu9InH0bhbWeKykt4e9MY8IQQP6Ll
         eNVtCOfcrEVX2YUFtT/XPN55z1bqmRq2YRudYno1HTyY40Dt5rCFXtwmQkWpLTllgGdp
         ecb/c9OHpKxUG+Yj3AtYrRNGdfFmurZ/ln1YOt/2lZwBSZbu+iCGXQSiL5hJlOkm2NaN
         Sq/g==
X-Gm-Message-State: AAQBX9f4Jd9uRVnEbjMg5taxFijTdKxqjeq1VCKXi6ZIypBDKAgFovoJ
        l6TZ7F2BhQWqPsMbDMnM5/byP1gFjCdYFTKLAzgKkw==
X-Google-Smtp-Source: AKy350apxvdy+XIxHTwYhZXMmn1N4PujKyCC3w1AnefcYjQ6n/U3snXAgHJSPociYFTCmXW/zXOLWsOD6Wv1ZV5jEeo=
X-Received: by 2002:a67:d813:0:b0:425:e5e6:d1d9 with SMTP id
 e19-20020a67d813000000b00425e5e6d1d9mr938588vsj.2.1680868010202; Fri, 07 Apr
 2023 04:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680708357.git.william.gray@linaro.org> <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
 <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk> <CAMRc=Mc0HcMnuBqsN7ReNB5JTWR0C4FbMRRM9S7kqhW5otP5WA@mail.gmail.com>
 <ZDABDvbflOWAqcs+@fedora>
In-Reply-To: <ZDABDvbflOWAqcs+@fedora>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 7 Apr 2023 13:46:39 +0200
Message-ID: <CAMRc=Mcq5__aD-42cL7fh-A-=MwubHoebN7myRkeO7DF++4_EQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 1:40=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> On Fri, Apr 07, 2023 at 12:17:31PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Apr 6, 2023 at 7:23=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
> > >
> > > On Wed, Apr 05, 2023 at 11:45:42AM -0400, William Breathitt Gray wrot=
e:
> > > > Allow the struct regmap_irq_chip set_type_config() callback to acce=
ss
> > > > irq_drv_data by passing it as a parameter.
> > >
> > > The following changes since commit e8d018dd0257f744ca50a729e3d042cf2e=
c9da65:
> > >
> > >   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git =
tags/regmap-set-type-irq-drv-data
> > >
> > > for you to fetch changes up to 7697c64b9e4908196f0ae68aa6d423dd406079=
73:
> > >
> > >   regmap: Pass irq_drv_data as a parameter for set_type_config() (202=
3-04-05 17:19:24 +0100)
> > >
> > > ----------------------------------------------------------------
> > > regmap: Pass irq_drv_data as a parameter for set_type_config()
> > >
> > > Allow callbacks to access irq_drv_data.
> > >
> > > ----------------------------------------------------------------
> > > William Breathitt Gray (1):
> > >       regmap: Pass irq_drv_data as a parameter for set_type_config()
> > >
> > >  drivers/base/regmap/regmap-irq.c | 8 +++++---
> > >  include/linux/regmap.h           | 6 ++++--
> > >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > Pulled Mark's tag and applied the two remaining patches, thanks!
> >
> > Bart
>
> Bart, the two remaining patches still depend on the handle_mask_sync
> change descripted in the cover patch [0].
>
> Mark, are you able to Ack those patches or alternatively provide an
> immutable branch with them? We need the handle_mask_sync change as well
> for the idio-16 migration patchset [1].
>
> William Breathitt Gray
>
> [0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.=
org/
> [1] https://lore.kernel.org/all/cover.1680618405.git.william.gray@linaro.=
org/

Ok, I'll back them out.

Bart
