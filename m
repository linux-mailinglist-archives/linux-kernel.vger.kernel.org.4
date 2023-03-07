Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E26AE7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCGRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCGRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:11:11 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC45A72B3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:05:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bj30so10132331oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678208727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7CGKDVh+i2FWK5xtLi5YTbqdfVgBlYik8IPEIqJIDI8=;
        b=nm4RCIJ/gCqHmbYXZN2vshBQoyjG98GJ3jGZwatgLhL34hz8VOYvD6HUMpv3+Zipd5
         sEl04mmqQ1kBqv4em/4KuSEvX6WMNYF1aDriyLyfXcyLI0b2dCd5agcl8spEisWmlzEh
         vxnF5B/qqt+TYEFUD30D+ymWCnr95wmJu+wOIvglIVD7JUOU9plQlk7YMlYWzFQYfz85
         mHIfSrq9Ep9uJFCy/zCQmhTIFaLXKkuhfum1hy3Dpv6oqk8vzf46zznKMqKZjEL0bCum
         75rNxEcG3YDK6VvHC4thmmotMniIgoAsfSHsARo3Pzzx7I+qHeEn4C8DT52GU7gaz9Nq
         xL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678208727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CGKDVh+i2FWK5xtLi5YTbqdfVgBlYik8IPEIqJIDI8=;
        b=gk0YAeSMnILd1WPy8ByoiWEGeAKoGcTFA0yVrSFv8mgMlekwp353FJRdEjoZmdenYl
         dJGKOyOuViaVj1RGsA8pyCET3YdQVXLvgMufWpJW9uSrxrHegWCEQlzIwsB4g7XFfq+c
         YntrrMSkqe0ImsfV3d5uGvFgCQNOiKHZRP+mR6zk6DB0FBOqLzGs/ZZLWiuRhhsHivGw
         5Zp7i5H42pc5GEK/urxInVgTJQCzo1GpIv8Z0GOq9q4j0zSLGlbk5cRr1nRCHRugCYkF
         g9se/+Mf2+pBUpkBFR+Wjnvt/CUmsD2PiKV+ga+0Fiza8BR9Yo94tqI0OWK4gi2gIC2z
         rHtQ==
X-Gm-Message-State: AO0yUKVBid73ii2c7AhWmbq3uwIESChYVOJbQ6NFbYaFIIrKxavOLxSZ
        n1w1tx9Nh31VGXH0EFNgHcONT9JS4dh4eQzuPm2yQ0x/
X-Google-Smtp-Source: AK7set9P+LkBZjYXpbWONua/huz3ObjaqzCrqRNBF/SlUCUA6CRljg2SrXgBRc4MloOheTNXSvYjZU09Y3lmPspTfxY=
X-Received: by 2002:a05:6808:994:b0:37f:a0a1:bda1 with SMTP id
 a20-20020a056808099400b0037fa0a1bda1mr4943210oic.3.1678208727262; Tue, 07 Mar
 2023 09:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20230305212411.25727-1-husain@alshehhi.io>
In-Reply-To: <20230305212411.25727-1-husain@alshehhi.io>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Mar 2023 12:05:15 -0500
Message-ID: <CADnq5_NCCNYLnSkQaZPXC+9hkNsMdzLh9bSw9Ybg2FmWaYFDFQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpu: fix typo in comment
To:     Husain Alshehhi <husain@alshehhi.io>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Sun, Mar 5, 2023 at 5:22 PM Husain Alshehhi <husain@alshehhi.io> wrote:
>
> Replace "isntance" with "instance".
>
> Signed-off-by: Husain Alshehhi <husain@alshehhi.io>
> ---
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 007d6bdc3e39..734b34902fa7 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -1971,7 +1971,7 @@ struct dmub_cmd_psr_copy_settings_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2029,7 +2029,7 @@ struct dmub_cmd_psr_set_level_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2056,7 +2056,7 @@ struct dmub_rb_cmd_psr_enable_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2100,7 +2100,7 @@ struct dmub_cmd_psr_set_version_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2131,7 +2131,7 @@ struct dmub_cmd_psr_force_static_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2206,7 +2206,7 @@ struct dmub_cmd_update_dirty_rect_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2344,7 +2344,7 @@ struct dmub_cmd_update_cursor_payload0 {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2391,7 +2391,7 @@ struct dmub_cmd_psr_set_vtotal_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -2429,7 +2429,7 @@ struct dmub_cmd_psr_set_power_opt_data {
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> --
> 2.39.2
>
>
