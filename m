Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862066DD859
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDKKxo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDKKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:53:42 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA12D57
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:53:41 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54f6a796bd0so35729367b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMZXbjYPoB8bF3eM0jBoFIas3yC6vYWDoi6gxtxj/GU=;
        b=BMiASOwyGYLlnDZr/n8atawVFA2P5Z6g7c80yW+cFKuvUqin5lAkmq0RJ7AI7n8rC8
         joEjbLzLfyZdBZCBEr9w5pB3xDo7QCohqyUxt8Hr6XvT3emLNUzafWv0nOxrhAH7TvYC
         bPHsCxuwaf5+WVefkjLoepg8c7Cq37vnBQ0roURmC58Mt1aVSMhk2G2SCBg/FQCDBPFp
         mseh3FcA/UQ8Uih3SsxyFHYiVcIHHakuM6w57oEV++icWbBhRfSImhDlzJjLzIcMUs/8
         RfJsPlTNaGSrfGe01zAnXk0EKRj01I2SoQQUa3Ht1y+059F50KshIjDiCAxqGycyz01A
         Ye+w==
X-Gm-Message-State: AAQBX9fc1/iaUC2u4x9auzSuEy8NRWuzFhgjO+Dai3sMIX1ZyyLes7VM
        wt9WtgU4MzMamykpVrUGbDAgKDieoyiXXA==
X-Google-Smtp-Source: AKy350ZotSQEPtOEsmN85fH/3Z+NJulxrqhitVRGFRUvuXnU1Fzh+17SYkF1vwWM4Ih1IDFADVVKIg==
X-Received: by 2002:a81:8981:0:b0:538:6515:e6f3 with SMTP id z123-20020a818981000000b005386515e6f3mr9206467ywf.51.1681210420104;
        Tue, 11 Apr 2023 03:53:40 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t69-20020a817848000000b00545a08184besm3419066ywc.78.2023.04.11.03.53.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:53:39 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-54bfa5e698eso303872557b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:53:39 -0700 (PDT)
X-Received: by 2002:a81:e401:0:b0:54c:19a6:480 with SMTP id
 r1-20020a81e401000000b0054c19a60480mr7419834ywl.4.1681210418913; Tue, 11 Apr
 2023 03:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <50439958420f91cc97ad929437334bfb19ca4d90.1681208396.git.geert+renesas@glider.be>
 <fd7c23298f2c62db85abc9114d12059ef5e5f330.1681208396.git.geert+renesas@glider.be>
 <CAB9dFds_C9hfwW+YBMbF8sakUwVXm4etVPSAXgXQpKMeTA9+yA@mail.gmail.com>
In-Reply-To: <CAB9dFds_C9hfwW+YBMbF8sakUwVXm4etVPSAXgXQpKMeTA9+yA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 12:53:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV14YpXgHf+a8RgJSFgBWh2QiwAVmOTJRs=_=4om83CuA@mail.gmail.com>
Message-ID: <CAMuHMdV14YpXgHf+a8RgJSFgBWh2QiwAVmOTJRs=_=4om83CuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: Spelling s/randevouz/rendez-vouz/
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@rox.of.borg, Xinhui <Xinhui.Pan@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Apr 11, 2023 at 12:49 PM Marc Dionne <marc.c.dionne@gmail.com> wrote:
> On Tue, Apr 11, 2023 at 7:44 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > Fix a misspelling of "rendez-vouz".
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/include/drm/task_barrier.h
> > +++ b/include/drm/task_barrier.h
> > @@ -24,7 +24,7 @@
> >  #include <linux/atomic.h>
> >
> >  /*
> > - * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
> > + * Reusable 2 PHASE task barrier (rendez-vouz point) implementation for N tasks.
> >   * Based on the Little book of semaphores - https://greenteapress.com/wp/semaphores/
> >   */
> >
> > --
> > 2.34.1
>
> Sorry for the drive by comment, but shouldn't this be "rendez-vous"
> (with an 's' rather than a 'z')?

Yes it should. Thanks!

/me hides in a brown paper bag, under a rock...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
