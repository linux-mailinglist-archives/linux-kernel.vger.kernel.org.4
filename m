Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C96E6731
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDRObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:31:34 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46F211B;
        Tue, 18 Apr 2023 07:31:32 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1879fc89f5eso310325fac.0;
        Tue, 18 Apr 2023 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681828292; x=1684420292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5ACrXrGwITOLTD4dccqngzAY+kQ6PuMFiv2tu/9e90=;
        b=HDG3wPhsu14GZOZbzagsY1x1sk+Kdmr/rua4nDTIL8VZWi1SnNdirRCkg6AlOpaFbe
         kNr6Qg5EZOw8DLgOy9r+OeJGmlf2hnoObFtzRb1Dz+NHhR/kNK7A+uGgvePxyWeMx9cN
         E6MwLh1CqXcsJ+3TZD9v46gyQe4ryV6kPOvatzk28DkgTb1+kQ1A7cQtxHxl5KDh4XhS
         kbThLZR6nIDd3JGBm1tlH8lADFcb25tRDludRZ11Hb4iTGmMoU6n6n9VFnlM+kmlQcHw
         1IoSssNRoPqOYk1UyyP0FKA41CjUoyzaDPzSAJfP+To3lDYRuXVXHe+PwUzRJr56D40t
         lNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681828292; x=1684420292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5ACrXrGwITOLTD4dccqngzAY+kQ6PuMFiv2tu/9e90=;
        b=fOJZG5BD1CZy8GPCqy/9ogPpt1JHMoJCAONC+uoo9NJfruIFRY3iVl07LnbxABhfVp
         0N0e9i64Itgq/On0ZkgKNTl+lojSA298V+UtqvL1yXz9lD2uY2BYKy5mpg4wlt8tUT6R
         2Bo22EH6lj12ymoP0gj4d0ovDhmZTG2Qoxcz1wXsd58osUTQk0wiEf/GzM9ByjTyUIHT
         cYbzKDOEgtO20PbQKX1lrA3aTQijH162ecPzhSLLeV7BMR6KAusV9JvbOOOhxMD9CbbN
         fXaKqulqOs3CVNVZPeRJ/b6bL1DhrsB8UVUrSdG/Df1W7ThzEfL86bx9HMkS4Nk9JTyk
         kk1w==
X-Gm-Message-State: AAQBX9elif39kjYf/9H5o4kqIwWfNqPJ8xBR6vEDIeCR3ANxZV4C9Vl1
        5YJLSRbi4H/Kw3wUk8AOrxQ/0Ir0kyq7xtvu+GY=
X-Google-Smtp-Source: AKy350aAs+nlCTwr3Bx+LCW+MDhg5c40W8a2nTsaDwXoGoGkBI0MbdGRg43BSQC/ynXheSqyV4A8zoqCX5LyHngHTDo=
X-Received: by 2002:a05:6870:11cf:b0:184:2097:e64f with SMTP id
 15-20020a05687011cf00b001842097e64fmr1140305oav.5.1681828291977; Tue, 18 Apr
 2023 07:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230417201215.448099-1-robdclark@gmail.com> <20230417201215.448099-3-robdclark@gmail.com>
 <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com> <ZD5WLMRNibbRkGQO@phenom.ffwll.local>
In-Reply-To: <ZD5WLMRNibbRkGQO@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 18 Apr 2023 07:31:21 -0700
Message-ID: <CAF6AEGugcuV08G_pxjUGvhTbp8DFFG4ws3=oiP5PpbRf=SJdhQ@mail.gmail.com>
Subject: Re: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
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

On Tue, Apr 18, 2023 at 1:34=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Tue, Apr 18, 2023 at 09:27:49AM +0100, Tvrtko Ursulin wrote:
> >
> > On 17/04/2023 21:12, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Make it work in terms of ctx so that it can be re-used for fdinfo.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
> > >   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
> > >   drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
> > >   drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
> > >   drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
> > >   5 files changed, 21 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/dr=
m/msm/adreno/adreno_gpu.c
> > > index bb38e728864d..43c4e1fea83f 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > @@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct =
msm_file_private *ctx,
> > >             /* Ensure string is null terminated: */
> > >             str[len] =3D '\0';
> > > -           mutex_lock(&gpu->lock);
> > > +           mutex_lock(&ctx->lock);
> > >             if (param =3D=3D MSM_PARAM_COMM) {
> > >                     paramp =3D &ctx->comm;
> > > @@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct =
msm_file_private *ctx,
> > >             kfree(*paramp);
> > >             *paramp =3D str;
> > > -           mutex_unlock(&gpu->lock);
> > > +           mutex_unlock(&ctx->lock);
> > >             return 0;
> > >     }
> > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_=
drv.c
> > > index 3d73b98d6a9c..ca0e89e46e13 100644
> > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > @@ -581,6 +581,8 @@ static int context_init(struct drm_device *dev, s=
truct drm_file *file)
> > >     rwlock_init(&ctx->queuelock);
> > >     kref_init(&ctx->ref);
> > > +   ctx->pid =3D get_pid(task_pid(current));
> >
> > Would it simplify things for msm if DRM core had an up to date file->pi=
d as
> > proposed in
> > https://patchwork.freedesktop.org/patch/526752/?series=3D109902&rev=3D4=
 ? It
