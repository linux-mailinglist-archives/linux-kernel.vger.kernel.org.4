Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593DE6DE16A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDKQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDKQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:47:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5677C59E3;
        Tue, 11 Apr 2023 09:47:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 39-20020a9d04aa000000b006a1370e214aso2414944otm.11;
        Tue, 11 Apr 2023 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681231663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV/uuQZ41eH3AQ7KVpUu+AQP65VPVOJDNUkIUJlBcW8=;
        b=M0JuxiDMCuw5UBrcSnwb9HMdF0X77GXMcLCxFtljkSQ17pMsAE5s6+iVvE8x1k64lk
         bFXie5+nYrcwp/e2JgNUFyd35ZZWgyNZArZ+Wuq8LfFlylOY11Zl6h7r76dLM7Xt9Wdd
         D82CHTUBVKnKyhf9KQIS2hQkLUYG42ti+02ifxh8vcbCaqfvbvpSrUFNlr1NYwlMIp3W
         wRiFQu/5DfcEA0XLxhNgxHFFHISPgN2hIIokMRLq0lxk6UiIcSd5yIiiN9I/HGUhmvlQ
         pLWaUSRGgkGWcbAaUWt3w7uNaAtNuyqxHMPEuzDdplBxkGdJlaW3Bhza+bcFOz7KDp3B
         OHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV/uuQZ41eH3AQ7KVpUu+AQP65VPVOJDNUkIUJlBcW8=;
        b=jGg9vnZvxgr2suM+ZMSPQ+5xn9u/aMKmxWc+UN+jJJkQVlq8u7EaCJHAU7QZ1vBH8L
         zfTyxCDB9v6jHpFPkN3MHEGd4PojGHQFVBPEIt3bdM1W32WDxgyc2al3Juh/eG5wN7H8
         4An5seHebE4SrXKbGs5Y5RWaaeaK5jlDal7zj6dosafqftX3syrRWzvmHIS5HHUj7BE5
         6ZKJgUhB00fR7asfohfnriyD1PjbmiB+vsckwYZnKEtx6/z+PnTsse5hnQvz0RlN6DB3
         ZN9k/SjzyDe9kRt/iv7w42YS4Eb8ikMLmGMDh+a8B6Fa4SuU4Xt4JtHIuUuzlGaE1PJt
         srEA==
X-Gm-Message-State: AAQBX9e5DZPWr/IwNzxsgpl1nEP0CuDLPXsePjo0RzZRh50bjp8gY4kA
        OoZndD1H4IEsjrELfTD9yn8KZ15SiBemwICXnd8=
X-Google-Smtp-Source: AKy350Zp/HByftvsIEBW+tEKszX5mY603bGDJCqGixLoxpUthI8l72LdtmsEHqerAO8/qJT918CEfStcjHdTFsPjnUU=
X-Received: by 2002:a05:6830:1b62:b0:6a4:17b6:8767 with SMTP id
 d2-20020a0568301b6200b006a417b68767mr12354ote.7.1681231663656; Tue, 11 Apr
 2023 09:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230410210608.1873968-1-robdclark@gmail.com>
In-Reply-To: <20230410210608.1873968-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 11 Apr 2023 09:47:32 -0700
Message-ID: <CAF6AEGvs4XMggPMthiJ89SiaUj3k+nY95OhxLZ5cD-01XPco4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm: fdinfo memory stats
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 2:06=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Similar motivation to other similar recent attempt[1].  But with an
> attempt to have some shared code for this.  As well as documentation.
>
> It is probably a bit UMA-centric, I guess devices with VRAM might want
> some placement stats as well.  But this seems like a reasonable start.
>
> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
> And already nvtop support: https://github.com/Syllo/nvtop/pull/204

On a related topic, I'm wondering if it would make sense to report
some more global things (temp, freq, etc) via fdinfo?  Some of this,
tools like nvtop could get by trawling sysfs or other driver specific
ways.  But maybe it makes sense to have these sort of things reported
in a standardized way (even though they aren't really per-drm_file)

BR,
-R


> [1] https://patchwork.freedesktop.org/series/112397/
>
> Rob Clark (2):
>   drm: Add fdinfo memory stats
>   drm/msm: Add memory stats to fdinfo
>
>  Documentation/gpu/drm-usage-stats.rst | 21 +++++++
>  drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_drv.c         | 25 ++++++++-
>  drivers/gpu/drm/msm/msm_gpu.c         |  2 -
>  include/drm/drm_file.h                | 10 ++++
>  5 files changed, 134 insertions(+), 3 deletions(-)
>
> --
> 2.39.2
>
