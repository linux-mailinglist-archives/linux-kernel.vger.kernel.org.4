Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F366FB881
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjEHUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjEHUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:49:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0E5FE6;
        Mon,  8 May 2023 13:49:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac7ac8a4ffso55551021fa.0;
        Mon, 08 May 2023 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683578943; x=1686170943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsKXl8LzqTVbbQol4cbpGlujpNWzeMbCqY5cgUyI8o8=;
        b=Ije9mb/D6+VFB6nkY/YkPSvWvq2MVTKKKzZ6ZpTjhk8NNtE2kioOKPpzWQPzsNAdJ3
         ANQ/r2sdxojQdNcHSz2+ClDeRX0YiITqoIu6vjfSjNgUffpVVo175+9/GguP1Uyg8lfP
         k1AZcMIQu6R45hrsqrgG6TsdPgElXKTUqlk532VfcnfykF34S7zpExWOHg0innT2WoeU
         pkb2egbFOgJ46sqpf9SakORgXEcUkNwFRY8ePe8AiLzzX3ZDlK38z9iPtb3cCBK2MYex
         wkhYPMHIPosH+IdI4vMWKevDuUIVhGuzZ3FODEN3cvGPENfry2lP16di/5XZM2OZ2zpU
         QEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578943; x=1686170943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsKXl8LzqTVbbQol4cbpGlujpNWzeMbCqY5cgUyI8o8=;
        b=b3PeMog/Lf/oDYFc9CdffcBcxIrfTn5pYFdVG8oZWqCs6LpYFdyi3DZDZQETrAE6Mu
         UJi9rvrCkD2JH7oZVXVRfpW9zeT9kOiGRlzmksTuIsFLi53b81gjJOVNUY5CVbfY2CIo
         mGpemL0tfHzpBEN8FxunosGIXGx7RXBKI0HyUZ3uJoR0i5nJq0cGkgGlm5farNBskgI0
         FKLgbyKOaDeT2opRSXpA56mXIQghXge7jdHqNU5H8tY1d4udbq7rSwEJBcS3Oid3iRnO
         Zbihrx+vFV7xw8AUwHZvU4RuP2TP1xFU2lE4MKMeC3aAzgMiZnyMifneTtCdr+8e5/Cz
         KPug==
X-Gm-Message-State: AC+VfDxIwIFOzB4Xv3SHO/+57Tk+qeggUEH2eTw9FOMDa8fNamWWCu9o
        FsiSo3Aj5Md/4uvntrhc8Nmo9C9UZe838xZYspA=
X-Google-Smtp-Source: ACHHUZ5qJVuJyvvfoypuM8hd7wNxfOnwHkc6MesNLWpXjXMvG0HDihbm47/mxm+yZITjeZc+iRNO9Itav3oEYHN4V2I=
X-Received: by 2002:a2e:81ce:0:b0:2ac:829f:487e with SMTP id
 s14-20020a2e81ce000000b002ac829f487emr116011ljg.21.1683578942992; Mon, 08 May
 2023 13:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <b87d1a4c-9624-4df8-98ba-f2560b7df18b@t-8ch.de>
 <CAOOmCE_DMb6ejprALCfmWa0eA3WQquFnS+Z3D0TjsqqPiytbQw@mail.gmail.com> <a1f87dd8-6547-4d6d-9fc8-d7986d9e2c93@t-8ch.de>
In-Reply-To: <a1f87dd8-6547-4d6d-9fc8-d7986d9e2c93@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 15:48:34 -0500
Message-ID: <CAOOmCE8fg1=A0KU6jWsbj0H-xxOkN4XFtqJJH6eOOZz5_oBotQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] HP BIOSCFG driver
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
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

On Mon, May 8, 2023 at 3:42=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-08 09:05:22-0500, Jorge Lopez wrote:
> > On Sat, May 6, 2023 at 1:57=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-=
8ch.de> wrote:
> > >
> > > On 2023-05-05 17:00:30-0500, Jorge Lopez wrote:
> > > <snip>
> > >
> > > > Jorge Lopez (13):
> > > >   HP BIOSCFG driver - Documentation
> > > >   HP BIOSCFG driver  - biosattr-interface
> > > >   HP BIOSCFG driver  - bioscfg
> > > >   HP BIOSCFG driver  - int-attributes
> > > >   HP BIOSCFG driver  - ordered-attributes
> > > >   HP BIOSCFG driver  - passwdobj-attributes
> > > >   HP BIOSCFG driver  - string-attributes
> > > >   HP BIOSCFG driver  - bioscfg-h
> > > >   HP BIOSCFG driver  - enum-attributes
> > > >   HP BIOSCFG driver  - spmobj-attributes
> > > >   HP BIOSCFG driver  - surestart-attributes
> > > >   HP BIOSCFG driver  - Makefile
> > > >   HP BIOSCFG driver  - MAINTAINERS
> > >
> > > These could be reordered a bit to be easier to read.
> > >
> > > * Documentation
> > > * bioscfg-h
> > > * bioscfg
> > > * biosattr-interface
> > > * *-attributes
> > > * Makefile
> > > * MAINTAINERS
> > >
> >
> > the order is determined when a particular commit took place and as
> > reported by git.
> > I will reorder the list in the cover-letter in future submissions.
>
> The commits should be ordered in a way that make the most sense.
> This should indeed match the order of commits/patches, you could reorder
> the commits to match the proposed order.
>

Thank you.  Will do.

> > > Also currently the subject spacing is currently inconsistent.
> > > Something like "hp-bioscfg: foo" would be more in line with the rest =
of
> > > the kernel.
> > >
> >
> > Noted.  I will update the subject spacing as indicated.   "hp-bioscfg: =
foo"
> >
> > > >
> > > >  .../testing/sysfs-class-firmware-attributes   | 117 ++-
> > > >  MAINTAINERS                                   |   6 +
> > > >  drivers/platform/x86/hp/Kconfig               |  16 +
> > > >  drivers/platform/x86/hp/Makefile              |   1 +
> > > >  drivers/platform/x86/hp/hp-bioscfg/Makefile   |  12 +
> > > >  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++
> > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 982 ++++++++++++++=
++++
> > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 523 ++++++++++
> > > >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 +++++++++
> > > >  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++
> > > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++
> > > >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 +++++++++++
> > > >  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 +++++++
> > > >  .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++
> > > >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 +++
> > > >  15 files changed, 4860 insertions(+), 2 deletions(-)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-int=
erface.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attribu=
tes.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attribut=
es.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attr=
ibutes.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-at=
tributes.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attri=
butes.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attri=
butes.c
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-at=
tributes.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
