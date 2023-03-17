Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2C6BF2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCQUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCQUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:42:38 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F95329E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:42:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t10so945357oiw.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUJVaBXdObXA4ldog+BJEDwTdtw7N3EL0ShGrYOtj+I=;
        b=d/Cc12ya7XgJy0UnQCXADw7lsc+9NlNtrM1BdzJttoDTV4DsJ/Hu30bLEwOWupPnFK
         mPpEK2LqAdLkSPWT4a7PyKoFB/6n2ly4RkjEzhSQh9fUuMAdMdmv8ZZdndsHa94dXk6A
         HOcrlxPXlLELD9V/Ytjquor/IOn4QbW0kCRz18zo9axdfd913zhqz4E07Dl+vm+riahi
         XAPJP4L9uRUCyi1XGjCgf60xQY/6JOD6X8w1dQ0Daub/Qs6Me+cr7vTCl5TzhXeHC5Cm
         3bQnRjECsMEDVQ6oJ+1YZ0trL7Yphsutondl12rye5268ojfXS8bKLk5SmwHfAwCmqzp
         hqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUJVaBXdObXA4ldog+BJEDwTdtw7N3EL0ShGrYOtj+I=;
        b=6PHa8YxbY6C5MKpl2EJ16hc7BXq3qcussezg5kYJ0vLYnhMNZwe8AdI6GXisf66Fza
         /tNPiKssGGyOmdsfrbkkzXt1kSQ69kCtYsD2jppFwZTCGVnHLVKa6OAlQ/DZOQxhGPaa
         rk7beSpSPOoHFBqxQFzR+VxOpkfiAjptHk+aPvZFB8vCb5/3CcZ4JK/lVXBszOYyKpzk
         3t8UtmqgyFP/w1df4Sv8fJTfAvS4oXwBKjMO+lNyvVt8HODfCb2BkJEQJD8r0LUYKN4d
         BDFtmN2bbgwkmRktkCeBQY3DxAdymQ1jwf60CUpXxC/VNp2KiFpFMcTL5QEmR6iW1wOd
         fGEQ==
X-Gm-Message-State: AO0yUKVxq+U0P2aFsDCBn8U0wx3gazpLOBs/PVGA4UIALOYwTddY++wk
        C9veAgGqc+nVoe8Rt219Qum6869xEkVfmCJ6Dke5ZX5c
X-Google-Smtp-Source: AK7set+ACaGdTsAK0eKk5mEFKIx3vKcncQ7us/VLfZCAiBPmqInVi2czONG/xoFan8fDz51JfcdvYzU5b6P9dXYqLCk=
X-Received: by 2002:a54:449a:0:b0:384:692c:56c9 with SMTP id
 v26-20020a54449a000000b00384692c56c9mr3627797oiv.3.1679085756498; Fri, 17 Mar
 2023 13:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-34-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-34-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:42:24 -0400
Message-ID: <CADnq5_NgE=QOyFGnomRhBg1-7iJrzyTJt+rOTgjHpKvuC8bJ=w@mail.gmail.com>
Subject: Re: [PATCH 33/37] drm/amd/display/dc/link/protocols/link_dp_capability:
 Demote non-compliant kerneldoc
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied.  Thanks!

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabili=
ty.c:2190: warning: Function parameter or member 'link' not described in 'd=
c_link_is_dp_sink_present'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capabi=
lity.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 51427f5081642..2a2443535b676 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -2177,7 +2177,7 @@ bool dp_verify_link_cap_with_retries(
>         return success;
>  }
>
> -/**
> +/*
>   * Check if there is a native DP or passive DP-HDMI dongle connected
>   */
>  bool dp_is_sink_present(struct dc_link *link)
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
