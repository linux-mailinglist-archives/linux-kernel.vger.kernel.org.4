Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C46F5F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjECTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:35:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197ECE;
        Wed,  3 May 2023 12:35:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2aa39ce5d26so58371251fa.1;
        Wed, 03 May 2023 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683142511; x=1685734511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVTjOoPTajzLs5EnFTk42rqCIkKzKzAO7FsfEwv4OOc=;
        b=MZ8pp3tVeiAB3HTgQ8xIHx8s9Y2jIFNkhjHcCGa0VokGGvzD+3pfVWkrJ63aJuifCz
         QG5LXkYbrba3ntxfnDaCXsdbNnMeMR+RU9GkTlrfq4OSoWp1I06cqHcspkJIHkEjEUBk
         +4JYm5p3vFzbi/20XW0WmLx4pc0/P3EXmUhmAVtdxVog/bSK9skpMWefL10t31G14D9a
         JQtfiRl9PzhMQWsU2XQ/KF+s9jkapOJSVtJt/yBlnmARXoGXPkYxH8utoRogag0pt9Ar
         0l1H8f3Z2zYlpybmdikwCMrDtkn52ckWce1XzrwUlFRmyRoqM8q60z9/yH71ihVwOJsx
         RE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142511; x=1685734511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVTjOoPTajzLs5EnFTk42rqCIkKzKzAO7FsfEwv4OOc=;
        b=hzoZZIMSyhPr7KD9xrAr0pvplQdu/v7Il2vpLxJYXmJmLXhUxJBocG1d5V1KN45TuV
         p0E9bRQXiU2ZbtUcH7jqLTBqcJWmEuH9ANQBdCrbhLipio6iSluzkUpJ00FebsSRc8Qf
         Ag8cfzyUApJDAu74DhoByrQCMqfK68LZmQFBQ+uwAw2WQ56RN1FNZ9aU0DxD9GEMXMSV
         0AdGO/mE937gssvGUMLxQh2mT+B7yE3deWtAl7NFo9NSWGQpL0WqpbrYlNjA18WAFI+l
         0Q3Epabaf4EK/AK5kMrurTjCvw7zEhiFLuFEkTdZkgAfSO4cX3xKsC3V3mhYYsemQOao
         UF+w==
X-Gm-Message-State: AC+VfDxhrdhe/zeylhaI/9AvY5qmZfQ7QWKMz6C6gLND4Qunu1ACVaz0
        aTMULIvww7T82Afv4JpMg9v/fCo3vePFB37/FTuXgSd8
X-Google-Smtp-Source: ACHHUZ79EpZQpBLtqnetYk4qtoVHX+AS/YXuCZE48AKFM909eTVh5w2sXI83OJktw8AJ8Dxva27SkwTlWr0aGsCY/Sc=
X-Received: by 2002:a2e:808a:0:b0:2a7:6807:2cf8 with SMTP id
 i10-20020a2e808a000000b002a768072cf8mr294667ljg.35.1683142510506; Wed, 03 May
 2023 12:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-12-jorge.lopez2@hp.com>
 <7364268c-cbff-42a3-a79a-069eef31899e@t-8ch.de>
In-Reply-To: <7364268c-cbff-42a3-a79a-069eef31899e@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 3 May 2023 14:34:43 -0500
Message-ID: <CAOOmCE-jP8Romsx+wYrRjOHj_VNh3m+JR4fnd1T0gjJm+n145Q@mail.gmail.com>
Subject: Re: [PATCH v11 11/14] HP BIOSCFG driver - spmobj-attributes
To:     thomas@t-8ch.de
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

