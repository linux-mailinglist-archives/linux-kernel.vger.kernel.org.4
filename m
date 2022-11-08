Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC0621949
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiKHQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:25:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848D1FFB4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:25:05 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id b124so16033087oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+8Yf/sZNwiNDUj/OMYT77J47waMsvsoaujY8tR8y14=;
        b=EFa7PkfPRlnNLAkXTEiEnYgZ6Y/YaZgVL3Mejm9llw7t8k9z2FPghpxGNhbq6VFRz2
         k7PwoEROsjYqFNWwtx5OsaxUU5VihVUmV33d3R8czegD4Rf9mz6bKtYLqY6LUL3yJ2kw
         qyM56Dyue5UAeC1R+nQWfRqk54qAo78RUOhkcKka8uYp35x5E655VZB55hwSxBXKGtsk
         x/YE+JhmfgoapqnX/pKbhmS+Sv7/WyGNIDFWvkvr1D7BohVGprfjMHJSclZc2dSIaVHN
         4AHbgUQrN6Mgqb0OFic4NvD3QVYHX5cT6tVHFXkG7c4aH5c91EF6OIz/o4cQLVa0iZcd
         wneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+8Yf/sZNwiNDUj/OMYT77J47waMsvsoaujY8tR8y14=;
        b=2wDkxe0lEDU/Q85xycQWHw8aDgwZVrOumGW31yrnuQy8kBjlwXj8m4FrMyyF6Jg5K5
         REubyPeh2N9Uq1R+EXpYciFZDUMl0zvx41w+AH+LNL3m0uJke5sz3LEoAg/SI6/wPoya
         jgryTYB00LPuGxCEVB2bcqTJHaDQ6OOUwhoiCd+Sg3dEMK1eFIcgIFy/7UH5l2aIR2ks
         JFhsr03cu4g0mdE4PRSYEos7UGpw0GgX7BOiE75VAZkIRkpncw7H4Pm5tVTK2eLNwzc4
         33h9y/CP+fpluiWu+wz7zgfxcr7brFe8RY/zZ17buH0uTvgWImAkjzICV03sozcoliVT
         byjw==
X-Gm-Message-State: ACrzQf3EVjzhysWkYafqVN8BbrQsZrM3ZqwKyxc9ta9B3DtmAClMf9kE
        hMxY0dGN9uvp/QjdbC6xfpVB4vYMQmwfHteCkr0=
X-Google-Smtp-Source: AMsMyM6FnW3smzsc2vqX42JCVFSvKrKyc0iMu552UOAzqJ/Mwzlw4oMjND0EEJAJMN56tBl6uBS3XHec1Vjmj7CzLVM=
X-Received: by 2002:aca:b655:0:b0:35a:4fb4:c3d2 with SMTP id
 g82-20020acab655000000b0035a4fb4c3d2mr16042060oif.96.1667924704519; Tue, 08
 Nov 2022 08:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20221107143715.279841-1-carlos.bilbao@amd.com>
In-Reply-To: <20221107143715.279841-1-carlos.bilbao@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 8 Nov 2022 11:24:52 -0500
Message-ID: <CADnq5_M9EvboWq9Oi58S3Rgh_U2_sNXGDA57NCh-oJWUedAN4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Amend descriptions within enum pipe_split_policy
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        jun.lei@amd.com, christian.koenig@amd.com, bilbao@vt.edu
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

On Mon, Nov 7, 2022 at 9:37 AM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> Correct descriptions of two last fields of enum pipe_split_policy, updating
> comments with proper field names.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index bfc5474c0f4c..277631a899d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -457,15 +457,16 @@ enum pipe_split_policy {
>         MPC_SPLIT_DYNAMIC = 0,
>
>         /**
> -        * @MPC_SPLIT_DYNAMIC: Avoid pipe split, which means that DC will not
> +        * @MPC_SPLIT_AVOID: Avoid pipe split, which means that DC will not
>          * try any sort of split optimization.
>          */
>         MPC_SPLIT_AVOID = 1,
>
>         /**
> -        * @MPC_SPLIT_DYNAMIC: With this option, DC will only try to optimize
> -        * the pipe utilization when using a single display; if the user
> -        * connects to a second display, DC will avoid pipe split.
> +        * @MPC_SPLIT_AVOID_MULT_DISP: With this option, DC will only try
> +        * to optimize the pipe utilization when using a single display;
> +        * if the user connects to a second display, DC will avoid pipe
> +        * split.
>          */
>         MPC_SPLIT_AVOID_MULT_DISP = 2,
>  };
> --
> 2.34.1
>
