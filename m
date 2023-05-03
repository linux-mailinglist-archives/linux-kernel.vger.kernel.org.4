Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525906F5F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjECTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:43:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C807AAD;
        Wed,  3 May 2023 12:43:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so7044652e87.2;
        Wed, 03 May 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683142984; x=1685734984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAFsdkuWO9UgRn1XWK4rWMo4+aWqxozWG317Kv1fPQI=;
        b=PDq5ODkIpFKfUY1aEuhCfzBRSE13qs5fZSAzLX6XZoXQB+61NiNekUMrnbcs37F/nV
         DfGdEFAtJYIbPSOQeqPaj2OuwBL3dFQjBj3Cv4zzELKOwliYMrldoJMKQgVY0t7SRWcv
         BCNFCvDtHfqn6Y3kGfDmyQKZ6Wa+TnKjpk1ivsyiO+1v4e3MvvW92HtWBuYKk1qLMYpE
         l405olgX87z0j4GYNoCdTBSfb/a4H4dIA0ZpGhRTxTffVlOGOUHu+beS/JqsF/voTgrs
         nzbNCq0qdov1EPsL5xy5OBYjDWosBD96V+XuIw3M19nV0DlIiyTumFxgOJx/4V76jbSX
         vlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142984; x=1685734984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAFsdkuWO9UgRn1XWK4rWMo4+aWqxozWG317Kv1fPQI=;
        b=hYn2GwDPWEC0w3N2lq4x8e3zj+vmKjicidvlURDutWIWd/BDayQAdkfqlHNhiYb/If
         yjJ0VqjLu7LvR0u1FuiU899Uh+TIOZjMb38NfkRGW80utx0GvG/V4XA2JTg5+gyQJwuY
         oQua10Tmw6j0ttO3Bcp8inWaIPHreF/1hc0gEJbGQnIlnLQQOmYuWhYpOUYIBrMmvpDr
         vh+560hd868wRccnsBkf3nhPlE+bvnbxq2aesUjsPmlHpWjMAhemRUz2o41/KkZsk8vi
         L5iM1sThj1C79aSYQkl8/TtohyUlUeH7VhO5XzgARd31KGqkevaBTkh7vcbcXxcH1bqI
         hZXg==
X-Gm-Message-State: AC+VfDxuEJU/9jWHKsOl8m2PBcVdOggEQpLO2ZkdqgsNqs867EBU5wqE
        5QbHtJEkapwsiyCpgI3hneX2oz7IBOZOos6Sm15Ri1EA
X-Google-Smtp-Source: ACHHUZ4gIRs9gBo1LjXdVV3q4tcb1osFnczRFcpQ7grVogYdoVSKuvGWsK6yPmJvwUjCH1hNHcnAhtATOCSBxm3UYIQ=
X-Received: by 2002:a05:6512:6f:b0:4ee:d562:573e with SMTP id
 i15-20020a056512006f00b004eed562573emr1565840lfo.22.1683142984319; Wed, 03
 May 2023 12:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-10-jorge.lopez2@hp.com>
 <951adb9c-dd5c-4c40-a786-2025ebe1650f@t-8ch.de>
In-Reply-To: <951adb9c-dd5c-4c40-a786-2025ebe1650f@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 3 May 2023 14:42:37 -0500
Message-ID: <CAOOmCE-dVzSrjWDx=tcXP-f+4NuN-U_-sc_QaLRt1qjtjaVVGw@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] HP BIOSCFG driver - enum-attributes
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

On Sun, Apr 23, 2023 at 7:55=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-20 11:54:49-0500, Jorge Lopez wrote:
> >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 543 ++++++++++++++++++
> >  1 file changed, 543 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.=
c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > new file mode 100644
> > index 000000000000..20defa92da6f
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > @@ -0,0 +1,543 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to enumeration type attributes under
> > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +GET_INSTANCE_ID(enumeration);
> > +
> > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_at=
tribute *attr, char *buf)
> > +{
> > +     int instance_id =3D get_enumeration_instance_id(kobj);
> > +
> > +     if (instance_id < 0)
> > +             return -EIO;
> > +
> > +     return sysfs_emit(buf, "%s\n",
> > +                      bioscfg_drv.enumeration_data[instance_id].curren=
t_value);
> > +}
> > +
> > +/*
> > + * validate_enumeration_input() -
> > + * Validate input of current_value against possible values
> > + *
> > + * @instance_id: The instance on which input is validated
> > + * @buf: Input value
> > + */
> > +static int validate_enumeration_input(int instance_id, const char *buf=
)
> > +{
> > +     int ret =3D 0;
> > +     int found =3D 0;
> > +     int i;
> > +     int possible_values;
> > +
> > +     /* Is it a read only attribute */
> > +     if (bioscfg_drv.enumeration_data[instance_id].common.is_readonly)
> > +             return -EIO;
> > +
> > +     possible_values =3D bioscfg_drv.enumeration_data[instance_id].pos=
sible_values_size;
> > +     for (i =3D 0; i < possible_values && !found; i++)
> > +             if (!strcasecmp(bioscfg_drv.enumeration_data[instance_id]=
.possible_values[i], buf))
>
> Is this also intentionally case-insensitive?

Yes

>
> > +                     found =3D 1;
> > +
> > +     if (!found) {
> > +             ret =3D -EINVAL;
> > +             goto exit_enum_input;
> > +     }
> > +
> > +     /*
> > +      * set pending reboot flag depending on
> > +      * "RequiresPhysicalPresence" value
> > +      */
> > +     if (bioscfg_drv.enumeration_data[instance_id].common.requires_phy=
sical_presence)
> > +             bioscfg_drv.pending_reboot =3D true;
> > +
> > +exit_enum_input:
> > +     return ret;
> > +}
> > +
> > +static void update_enumeration_value(int instance_id, char *attr_value=
)
> > +{
> > +     strscpy(bioscfg_drv.enumeration_data[instance_id].current_value,
> > +             attr_value,
> > +             sizeof(bioscfg_drv.enumeration_data[instance_id].current_=
value));
> > +}
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, enumerati=
on);
> > +static struct kobj_attribute enumeration_display_langcode =3D
> > +             __ATTR_RO(display_name_language_code);
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, enumeration);
> > +static struct kobj_attribute  enumeration_display_name =3D
> > +             __ATTR_RO(display_name);
> > +
> > +ATTRIBUTE_PROPERTY_STORE(current_value, enumeration);
> > +static struct kobj_attribute enumeration_current_val =3D
> > +     __ATTR_RW_MODE(current_value, 0644);
>
> 0644 is the default for __ATTR_RW(), use that instead.

Done!
>

<snip>
