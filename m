Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB069334B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBKTYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBKTYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:24:37 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C2193D0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:24:35 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t74so287709vkc.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676143474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxlJ1ylLIbukjk1rqvmj0yN/uchUwg9M7RlTwLyGWuY=;
        b=GkOee6yuha8KCFlJkb58KhoIf1WvDhoQGtKv5bfk3o8tsTw+l/AsWr+2V/5JogWj5S
         e+tne2hDNFv1lpCplUyRYJ8XvXJT/A86j9C6i4RrCLDhYDzUH1pdJxgLHNZVq73aui39
         5rcNE3u8qrpeAfy17RxKjgbVwdyWKa+QtwOz4hidJv8eZzgjnKhWEyvMMx14AqZH4Nq4
         TG8+24y9MmfpA6DBbd/7StK3VZjcYSfq4ZkK0A81/+Jg014d+TErR5x9m4vwOP0lQK2R
         C0H5Kz2iqI0dL1Yq2gcKuiAF8/iGmlIS/Vl6F/BWWqtKm9JR3f9wyanfKxR5l86KD4+I
         fzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676143474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxlJ1ylLIbukjk1rqvmj0yN/uchUwg9M7RlTwLyGWuY=;
        b=6eluBLfe9CWqMLBLC8vzVe/HiYyPe9g2O9kOcZ8trfMn9GZd4v2WhtyEIMPxWAuYM8
         JxGyA4rjnXe/DQsmOcjOpFm8a6sbvdxFqpfYisGNql5CgjXH5kXQ7nuQNeZQruupZepX
         +F7075Rb4aRdrg1oEhtdQIjrG2hh2dftQMR8o1Yekj4/ILCz98oMFjHThgoBAuRnZx1o
         GW28DpoH0SWJoUWWMLYNLdposgGNmPHG4GndmYn7zSofsHgl7rrIZLhN2QciRnWFzq+u
         lKrvm78RJcT0uBpHsxF2hRZfDyy6Xuefw2x0QiOJgpufy54VSHeJICSGhHv+Lt9T1XW4
         a8lQ==
X-Gm-Message-State: AO0yUKVykgwA6m8ajO5anpLb6OzD7SBz7J2AgaZCjfqihLmZTJa0J6Ko
        F5+rTo2qLWwEW3/2XX6rh3oiilPAXjm2Dcfpwo6hj15I10o=
X-Google-Smtp-Source: AK7set+VxozcaMiBwzTBA/oB2AIISrAuQ7Bedp9xn0ogNT61aLcgqppS9XrHSr2WISoF0Ecv104SL7WHbg5llfrzjs4=
X-Received: by 2002:a1f:1444:0:b0:400:db9c:7a9f with SMTP id
 65-20020a1f1444000000b00400db9c7a9fmr3680755vku.6.1676143473964; Sat, 11 Feb
 2023 11:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20230125203743.564009-1-jim.cromie@gmail.com> <20230125203743.564009-15-jim.cromie@gmail.com>
In-Reply-To: <20230125203743.564009-15-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Sat, 11 Feb 2023 12:24:07 -0700
Message-ID: <CAJfuBxw+g6w9_p2ym-hpCQNbr01crRMK_aYb4oV4j_BhoPwQjw@mail.gmail.com>
Subject: Re: [PATCH v3 14/19] drm_print: fix stale macro-name in comment
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com
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

On Wed, Jan 25, 2023 at 1:38 PM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Cited commit uses stale macro name, fix this, and explain better.




So this patch is somehow drawing an 'F' flag from patchwork,
but theres no hint of what went wrong.
(I have seen a merge conflict, probably not that).

https://patchwork.freedesktop.org/series/113361/

https://patchwork.freedesktop.org/patch/520460/?series=113361&rev=1

Without this resolved, I cant see BAT results or the more exhaustive tests.





>
> When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
> onto BITs in drm.debug.  This still uses enum drm_debug_category, but
> it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
> This requires that the macro args: DRM_UT_* list must be kept in sync
> and in order.
>
> Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> . emphasize ABI non-change despite enum val change - Jani Nikula
> . reorder to back of patchset to follow API name changes.
> ---
>  include/drm/drm_print.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 6a27e8f26770..7695ba31b3a4 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
>   *
>   */
>  enum drm_debug_category {
> -       /* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
> +       /*
> +        * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
> +        * the enum-values define BIT()s in drm.debug, so are ABI.
> +        */
>         /**
>          * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
>          * drm_memory.c, ...
> --
> 2.39.1
>
