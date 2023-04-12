Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6847F6DF9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDLPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDLPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:21:06 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD37EEF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:20:35 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1842df7cb53so14172501fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312835; x=1683904835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SkQUe1sjVjm42OHiHhks/DOrgWsxVG26S1+y3HVvJk=;
        b=gkhlF4kzoVQ3so1r46S3MCKarEYn8iRvENC4uneOuGL3oeNRHP3y/Dfzskiy/EveNi
         IExZmlF1+CSpGYXUR28ehshK5OODFllNsVWJjJ41+DTQWJ8l4OYmjbIqlmSzAMOZ/M+0
         Mw8cD0yJ3tnnZ9JSJ5UZvahqZu8e3m2z3z/eAebu8svyj2QPgHswjDu9DpcpM6whN5qi
         xb+KFASS84EpvMI/2rVqUohivtr0cujvYtNp+NbVppgfsjIsfv15X8PqDjiGrj3NsqXL
         FAhIVEVHDXGmUhSN6ojiDFIAbb4mEkbhiLVnLgD+Qlo4Y9ZsxnXA9cb2C5ykNtsp4uej
         slAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312835; x=1683904835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SkQUe1sjVjm42OHiHhks/DOrgWsxVG26S1+y3HVvJk=;
        b=s7XfrXUkxflag++VS7qbvZ+FZmlvSITwpxIwunFI1AekFcAkPWi2oHIa1rhFBLRw7k
         3WUoDE/RsQuyi6BXPjsWRUe9SuweeNG7GQOjFPIHkNozZjlE4TMdWk3HcEJ5inPYafno
         YWBH/PQ7Z/yrQrFw8muLOzggxdvMmOobPBPBEBKSYSicT8ca5/yZd1ZGd9f7DATfLubB
         dnIjZ3QdF+lWIWMemMBeexshp6L60ZUwz+GYSvxXd5hMV88PxZJ7SVnB+jE91andrl7J
         X891uHm4q31cJCyH3d2izFbtejJCZoYlhUFpcsQakuKXyrgnon+h/yInVOLtTPTxQRNf
         DMag==
X-Gm-Message-State: AAQBX9eR8tg8ylhbyrlpu2U2ngRsqncQBjUSQMjRQJN+IcvKL8b1TSRc
        5mJsYwjZ83nihgeOcYFGbAUA2Mr8K/ptNl5PGgs=
X-Google-Smtp-Source: AKy350YGghYNh91iovq41s2Uzcr2C1jcbbEj9Nd9XDec0GIcwxWjGH4t3ykPmNDskbpvwkZL9ifIyrCykZ0DRLa8HP4=
X-Received: by 2002:a05:6870:3050:b0:184:56bd:363a with SMTP id
 u16-20020a056870305000b0018456bd363amr3697696oau.3.1681312834820; Wed, 12 Apr
 2023 08:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403182808.8699-1-n.zhandarovich@fintech.ru>
 <BL1PR12MB51446866BAE5945297315399F79A9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <5d5b0b94-4dd4-2a95-a777-521b65f6f053@fintech.ru>
In-Reply-To: <5d5b0b94-4dd4-2a95-a777-521b65f6f053@fintech.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Apr 2023 11:20:23 -0400
Message-ID: <CADnq5_PECupBm9ADGs5DsfM4i7FJCORD_s6=8Ky=416eFX4CTg@mail.gmail.com>
Subject: Re: [PATCH] radeon: avoid double free in ci_dpm_init()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Wed, Apr 12, 2023 at 8:39=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
>
>
> On 4/11/23 14:11, Deucher, Alexander wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> >> Sent: Monday, April 3, 2023 2:28 PM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> >> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; amd-
> >> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> >> kernel@vger.kernel.org; lvc-project@linuxtesting.org
> >> Subject: [PATCH] radeon: avoid double free in ci_dpm_init()
> >>
> >> There are several calls to ci_dpm_fini() in ci_dpm_init() when there o=
ccur
> >> errors in functions like r600_parse_extended_power_table().
> >> This is harmful as it can lead to double free situations: for instance=
,
> >> r600_parse_extended_power_table() will call for
> >> r600_free_extended_power_table() as will ci_dpm_fini(), both of which =
will
> >> try to free resources.
> >> Other drivers do not call *_dpm_fini functions from their respective
> >> *_dpm_init calls - neither should cpm_dpm_init().
> >>
> >> Fix this by removing extra calls to ci_dpm_fini().
> >
> > You can't just drop the calls to fini().  You'll need to properly unwin=
d to avoid leaking memory.
> >
> > Alex
> >>>
> >> Found by Linux Verification Center (linuxtesting.org) with static anal=
ysis tool
> >> SVACE.
> >>
> >> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Natalia Petrova <n.petrova@fintech.ru>
> >> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> >>
> >> ---
> >>  drivers/gpu/drm/radeon/ci_dpm.c | 20 +++++---------------
> >>  1 file changed, 5 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c
> >> b/drivers/gpu/drm/radeon/ci_dpm.c index 8ef25ab305ae..7b77d4c93f1d
> >> 100644
> >> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> >> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> >> @@ -5677,28 +5677,20 @@ int ci_dpm_init(struct radeon_device *rdev)
> >>      pi->pcie_lane_powersaving.min =3D 16;
> >>
> >>      ret =3D ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
> >> -    if (ret) {
> >> -            ci_dpm_fini(rdev);
> >> +    if (ret)
> >>              return ret;
> >> -    }
> >>
> >>      ret =3D r600_get_platform_caps(rdev);
> >> -    if (ret) {
> >> -            ci_dpm_fini(rdev);
> >> +    if (ret)
> >>              return ret;
> >> -    }
> >>
> >>      ret =3D r600_parse_extended_power_table(rdev);
> >> -    if (ret) {
> >> -            ci_dpm_fini(rdev);
> >> +    if (ret)
> >>              return ret;
> >> -    }
> >>
> >>      ret =3D ci_parse_power_table(rdev);
> >> -    if (ret) {
> >> -            ci_dpm_fini(rdev);
> >> +    if (ret)
> >>              return ret;
> >> -    }
> >>
> >>      pi->dll_default_on =3D false;
> >>      pi->sram_end =3D SMC_RAM_END;
> >> @@ -5749,10 +5741,8 @@ int ci_dpm_init(struct radeon_device *rdev)
> >>              kcalloc(4,
> >>                      sizeof(struct
> >> radeon_clock_voltage_dependency_entry),
> >>                      GFP_KERNEL);
> >> -    if (!rdev-
> >>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
> >> -            ci_dpm_fini(rdev);
> >> +    if (!rdev-
> >>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
> >>              return -ENOMEM;
> >> -    }
> >>      rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count =3D 4;
> >>      rdev-
> >>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk =3D 0;
> >>      rdev-
> >>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v =3D 0;
>
>
> I think you are correct when it comes to ensuring we deal with memory
> issues in ci_dpm_init().
>
> However, I could use some direction on how to deal with the problem of
> freeing only previously allocated resources. For instance, once
> ci_parse_power_table() fails, it is not clear what we should and should
> not free.

You'll want to free any memory allocated in ci_dpm_init().  Any of the
functions called from that function should clean themselves up if they
allocate any memory, but if not, they should be fixed.

Alex


>
> I wanna point out that in this case I would like to fix both double and
> uninitialized free issues as it can also lead to undefined behavior.
>
> Thanks for your patience,
> Nikita
