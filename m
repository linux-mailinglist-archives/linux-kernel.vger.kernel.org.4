Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173AA6A8D12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCBXdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCBXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:33:20 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3700C12BC2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:33:19 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-172334d5c8aso1182666fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677799998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWQrOjmlTF/eT/5hix+xLxcrGdhqmVIvOhIR8FuYfOE=;
        b=lN4O5IHRLWyhbSMEcD8F0G8wFR8QiH6oGXMFIJfZTiCWkg7XROh8F8SsG/qP0wNKCe
         d4SHivhy9etlsWR1U8y5/kMeCRe8w5lHrcTALEy7lbd6LtUv2lYr32C/yjBI4Gf+xlRb
         enRjQMho94lsdGs00WCpvhX4YXlG/IKd+cnt/3dPJJzUOPV6ot6s1+Tu7m52rbzbSFOM
         IHkdVS8emNIuPxontdSocYsaudiDw1/JD6xcBFcyOir5AKQ3D0A2Hoo+ANqSynw/aWPv
         hgy4aQjOmZcJf6UXNp1wRnvRFN0iy1L1vtJ45ZNmf+AUo6Z2CGemofvuhFDkPKIHs2k+
         V6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWQrOjmlTF/eT/5hix+xLxcrGdhqmVIvOhIR8FuYfOE=;
        b=72YTRhDvQyBm/PLE0lRBX+yJZkYmikFcAIQT7MELvGxU9Y7LdELxkLhxRBSic+Hrzr
         /YET/97wE3ETwo97xw7lksEwQFsHiCcdGUktBR6gII25qMajbqK5V8VhtZbSa7oHflnF
         sUTCRh2nr98N0uHT9U1v0uGsN5Z7G3wIVqObKDcEr5rhdapBmbp1Eby/fOnXnYub5fXM
         wQdOLf70+9RjqNf1FhENG2sbkCveEQS7xTFTK1sfR0zZT7csqfyONirS6T7nK6BjAR/H
         qtyEZ570pQs7vnu9Pxg2RIxuuVWGTH1WWT8lFPRK8/I41GtrEN/+PtAPBhrtc0m+ypv6
         yX4w==
X-Gm-Message-State: AO0yUKUPZTiRluFPqlsRA5yrfGc8c7us6I+8meBhHW+xWD2nMBhTgbQH
        7sDP0m+b0WnTwJNjTxUuf+3KfDZiKGy7tAcI0vE=
X-Google-Smtp-Source: AK7set8T8UHOZvlKDyCHvWaZjZeVjVEqLrtjJRHYusFiiklAQLDMFXAgieBae3bnu4+f7KLJ3bIMqyww1KsFqKWgDSk=
X-Received: by 2002:a05:6871:6ba1:b0:176:6af1:1122 with SMTP id
 zh33-20020a0568716ba100b001766af11122mr31222oab.3.1677799998081; Thu, 02 Mar
 2023 15:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20230301185432.3010939-1-robdclark@gmail.com> <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
 <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
In-Reply-To: <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 2 Mar 2023 15:33:07 -0800
Message-ID: <CAF6AEGtzdty5m9ccRZqYNN=+OCa0KogNQxR41AD-LWC5fjbujw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/virtio: Add option to disable KMS support
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 11:25 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Mar 02, 2023 at 12:39:33AM +0300, Dmitry Osipenko wrote:
> > On 3/1/23 21:54, Rob Clark wrote:
> > >  /* virtgpu_display.c */
> > > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> > >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> > >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > > +#else
> > > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > > +{
> > > +   return 0;
> > > +}
> > > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > > +{
> > > +}
> > > +#endif
> >
> > In v4 Gerd wanted to keep building the virtgpu_display.o and instead add
> > the KSM config check to virtio_gpu_modeset_init/fini().
>
> The main point is that the code workflow should be the same in both
> cases.  The patch does that for virtio_gpu_modeset_init() but doesn't
> for virtio_gpu_modeset_fini().
>
> Return early in the functions (and drop the #ifdef here) is how I would
> implement this, but I wouldn't insist on that, there are other ways to
> solve this too ;)

Ahh, true, I guess omitting that one file doesn't save anything and
early return makes for a bit simpler/smaller patch

BR,
-R
