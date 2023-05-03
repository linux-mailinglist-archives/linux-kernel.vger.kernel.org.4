Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B06F6078
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjECVQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:16:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CE7DBB;
        Wed,  3 May 2023 14:16:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8dd1489b0so56940781fa.3;
        Wed, 03 May 2023 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683148598; x=1685740598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfneWEBGkEit9hjisZDYzsO4oPwvETd0SmOvJNo/zgs=;
        b=ZIUX7ziomSh5SuyJ8ylhsXuK28PWeB6sETtlLIzwri9cHe0VxLKS0CwcScTj9fTWrS
         n+s+qH6/v7QSUAoclqpB0FI5phrE2kHftIC9/M58e16jvReNhHlicvY48Y3d65a7qReC
         2H0GmUT9eUl2JZbptgEVLpO8nNlZwRHRFPn7+VbAXmcLATku549HzUTTkjM+KxP9mkN7
         GiStmvvxSCeo3E6MBWk9sB5JGH99bY4eB4n4IYRZjbJndFRjn+rQmHr+NQoNA2JkY9YQ
         GbYR2Q08aQ6xwRI16jaDA/b2jubWBvmhSv/p424784edH1IrcZ/EEL5zhAeEyufx2q8h
         i5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148598; x=1685740598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfneWEBGkEit9hjisZDYzsO4oPwvETd0SmOvJNo/zgs=;
        b=OX8lt3q18M/ZVtGSbjpufMQ8ydbVlm+j+pDNeVZx49OihlHX3PYenu4Rx3Z6MngFyI
         KGTL2nqxpR1PxUOhgndr5+Ii2cStpQdg4ns/fJrv+Z0OOitVhtoaduflk1A00euLEtcI
         scBf7+tKEbnJ5ptfsqMqK/zkxUUFTe7Av0KuNPk/Tfi8jacOwZUs/sEoClgUl/NykKtj
         jGjhayUrh1Jws48uWyz0Yh3UihhmHzfAY+5rRbz9/HiQMDjJGqKBZ+OU4hDoT+UfaK7a
         e7GGaaAk8Qn8QGBwkwrTNcyvF+m8Erv9X6VXpHFSSgOBaU/FX5aXPUBgXBlyJgo3pWRs
         GTjQ==
X-Gm-Message-State: AC+VfDxC43/Nmo3sapD8e997XOFx2iQOVEi+a3xlPLednOFCI6e/wMHT
        gR/BcFSoy0BOX/jWhGgv/H8oMsC2cIP3uY4vRWk=
X-Google-Smtp-Source: ACHHUZ617dPFTK3e1k76g4ZAzwftiztvJZrL/cafUdsxDThReLl+6IGX3gYbtkOpfEi+1Vyo8Ya46prU6MhUTeySqoY=
X-Received: by 2002:a2e:9cd7:0:b0:2ac:70fa:fb7b with SMTP id
 g23-20020a2e9cd7000000b002ac70fafb7bmr400396ljj.18.1683148598141; Wed, 03 May
 2023 14:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-11-jorge.lopez2@hp.com>
 <740fec33-7dd5-401f-b5fb-aaf2201f1d1f@t-8ch.de>
In-Reply-To: <740fec33-7dd5-401f-b5fb-aaf2201f1d1f@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 3 May 2023 16:16:11 -0500
Message-ID: <CAOOmCE_p4=Lf6ngneiVRHMuhmwTizU8WoAL5otnr4Jrzm1o+=Q@mail.gmail.com>
Subject: Re: [PATCH v11 10/14] HP BIOSCFG driver - passwdattr-interface
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

On Sun, Apr 23, 2023 at 7:58=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-20 11:54:50-0500, Jorge Lopez wrote:
> > ---
> >  .../x86/hp/hp-bioscfg/passwdattr-interface.c  | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdattr-inter=
face.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c =
b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> > new file mode 100644
> > index 000000000000..02fc766eb3cf
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to SET password methods under
> > + * HP_WMI_SET_BIOS_SETTING_GUID for use with hp-bioscfg driver.
> > + *
> > + * Copyright (c) 2022 Hewlett-Packard Inc.
> > + */
> > +
> > +#include <linux/wmi.h>
> > +#include "bioscfg.h"
> > +
> > +static int bios_attr_pass_interface_probe(struct wmi_device *wdev,
> > +                                       const void *context)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.password_attr_wdev =3D wdev;
>
> This wdev is never used. It seems this full subdriver can be dropped.
> Or the one UUID-based callsite using the same UUID can use the driver.

I will remove the subdriver.

>
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return 0;
> > +}
> > +
> > +static void bios_attr_pass_interface_remove(struct wmi_device *wdev)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.password_attr_wdev =3D NULL;
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +}
> > +
> > +static const struct wmi_device_id bios_attr_pass_interface_id_table[] =
=3D {
> > +     { .guid_string =3D HP_WMI_SET_BIOS_SETTING_GUID },
> > +     { },
>
> No comma after end-of-array marker.
>
> > +};
> > +static struct wmi_driver bios_attr_pass_interface_driver =3D {
> > +     .driver =3D {
> > +             .name =3D DRIVER_NAME"-password"
> > +     },
> > +     .probe =3D bios_attr_pass_interface_probe,
> > +     .remove =3D bios_attr_pass_interface_remove,
> > +     .id_table =3D bios_attr_pass_interface_id_table,
> > +};
> > +
> > +int init_bios_attr_pass_interface(void)
> > +{
> > +     return wmi_driver_register(&bios_attr_pass_interface_driver);
> > +}
> > +
> > +void exit_bios_attr_pass_interface(void)
> > +{
> > +     wmi_driver_unregister(&bios_attr_pass_interface_driver);
> > +}
> > +
> > +MODULE_DEVICE_TABLE(wmi, bios_attr_pass_interface_id_table);
> > --
> > 2.34.1
> >
