Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0006FB23B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjEHOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjEHOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:05:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FD3702F;
        Mon,  8 May 2023 07:05:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f22908a082so2090166e87.1;
        Mon, 08 May 2023 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683554751; x=1686146751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWNncTmOaU1oBF4kcSIZuWY4F3BHDWn7zaVjpGhRugY=;
        b=AucDXxV0IrYTVqFWyj/A6QGMIM5bkGC0CBbepFPXE+OgthWHM+jRNYnHw8DsWeeuvn
         poxn9BS8AXAhHN8TzoFLpaoeVSi3Oi+V7xCqz/oY3O8Ux5BJz0Nh534YxcNByvyESCLM
         ASIpsW0NJSAeiGPYggJjvYEYm19lEEfJ6nWCAeGqKaCMG6HuNGIbnW7gb17A6zhom/gp
         a9qBsuJeA1TV07jIx0AZeQ/Js9J/oh8y3ghg7IB6QdAlRAtDBKwiL1HH4xNNeEyBI5LA
         /UpgLZOgxXhCa+t74xLAQ5e0WaaWWcp+x8TyKW9UUvrAHbfNUeGu2bWfVkjahBRq+p7V
         eKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554751; x=1686146751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWNncTmOaU1oBF4kcSIZuWY4F3BHDWn7zaVjpGhRugY=;
        b=YoBX7SAT4WYmaH/e65uUwlsWGLmjxSH0znRgwLkvkcD0lrpLxsgyLvbV41EXJQE3aM
         F5R4gPXUca6svhf590M6iYBJgQHdgbs+l+cQajM0h1e1Y3/KRMidpuqFy2KPknvaebVF
         j3aRXT7+0ctoHV9WZbd2W1pWbYsU3V3TNqwVZwE9hOFukLTowwk2xwu4ypv9Cg4LBEBg
         jJhNORcNNSMovIkX07mIj7FMKCRx3jXwA8hYPjWqwbJ39YiZkx6oX49xCkpkVVX8pbbr
         0C2/q10hspgf01F5gq5qFwYAol/Tdn/KLc6eE3SYl4yn5yCDO3lVl+DXUjyPZP7r2vTS
         htwQ==
X-Gm-Message-State: AC+VfDxAvzqrwApP3Dz1uzrqabnzTBLbDl/ldr43EkZSePNYDtrxy2Jn
        Y7qKQXlz7ivACsgLocAmV1r91pvx0/ZxFZODvLAvV0WnvFk=
X-Google-Smtp-Source: ACHHUZ68GRshX+6nu/l/ClOQ1xp832C9F8zAk3AuIzJnWd9w4y826q58OmSXyCyBo9y/SgS7O6Jqey2zihDSHIYgmVA=
X-Received: by 2002:ac2:54ba:0:b0:4f2:4f09:8f40 with SMTP id
 w26-20020ac254ba000000b004f24f098f40mr796581lfk.27.1683554750672; Mon, 08 May
 2023 07:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <b87d1a4c-9624-4df8-98ba-f2560b7df18b@t-8ch.de>
In-Reply-To: <b87d1a4c-9624-4df8-98ba-f2560b7df18b@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 09:05:22 -0500
Message-ID: <CAOOmCE_DMb6ejprALCfmWa0eA3WQquFnS+Z3D0TjsqqPiytbQw@mail.gmail.com>
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

On Sat, May 6, 2023 at 1:57=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-05 17:00:30-0500, Jorge Lopez wrote:
> <snip>
>
> > Jorge Lopez (13):
> >   HP BIOSCFG driver - Documentation
> >   HP BIOSCFG driver  - biosattr-interface
> >   HP BIOSCFG driver  - bioscfg
> >   HP BIOSCFG driver  - int-attributes
> >   HP BIOSCFG driver  - ordered-attributes
> >   HP BIOSCFG driver  - passwdobj-attributes
> >   HP BIOSCFG driver  - string-attributes
> >   HP BIOSCFG driver  - bioscfg-h
> >   HP BIOSCFG driver  - enum-attributes
> >   HP BIOSCFG driver  - spmobj-attributes
> >   HP BIOSCFG driver  - surestart-attributes
> >   HP BIOSCFG driver  - Makefile
> >   HP BIOSCFG driver  - MAINTAINERS
>
> These could be reordered a bit to be easier to read.
>
> * Documentation
> * bioscfg-h
> * bioscfg
> * biosattr-interface
> * *-attributes
> * Makefile
> * MAINTAINERS
>

the order is determined when a particular commit took place and as
reported by git.
I will reorder the list in the cover-letter in future submissions.

> Also currently the subject spacing is currently inconsistent.
> Something like "hp-bioscfg: foo" would be more in line with the rest of
> the kernel.
>

Noted.  I will update the subject spacing as indicated.   "hp-bioscfg: foo"

> >
> >  .../testing/sysfs-class-firmware-attributes   | 117 ++-
> >  MAINTAINERS                                   |   6 +
> >  drivers/platform/x86/hp/Kconfig               |  16 +
> >  drivers/platform/x86/hp/Makefile              |   1 +
> >  drivers/platform/x86/hp/hp-bioscfg/Makefile   |  12 +
> >  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 982 ++++++++++++++++++
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 523 ++++++++++
> >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 +++++++++
> >  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++
> >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++
> >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 +++++++++++
> >  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 +++++++
> >  .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++
> >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 +++
> >  15 files changed, 4860 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interfa=
ce.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.=
c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attribut=
es.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attrib=
utes.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attribute=
s.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attribute=
s.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attrib=
utes.c
> >
> > --
> > 2.34.1
> >
