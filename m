Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B45BBA1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIQTWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIQTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:22:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9E27DE7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:22:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j16so13632757lfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=4Ovbgm6nZe3/QpGYRlWJovhE/R7kO1q7d0zHL2Mifrc=;
        b=qUYPBRBfPN8ba4coLRPbhK7ncTZyn7P5fR5x/Jw7xmQQplV7fbm9cTUF9rPQUbKRko
         Pu1vZVNel79NuIeyr8DrhH8FAyh9MwRFveYIlMbUe0WWsGv4naKQFlDtKlbUY1ZIaqKI
         I0j4EFJYoxholQe/ayH4v8sRStq9vK2uNwSTjU5XPsTmpsGz6woE7hJoJR4lnIepvySV
         ALOd0cY13Y+4OPZ09NWPTs6sb4F7kFqDePpCTrsrYqpbqo9R3qrN7EBJkCzYS7fdiWMq
         j7MP49emET+1ydNUqD7fKYhJKO6oturtCL+KJrtbsnulwssCJDjFCkklfZeAKmnECTba
         rlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4Ovbgm6nZe3/QpGYRlWJovhE/R7kO1q7d0zHL2Mifrc=;
        b=tTyj2v6MOCh7btYh/hFpfTxgxYMvSGrJgkhSoyU5+gzLHr/GojtR2omjvta+b7F96x
         pqfcrweAYRaX73Qob++DdxMQEVlND9pXlMp+hMO0lCzUEX3Al9q2cPopuCcXAVHSdO4Q
         kpSa9R+2fiFOF3Uu+vooMltS06UOTgBoP6zVDJ5wCzN1yf4FwUlLaWpVPjDQDGss5I6t
         PTM+5cCDK5oJoVP4uGgf56nuyvz6XeWgo/4QXlT1zNGPycRKaE9TyU9tpI5dqj55przb
         CjSX6maFT36onD20ZomHH0JJA6v4iOOhVqKDTqm8ZrOhIwKFNgTLqVVkBWouRymj2rB3
         F4Hg==
X-Gm-Message-State: ACrzQf2w8WgHoGEcOj7vbSwxTaRQOpBYWFSFge5uMB7btsBBTYYMXu5v
        NU9wsEEZVODru10ELjM+VgWRC4HzVfazJwv9EBg=
X-Google-Smtp-Source: AMsMyM5yAf1p4dlhFzQKaQzWuD3rAawk4dyVy0LkQ3j+q4z6N3tGG6YeSA2+S70HwBnq5kMhtGIW0eLELR8KkKRwagU=
X-Received: by 2002:ac2:5191:0:b0:497:ac0c:cf65 with SMTP id
 u17-20020ac25191000000b00497ac0ccf65mr3811944lfi.436.1663442565407; Sat, 17
 Sep 2022 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220825191946.1678798-1-maccraft123mc@gmail.com> <b245787a-38fa-4202-cc7a-8fe18bc2308d@redhat.com>
In-Reply-To: <b245787a-38fa-4202-cc7a-8fe18bc2308d@redhat.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Sat, 17 Sep 2022 21:22:08 +0200
Message-ID: <CAO_MupKvwvG8Sg98psArQMHoqpBVxmgwpOzMpw340DoeDkPSng@mail.gmail.com>
Subject: Re: drm: panel-orientation-quirks: Add quirk for Aya Neo Air
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

sob., 17 wrz 2022 o 20:00 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(=
a):
>
> Hi,
>
> On 8/25/22 21:19, Maccraft123 wrote:
> > From: Maya Matuszczyk <maccraft123mc@gmail.com>
> >
> > Yet another x86 gaming handheld.
> >
> > This one has many SKUs with quite a few of DMI strings,
> > so let's just use a catchall, just as with Aya Neo Next.
> >
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>
> Thanks, I have pushed this out to drm-misc-next now.
>
> Note for future drm_panel_orientation_quirks.c patches please Cc me,
> I am not subscribed to dri-devel.
Yeah i forgot to Cc you on this patch, and had no idea how to bring it up.
I'll do my best to remember in future.
Thanks for picking this up!

Best Regards,
Maya Matuszczyk

>
> Regards,
>
> Hans
>
>
> > ---
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/drm/drm_panel_orientation_quirks.c
> > index fc1728d46ac2..0b011b615495 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -103,6 +103,12 @@ static const struct drm_dmi_panel_orientation_data=
 lcd800x1280_rightside_up =3D {
> >       .orientation =3D DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> >  };
> >
> > +static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftsi=
de_up =3D {
> > +     .width =3D 1080,
> > +     .height =3D 1920,
> > +     .orientation =3D DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> > +};
> > +
> >  static const struct drm_dmi_panel_orientation_data lcd1200x1920_rights=
ide_up =3D {
> >       .width =3D 1200,
> >       .height =3D 1920,
> > @@ -152,6 +158,12 @@ static const struct dmi_system_id orientation_data=
[] =3D {
> >                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
> >               },
> >               .driver_data =3D (void *)&lcd800x1280_rightside_up,
> > +     }, {    /* AYA NEO AIR */
> > +             .matches =3D {
> > +               DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> > +               DMI_MATCH(DMI_BOARD_NAME, "AIR"),
> > +             },
> > +             .driver_data =3D (void *)&lcd1080x1920_leftside_up,
> >       }, {    /* AYA NEO NEXT */
> >               .matches =3D {
> >                 DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>
