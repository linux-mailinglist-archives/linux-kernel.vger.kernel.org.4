Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814695BB9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIQRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 13:51:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A52717C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:51:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j9so6439683ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=QLB73e/AoLaAaQXTsmvr/2mevo0TuA6Fykh7CCtGThc=;
        b=eKEtUDOeK4mx3mJec93tUvCamLNs3TwxuhdN7DbP9+dgtJ8D53Tir/4xQYrdtxIFzm
         igUm9o1p1yLkW1LugoGfFSeKIwWH1CgeQ7+EZU7cCRK3N/0mgiAvccfMyuMyu9FLDSsh
         uwIhgiIt6W5tQAu17NoLbHkk5LI7d8bSRicY4ME4CK60Enl3cQtxXwXYWSqXfdjB8PiL
         wtpGkif048BsKJfq7V83M7jat0d09yTxMhNjQsdY2LZujp7TVIVMJWShaXmXLPIK5lXF
         /5g1CqE+aDyHBCNPecTrEBHsOPTFjeMCmThqAih9Brook+XyWNlkqIBkPiP90Bvdxegp
         TqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QLB73e/AoLaAaQXTsmvr/2mevo0TuA6Fykh7CCtGThc=;
        b=puenj/YF0vUM2RR7vZTrTstl9i0jLMmTpXhL0PwnUQbZN88P8n0uMx/Ze7C+/Dl/6g
         FUZmVjlV0NtnZVh4VFNWUb9COK3najNdcvWo0tMwL9Rsc+MZcCdf0DbYW1uRoe8r8P0T
         XSA3TrZ9+t12OPR+MZJeIKjK5KsYVdUwWFSBsrbocqiRdWD6VudiiSL/09jCyWrDK2pa
         pWb/oDmfCwLi39uPuRGaGYAbjHaofJnDmzfIn5Z9TAtFmHtRHuUl+1vPApCndtAmbWKB
         G7WjRGk+z94pmGPFd+k+AQJ5vK4BhYizxTWhP2/v8oPRnGar2zKNWRDBMsNDseUisy1B
         TK3Q==
X-Gm-Message-State: ACrzQf2TUve8ceib1XOACWJc5Ekem0/5CkcIiKwXJkI4eihN32HlOykh
        3CoqiT0aYO2MbJWxNHiT+XcT1855hDtQbOICUpg=
X-Google-Smtp-Source: AMsMyM4CaDwbvsWZheNnie6dHTP6HCVagwrEHEZ5r/uxrchts8wh1RceesPb3AFxqyMYMCHkiDUD0SqnKIUNTkUzYXA=
X-Received: by 2002:a2e:a41b:0:b0:26c:3714:1d99 with SMTP id
 p27-20020a2ea41b000000b0026c37141d99mr2788606ljn.144.1663437077112; Sat, 17
 Sep 2022 10:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220803182402.1217293-1-maccraft123mc@gmail.com> <4e145e1d-db9a-0edb-cdd4-1da3e02131fd@redhat.com>
In-Reply-To: <4e145e1d-db9a-0edb-cdd4-1da3e02131fd@redhat.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Sat, 17 Sep 2022 19:50:40 +0200
Message-ID: <CAO_MupL6pHFS8=jGjUy6mBgkdL4bNbJp8R1MaBBNOzOP20eurQ@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Anbernic Win600
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hello,

sob., 17 wrz 2022 o 15:04 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(=
a):
>
> Hi,
>
> On 8/3/22 20:24, Maccraft123 wrote:
> > From: Maya Matuszczyk <maccraft123mc@gmail.com>
> >
> > This device is another x86 gaming handheld, and as (hopefully) there is
> > only one set of DMI IDs it's using DMI_EXACT_MATCH
> >
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>
> Thanks I have added this patch to my local drm-misc-next branch.
>
> I will push this out to the official drm-misc-next branch after
> running some local tests.

Can you also take a look at this patch too?
https://patchwork.freedesktop.org/patch/499589/

Best Regards,
Maya Matuszczyk

>
> (unfortunately it is too late now to push this to drm-misc-fixes
> for this cycle, sorry).
>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/drm/drm_panel_orientation_quirks.c
> > index d4e0f2e85548..a8681610ede7 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -128,6 +128,12 @@ static const struct dmi_system_id orientation_data=
[] =3D {
> >                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
> >               },
> >               .driver_data =3D (void *)&lcd800x1280_rightside_up,
> > +     }, {    /* Anbernic Win600 */
> > +             .matches =3D {
> > +               DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Anbernic"),
> > +               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
> > +             },
> > +             .driver_data =3D (void *)&lcd720x1280_rightside_up,
> >       }, {    /* Asus T100HA */
> >               .matches =3D {
> >                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
>
