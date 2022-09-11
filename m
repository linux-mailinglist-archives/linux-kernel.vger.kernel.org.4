Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65CD5B5074
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIKSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:00:33 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67335FD0;
        Sun, 11 Sep 2022 11:00:31 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11e9a7135easo17767234fac.6;
        Sun, 11 Sep 2022 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lpIz80DghGGwjIn4yGkOwm4Ls4TinTTtzRBXCYSCrDk=;
        b=ZOZgXqz/ArjfoAnB+0jZzRx+rthBH9sr3pdoFE3GNbBzpRISacpgTcE6VOzMyzccAX
         9F1FpqE8Q9dddd8Cf2TyxBRuX3ELEsjZHVa90iPoGZU5Jg753yq3RV4r9MrVb7yfyk7H
         pxaLwQoDIkA0jj3CgMY+swbBn2G7O7395aPkaAtWV5Ss4L6wEF+Vnx6S9tQ0D6vEj33B
         0l5eyMPS0yrXVJ8U9oVTPNTjPPnE1OZDEwadVQ91Ux9Hne8z+Ee9XAbFCKLh1PhOzIT3
         +Ey31t2F9J6sJwOQHUkh7Ht4bITQYO0W1jiAI7jq+S8JemMZve7JEPgInAnkNyGJxhS2
         hhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lpIz80DghGGwjIn4yGkOwm4Ls4TinTTtzRBXCYSCrDk=;
        b=Heg4l/9A8oOkck56aoynRlwGzsotTSlF1tEej74dCoAjzZG37HJ+3fjdrhhODz0jHL
         gMeBY0ypNblR7HkVORdd+8bdWB6hqqgvmbZvD0tdNpke8GufdFDbXdjKchIVFKwud1yC
         0vak4ZsGjfjKXIRaiMs2mBKjpnecS2GmAw81bYTeg98CA3XqlK0Oi7L1uLCNRATiJaqn
         UJg03D/YmmRW2S5olAF9gRFAIERGwC0iBjzoNp0YmfgOazftVoUkEnbtyVyiesiB3L5V
         7MGurdJz1KVe6U80B9n1FuJiSC26djd+efwsVw/7a0QNCby1f8iAzWBAsA+5nBWGUB6w
         9Oxg==
X-Gm-Message-State: ACgBeo1w3OpJo8qDAT1yTd6dhmodOzZ6Te5iwObrEP9QH3gG77cr57+x
        C3D3ynaR2c9Snq2oejDeM7GkIV7bl+rJj3830ns=
X-Google-Smtp-Source: AA6agR7dMjfSO8Fs6ZPG+miD78AZ0xIGFwEMeQnueiJDM9vQ5cSuGDdWOkeInvxGvtlWlUu5YIafHoVmQClvNOkxNsQ=
X-Received: by 2002:a05:6808:1a9a:b0:34f:b9df:b3 with SMTP id
 bm26-20020a0568081a9a00b0034fb9df00b3mr224200oib.183.1662919230912; Sun, 11
 Sep 2022 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com> <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com> <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com> <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com> <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com> <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
 <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com> <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
 <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com> <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
 <bab5a55b-cbd3-4119-af39-794e38f5a0ee@collabora.com>
In-Reply-To: <bab5a55b-cbd3-4119-af39-794e38f5a0ee@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 11 Sep 2022 11:00:21 -0700
Message-ID: <CAF6AEGvdyu8gO-Mjnau8uMwuKNPreEnnUH86WL=LQPcgW_WOEA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>
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