On Sun, Apr 23, 2023 at 4:24=E2=80=AFAM <thomas@t-8ch.de> wrote:
>
> On 2023-04-20 11:54:51-0500, Jorge Lopez wrote:
> >  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 405 ++++++++++++++++++
> >  1 file changed, 405 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attribute=
s.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> > new file mode 100644
> > index 000000000000..78228f44c39b
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> > @@ -0,0 +1,405 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to secure platform management object type
> > + * attributes under BIOS PASSWORD for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +
> > +static const char * const spm_state_types[] =3D {
> > +     "not provisioned",
> > +     "provisioned",
> > +     "provisioning in progress"
> > +};
> > +
> > +static const char * const spm_mechanism_types[] =3D {
> > +     "not provision",
>
> "not provisioned" as above?

Good catch.  Done!
>
> > +     "signing-key",
> > +     "endorsement-key"
>
> Trailing commas please.
>
Done!
> > +};
> > +
> > +
> > +int check_spm_is_enabled(void)
> > +{
> > +     /* do we need to check the admin password is also configured */
> > +     return bioscfg_drv.spm_data.is_enabled;
> > +}
> > +
> > +/*
> > + * calculate_security_buffer() - determines size of security buffer
> > + * for authentication scheme
> > + *
> > + * @authentication: the authentication content
> > + *
> > + * Currently only supported type is Admin password
> > + */
> > +size_t calculate_security_buffer(const char *authentication)
> > +{
> > +     int size;
> > +
> > +     if (authentication !=3D NULL && strlen(authentication) > 0) {
> > +
> > +             size =3D (sizeof(u16) + (strlen(authentication) * sizeof(=
u16)));
> > +             if (strncmp(authentication, BEAM_PREFIX, strlen(BEAM_PREF=
IX)) !=3D 0)
>
> strstarts()

Done!
>
> > +                     size +=3D (strlen(UTF_PREFIX) * sizeof(u16));
>
> No need for braces.

Done!
>
> > +
> > +             return size;
> > +     }
> > +
> > +     size  =3D sizeof(u16) * 2;
> > +     return size;
> > +}
> > +
> > +/*
> > + * populate_security_buffer() - builds a security buffer for
> > + * authentication scheme
> > + *
> > + * @buffer: the buffer to populate
> > + * @authentication: the authentication content
> > + *
> > + * Currently only supported type is PLAIN TEXT
> > + */
> > +void populate_security_buffer(u16 *buffer, const char *authentication)
> > +{
> > +     u16 *auth =3D buffer;
> > +     char *strprefix =3D NULL;
> > +
> > +     if (strncmp(authentication, BEAM_PREFIX, strlen(BEAM_PREFIX)) =3D=
=3D 0) {
>
> strstarts()

Done!
>
> > +             /*
> > +              * BEAM_PREFIX is append to buffer when a signature
> > +              * is provided and Sure Admin is enabled in BIOS
> > +              */
> > +             // BEAM_PREFIX found, convert part to unicode
> > +             auth =3D ascii_to_utf16_unicode(auth, authentication);
> > +     } else {
> > +             /*
> > +              * UTF-16 prefix is append to the * buffer when a BIOS
> > +              * admin password is configured in BIOS
> > +              */
> > +
> > +             // append UTF_PREFIX to part and then convert it to unico=
de
> > +             strprefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> > +                                   authentication);
> > +             if (!strprefix)
> > +                     goto out_buffer;
> > +
> > +             auth =3D ascii_to_utf16_unicode(auth, strprefix);
> > +     }
> > +out_buffer:
> > +
> > +     kfree(strprefix);
> > +}
> > +
> > +ssize_t update_spm_state(void)
> > +{
> > +     int ret;
> > +     struct secureplatform_provisioning_data *data =3D NULL;
>
> This can be allocated on the stack.

Done!
>
> > +
> > +     data =3D kmalloc(sizeof(struct secureplatform_provisioning_data),
> > +                    GFP_KERNEL);
> > +     if (!data) {
> > +             ret =3D -ENOMEM;
> > +             goto state_exit;
> > +     }
> > +
> > +     ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> > +                                HPWMI_SECUREPLATFORM, data, 0,
> > +                                sizeof(*data));
> > +     if (ret < 0)
> > +             goto state_exit;
> > +
> > +     bioscfg_drv.spm_data.mechanism =3D data->state;
> > +     if (bioscfg_drv.spm_data.mechanism)
> > +             bioscfg_drv.spm_data.is_enabled =3D 1;
> > +
> > +state_exit:
> > +     kfree(data);
> > +
> > +     return ret;
> > +}
> > +
> > +ssize_t statusbin(struct kobject *kobj,
> > +               struct kobj_attribute *attr, char *buf)
>
> This can be static.

Done!
>
> If it is known that a struct secureplatform_provisioning_data is to be
> passed, then the type can reflect that.

Done!
>
> > +{
> > +     int ret =3D hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> > +                                    HPWMI_SECUREPLATFORM, buf, 0,
> > +                                    sizeof(struct secureplatform_provi=
sioning_data));
> > +
> > +     return ret ? -ENODEV : sizeof(struct secureplatform_provisioning_=
data);
>
> Why not return "ret" on error?

Good point. Done!
>
> > +}
> > +
> > +/*
> > + * status_show - Reads SPM status
> > + */
> > +ssize_t status_show(struct kobject *kobj, struct kobj_attribute
> > +                 *attr, char *buf)
> > +{
> > +     int ret, i;
> > +     struct secureplatform_provisioning_data *data =3D NULL;
>
> Can also be on-stack.

Done!
>
<snip>
> > +static struct kobj_attribute password_spm_key_mechanism =3D __ATTR_RO(=
key_mechanism);
> > +
> > +static ssize_t sk_store(struct kobject *kobj,
> > +                     struct kobj_attribute *attr,
> > +                     const char *buf, size_t count)
> > +{
> > +     int ret;
> > +     int length;
> > +
> > +     length =3D count;
> > +     if (buf[length-1] =3D=3D '\n')
> > +             length--;
> > +
> > +     /* allocate space and copy current signing key */
> > +     bioscfg_drv.spm_data.signing_key =3D kmalloc(length, GFP_KERNEL);
> > +     if (!bioscfg_drv.spm_data.signing_key) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_sk;
> > +     }
> > +
> > +     memcpy(bioscfg_drv.spm_data.signing_key, buf, length);
> > +     bioscfg_drv.spm_data.signing_key[length] =3D '\0';
>
> Is this supposed to handle zero-bytes in the input?
> If yes: Did you test this with zero bytes, I don't think the normal
> attribute APIs handle this.
> If no: Why not use strscpy?
>

Done!

<snip>
