Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385B570860F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjERQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:29:02 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6028B3;
        Thu, 18 May 2023 09:29:00 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-54fd9c0e435so1039398eaf.2;
        Thu, 18 May 2023 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684427340; x=1687019340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU/QbehuPdiis3FPBB/wwGErB67sty3CgLk7RAimgtM=;
        b=fG846peOIWRolpBHwk0Odd8RmOGM3sEUZXDYvrXdaoU1yo38Llsi748DBrwOur7Nx5
         XU4PQr1zU0vrbPnaOq/56QU27QpBIksKKNO8ueWh/kiETN7aO4Fa9ByTq3wn7XraGsKG
         /ESkxYGpdd9aHDzU4qgbQ3m43EaKMMi25StEML8tM6pE1DD9Nu6KbLphcYMZwYZ1h2lV
         qIUQoernB5OWXb2eG2d+6yE78F9RcaehGf2lNjA8pa0V6h/fkePGF1UetJdZ1bA5Hpv0
         jxFa4qEcTJlVVCrStv0cnJugsKaFkqKpavhz8bligJ6OCqlt+L+M6c2AbMEW9hSTuy9j
         tZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684427340; x=1687019340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU/QbehuPdiis3FPBB/wwGErB67sty3CgLk7RAimgtM=;
        b=CZKQnk2cp9AatkAnPytxPNy3MpWDS5rUY7RtsqK2y4us5foSN0B7F2gBThiU0Vb8hS
         38LxDDkZFrWmWxpTHmlBuZkLpuDSo8xHWL82gslKXi1tDRJCpnKEwlCp0GbpV1qYZIlK
         7ZO1fNRbSMMX0yecNZ3oi6O6VjxAPIuorhf0umXqmvzVV1+O7CSZV1SHKc5suK2Th+Rd
         w+lFtMUHIlmlcQ0GG7WoCCeYCZZgIc0aaBPHnGXpzIPIDRfa783P14Xw2LOpeII/NpMJ
         +/D9MxNE3ROOVdPWaDkxeWPeIyBSHhgr6w0dkPBgdBn54AWV5OPvxh6p24Xt3vMUJ0nt
         8j4g==
X-Gm-Message-State: AC+VfDxFA5poLS7AxmG929Up0jC3WgPk4HcgjsW4AfeaVvlIAtyya4e8
        7pKlgqFkn7cstEhVM0UCiOWmVisMVNn6kfLfX6Q=
X-Google-Smtp-Source: ACHHUZ7Cba0L5dSEXsajkVCTobT5f2fijlyMwRzbQeTTadci7v1I+bLeSHhzp9m1Z9Tj7+8M5F6HLgrMDmVNUPtf1yg=
X-Received: by 2002:a05:6808:649:b0:394:27d6:8d98 with SMTP id
 z9-20020a056808064900b0039427d68d98mr1415180oih.31.1684427339800; Thu, 18 May
 2023 09:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230427175340.1280952-1-robdclark@gmail.com> <20230427175340.1280952-9-robdclark@gmail.com>
 <135ff649-e50c-50f4-55ba-a1b615865e02@linux.intel.com> <CAF6AEGvKnPgtna4yjN56mMjCLqpjs8B8K152VWxmPs1NdY78vA@mail.gmail.com>
 <b615ba5e-c15a-226b-959b-e76216015f83@linux.intel.com> <1420ed7c-d3c2-7768-f954-4a88036448a9@linux.intel.com>
In-Reply-To: <1420ed7c-d3c2-7768-f954-4a88036448a9@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 18 May 2023 09:28:48 -0700
Message-ID: <CAF6AEGu40P8LY1H9UjJyfNsgOBtsBrPON3i4Jkj-mjxAbPsreA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] drm/fdinfo: Add comm/cmdline override fields
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, May 18, 2023 at 2:43=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> In case you were waiting for me looking at the rest of the series, there
> was this reply from the previous round I can expand on.
>
> On 02/05/2023 08:50, Tvrtko Ursulin wrote:
> >
> > On 01/05/2023 17:58, Rob Clark wrote:
> >> On Fri, Apr 28, 2023 at 4:05=E2=80=AFAM Tvrtko Ursulin
> >> <tvrtko.ursulin@linux.intel.com> wrote:
> >>>
> >>>
> >>> On 27/04/2023 18:53, Rob Clark wrote:
> >>>> From: Rob Clark <robdclark@chromium.org>
> >>>>
> >>>> These are useful in particular for VM scenarios where the process wh=
ich
> >>>> has opened to drm device file is just a proxy for the real user in a=
 VM
