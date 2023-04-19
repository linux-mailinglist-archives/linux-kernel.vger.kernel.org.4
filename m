Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64EA6E7D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjDSPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjDSPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:00:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE91BF4;
        Wed, 19 Apr 2023 08:00:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id qf26so6325578qvb.6;
        Wed, 19 Apr 2023 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681916439; x=1684508439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+yIEO9tM41Om4Q5uaCccd0BnUH6gwgppvqHFPpI6yw=;
        b=QOwVTX+QNSFCXCs/MJan8WYyINf0tWZcH53Rr2Bu9T5EpKteEBzuFFOQMc5z8HXgPB
         h8hGsp8mMYLmAqpGcsdGzIA/UkFhVIpu9bu+8RzzhymzPgXIXC33IPRRaxckDVh6oYJt
         XXXdyExlRmgx7yJExVEIz5e127w7O5sUTu97Cct2+M3VYa222tEbYJR9/ArcXPNa3Aq4
         J7Iy2EK6QnDmadhAbGnqnCycuIlh81fyCaJk7lYHBaTvVbdQxSOrpLZuyBp//pbB9MJa
         WMSTltAgNXTbZN4nHwJOc8KHP2r2B38AnayEd1irwV76jBNUC9L/+2Fcd19Auq0ENZ7H
         0MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681916439; x=1684508439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+yIEO9tM41Om4Q5uaCccd0BnUH6gwgppvqHFPpI6yw=;
        b=Zqgm386+scvBtMpZAexxlF7PPHdaALllpvhe1LyF5mhXSfb4X/vM9xOCwX0/6dHvAi
         Eab6HVrBuX2prV9qLHqTK85IHx1yfItWa5YqhkS3w1jPx8eI/Wq4IvtxYYyTVEVQzL52
         R01z9HNT6DLeWDovefC3TcfDwr2al6Tk1moXrftYj6uhAl6bajI1kwVTvyiVoX4BLkrO
         JX1Zl+8LU9A23ID4YRmtLGynaN4mIEQaJe8etP+3DW0FaT6YBfgj4l1wGuedj8G2rayK
         qRYjZIwBYoSfMXBVo6ymJpUp1/rYsDT2xr1wFdgeVXSu9QRBD9J7cs+1Yc/hZ8hi/oPb
         r5Dg==
X-Gm-Message-State: AAQBX9dQUjWQ3trFCm+HJI0UlAfvQ0GMbIVRUoejTLxLfigEK0xAyGrx
        zNU8t8/turON8PUdRfRZymFfIoCY9wzRtGgpBQY=
X-Google-Smtp-Source: AKy350Y0Y/hbLWnpKH21R7X0WmgSsn4q71y5hJ1BaeJMOA8s4dxSu/iV5N/lTPb/+6LtE08yN5Ns2UMq18fFwR86hPA=
X-Received: by 2002:a05:6214:29ca:b0:56e:a96a:2bdc with SMTP id
 gh10-20020a05621429ca00b0056ea96a2bdcmr22630028qvb.40.1681916439030; Wed, 19
 Apr 2023 08:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230417201215.448099-1-robdclark@gmail.com> <20230417201215.448099-4-robdclark@gmail.com>
 <20655be0-65e3-0000-4acd-310ec9cc1d3a@linux.intel.com> <CAF6AEGsiNeHc7PuBnBkmwZ22S9dkmGqx70AEPmK8Fdp5J0YVaw@mail.gmail.com>
 <dfabcc1b-52d3-c5ef-3cd3-aad0aa51f960@linux.intel.com>