On Wed, Sep 7, 2022 at 3:25 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 8/23/22 19:47, Rob Clark wrote:
> > On Tue, Aug 23, 2022 at 3:01 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >> Am 22.08.22 um 19:26 schrieb Dmitry Osipenko:
> >>> On 8/16/22 22:55, Dmitry Osipenko wrote:
> >>>> On 8/16/22 15:03, Christian K=C3=B6nig wrote:
> >>>>> Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
> >>>>>> [SNIP]
> >>>>>>> The other complication I noticed is that we don't seem to keep ar=
ound
> >>>>>>> the fd after importing to a GEM handle.  And I could imagine that
> >>>>>>> doing so could cause issues with too many fd's.  So I guess the b=
est
> >>>>>>> thing is to keep the status quo and let drivers that cannot mmap
> >>>>>>> imported buffers just fail mmap?
> >>>>>> That actually should be all the drivers excluding those that use
> >>>>>> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why i=
t
> >>>>>> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn=
't
> >>>>>> work for the MSM driver, isn't it?
> >>>>>>
> >>>>>> Intel and AMD drivers don't allow to map the imported dma-bufs. Bo=
th
> >>>>>> refuse to do the mapping.
> >>>>>>
> >>>>>> Although, AMDGPU "succeeds" to do the mapping using
> >>>>>> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus fa=
ult,
> >>>>>> hence mapping actually fails. I think it might be the AMDGPU
> >>>>>> driver/libdrm bug, haven't checked yet.
> >>>>> That's then certainly broken somehow. Amdgpu should nerve ever have
> >>>>> allowed to mmap() imported DMA-bufs and the last time I check it di=
dn't.
> >>>> I'll take a closer look. So far I can only tell that it's a kernel
> >>>> driver issue because once I re-applied this "Don't map imported GEMs=
"
> >>>> patch, AMDGPU began to refuse mapping AMDGPU_GEM_DOMAIN_GTT.
> >>>>
> >>>>>> So we're back to the point that neither of DRM drivers need to map
> >>>>>> imported dma-bufs and this was never tested. In this case this pat=
ch is
> >>>>>> valid, IMO.
> >>>> Actually, I'm now looking at Etnaviv and Nouveau and seems they shou=
ld
> >>>> map imported dma-buf properly. I know that people ran Android on
> >>>> Etnaviv. So maybe devices with a separated GPU/display need to map
> >>>> imported display BO for Android support. Wish somebody who ran Andro=
id
> >>>> on one of these devices using upstream drivers could give a definiti=
ve
> >>>> answer. I may try to test Nouveau later on.
> >>>>
> >>> Nouveau+Intel combo doesn't work because of [1] that says:
> >>>
> >>> "Refuse to fault imported pages. This should be handled (if at all) b=
y
> >>> redirecting mmap to the exporter."
> >>>
> >>> [1]
> >>> https://elixir.bootlin.com/linux/v5.19/source/drivers/gpu/drm/ttm/ttm=
_bo_vm.c#L154
> >>>
> >>> Interestingly, I noticed that there are IGT tests which check prime
> >>> mmaping of Nouveau+Intel [2] (added 9 years ago), but they fail as we=
ll,
> >>> as expected. The fact that IGT has such tests is interesting because =
it
> >>> suggests that the mapping worked in the past. It's also surprising th=
at
> >>> nobody cared to fix the failing tests. For the reference, I checked
> >>> v5.18 and today's linux-next.
> >>>
> >>> [2]
> >>> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/=
prime_nv_test.c#L132
> >>>
> >>> Starting subtest: nv_write_i915_cpu_mmap_read
> >>> Received signal SIGBUS.
> >>> Stack trace:
> >>>   #0 [fatal_sig_handler+0x163]
> >>>   #1 [__sigaction+0x50]
> >>>   #2 [__igt_unique____real_main354+0x406]
> >>>   #3 [main+0x23]
> >>>   #4 [__libc_start_call_main+0x80]
> >>>   #5 [__libc_start_main+0x89]
> >>>   #6 [_start+0x25]
> >>> Subtest nv_write_i915_cpu_mmap_read: CRASH (0,005s)
> >>>
> >>> Starting subtest: nv_write_i915_gtt_mmap_read
> >>> Received signal SIGBUS.
> >>> Stack trace:
> >>>   #0 [fatal_sig_handler+0x163]
> >>>   #1 [__sigaction+0x50]
> >>>   #2 [__igt_unique____real_main354+0x33d]
> >>>   #3 [main+0x23]
> >>>   #4 [__libc_start_call_main+0x80]
> >>>   #5 [__libc_start_main+0x89]
> >>>   #6 [_start+0x25]
> >>> Subtest nv_write_i915_gtt_mmap_read: CRASH (0,004s)
> >>>
> >>> I'm curious about the Etnaviv driver because it uses own shmem
> >>> implementation and maybe it has a working mmaping of imported GEMs si=
nce
> >>> it imports the dma-buf pages into Entaviv BO. Although, it should be
> >>> risking to map pages using a different caching attributes (WC) from t=
he
> >>> exporter, which is prohibited on ARM ad then one may try to map impor=
ted
> >>> udmabuf.
>
> I see now that Etnaviv uses dma_buf_mmap(), so it should be okay.
>
> >>> Apparently, the Intel DG TTM driver should be able to map imported
> >>> dma-buf because it sets TTM_TT_FLAG_EXTERNAL_MAPPABLE.
> >>
> >> Even with that flag set it is illegal to map the pages directly by an
> >> importer.
> >>
> >> If that ever worked then the only real solution is to redirect mmap()
> >> calls on importer BOs to dma_buf_mmap().
> >
> > Yeah, I think this is the best option.  Forcing userspace to hang on
> > to the fd just in case someone calls readpix would be pretty harsh.
>
> Actually, I proposed this couple months ago [1].
>
> [1] https://patchwork.freedesktop.org/patch/487481/
>
> What's not clear to me is how userspace is supposed to sync CPU accesses
> for imported GEMs. Either userspace need to use dma_buf_sync UAPI for
> dmabuf of imported GEM or importer driver should do that, or there is
> some other option?

For anything involving the GPU, userspace already needs to sync access
(ie. GPUs are asynchronous).. this is done using drm_gem_object::resv
(which comes from dma_buf::resv)..

Possibly we should require that
dma_buf_begin_cpu_access()/dma_buf_end_cpu_access().. but in practice
if the gl/vk driver needs CPU access it is to read the results of it's
own GPU rendering.  Disallow that and all of deqp/piglit/etc will
break on systems where "window" surfaces are dma-buf imports (like
android), which would be a rather unpopular outcome ;-)

BR,
-R