> >>>> guest.
> >>>>
> >>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>>> ---
> >>>>    Documentation/gpu/drm-usage-stats.rst | 18 ++++++++++++++++++
> >>>>    drivers/gpu/drm/drm_file.c            | 15 +++++++++++++++
> >>>>    include/drm/drm_file.h                | 19 +++++++++++++++++++
> >>>>    3 files changed, 52 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/gpu/drm-usage-stats.rst
> >>>> b/Documentation/gpu/drm-usage-stats.rst
> >>>> index 58dc0d3f8c58..e4877cf8089c 100644
> >>>> --- a/Documentation/gpu/drm-usage-stats.rst
> >>>> +++ b/Documentation/gpu/drm-usage-stats.rst
> >>>> @@ -73,6 +73,24 @@ scope of each device, in which case `drm-pdev`
> >>>> shall be present as well.
> >>>>    Userspace should make sure to not double account any usage
> >>>> statistics by using
> >>>>    the above described criteria in order to associate data to
> >>>> individual clients.
> >>>>
> >>>> +- drm-comm-override: <valstr>
> >>>> +
> >>>> +Returns the client executable override string.  Some drivers
> >>>> support letting
> >>>> +userspace override this in cases where the userspace is simply a
> >>>> "proxy".
> >>>> +Such as is the case with virglrenderer drm native context, where
> >>>> the host
> >>>> +process is just forwarding command submission, etc, from guest
> >>>> userspace.
> >>>> +This allows the proxy to make visible the executable name of the
> >>>> actual
> >>>> +app in the VM guest.
> >>>> +
> >>>> +- drm-cmdline-override: <valstr>
> >>>> +
> >>>> +Returns the client cmdline override string.  Some drivers support
> >>>> letting
> >>>> +userspace override this in cases where the userspace is simply a
> >>>> "proxy".
> >>>> +Such as is the case with virglrenderer drm native context, where
> >>>> the host
> >>>> +process is just forwarding command submission, etc, from guest
> >>>> userspace.
> >>>> +This allows the proxy to make visible the cmdline of the actual app
> >>>> in the
> >>>> +VM guest.
> >>>
> >>> Perhaps it would be okay to save space here by not repeating the
> >>> description, like:
> >>>
> >>> drm-comm-override: <valstr>
> >>> drm-cmdline-override: <valstr>
> >>>
> >>> Long description blah blah...
> >>> This allows the proxy to make visible the _executable name *and* comm=
and
> >>> line_ blah blah..
> >>>
> >>>> +
> >>>>    Utilization
> >>>>    ^^^^^^^^^^^
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> >>>> index 9321eb0bf020..d7514c313af1 100644
> >>>> --- a/drivers/gpu/drm/drm_file.c
> >>>> +++ b/drivers/gpu/drm/drm_file.c
> >>>> @@ -178,6 +178,8 @@ struct drm_file *drm_file_alloc(struct drm_minor
> >>>> *minor)
> >>>>        spin_lock_init(&file->master_lookup_lock);
> >>>>        mutex_init(&file->event_read_lock);
> >>>>
> >>>> +     mutex_init(&file->override_lock);
> >>>> +
> >>>>        if (drm_core_check_feature(dev, DRIVER_GEM))
> >>>>                drm_gem_open(dev, file);
> >>>>
> >>>> @@ -292,6 +294,8 @@ void drm_file_free(struct drm_file *file)
> >>>>        WARN_ON(!list_empty(&file->event_list));
> >>>>
> >>>>        put_pid(file->pid);
> >>>> +     kfree(file->override_comm);
> >>>> +     kfree(file->override_cmdline);
> >>>>        kfree(file);
> >>>>    }
> >>>>
> >>>> @@ -995,6 +999,17 @@ void drm_show_fdinfo(struct seq_file *m, struct
> >>>> file *f)
> >>>>                           PCI_SLOT(pdev->devfn),
> >>>> PCI_FUNC(pdev->devfn));
> >>>>        }
> >>>>
> >>>> +     mutex_lock(&file->override_lock);
> >>>
> >>> You could add a fast unlocked check before taking the mutex for no ri=
sk
> >>> apart a transient false negative. For 99.9999% of userspace it would
> >>> mean no pointless lock/unlock cycle.
> >>
> >> I'm not sure I get your point?  This needs to be serialized against
> >> userspace setting the override values
> >
> > if (file->override_comm || file->override_cmdline) {
> >      mutex_lock(&file->override_lock);
> >      if (file->override_comm)
> >          drm_printf(&p, "drm-comm-override:\t%s\n",
> >                 file->override_comm);
> >      if (file->override_cmdline)
> >          drm_printf(&p, "drm-cmdline-override:\t%s\n",
> >                 file->override_cmdline);
> >      mutext_unlock(&file->override_lock);
> > }
> >
> > No risk apart for a transient false negative (which is immaterial for
> > userspace since fdinfo reads are not ordered versus the override settin=
g
> > anyway) and 99.9% of deployments can get by not needing to pointlessly
> > cycle the lock.
>
> This fast path bypass I think is worth it but up to you if you are
> really opposed. It's just that I don't see a point for cycling the mutex
> for nothing in majority of cases.

