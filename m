Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD30868C5A5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBFSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBFSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:22:11 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2509771
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:22:10 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-15f97c478a8so16108024fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7e8GU9xSC1sP5VIpcopkgOF82v0TP3oKnk/11tSpP0=;
        b=AxUKFec2/yYtc34aAbMml1uUi5rUZKsLvPJ2ut79kAsHZukakfQ2QvJ4YlaLZfv1w5
         GYzWohONUwHzSHZsJbCcEnGhoh3XuETMS/NZAl/+UX8sTKmjPvckY5YwZ9d0Ev2aC2/d
         yTXh08vGy9qkZOpMMV6Io04TNM0WmbMlbJDWqp1zKqADOj/L73JCIsixB8Jy065pL22x
         Fs3M1H/pTeDYNSxVn5Vcw5a1jOU6dwVSzBD4HkPxpIMfYrWthtwFITtsrwIsG8DT5TUP
         Daxeh9L0koy5qiT5VvUslmHGC3/Z87PQT5pxCi+3swjMGAglkJVyChi/RcOySXaCuymx
         5iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7e8GU9xSC1sP5VIpcopkgOF82v0TP3oKnk/11tSpP0=;
        b=Avn/GxorzmCoI1qby21oew/KhX6mGa0Z1tQ9REnHfAcCgxKCGjb3HoSmSlwVHq6r+b
         ioH56HIVSHNfe0q6G2IrztJeJQSmwRHJJo3yp83iSnR7hpcUXYehoN4q0TQArKSTsNYA
         zOYKLP2Dvi1dhGk15aAOhURJr5TFEzKmP8YGROpu+Ph09SyHdxkAMGUhAoDhzFvH0FCy
         8gsWPB1L2iTEu2CAYp6PROmkkiJkJzRl/7ApYc8NB6uykdrouzSHWjoq+X3wdDlyFUE+
         rF7ZpqTkuR9eEY5esXkjV1BGQpZAu2BGZ0lOpY6GT7+N2GewfeG5m+e4Zc2ol1OTvZbN
         U1+w==
X-Gm-Message-State: AO0yUKVmPObQ8vqdweQEqQyll9Y15wSsfzvYVgrc34iJ/E6eBIkKr1Cd
        5nXpvSnehGDVceW+CzDYBCPe8yJbNEDyg+HXl3A=
X-Google-Smtp-Source: AK7set+yVVcaiUCUBgcMs3+pTWuTLaezK5+rSwnpMO/PfEL4Ya6vQe1iIoTXlqJW135Qgr9ym4Rue46r4whDjVkDRvM=
X-Received: by 2002:a05:6870:14c8:b0:163:999e:6460 with SMTP id
 l8-20020a05687014c800b00163999e6460mr57502oab.38.1675707729560; Mon, 06 Feb
 2023 10:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20230203181005.4129175-1-robdclark@gmail.com> <2d5fc6f8-2247-8a8b-1174-eccdc2b08064@amd.com>
 <CAF6AEGtAqE-h06zgCzjr+R-WWj0ELfyKkD8KHZUYeo6cjS1ceQ@mail.gmail.com> <c6c9b6af-f832-3cc3-2d03-29d5f7aaddef@amd.com>
In-Reply-To: <c6c9b6af-f832-3cc3-2d03-29d5f7aaddef@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 6 Feb 2023 10:21:58 -0800
Message-ID: <CAF6AEGuxsYQo5yHhXkJHagM4Wiq0XCughPfSFxyTWZPorp5mgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix potential race processing vm->freed
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>, Qiang Yu <qiang.yu@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 6, 2023 at 8:05 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 06.02.23 um 16:52 schrieb Rob Clark:
> > On Mon, Feb 6, 2023 at 2:15 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 03.02.23 um 19:10 schrieb Rob Clark:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> If userspace calls the AMDGPU_CS ioctl from multiple threads, because
> >>> the vm is global to the drm_file, you can end up with multiple thread=
s
> >>> racing in amdgpu_vm_clear_freed().  So the freed list should be
> >>> protected with the status_lock, similar to other vm lists.
> >> Well this is nonsense. To process the freed list the VM root PD lock
> >> must be held anyway.
> >>
> >> If we have a call path where this isn't true then we have a major bug =
at
> >> a different place here.
> > I'm not super familiar w/ the amdgpu cs parser stuff, but the only
> > thing that I'm seeing that protects things is the bo_list_mutex and it
> > isn't clear to me that this is 1:1 with the vm (it looks like it is
> > not).
>
> Do you have a backtrace?
>
> Take a look at the reservation object of vm->root.bo. This should always
> be locked first before doing *anything* in a CS.
>
> If that isn't the case we have a much worse problem.