In-Reply-To: <dfabcc1b-52d3-c5ef-3cd3-aad0aa51f960@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 19 Apr 2023 08:00:27 -0700
Message-ID: <CAF6AEGuxKwAVBijMwPThORsZ5hQ6Mzhfe66UTNFqNQNUfQfimQ@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/msm: Add comm/cmdline fields
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 6:36=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 18/04/2023 15:56, Rob Clark wrote:
> > On Tue, Apr 18, 2023 at 1:53=E2=80=AFAM Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> >>
> >>
> >> On 17/04/2023 21:12, Rob Clark wrote:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> Normally this would be the same information that can be obtained in
> >>> other ways.  But in some cases the process opening the drm fd is mere=
ly
> >>> a sort of proxy for the actual process using the GPU.  This is the ca=
se
> >>> for guest VM processes using the GPU via virglrenderer, in which case
> >>> the msm native-context renderer in virglrenderer overrides the comm/
> >>> cmdline to be the guest process's values.
> >>>
> >>> Exposing this via fdinfo allows tools like gputop to show something m=
ore
> >>> meaningful than just a bunch of "pcivirtio-gpu" users.
> >>
> >> You also later expanded with:
> >>
> >> """
> >> I should have also mentioned, in the VM/proxy scenario we have a
> >> single process with separate drm_file's for each guest VM process.  So
> >> it isn't an option to just change the proxy process's name to match
> >> the client.
> >> """
> >>
> >> So how does that work - this single process temporarily changes it's
> >> name for each drm fd it opens and creates a context or it is actually =
in
> >> the native context protocol?
> >
> > It is part of the protocol, the mesa driver in the VM sends[1] this
> > info to the native-context "shim" in host userspace which uses the
> > SET_PARAM ioctl to pass this to the kernel.  In the host userspace
> > there is just a single process (you see the host PID below) but it
> > does a separate open() of the drm dev for each guest process (so that
> > they each have their own GPU address space for isolation):
> >
> > DRM minor 128
> >      PID    MEM ACTIV              NAME                    gpu
> >      5297  200M   82M com.mojang.minecr |=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=8F                        |
> >      1859  199M    0B            chrome |=E2=96=88=E2=96=89            =
                         |
> >      5297   64M    9M    surfaceflinger |                              =
         |
> >      5297   12M    0B org.chromium.arc. |                              =
         |
> >      5297   12M    0B com.android.syste |                              =
         |
> >      5297   12M    0B org.chromium.arc. |                              =
         |
> >      5297   26M    0B com.google.androi |                              =
         |
> >      5297   65M    0B     system_server |                              =
         |
