Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353D5694C34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBMQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBMQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:16:33 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB391ADEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:16:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n132so10611890oih.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3+M7WtemNip/UJvGhOQX8hNfkWUyxL/twEyAekdKObY=;
        b=FS0X5VFg/YFXbL6u6zZoIt3SzuxfTpvN95kD2y5SzyJnr1o4689pb+wARuSrUhiH1O
         G3AkvOikpY9FK1242nbEWxw+tEJIntXD6sGZ0SeXAwvdtJ8VPGNIrn/IE7fBmnH/v2zD
         3nDiLWmBhCap7k5kXMyWCgoFKmWPjpzEIML0mgWCRdtHBU6e6YogxJZw5eDyQdPieVEK
         ynBx5MpB99ZmjGLgpOdR1OijMaCs7ac3zMWwPPzdPMG5FjdVnx2taim7juH0eDvTBmy2
         Yt2k7mUkkGcm+VUf+0L3ySTW8p4OLIwb1obdiIPXDTPIZa+5CJbo7Quc3d5IEacZuIgC
         Y5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+M7WtemNip/UJvGhOQX8hNfkWUyxL/twEyAekdKObY=;
        b=h7/QSnr3FiEvlXHPdCI+Bvow17zX4GT1kmftLhA9NW0VHDna4SygNHnpBHQ22m5pCi
         hSPYHU8XdaoravV8gNMXjKQipsCrvFl0zq6j14vUyN9LD6RkWuQNpRJ/IAohd80c928t
         ldS4m3HQq00s76Np61yTuFEYHWFPU+V9DSF4aDom3zzpha2lj2pm8tGzJpddyYl0mnzr
         Qwp6HqOScGx/HM+wE+VSyhh4A0jfusosLKov+LMMxhS9L/vQ5MPh1ByvA8sjSXSzVZ9H
         tsTpl4SUIpuCo2wlchSp2RgmvkUdagNtNnB8+g8gMMgjJoQDrsy27NiPm2Z3oArrIcIh
         hfnA==
X-Gm-Message-State: AO0yUKWKyNWCKUf87cL0VE2cnU9A1fBUtl+R1LiAEs1LZVj1iCaJb6Ir
        YFr3xs7Mvx2QvHnlxtobxcdz61X9u667qZMh83BZACge
X-Google-Smtp-Source: AK7set/69DU7Esqov48oCY93FnjRw6qc7JKs9WQo+x54lEtrHwEU+0tqMbfjGKFPZ7t7V1t1018RdoZ6dgu9fHInmLU=
X-Received: by 2002:aca:3dd4:0:b0:378:4edd:a89c with SMTP id
 k203-20020aca3dd4000000b003784edda89cmr2010642oia.46.1676304984022; Mon, 13
 Feb 2023 08:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210024343.26220-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230210024343.26220-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Feb 2023 11:16:12 -0500
Message-ID: <CADnq5_O_byNv=MVKQSL8hCXy-ENtLo31vq5zdmrE_dKZwif=nA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove the unused variable pre_connection_type
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

Applied.  Thanks!

On Thu, Feb 9, 2023 at 9:44 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable pre_connection_type is not effectively used, so delete it.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4031
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 63e75c392031..d224a44c4cc8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -886,7 +886,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>         struct dc_sink *prev_sink = NULL;
>         struct dpcd_caps prev_dpcd_caps;
>         enum dc_connection_type new_connection_type = dc_connection_none;
> -       enum dc_connection_type pre_connection_type = dc_connection_none;
>         const uint32_t post_oui_delay = 30; // 30ms
>
>         DC_LOGGER_INIT(link->ctx->logger);
> @@ -923,7 +922,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>
>         link_disconnect_sink(link);
>         if (new_connection_type != dc_connection_none) {
> -               pre_connection_type = link->type;
>                 link->type = new_connection_type;
>                 link->link_state_valid = false;
>
> --
> 2.20.1.7.g153144c
>