In this case, maybe an dma_resv_assert_held() would be a good idea?

BR,
-R

> > (I cc'd you on the bug report, jfyi)
>
> I unfortunately only get a permission denied when I try to access that on=
e.
>
> Regards,
> Christian.
>
> >
> > BR,
> > -R
> >
> >> Regards,
> >> Christian.
> >>
> >>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 33 ++++++++++++++++++++++=
----
> >>>    1 file changed, 29 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> >>> index b9441ab457ea..aeed7bc1512f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -1240,10 +1240,19 @@ int amdgpu_vm_clear_freed(struct amdgpu_devic=
e *adev,
> >>>        struct amdgpu_bo_va_mapping *mapping;
> >>>        uint64_t init_pte_value =3D 0;
> >>>        struct dma_fence *f =3D NULL;
> >>> +     struct list_head freed;
> >>>        int r;
> >>>
> >>> -     while (!list_empty(&vm->freed)) {
> >>> -             mapping =3D list_first_entry(&vm->freed,
> >>> +     /*
> >>> +      * Move the contents of the VM's freed list to a local list
> >>> +      * that we can iterate without racing against other threads:
> >>> +      */
> >>> +     spin_lock(&vm->status_lock);
> >>> +     list_replace_init(&vm->freed, &freed);
> >>> +     spin_unlock(&vm->status_lock);
> >>> +
> >>> +     while (!list_empty(&freed)) {
> >>> +             mapping =3D list_first_entry(&freed,
> >>>                        struct amdgpu_bo_va_mapping, list);
> >>>                list_del(&mapping->list);
> >>>
> >>> @@ -1258,6 +1267,15 @@ int amdgpu_vm_clear_freed(struct amdgpu_device=
 *adev,
> >>>                amdgpu_vm_free_mapping(adev, vm, mapping, f);
> >>>                if (r) {
> >>>                        dma_fence_put(f);
> >>> +
> >>> +                     /*
> >>> +                      * Move any unprocessed mappings back to the fr=
eed
> >>> +                      * list:
> >>> +                      */
> >>> +                     spin_lock(&vm->status_lock);
> >>> +                     list_splice_tail(&freed, &vm->freed);
> >>> +                     spin_unlock(&vm->status_lock);
> >>> +
> >>>                        return r;
> >>>                }
> >>>        }
> >>> @@ -1583,11 +1601,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *=
adev,
> >>>        mapping->bo_va =3D NULL;
> >>>        trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> >>>
> >>> -     if (valid)
> >>> +     if (valid) {
> >>> +             spin_lock(&vm->status_lock);
> >>>                list_add(&mapping->list, &vm->freed);
> >>> -     else
> >>> +             spin_unlock(&vm->status_lock);
> >>> +     } else {
> >>>                amdgpu_vm_free_mapping(adev, vm, mapping,
> >>>                                       bo_va->last_pt_update);
> >>> +     }
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -1671,7 +1692,9 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_d=
evice *adev,
> >>>                    tmp->last =3D eaddr;
> >>>
> >>>                tmp->bo_va =3D NULL;
> >>> +             spin_lock(&vm->status_lock);
> >>>                list_add(&tmp->list, &vm->freed);
> >>> +             spin_unlock(&vm->status_lock);
> >>>                trace_amdgpu_vm_bo_unmap(NULL, tmp);
> >>>        }
> >>>
> >>> @@ -1788,7 +1811,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *ade=
v,
> >>>                amdgpu_vm_it_remove(mapping, &vm->va);
> >>>                mapping->bo_va =3D NULL;
> >>>                trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> >>> +             spin_lock(&vm->status_lock);
> >>>                list_add(&mapping->list, &vm->freed);
> >>> +             spin_unlock(&vm->status_lock);
> >>>        }
> >>>        list_for_each_entry_safe(mapping, next, &bo_va->invalids, list=
) {
> >>>                list_del(&mapping->list);
>
