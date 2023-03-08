Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BB6B0D23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCHPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCHPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:42:05 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9980DC3B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:40:59 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso9207646otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1eaevzD/VPDBLno7am529FO5BQItrE1PVYk+UmlJ30=;
        b=jo7rya6xSxN51x9Agv7lCoYt3NELUGNXEedCdddprWZMyEetydQ+VAzjhfsveqPncT
         U4OyFqbRxprUag/By3VxXdmsuY2RVJU/msDixT15maV8wgkSpTAv3wXuVsKS7DB9SKeL
         wqB8/HNzPeUWM15t6WQz3t8RRJrSsAd3inuqxvUgnUCLvP03jMmjh7XNmNuJVKRGd+hI
         jLqruPfGAiNzz5wFrUsJgqPPj9Kcg5+ToW18Zr/vrJligw92oiYGcWq8H6/wNNA6THGq
         32iu2QBeI7T+IKQz4/WtUGE4Pamkdfwm7P0UNgeizuDfP1cVfy1y6hfRvT8DHsseOfYa
         jHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1eaevzD/VPDBLno7am529FO5BQItrE1PVYk+UmlJ30=;
        b=6sTA8L+H26x+phLP2utXdg4ipPAnsfFnoaN5D1Q4AvMC6Ul7RVWyg0GhPYulXji1pf
         VitlSV1Kx9Kq4t/WApZnYOVvz0z7+URBYYGXCi3lwJTydqKGf1xKTAC6Bdytpnc8hvEl
         3naT/UtIIGITX4vHqj+/LsFwb7ETPmTJrp3HRow5ifex0vhlc3NTxeW66w+Aa82C9VYd
         mv9qKBRIKN6I/tfTNo3Gv/7NCIwTKnEIOaeE+LZKgVwC69zZyXU3ihBoIUdRqAvuK7+K
         4fs/aMaBYgbFrx46CzztTsEVu8tUk9PT2meb7YHU9OELuCzvvI/D44P7HrPKYLTgmKKk
         kyBA==
X-Gm-Message-State: AO0yUKVOGn02tNgYe6HoFWk7fTD02JVkTP0zwNzfqWan+XpjSXFK7p1P
        5KcuSHqnocaW3vh+ez+E45+scVEtz7QkqvKRSqo=
X-Google-Smtp-Source: AK7set/3YXnoE0ouW6QKye+UdVIfFc6/NcrKfnpl+KoXnboudNx6jNlvIiSmQTAgHzhdNCUl12UfKeVmimwBzUUsk9Y=
X-Received: by 2002:a9d:724c:0:b0:68b:ccee:5ead with SMTP id
 a12-20020a9d724c000000b0068bccee5eadmr6361844otk.3.1678290058340; Wed, 08 Mar
 2023 07:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20230308141057.2010361-1-trix@redhat.com>
In-Reply-To: <20230308141057.2010361-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 10:40:46 -0500
Message-ID: <CADnq5_PtFqWKvVePq+jydpC06QG35q420-9iQErv6OcgYcPzJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused variable available
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, wenjing.liu@amd.com, qingqing.zhuo@amd.com,
        Jun.Lei@amd.com, mghaddar@amd.com, candice.li@amd.com,
        aric.cyr@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 8, 2023 at 9:11 AM Tom Rix <trix@redhat.com> wrote:
>
> With gcc and W=3D1, there is this error
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c=
:297:13: error:
>   variable =E2=80=98available=E2=80=99 set but not used [-Werror=3Dunused=
-but-set-variable]
>   297 |         int available =3D 0;
>       |             ^~~~~~~~~
>
> Since available is unused, remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c   | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_b=
w.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> index f14217cc16fd..2f0311c42f90 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> @@ -294,7 +294,6 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(stru=
ct dc_link *link)
>  void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uin=
t8_t result)
>  {
>         int bw_needed =3D 0;
> -       int available =3D 0;
>         int estimated =3D 0;
>         int host_router_total_estimated_bw =3D 0;
>
> @@ -373,20 +372,13 @@ void dpia_handle_bw_alloc_response(struct dc_link *=
link, uint8_t bw, uint8_t res
>
>                 // 1. If due to unplug of other sink
>                 if (estimated =3D=3D host_router_total_estimated_bw) {
> -
>                         // First update the estimated & max_bw fields
>                         if (link->dpia_bw_alloc_config.estimated_bw < est=
imated) {
> -                               available =3D estimated - link->dpia_bw_a=
lloc_config.estimated_bw;
>                                 link->dpia_bw_alloc_config.estimated_bw =
=3D estimated;
>                         }
>                 }
>                 // 2. If due to realloc bw btw 2 dpia due to plug OR real=
loc unused Bw
>                 else {
> -
> -                       // We took from another unplugged/problematic sin=
k to give to us
> -                       if (link->dpia_bw_alloc_config.estimated_bw < est=
imated)
> -                               available =3D estimated - link->dpia_bw_a=
lloc_config.estimated_bw;
> -
>                         // We lost estimated bw usually due to plug event=
 of other dpia
>                         link->dpia_bw_alloc_config.estimated_bw =3D estim=
ated;
>                 }
> --
> 2.27.0
>
