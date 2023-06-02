Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7191B720966
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbjFBSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbjFBSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:50:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09011B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:50:31 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5552cbcda35so1717377eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685731831; x=1688323831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9IT4dMLc0VJwFJv5MIZvoqgL4JP+fvL51k/lEqt6X8=;
        b=O845rgfJyJbtMEuivJ7pmwbwAJKJa66AhqKS+rz7FhGMCe5FqpHSf2Cw/0HYflwRqd
         3fB3wz59l3Z9naRjBoiQbyJNSUYyp9IraLFuOfIc3phQKd8SzSS5vjE13Igk9Nl6LxPA
         gYlSzmd5z/EoI7ydkmKc4ox1iI4nTJ4+PaqjZEG84OVkzKCVDnpjXQNe9m7lk+hWa1ca
         3F6JPHHM5oRvp/QTxtCBe0iJfzDJZwzdenSKY9d/rj5AUM2GWNLoMHJEpYHRHpZ5Z6iu
         qrvEcWQ8wi8T0XgbbWuMYR0/07DmKU0dFevUoDAiyDNtr8CeXJdchlgTGPCLLBjBD68L
         i30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731831; x=1688323831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9IT4dMLc0VJwFJv5MIZvoqgL4JP+fvL51k/lEqt6X8=;
        b=L9BXxNqF1BR2bTaE+XtBqHeWQkGTX/StH9VABPsnTe6GKkihHhcoD97vE8s8ypkydC
         JilWzufvl83QUs5WRMY8drC7SzN6mO0HyyIHoxRdkAD5U2tS7x5HTsaaUHsBt41f0Uv6
         eZ4ogfDq0iORsqf9VXPByFQQWn2f6H5a7i5XE26VAO5t8PGPmd4vBz58cp5wN/wvzI0a
         QP/CyBnrV6oQOL0KVtP63e8LTbfhHOV+2RiKTBWiEj30+vKYTFYA9QcZq9V41QzP7o7p
         vWA/EWPywOnGN8XUcChZOHc3Fpa41S0BVcIcDdj03vcdgtk3rGVvJna7wcCEZ+gp1nfk
         hjHg==
X-Gm-Message-State: AC+VfDz2KApCxjFnBeeULkAvundpV499556vp7shSost8fQRUW7si82W
        VsBj9AJSBUjqZ0cJbwGKLbWuI4GxxCVuFKN7CPf4Uzou
X-Google-Smtp-Source: ACHHUZ6a8a2i7gjugJRdJ7jtjj03LgJWq8kQFfaWhatEWxSvcgJqqgtrkNrJPH7jnG3Q1p7xe2iu6lBfygiJ8SBYUJ0=
X-Received: by 2002:a4a:8c05:0:b0:555:51fd:a760 with SMTP id
 u5-20020a4a8c05000000b0055551fda760mr8048348ooj.4.1685731830965; Fri, 02 Jun
 2023 11:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214814.2329224-1-olvaffe@gmail.com> <CADnq5_NQ2zgvRDZ8NWUsCm-8JO6PZSEmQ+WrbjYqjv3vTLfinw@mail.gmail.com>
In-Reply-To: <CADnq5_NQ2zgvRDZ8NWUsCm-8JO6PZSEmQ+WrbjYqjv3vTLfinw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 14:50:19 -0400
Message-ID: <CADnq5_OmrnBhRbRZ_0thdKktNsSDG4w7dr8Vn_sbiNT2_t2UQA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix xclk freq on CHIP_STONEY
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

Nevermind, missing your Signed-off-by.  Please add and I'll apply.

Alex

On Fri, Jun 2, 2023 at 2:19=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Applied.  Thanks!
>
> Alex
>
> On Thu, Jun 1, 2023 at 5:48=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrot=
e:
> >
> > According to Alex, most APUs from that time seem to have the same issue
> > (vbios says 48Mhz, actual is 100Mhz).  I only have a CHIP_STONEY so I
> > limit the fixup to CHIP_STONEY
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> > index 770f2d7a371fc..6a8494f98d3ef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
> >         u32 reference_clock =3D adev->clock.spll.reference_freq;
> >         u32 tmp;
> >
> > -       if (adev->flags & AMD_IS_APU)
> > -               return reference_clock;
> > +       if (adev->flags & AMD_IS_APU) {
> > +               switch (adev->asic_type) {
> > +               case CHIP_STONEY:
> > +                       /* vbios says 48Mhz, but the actual freq is 100=
Mhz */
> > +                       return 10000;
> > +               default:
> > +                       return reference_clock;
> > +               }
> > +       }
> >
> >         tmp =3D RREG32_SMC(ixCG_CLKPIN_CNTL_2);
> >         if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
