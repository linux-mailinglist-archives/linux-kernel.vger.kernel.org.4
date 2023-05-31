Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07653718AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEaUJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEaUJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:09:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB331133;
        Wed, 31 May 2023 13:09:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2602848aso958171fa.2;
        Wed, 31 May 2023 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685563792; x=1688155792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BPhS7tVN3BcYUeoYVKYPXPXbiDz8mkTfwynZ5mZY4M=;
        b=lg9GTBxQE9ytFcUJkP/N2lIs73RSCEJHfZLjYbP5LXJQ42iHbWHSnCAHLFTMcrhSw6
         NFLWblk9svnE0XQ6xiwG8d1DIug5oVgVi6qs8JnSTJs4UZ1P8JHkJHC1+SeUuE61Ud3e
         lXYyMkswWg1J8xFgRCSOh1D97Rj8v/b9CbRpqolrkH/QmcJaYS/6n8m0Voc4mO0XfSAU
         Fc5mp/jxdBxdLnkrxV91uGUv/BE4uNQC/EvfsM4pF+Q440QAZhLHGP1t329o16O9eq0f
         lSWF+9f5koSeSK28mU86gFgthAFcUPMfMo/0dB1Cw2GCCPYwx8IzGG61vFUIppiodHSN
         VwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563792; x=1688155792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BPhS7tVN3BcYUeoYVKYPXPXbiDz8mkTfwynZ5mZY4M=;
        b=bfV4Duvb1nw2FVZwlk1U2ElBJgJiCgjTCi6qpmHbjl68PIi2NZCxvu8qAwuk1NZrhS
         fZZMwcHQKfQpuqHjoanUZQn1f8V8X7AsSf5SfmkZzBsvD5oD4LsQIW5izeOOmalq6UAo
         FAwP210FQP+X3Xa6+MMoKn05smotxrToQ6oW3n8cp0+JAiZC8qBe0i/BujztR3x5rkJz
         vgmHGyR3imI0c9QTkbJCsPr3Y06PUfXudrcJn57NzpmquRw77gKIihSXkB+xL1onZFT8
         YGtzPbXHHXSU5ASFv/zyslSNVicIWyDS+YXJ3wtRhY1LYYBY/CsojjtR02rvlXIvzjEU
         8v5g==
X-Gm-Message-State: AC+VfDxemN5+u9VrK87dAic/9ZYZtlmHED9usRApKJ+ytsRi8bQb+Iri
        7n2I2E0RXThNJjTggwUrP29yISFsoog8CW5Bz3bsboWW
X-Google-Smtp-Source: ACHHUZ4cfOQ4tTrnxcDFrngQ09wUU2FEnqoK64LEpa/2uLT8ybNpqAeTgqgp1i196TwLOIlRBIo2nN3t/qcZ+j4ms2Q=
X-Received: by 2002:a2e:9b82:0:b0:2b0:770f:c83c with SMTP id
 z2-20020a2e9b82000000b002b0770fc83cmr3324661lji.4.1685563791608; Wed, 31 May
 2023 13:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201300.12964-1-jorge.lopez2@hp.com> <20230519201300.12964-4-jorge.lopez2@hp.com>
 <f147240d-7da8-4fd7-9201-a11476b0b9e6@t-8ch.de>
In-Reply-To: <f147240d-7da8-4fd7-9201-a11476b0b9e6@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 31 May 2023 15:09:15 -0500
Message-ID: <CAOOmCE-GWjcncveifa5=T4O3tt1wkZKM0og-7ZUMUQSdr6d5cQ@mail.gmail.com>
Subject: Re: [PATCH v15 03/13] hp-bioscfg: bioscfg
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
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

On Fri, May 26, 2023 at 10:28=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-05-19 15:12:50-0500, Jorge Lopez wrote:
>
> <snip>
>
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 988 +++++++++++++++++++
> >  1 file changed, 988 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.c
> > new file mode 100644
> > index 000000000000..fe0be40c8dee
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > @@ -0,0 +1,988 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common methods for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/wmi.h>
> > +#include "bioscfg.h"
> > +#include "../../firmware_attributes_class.h"
> > +#include <linux/nls.h>
> > +#include <linux/errno.h>
> > +
> > +MODULE_AUTHOR("Jorge Lopez <jorge.lopez2@hp.com>");
> > +MODULE_DESCRIPTION("HP BIOS Configuration Driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +struct bioscfg_priv bioscfg_drv =3D {
> > +     .mutex =3D __MUTEX_INITIALIZER(bioscfg_drv.mutex),
> > +};
> > +
> > +static struct class *fw_attr_class;
> > +
> > +ssize_t display_name_language_code_show(struct kobject *kobj,
> > +                                     struct kobj_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", bioscfg_drv.display_name_language_=
code);
> > +}
>
> You probably can also define the "struct attribute" for this callback
> right here.
> Then there don't have to be attribute definitions everywhere.
>
> As the language code is always the same anyways this can just print the
> constant. Also remove the variables and explicit setting from all the
> attributes.

Done!

>
> > +
> > +int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *int=
eger)
> > +{
> > +     int *ptr =3D PTR_ALIGN((int *)*buffer, 4);
>
> 4 -> sizeof(int)

Done!

>
> > +
> > +     /* Ensure there is enough space remaining to read the integer */
> > +     if (*buffer_size < sizeof(int))
> > +             return -EINVAL;
> > +
> > +     *integer =3D *(ptr++);
> > +     *buffer =3D (u8 *)ptr;
> > +     *buffer_size -=3D sizeof(int);
> > +
> > +     return 0;
> > +}
> > +

<snip>

> > +/**
> > + * hp_init_bios_attributes() - Initialize all attributes for a type
> > + * @attr_type: The attribute type to initialize
> > + * @guid: The WMI GUID associated with this type to initialize
> > + *
> > + * Initialiaze all 5 types of attributes: enumeration, integer,
>
> "Initialize"

Done!

>
> > + * string, password, ordered list  object.  Populates each attrbute ty=
pes
> > + * respective properties under sysfs files
> > + */
> > +static int hp_init_bios_attributes(enum hp_wmi_data_type attr_type, co=
nst char *guid)
> > +{
> > +     union acpi_object *obj =3D NULL;
> > +     int min_elements;
> > +
> > +     /* instance_id needs to be reset for each type GUID
> > +      * also, instance IDs are unique within GUID but not across
> > +      */
> > +     int instance_id =3D 0;
> > +     int retval =3D 0;
>
> More common would be just "ret" instead of "retval".
> Same everywhere else.

Done!

<snip>

> > +     fw_attributes_class_put();
> > +     hp_exit_attr_set_interface();
> > +}
> > +
> > +module_init(hp_init);
> > +module_exit(hp_exit);
> > --
> > 2.34.1
> >
