Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3656BF2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCQUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCQUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:44:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CB6186
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:44:52 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y184so4713784oiy.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfjuORG0Jk52NuAgQu3T61JWbt/fIRebBWYt5aRa1ZI=;
        b=E+D69mswJ38gpG+o+TpBZWu3nQbx3WGZ+PxFFDc6B4aBvWUijpyEZ6+lW/Md4K7bgG
         YeN4xDZ6uMZ20L2cCic7ERg5ddZVY7DQbhLBjnlsmhAKI8c5qvTsPu0X2LC5tQH1FxJK
         awdevvB/k4KdAK326XTtYvv7jC62PWCwmOf59onO3m17amCM+G6ZkbWWyxk1yNJJc2N7
         1HS4n1Rf7NDsLfEK58+OdjbWgI3lXn5Amwrc4ePADLlUYIvgy7MYcxGzFeJqkcLpH2X4
         yRyvwUb9CariBy5Oj9GjxL6DRGV8dv38t3081Mv8pmSPSWp2XjR6jhL7zAwPod6A717P
         afKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfjuORG0Jk52NuAgQu3T61JWbt/fIRebBWYt5aRa1ZI=;
        b=sYgItb28A5Ccxgl9o6Mhl/5hvFyCZ0UWipocIVPJ2LYX/4VAEMFdMUzO/o27k/UlhB
         +/Qa8WYco4rPXm0PM5tH7bV8xpiIIVlhOtjLFg4/6IXReSWk7E64QkHyh0AtoQHKdxEe
         IFXG0W+ctAVtcbDDdJBU7GLmh1r26XRxlCvF6/SUmBckniVvaMAfIeA7uINw1JGHxD21
         Jn7wOZd5UDAmDCV1esoC/Te04UV09dLqASKksgUlnHrH7TMIn3ZAg+GoOD0WH5A97bE2
         Cd34NHg94QrLOr34CEdisWvAbTihokE4H++PRPo65Es9VB3JpVGIBI9ekWI5U6xK1uuP
         NwBg==
X-Gm-Message-State: AO0yUKUO9GEu/s4KDDHqGqinhfC6UfLNL0SyWmDbK36TOWP8f9H3kLDs
        Q+ezJLXKz+S3o9sfZfPDd7XTH3uIl/uPRMzQ/u0=
X-Google-Smtp-Source: AK7set9EwHcrr2T4dPN90TCsm3UZrcSmjMFi7iytpPcTOGxCLy25G/jRQq3nXnlzQf+1bY4uyO02u9vF+S40Y/rMA0E=
X-Received: by 2002:a54:449a:0:b0:384:692c:56c9 with SMTP id
 v26-20020a54449a000000b00384692c56c9mr3629617oiv.3.1679085891801; Fri, 17 Mar
 2023 13:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-37-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-37-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:44:40 -0400
Message-ID: <CADnq5_MhMNbcChfaQ=qbk7=F0xQ+nHvFf6W9Q+rEqXm0Zac14w@mail.gmail.com>
Subject: Re: [PATCH 36/37] drm/amd/display/dc/link/link_detection: Demote a
 couple of kerneldoc abuses
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Wenjing Liu <wenjing.liu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
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

On Fri, Mar 17, 2023 at 4:24=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:877: warn=
ing: Function parameter or member 'link' not described in 'detect_link_and_=
local_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:877: warn=
ing: Function parameter or member 'reason' not described in 'detect_link_an=
d_local_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:1232: war=
ning: Function parameter or member 'link' not described in 'dc_link_detect_=
connection_type'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index 9a4cfa777622e..67addedd89563 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -832,7 +832,7 @@ static void verify_link_capability(struct dc_link *li=
nk, struct dc_sink *sink,
>                 verify_link_capability_non_destructive(link);
>  }
>
> -/**
> +/*
>   * detect_link_and_local_sink() - Detect if a sink is attached to a give=
n link
>   *
>   * link->local_sink is created or destroyed as needed.
> @@ -1185,7 +1185,7 @@ static bool detect_link_and_local_sink(struct dc_li=
nk *link,
>         return true;
>  }
>
> -/**
> +/*
>   * link_detect_connection_type() - Determine if there is a sink connecte=
d
>   *
>   * @type: Returned connection type
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
