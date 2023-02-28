Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE416A5C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1Pnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1Pnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:43:49 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42823113D9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:43:48 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id w25-20020a4ae9f9000000b0052513fb2e09so1613344ooc.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LonH6h0XflHd2ZjJoaCMQxM+eselh1rFlXJtr2TdEH0=;
        b=WyJg6CTQHizjZtwa26KfNyODiFG3bpBQVCtLC6kZa2jQ93g3cNA0st7X5zv0Q0WEyz
         DssEP8HT6EafkjajKflc8sIiiF0dUns20WwxZRwoLYoYxJDiuQntnrgON6O0bmAB78gU
         eusnG6BYYBWBbE9LMTXMKE1W0CDyQP43ruj+RGcEzoFV8LOE3zN/x9BMvVl2JZ1quO1J
         YTTCzT58vDVD0zhGKokq3aPnJ1b01i5rGPvzR8ipxkTmzyihfnBoBJxmHS8DBHDCFkJT
         en235u700aMHlAZhuPqoO8i2/Fohbbk33SHXIvLNO4mmMkLm7loqL7m1EG3wa+b8ziGD
         udpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LonH6h0XflHd2ZjJoaCMQxM+eselh1rFlXJtr2TdEH0=;
        b=flTsmOCfmeDSBvZOCshBLtp12bRM3QauyHoJIDwhy3USNHoYxmmCQGmWOFuLtFdxps
         x/QxMgB0hdwjYiwBQF2RpDJilWEVvRZKZljh5vtcZEZrFa0bCOv17nffYyJKgcVq+/kB
         A3LN/Dwvm5HK4IpDmAq8os4JdLuwvPPcGeAtyEUY5yBkWjzeA8NahSyyKn+gqVvG3dzR
         VW/PbBrKEFo0H4QxdnEOJ7QIg2ass11f9fHHSYgx2DWM/kcUiowu36AfZszjtD4rgvQF
         nvuYaV0JF6cs6bTFRh+0FhE5+1kwnIS+Kih5AbfxvE36NeaYofPRiTMf8Bosv99XgjGD
         CeYQ==
X-Gm-Message-State: AO0yUKVDW8V9hVA7954XqkpuuEQOlIrSFrBj4xKgLn5bTRCryni7xjNy
        1yt3lkGP81/oe/IuIWWtRRUiFLgZUYYYdPh8c30=
X-Google-Smtp-Source: AK7set8STQ1oztAalDc2bpQ9rNAMwQTUZCm2yzbWRYUjL7JbeIR+duZmjExm+N3PqFqj9f5vVh1ZzbL3mR9s5ouJdgQ=
X-Received: by 2002:a4a:840f:0:b0:525:499e:ce2f with SMTP id
 l15-20020a4a840f000000b00525499ece2fmr795883oog.1.1677599027483; Tue, 28 Feb
 2023 07:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20230227173800.2809727-1-robdclark@gmail.com> <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
 <CAF6AEGsT8_o+v0vzGu1nyh6Z82pj8FnGUdMFc0Lq+4OWoSjRBQ@mail.gmail.com> <fb70356e-4e13-1858-9e1a-e886f5918030@suse.de>
In-Reply-To: <fb70356e-4e13-1858-9e1a-e886f5918030@suse.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Feb 2023 07:43:36 -0800
Message-ID: <CAF6AEGt2SYvppE3-QbmZNbgVgTNndT+mRUe6N-z0AS+SB6KKoQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
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

On Tue, Feb 28, 2023 at 4:34 AM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 27.02.23 um 19:15 schrieb Rob Clark:
> > On Mon, Feb 27, 2023 at 9:57 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 2/27/23 20:38, Rob Clark wrote:
> >> ...
> >>> +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> >>> +             /* get display info */
> >>> +             virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> >>> +                             num_scanouts, &num_scanouts);
> >>> +             vgdev->num_scanouts =3D min_t(uint32_t, num_scanouts,
> >>> +                                         VIRTIO_GPU_MAX_SCANOUTS);
> >>> +             if (!vgdev->num_scanouts) {
> >>> +                     /*
> >>> +                      * Having an EDID but no scanouts is non-sensic=
al,
> >>> +                      * but it is permitted to have no scanouts and =
no
> >>> +                      * EDID (in which case DRIVER_MODESET and
> >>> +                      * DRIVER_ATOMIC are not advertised)
> >>> +                      */
> >>> +                     if (vgdev->has_edid) {
> >>> +                             DRM_ERROR("num_scanouts is zero\n");
> >>> +                             ret =3D -EINVAL;
> >>> +                             goto err_scanouts;
> >>> +                     }
> >>> +                     dev->driver_features &=3D ~(DRIVER_MODESET | DR=
IVER_ATOMIC);
> >>
> >> If it's now configurable by host, why do we need the
> >> CONFIG_DRM_VIRTIO_GPU_KMS?
> >
> > Because a kernel config option makes it more obvious that
> > modeset/atomic ioctls are blocked.  Which makes it more obvious about
> > where any potential security issues apply and where fixes need to get
> > backported to.  The config option is the only thing _I_ want,
> > everything else is just a bonus to help other people's use-cases.
>
> I find this very vague. What's the security thread?

The modeset ioctls are a big potential attack surface area.  Which in
the case of CrOS VM guests serves no legitimate purpose.  (kms is
unused in the guest, instead guest window surfaces are proxied to host
for composition alongside host window surfaces.)

There have been in the past potential security bugs (use-after-free,
etc) found in the kms ioctls.  We should assume that there will be
more in the future.  So it seems like simple common sense to want to
block unused ioctls.

> And if the config option is useful, shouldn't it be DRM-wide? The
> modesetting ioctl calls are shared among all drivers.

Maybe, if there is a use?  The situation of compositing guest windows
in the host seems a bit unique to virtgpu, which is why I went with a
config option specific to virtgpu.

BR,
-R

> Best regards
> Thomas
>
> >
> > BR,
> > -R
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