I think it is a premature optimization.. an uncontended lock is "just"
an atomic.  Yes, atomics can be expensive in a hot path.. but in this
case it is going to be lost in the noise.  I did look a bit at gputop
with `perf record` and it is very much not the problem.

> >>>
> >>>> +     if (file->override_comm) {
> >>>> +             drm_printf(&p, "drm-comm-override:\t%s\n",
> >>>> +                        file->override_comm);
> >>>> +     }
> >>>> +     if (file->override_cmdline) {
> >>>> +             drm_printf(&p, "drm-cmdline-override:\t%s\n",
> >>>> +                        file->override_cmdline);
> >>>> +     }
> >>>> +     mutex_unlock(&file->override_lock);
> >>>> +
> >>>>        if (dev->driver->show_fdinfo)
> >>>>                dev->driver->show_fdinfo(&p, file);
> >>>>    }
> >>>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> >>>> index 1339e925af52..604d05fa6f0c 100644
> >>>> --- a/include/drm/drm_file.h
> >>>> +++ b/include/drm/drm_file.h
> >>>> @@ -370,6 +370,25 @@ struct drm_file {
> >>>>         */
> >>>>        struct drm_prime_file_private prime;
> >>>>
> >>>> +     /**
> >>>> +      * @comm: Overridden task comm
> >>>> +      *
> >>>> +      * Accessed under override_lock
> >>>> +      */
> >>>> +     char *override_comm;
> >>>> +
> >>>> +     /**
> >>>> +      * @cmdline: Overridden task cmdline
> >>>> +      *
> >>>> +      * Accessed under override_lock
> >>>> +      */
> >>>> +     char *override_cmdline;
> >>>> +
> >>>> +     /**
> >>>> +      * @override_lock: Serialize access to override_comm and
> >>>> override_cmdline
> >>>> +      */
> >>>> +     struct mutex override_lock;
> >>>> +
> >>>
> >>> I don't think this should go to drm just yet though. Only one driver =
can
> >>> make use of it so I'd leave it for later and print from msm_show_fdin=
fo
> >>> for now.
> >>
> >> This was my original approach but danvet asked that it be moved into
> >> drm for consistency across drivers.  (And really, I want the in-flight
> >> amd and intel native-context stuff to motivate adding similar features
> >> to amdgpu/i915/xe.)
> >
> > IMO if implementation is not shared, not even by using helpers, I don't
> > think data storage should be either, but it's not a deal breaker.
>
> To summarise my thoughts on the patch (v4):
>
> I am not really keen on the split of data fields in common and no common
> implementation or helpers.

I can go either way on this.. it was danvet that suggested moving to
drm_file to encourage more standardization.

(But we can also land the meminfo parts of the series without this
part.. it was just convenient for me to keep them in the same series
to avoid conflicts)

BR,
-R

> For what the drm-usage-stats.rst are concerned it looks completely fine.
> And feature really will be useful in virtualised stacks.
>
> Code in this patch is also completely fine.
>
> Therefore you can have an r-b on those parts, but with reservations on
> whether it makes sense to put the fields under drm_file just yet. That
> should be fine under the r-b rules AFAIU. Ideally you can collect an ack
> from someone else too.
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> Regards,
>
> Tvrtko
>
> >
> > Regards,
> >
> > Tvrtko
> >
> >>
> >> BR,
> >> -R
> >>
> >>> Regards,
> >>>
> >>> Tvrtko
> >>>
> >>>>        /* private: */
> >>>>    #if IS_ENABLED(CONFIG_DRM_LEGACY)
> >>>>        unsigned long lock_count; /* DRI1 legacy lock count */
