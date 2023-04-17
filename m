Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491696E50EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjDQT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjDQT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:28:53 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D570729E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:28:33 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-187916b6543so16076747fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681759713; x=1684351713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4g+hmFG2hUra6SC/fsLnmP46WQx2KRuK2G3ZEHGCWs=;
        b=UV93IM6N/SBFjFRKZoUVrsBH/AHHXGJNLxt+tHJsZ90TTOcFg/fp2wfoWCKAvdnSc+
         lUjqCYrCMsR9yRnbBDjSENLH7jNlyBsTdJH17jTw68KrEV4nmPQNjc7uPD/iYCsanN8O
         Y32mQBkCqzy9M4bRaPwHvvnGF3z7Dd6UUFHbNNRZrSv1j+pVRtCQsU/Md2pd0BBLZtnS
         Acq5mbPspUjVLl2FWAyftyTNlWD4vBNEygapFN5yDuqFfKKl4rlGN2V6OMx8O1TMb8AY
         6+zA43YlW5+1xSRPEjL+nuQ3VothVYnr7EQ1GWb4j3bmlK0oGwrvzB3BeZGWc7h3P4pU
         lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759713; x=1684351713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4g+hmFG2hUra6SC/fsLnmP46WQx2KRuK2G3ZEHGCWs=;
        b=HVgcqvFWiZtEE63VWcmzjLI5kl6lYyreOwZHVL+p8hGL1xz33fnmCdVpOgRrDrHvfJ
         jQtZmxIl3/e12xOE1BqS5YAhh/UVjdHCAlm6Th7GJlb6StsQ+OSvAPT4IQZy6IQoRh3y
         UT1lMMNaTWh2ESE/TfSTuYBiEy4shdPRc+4GFAJiErUptNteCutKSTBavnCWU+qDryK4
         2d0AgcKAdFDDFO7Dchcf2NFNO7lduQOQsSmhhjThN7Oha7RiAqOj4H8n20BuHd9l8/Fv
         pWW3vCbGYXqJxSYNYTDTN2Yf60cb/wVDl3tJ0EfwNKE+JbGgG/snst3NWwgwIioz95N5
         DM9g==
X-Gm-Message-State: AAQBX9c7w9gtOGDFmI84WJF1FbdxBXGovJQNYqLEnhQMUHihUUm2dWcJ
        kDfEqtIAalbG9sDwDSWmhPSuCDhPmbXfevECu74=
X-Google-Smtp-Source: AKy350Ype+Viup2qX4/8PJj4TAhayZgd5LJav0NCFhC/hTj2y7gBSdREXeexNBhmWfjamHynt0zsvFQrK9hx1hnLZJY=
X-Received: by 2002:a05:6870:2e0e:b0:187:7524:9a8d with SMTP id
 oi14-20020a0568702e0e00b0018775249a8dmr7534364oab.4.1681759712906; Mon, 17
 Apr 2023 12:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230414150830.3173504-1-trix@redhat.com>
In-Reply-To: <20230414150830.3173504-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Apr 2023 15:28:21 -0400
Message-ID: <CADnq5_OHu7kJGvTVg_oDMadqQFBrhFAZBM9H76y6tiYNsWT+4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused variable oldest_index
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, HaoPing.Liu@amd.com, aric.cyr@amd.com,
        qingqing.zhuo@amd.com, hanghong.ma@amd.com, felipe.clark@amd.com,
        Dillon.Varone@amd.com, Mike.Hsieh@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Apr 14, 2023 at 11:08=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> cpp_check reports
> drivers/gpu/drm/amd/display/modules/freesync/freesync.c:1143:17: style: V=
ariable
>   'oldest_index' is assigned a value that is never used. [unreadVariable]
>    oldest_index =3D 0;
>                 ^
>
> This variable is not used so remove.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/dr=
ivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 5c41a4751db4..5798c0eafa1f 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -1137,10 +1137,6 @@ void mod_freesync_handle_preflip(struct mod_freesy=
nc *mod_freesync,
>
>         if (in_out_vrr->supported &&
>                         in_out_vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABL=
E) {
> -               unsigned int oldest_index =3D plane->time.index + 1;
> -
> -               if (oldest_index >=3D DC_PLANE_UPDATE_TIMES_MAX)
> -                       oldest_index =3D 0;
>
>                 last_render_time_in_us =3D curr_time_stamp_in_us -
>                                 plane->time.prev_update_time_in_us;
> --
> 2.27.0
>
