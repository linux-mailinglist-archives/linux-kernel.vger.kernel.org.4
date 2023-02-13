Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66313694C25
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBMQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBMQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:14:39 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A030CA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:14:38 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-169ba826189so15750064fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+daSh/Z6FdPjI606HSEb8Krfq5/w7DOEju6X6glUWc=;
        b=ea7Smiuhu4d9oZABwxVM0NTMtLIFiHVnmKQaOfsLt5w2uJyoLJLiGtgMDAG0CqSZ7w
         IDUJhB6w0bzXVBybdy1JpA53L+suWpiS4Jd2nWiTyO8pE+BBI3H72nfRyN2ubU5xcGtq
         K/QYzK0RT51rA99IjrWZdCwSwUbCVJRgy3Kl6/umR7eVyzlwL3ssegn8EZ1yLHaAOusk
         S4R0Nwx6IUfBX8j6ZVoiZbmIG1J+Sr3b1iBrcRV3qK3Hx4mzzvO1zDD3yn/Llqst9Fw5
         UjnN/1atOusuH2DZoDWeQd3VCb3m3d3MP4WKsuHOJwm6EIa3o78vq1AVJbzcL5jyYZBX
         9iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+daSh/Z6FdPjI606HSEb8Krfq5/w7DOEju6X6glUWc=;
        b=cFGH0qQc4DqLcTKj0CmJ4CoCjlIgGa0EMXNrS0EKpOga1gcux7V6IDMCFPVGtjoVVe
         rHXHk5BGzuvs9EOoPUX8qvtgZVTjV/SR+N6t304F9sJWWDmx4hxC8q10CeNlCMwhVSrW
         iO6gg7t++3TaTFPGK6thzP0EUyXpR87TSUX7nBKGIuT62qrNsCrotU/kWuIMyM4YW3V9
         2zgfW/86L6Mjhtq/i7VooYHQ+7Du+lx5ib5AOWYxg3QKnDTfT0denzV1U/pTkLFlp9U1
         O2474RluRlegPtvCH+CfZfONfhkwbeJZgF9TD7CujhaoJVbDW7szmCRp49VP2lmLP5Kg
         ch+w==
X-Gm-Message-State: AO0yUKXLTp7Srp4uVVIxR/CbHgvFoorG/tfDI3eB6LRomS93FpPpuXRE
        TyeJxShHTLcH4pxC68fVUC4eLZif2Fj+Kxrzur8=
X-Google-Smtp-Source: AK7set97WCzJ4Aa7TmQ1GCX0WG33oXuc2vcHSz1xIZ92ltEtafFhAodhFKGmdvH9ZrEk40q3d6gB/FepHwjoZ9XNELQ=
X-Received: by 2002:a05:6870:13d1:b0:163:a303:fe2f with SMTP id
 17-20020a05687013d100b00163a303fe2fmr2647493oat.96.1676304876804; Mon, 13 Feb
 2023 08:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20230210010558.10621-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230210010558.10621-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Feb 2023 11:14:25 -0500
Message-ID: <CADnq5_OR9QN7yXhEF2SJ4oRtX3uLtwCT6WCWTcNj0ibj7Azptw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
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

On Thu, Feb 9, 2023 at 8:06 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:145 get_ddc_line() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:201 dc_link_construct_phy() warn: inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4026
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> index 13a766273755..23f668d90460 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> @@ -142,7 +142,7 @@ static enum channel_id get_ddc_line(struct dc_link *link)
>         struct ddc *ddc;
>         enum channel_id channel;
>
> -               channel = CHANNEL_ID_UNKNOWN;
> +       channel = CHANNEL_ID_UNKNOWN;
>
>         ddc = get_ddc_pin(link->ddc);
>
> @@ -196,8 +196,8 @@ static bool dc_link_construct_phy(struct dc_link *link,
>
>         DC_LOGGER_INIT(dc_ctx->logger);
>
> -               link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
> -               link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
> +       link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
> +       link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
>         link->link_status.dpcd_caps = &link->dpcd_caps;
>
>         link->dc = init_params->dc;
> --
> 2.20.1.7.g153144c
>