> > gets updated if ioctl issuer is different than fd opener and this being
> > context_init here reminded me of it. Maybe you wouldn't have to track t=
he
> > pid in msm?

The problem is that we also need this for gpu devcore dumps, which
could happen after the drm_file is closed.  The ctx can outlive the
file.

But the ctx->pid has the same problem as the existing file->pid when
it comes to Xorg.. hopefully over time that problem just goes away.  I
guess I could do a similar dance to your patch to update the pid
whenever (for ex) a submitqueue is created.

> Can we go one step further and let the drm fdinfo stuff print these new
> additions? Consistency across drivers and all that.

Hmm, I guess I could _also_ store the overridden comm/cmdline in
drm_file.  I still need to track it in ctx (msm_file_private) because
I could need it after the file is closed.

Maybe it could be useful to have a gl extension to let the app set a
name on the context so that this is useful beyond native-ctx (ie.
maybe it would be nice to see that "chrome: lwn.net" is using less gpu
memory than "chrome: phoronix.com", etc)

BR,
-R

> Also for a generic trigger I think any driver ioctl is good enough (we
> only really need to avoid the auth dance when you're not on a render
> node).
> -Daniel
>
> >
> > Regards,
> >
> > Tvrtko
> >
> > > +   mutex_init(&ctx->lock);
> > >     msm_submitqueue_init(dev, ctx);
> > >     ctx->aspace =3D msm_gpu_create_private_address_space(priv->gpu, c=
urrent);
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_=
gpu.c
> > > index c403912d13ab..f0f4f845c32d 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > > @@ -327,18 +327,17 @@ find_submit(struct msm_ringbuffer *ring, uint32=
_t fence)
> > >   static void retire_submits(struct msm_gpu *gpu);
> > > -static void get_comm_cmdline(struct msm_gem_submit *submit, char **c=
omm, char **cmd)
> > > +static void get_comm_cmdline(struct msm_file_private *ctx, char **co=
mm, char **cmd)
> > >   {
> > > -   struct msm_file_private *ctx =3D submit->queue->ctx;
> > >     struct task_struct *task;
> > > -   WARN_ON(!mutex_is_locked(&submit->gpu->lock));
> > > -
> > >     /* Note that kstrdup will return NULL if argument is NULL: */
> > > +   mutex_lock(&ctx->lock);
> > >     *comm =3D kstrdup(ctx->comm, GFP_KERNEL);
> > >     *cmd  =3D kstrdup(ctx->cmdline, GFP_KERNEL);
> > > +   mutex_unlock(&ctx->lock);
> > > -   task =3D get_pid_task(submit->pid, PIDTYPE_PID);
> > > +   task =3D get_pid_task(ctx->pid, PIDTYPE_PID);
> > >     if (!task)
> > >             return;
> > > @@ -372,7 +371,7 @@ static void recover_worker(struct kthread_work *w=
ork)
> > >             if (submit->aspace)
> > >                     submit->aspace->faults++;
> > > -           get_comm_cmdline(submit, &comm, &cmd);
> > > +           get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
> > >             if (comm && cmd) {
> > >                     DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (=
%s)\n",
> > > @@ -460,7 +459,7 @@ static void fault_worker(struct kthread_work *wor=
k)
> > >             goto resume_smmu;
> > >     if (submit) {
> > > -           get_comm_cmdline(submit, &comm, &cmd);
> > > +           get_comm_cmdline(submit->queue->ctx, &comm, &cmd);
> > >             /*
> > >              * When we get GPU iova faults, we can get 1000s of them,
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_=
gpu.h
> > > index 7a4fa1b8655b..b2023a42116b 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > > @@ -377,17 +377,25 @@ struct msm_file_private {
> > >      */
> > >     int sysprof;
> > > +   /** @pid: Process that opened this file. */
> > > +   struct pid *pid;
> > > +
> > > +   /**
> > > +    * lock: Protects comm and cmdline
> > > +    */
> > > +   struct mutex lock;
> > > +
> > >     /**
> > >      * comm: Overridden task comm, see MSM_PARAM_COMM
> > >      *
> > > -    * Accessed under msm_gpu::lock
> > > +    * Accessed under msm_file_private::lock
> > >      */
> > >     char *comm;
> > >     /**
> > >      * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
> > >      *
> > > -    * Accessed under msm_gpu::lock
> > > +    * Accessed under msm_file_private::lock
> > >      */
> > >     char *cmdline;
> > > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/=
msm/msm_submitqueue.c
> > > index 0e803125a325..0444ba04fa06 100644
> > > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > @@ -61,6 +61,7 @@ void __msm_file_private_destroy(struct kref *kref)
> > >     }
> > >     msm_gem_address_space_put(ctx->aspace);
> > > +   put_pid(ctx->pid);
> > >     kfree(ctx->comm);
> > >     kfree(ctx->cmdline);
> > >     kfree(ctx);
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
