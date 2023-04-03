Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6536D4515
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjDCNBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDCNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:01:07 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405612D5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:01:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m16so14284239ybk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680526865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YLJ1r5bdMLsK8dBy54n3Qb5veY9qnBAq1TCcYa+Dx8=;
        b=RSZfuYH81aTTTFuhFczj95wZbfft2iucFlkpjeH7LbrYx2FOIqWpoS2BcpYe0zc+FX
         atbYdyjjRM1Yct5sQMhIlPAlcbbrKeH9OPGgUo9ENfZ92F9ehcVvyvYHol5BrQE5HHhW
         kjtCs4Bj2TBNoWIzhJlRqS+rSfTuDUQTx5lWGeWQTXI7taOSs1BtxEhIze1r8XwGHxYg
         L2uFPZ4USzG0+N1gN80Li1DhT7G9cQW4klHhP8AF5wt3E8iInUMBQDivG6tXtRud9pA7
         kaAWT0h75vAYW1cVx7iM1dUpG7lj6lNnJia5rYMKVvfWCvKuclArjzfoou/0zaGHJimi
         u0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YLJ1r5bdMLsK8dBy54n3Qb5veY9qnBAq1TCcYa+Dx8=;
        b=kE6pHutBdICtGYMd9Bv7tV/nT3QygkHJ3Q3X640ruk8YnQSyhcZpVkRwixKGvW7k2x
         NkwK5at7Ruxb+yQp6iepJKSvO13FHVdjMdkyCsEJ+VmqIbwCnNFYnHUp79g96kzfK6r5
         00w7+g7Su9kan0XnDxm13SLGgnjsqNQ4GfA3kHFt8VvE7Qm0/L+UO7fJm0Yp14HfEfZB
         c5sEYe3x2GZUuxEgYGSWTK1swYqGyq6u+9iiqR9O2jEF1ZHLosdTy6KNstd5t9yRAd9U
         0Yc++NYHTINWiP3Unc7JbA96/WoOwPPb8Wj3SFXGpr9Sdc4xyRs3v1QQ+tfCl0QZJm71
         rwqQ==
X-Gm-Message-State: AAQBX9cFjDxmI+zkMqN6XOZcdCfge7ogfnPRDSjfO33I+4pvaW2BPdg/
        QWTWkLsYEtuLRHD+c9WjwdKqQR+1CF/OYB1cdnU=
X-Google-Smtp-Source: AKy350ZmAUD/hfo7+b/Uc0EPxmcymTmczI4//qDUSR73IUhQmLucgJ9hxbJb+7nsAzBolXbdv5evf3LMSyRuIh10aUg=
X-Received: by 2002:a05:6902:920:b0:b76:ae61:b68b with SMTP id
 bu32-20020a056902092000b00b76ae61b68bmr18277120ybb.5.1680526865194; Mon, 03
 Apr 2023 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-3-dmitry.osipenko@collabora.com> <ZCXF4q81wPcczkqx@arch-x395>
 <3618a293-4f61-b076-0a9c-c70812436431@collabora.com>
In-Reply-To: <3618a293-4f61-b076-0a9c-c70812436431@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 3 Apr 2023 14:00:53 +0100
Message-ID: <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/virtio: Support sync objects
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023 at 18:45, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/30/23 20:24, Emil Velikov wrote:
> > Hi Dmitry,
> >
> > Have you considered creating a few DRM helpers for this functionality?
> >
> > AFAICT this is the third driver which supports syncobj timelines and
> > looking at one of the implementations ... it is not great. Note that
> > this suggestion is _not_ a blocker.
>
> Would like to see a third driver starting to use the exactly same
> drm_execbuffer_syncobj struct because UABI part isn't generic, though
> it's a replica of the MSM driver for now.
>
> The virtio-gpu is only at the beginning of starting to use sync objects,
> compared to MSM driver. Will be better to defer the generalization until
> virtio-gpu will become more mature, like maybe after a year since the
> time virtio userspace will start using sync objects, IMO.
>

I wasn't talking about generic UAPI, but having drm helpers instead.
The former (as you pointed out) would need time to crystallize. While
the latter can be done even today.

> ...
> >> +static void virtio_gpu_reset_syncobjs(struct drm_syncobj **syncobjs,
> >> +                                  uint32_t nr_syncobjs)
> >> +{
> >> +    uint32_t i;
> >> +
> >> +    for (i = 0; i < nr_syncobjs; i++) {
> >> +            if (syncobjs[i])
> >> +                    drm_syncobj_replace_fence(syncobjs[i], NULL);
> >
> > Side note: the drm_syncobj_put() called immediately after also calls
> > replace/reset fence internally. Although reading from the docs, I'm not
> > sure if relying on that is a wise move.
> >
> > Just thought I'd point it out.
>
> The drm_syncobj_put() doesn't call replace/reset fence until syncobj is
> freed. We drop the old fence for active/alive in-syncobj here after
> handling the fence-wait, this makes syncobj reusable, otherwise
> userpsace would have to re-create syncobjs after each submission.
>

I see, thanks.

> >>
> >> +    ret = virtio_gpu_parse_deps(&submit);
> >> +    if (ret)
> >> +            goto cleanup;
> >> +
> >> +    ret = virtio_gpu_parse_post_deps(&submit);
> >> +    if (ret)
> >> +            goto cleanup;
> >> +
> >
> > I think we should zero num_(in|out)_syncobjs when the respective parse
> > fails. Otherwise we get one "cleanup" within the parse function itself
> > and a second during the cleanup_submit. Haven't looked at it too closely
> > but I suspect that will trigger an UAF or two.
>
> There are checks for NULL pointers in the code that will prevent the
> UAF.  I'll add zeroing of the nums for more consistency.
>

Riiiight the drm_syncobj is attached to the encapsulating struct
virtio_gpu_submit _only_ on success.
By clearing the num variables,  the NULL checks will no longer be
needed ... in case you'd want to drop that.

Either way - even as-is the code is safe.

> >>      ret = virtio_gpu_install_out_fence_fd(&submit);
> >>      if (ret)
> >>              goto cleanup;
> >> @@ -294,6 +512,7 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >>              goto cleanup;
> >>
> >>      virtio_gpu_submit(&submit);
> >> +    virtio_gpu_process_post_deps(&submit);
> >
> > Any particular reason why the virtio_gpu_reset_syncobjs is deferred to
> > virtio_gpu_cleanup_submit(). Having it just above the process_post_deps
> > (similar to msm) allows the reader to get closure about the in syncobjs.
> >
> > This is just personal preference, so don't read too much into it.
>
> The job submission path should be short as possible in general.
> Technically, virtio_gpu_process_post_deps() should be fast, but since
> I'm not 100% sure about all the corner cases, it's better to hold until
> job is sent out.
>

Ack, thanks again

-Emil