> >
> >
> > [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/blob/master/sr=
c/drm/msm/msm_proto.h#L326
> > [2] https://gitlab.freedesktop.org/virgl/virglrenderer/-/blob/master/sr=
c/drm/msm/msm_renderer.c#L1050
> >
> >>>
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>>    Documentation/gpu/drm-usage-stats.rst |  8 ++++++++
> >>>    drivers/gpu/drm/msm/msm_gpu.c         | 14 ++++++++++++++
> >>>    2 files changed, 22 insertions(+)
> >>>
> >>> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gp=
u/drm-usage-stats.rst
> >>> index 8e00d53231e0..bc90bed455e3 100644
> >>> --- a/Documentation/gpu/drm-usage-stats.rst
> >>> +++ b/Documentation/gpu/drm-usage-stats.rst
> >>> @@ -148,6 +148,14 @@ percentage utilization of the engine, whereas dr=
m-engine-<keystr> only reflects
> >>>    time active without considering what frequency the engine is opera=
ting as a
> >>>    percentage of it's maximum frequency.
> >>>
> >>> +- drm-comm: <valstr>
> >>> +
> >>> +Returns the clients executable path.
> >>
> >> Full path and not just current->comm? In this case probably give it a
> >> more descriptive name here.
> >>
> >> drm-client-executable
> >> drm-client-command-line
> >>
> >> So we stay in the drm-client- namespace?
> >>
> >> Or if the former is absolute path could one key be enough for both?
> >>
> >> drm-client-command-line: /path/to/executable --arguments
> >
> > comm and cmdline can be different. Android seems to change the comm to
> > the apk name, for example (and w/ the zygote stuff cmdline isn't
> > really a thing)
> >
> > I guess it could be drm-client-comm and drm-client-cmdline?  Although
> > comm/cmdline aren't the best names, they are just following what the
> > kernel calls them elsewhere.
>
> I wasn't sure what do you plan to do given mention of a path under the
> drm-comm description. If it is a path then comm would be misleading,
> since comm as defined in procfs is not a path, I don't think so at
> least. Which is why I was suggesting executable. But if you remove the
> mention of a path from rst and rather refer to processes' comm value I
> think that is then okay.

Oh, whoops the mention of "path" for comm was a mistake.  task->comm
is described as executable name without path, and that is what the
fdinfo field was intending to follow.

> >>> +
> >>> +- drm-cmdline: <valstr>
> >>> +
> >>> +Returns the clients cmdline.
> >>
> >> I think drm-usage-stats.rst text should provide some more text with
> >> these two. To precisely define their content and outline the use case
> >> under which driver authors may want to add them, and fdinfo consumer
> >> therefore expect to see them. Just so everything is completely clear a=
nd
> >> people do not start adding them for drivers which do not support nativ=
e
> >> context (or like).
> >
> > I really was just piggy-backing on existing comm/cmdline.. but I'll
> > try to write up something better.
> >
> > I think it maybe should not be limited just to native context.. for
> > ex. if the browser did somehow manage to create different displays
> > associated with different drm_file instances (I guess it would have to
> > use gbm to do this?) it would be nice to see browser tab names.
>
> Would be cool yes.
>
> My thinking behind why we maybe do not want to blanket add them is
> because for common case is it the same information which can be obtained
> from procfs. Like in igt_drm_clients.c I get the pid and comm from
> /proc/$pid/stat. So I was thinking it is only interesting to add to
> fdinfo for drivers where it could differ by the explicit override like
> you have with native context.

Yeah, I suppose I could define them as drm-client-comm-override and
drm-client-cmdline-override

> It can be added once there is a GL/whatever extension which would allow
> it? (I am not familiar with how browsers manage rendering contexts so
> maybe I am missing something.)
>
> >> But on the overall it sounds reasonable to me - it would be really coo=
l
> >> to not just see pcivirtio-gpu as you say. Even if the standard virtiog=
pu
> >> use case (not native context) could show real users.
> >
> > For vrend/virgl, we'd first need to solve the issue that there is just
> > a single drm_file for all guest processes.  But really, just don't use
> > virgl.  (I mean, like seriously, would you put a gl driver in the
> > kernel?  Vrend has access to all guest memory, so this is essentially
> > what you have with virgl.  This is just not a sane thing to do.) The
> > only "valid" reason for not doing native-context is if you don't have
> > the src code for your UMD to be able to modify it to talk
> > native-context to virtgpu in the guest. ;-)
>
> I am just observing the current state of things on an Intel based
> Chromebook. :) Presumably the custom name for a context would be
> passable via the virtio-gpu protocol or something?

It is part of the context-type specific protocol.  Ie. some parts of
the protocol are "core" and dealt with in virtgpu guest kernel driver.
But on top of that there are various context-types with their own
protocol (ie. virgl, venus, cross-domain, msm native ctx, and some WIP
native ctx types floating around)

BR,
-R

> Regards,
>
> Tvrtko
>
> >
> > BR,
> > -R
> >
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>> +
> >>>    Implementation Details
> >>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_=
gpu.c
> >>> index f0f4f845c32d..1150dcbf28aa 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >>> @@ -148,12 +148,26 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static void get_comm_cmdline(struct msm_file_private *ctx, char **co=
mm, char **cmd);
> >>> +
> >>>    void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_priv=
ate *ctx,
> >>>                         struct drm_printer *p)
> >>>    {
> >>> +     char *comm, *cmdline;
> >>> +
> >>> +     get_comm_cmdline(ctx, &comm, &cmdline);
> >>> +
> >>>        drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
> >>>        drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
> >>>        drm_printf(p, "drm-maxfreq-gpu:\t%u Hz\n", gpu->fast_rate);
> >>> +
> >>> +     if (comm)
> >>> +             drm_printf(p, "drm-comm:\t%s\n", comm);
> >>> +     if (cmdline)
> >>> +             drm_printf(p, "drm-cmdline:\t%s\n", cmdline);
> >>> +
> >>> +     kfree(comm);
> >>> +     kfree(cmdline);
> >>>    }
> >>>
> >>>    int msm_gpu_hw_init(struct msm_gpu *gpu)
