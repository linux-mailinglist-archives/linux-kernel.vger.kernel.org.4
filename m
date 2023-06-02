Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8A720910
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjFBSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjFBSXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:23:12 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A586123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:23:11 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5584f8ec391so1069369eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685730190; x=1688322190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPPbGQG2A4DDUN/YGohD/TGb1d9QQtBg0RaPc36PrpY=;
        b=AunarUqlKHvr+qASkx7HSnX5+ALP5AnzOCGrhpN5es4q/5pZ/tlGc1ZrAAHeQzU8+s
         +iXgmXC2VcRkjLjiRCIRPPgTU073LvEu3vC2X/Dlrc09bzkOA5aWaBWURbERw8c4N67Q
         v0eEg2f2ISKwtfwrG3emylwy1i+Bf7sClBCumE1rPKhWlKhxTUvDWXpobioBMn/uwcop
         4WIrcbA8kVCZ1Qz0Vmax+GvABOP/Au9xydNS9cYmCgUg4H3EPvPQ2+Ngx3/tWapGZWZq
         5yFOfr2pBik8CtRqq21aVtn3yW5JBcVcqTb4+MWbxu4YsCWvgDnueCIE3hKr+FievzvL
         ZtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730190; x=1688322190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPPbGQG2A4DDUN/YGohD/TGb1d9QQtBg0RaPc36PrpY=;
        b=jq4YZgDqR1qLCwdBfQdonRytnq7nVeZZJH/KjK9f6qGgdmUonZ1mDZZU1w4p9oW0y9
         c7rL0zOyvxiyKdE/PXoRPju9nktj5ghmL8yebHxbEJEYjkHtuf93mr3ULeQaiie/euwd
         eCgqB1zhHu12bmJJPOWJ1k6Ymo2V5ODJiVioKfCc5rMf5ydk0d3MNVX6W7L5eAMBWRo6
         P+cTRVO2JVrvobgDyTI9Rr1wvQ8LukEXyWQPIgoQpoQz2V6lRwrtFDp3fc5TLivtrWia
         3zJOPGtQ8wvFhNzgN7qMYL8UizNfWkI33O15hpFc1aiIcvCJuT/wjbPOUKmNSw54/28v
         Gh2w==
X-Gm-Message-State: AC+VfDwRGgfU8TCOt3GGrhhvwr0RN2culjzFo36rhwa/KfMFPRXqK7ZW
        otP6ccFLixQukoS1k3xNPK/9Qct/dn7T390QZGY=
X-Google-Smtp-Source: ACHHUZ61GfoJyGVd2+JIiM4DBsjSxXhMgTpekrg/Fdyp9NPDJGlMxEPGKsqQRVnqsaPc5Tz6IfL7/5sXfJTo8OwU9Ak=
X-Received: by 2002:a4a:2cc2:0:b0:555:48c0:cc63 with SMTP id
 o185-20020a4a2cc2000000b0055548c0cc63mr5624308ooo.2.1685730190624; Fri, 02
 Jun 2023 11:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230601224419.2392422-1-olvaffe@gmail.com> <0e55585d-d6d7-b9ac-aed5-8df56895e209@amd.com>
In-Reply-To: <0e55585d-d6d7-b9ac-aed5-8df56895e209@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 14:22:59 -0400
Message-ID: <CADnq5_MEZU=wD+wXdt+x0_LJS6y=PqkMLw7qD7yFk8ObR0k0-Q@mail.gmail.com>
Subject: Re: [PATCH v3] amdgpu: validate offset_in_bo of drm_amdgpu_gem_va
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        Philip Yang <Philip.Yang@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
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

Applied.  Thanks!


Alex

On Fri, Jun 2, 2023 at 7:43=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 02.06.23 um 00:44 schrieb Chia-I Wu:
> > This is motivated by OOB access in amdgpu_vm_update_range when
> > offset_in_bo+map_size overflows.
> >
> > v2: keep the validations in amdgpu_vm_bo_map
> > v3: add the validations to amdgpu_vm_bo_map/amdgpu_vm_bo_replace_map
> >      rather than to amdgpu_gem_va_ioctl
> >
> > Fixes: 9f7eb5367d00 ("drm/amdgpu: actually use the VM map parameters")
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 22f9a65ca0fc7..76d57bc7ac620 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1434,14 +1434,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev=
,
> >       uint64_t eaddr;
> >
> >       /* validate the parameters */
> > -     if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
> > -         size =3D=3D 0 || size & ~PAGE_MASK)
> > +     if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MAS=
K)
> > +             return -EINVAL;
> > +     if (saddr + size <=3D saddr || offset + size <=3D offset)
> >               return -EINVAL;
> >
> >       /* make sure object fit at this offset */
> >       eaddr =3D saddr + size - 1;
> > -     if (saddr >=3D eaddr ||
> > -         (bo && offset + size > amdgpu_bo_size(bo)) ||
> > +     if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> >           (eaddr >=3D adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT=
))
> >               return -EINVAL;
> >
> > @@ -1500,14 +1500,14 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_devi=
ce *adev,
> >       int r;
> >
> >       /* validate the parameters */
> > -     if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
> > -         size =3D=3D 0 || size & ~PAGE_MASK)
> > +     if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MAS=
K)
> > +             return -EINVAL;
> > +     if (saddr + size <=3D saddr || offset + size <=3D offset)
> >               return -EINVAL;
> >
> >       /* make sure object fit at this offset */
> >       eaddr =3D saddr + size - 1;
> > -     if (saddr >=3D eaddr ||
> > -         (bo && offset + size > amdgpu_bo_size(bo)) ||
> > +     if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> >           (eaddr >=3D adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT=
))
> >               return -EINVAL;
> >
>
