Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EB73D1BE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjFYPg2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFYPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:36:27 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E231E4C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:36:22 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-576918f4cf7so15303197b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687707381; x=1690299381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6hADTvRtybxnAgwb/MiYU3LVBKmH7BajnYoRP9HcuU=;
        b=Syx/rBRG3+kD1JPCjAE7Jck5LSHZk7iC61ODQFaW6dpVgO6RIVA5QazWpWgI54JpSb
         Rz0MQerrcff5D9W70dutgNWJerYT1X6Mk7/reH2GZiMwhUpUkn2hmiiQPEiTOHgEGRMV
         5HGkiwzpmB5xcal0lQqvMW2QlQo1gLtBquMwOQ76oFoL/qhQ/+V6doAJcqG3jncUDRHW
         MAPum4RvYLEeiaotGeiXRem4XLagLS0UXgm9RwbNFyDk57wrHcgJbZFGIBTePJHOCmSW
         NDPQUhtZ6lDGOWDXAw5N5eYQskVGPY7HHI1K04lmVJ/w4hIMx4lVJOR8vCg4Qtfr0u8I
         jwxA==
X-Gm-Message-State: AC+VfDwQVrvwnSXxxO3uMmEfZ5Y+dsl4ODcpAs2i289+dbIByauut9oh
        UZ52P7gIZkkmkgQfe6ZMKtRMMZryJQ4WTQ==
X-Google-Smtp-Source: ACHHUZ75ZjncTumKfvnuiRjt/W19Pq7iqMOy/BkKE30OaCkRuZ0l5HhlNSoTj6rrUOgzquJTf0zpXw==
X-Received: by 2002:a0d:f7c6:0:b0:576:6b83:2466 with SMTP id h189-20020a0df7c6000000b005766b832466mr7475746ywf.25.1687707381554;
        Sun, 25 Jun 2023 08:36:21 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u15-20020a81a50f000000b00559be540b56sm836264ywg.134.2023.06.25.08.36.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:36:19 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bff27026cb0so2429439276.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:36:18 -0700 (PDT)
X-Received: by 2002:a0d:d649:0:b0:56d:c02:58a7 with SMTP id
 y70-20020a0dd649000000b0056d0c0258a7mr27473610ywd.18.1687707378531; Sun, 25
 Jun 2023 08:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com> <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
In-Reply-To: <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 17:36:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
Message-ID: <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, Jun 25, 2023 at 2:41 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> On 6/25/23 11:47, Geert Uytterhoeven wrote:
> > On Sun, Apr 16, 2023 at 1:55 PM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >> Add sync object DRM UAPI support to VirtIO-GPU driver. Sync objects
> >> support is needed by native context VirtIO-GPU Mesa drivers, it also will
> >> be used by Venus and Virgl contexts.
> >>
> >> Reviewed-by; Emil Velikov <emil.velikov@collabora.com>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> >
> >> +static int
> >> +virtio_gpu_parse_deps(struct virtio_gpu_submit *submit)
> >> +{
> >> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> >> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> >> +       size_t syncobj_stride = exbuf->syncobj_stride;
> >> +       u32 num_in_syncobjs = exbuf->num_in_syncobjs;
> >> +       struct drm_syncobj **syncobjs;
> >> +       int ret = 0, i;
> >> +
> >> +       if (!num_in_syncobjs)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * kvalloc at first tries to allocate memory using kmalloc and
> >> +        * falls back to vmalloc only on failure. It also uses GFP_NOWARN
> >
> > GFP_NOWARN does not exist.
>
> https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/gfp_types.h#L38

That line defines "__GFP_NOWARN", not "GFP_NOWARN".
C is case- and underscore-sensitive. as is "git grep -w" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
