Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841CC6666EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAKXCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjAKXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:02:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0AA2733
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:02:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g10so12084177wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5DAHiUXNSqP8lsMat4V7Y9pDYdgiNXYeg0YIR9t8tw=;
        b=ijgJVYN6mmNTbTPFO5OqRoZJG72dUQWCDuNXxKwYGwTa0H+jMvm9BpIyRHatxnCL+G
         H98LSjPJpsNaGcsjI/aze5PgnnoHRW8kyHFa6VjVASmpy7N+Pq2lh2SPkWtTXdQsZZVJ
         4IHyqrcso5C29wuZwnx/ROG5bnhHvvZpFV+r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5DAHiUXNSqP8lsMat4V7Y9pDYdgiNXYeg0YIR9t8tw=;
        b=FcVGDiCCbIYhvk9n+uSmLNAw1CC14J0L/AugoGsfgl+SO7QU4RTNEARQO4NcXkjg+R
         dOItkEcsWYwO8hrVVnMbEPqpepFc8Rwpk2f3Qp2rXXjUO+Az4f4q0h9iFyKA4WTx7Mft
         nDPYf9nI8XVX/L8HL1qskSAXBP139rG+K72h41FHk3hbaDZ8EPXKtnFBnb9mwuWJv7f9
         mliIlM5P7USFWEyNAoeLfsHuIIblABFzd5ZY9vId92deXsk2po2RR2Haa+OOgm7AxNNt
         /SW2s3uGRBhbfnQPl9U/fF5AG2qmyYi0N8txoWrRVjNKIQkXS+sGK1QiXJykqEHb14QG
         kHew==
X-Gm-Message-State: AFqh2koy2hehVax10RQez1hHOSwLEq71lJJLdr1KuXqEymJBiS1A9hQf
        9Gi8DGxliJENXWGJhdJQIZIDIQ==
X-Google-Smtp-Source: AMrXdXu42yEstUzQrpMN6ziaFxtpQwABY5sjgNZ43ZWdGx9iwmPJ1+C7GDfu3P+KAaFELhdK5tZrJg==
X-Received: by 2002:a05:600c:3d91:b0:3d9:103d:9078 with SMTP id bi17-20020a05600c3d9100b003d9103d9078mr52671943wmb.22.1673478155135;
        Wed, 11 Jan 2023 15:02:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm22004350wms.10.2023.01.11.15.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 15:02:34 -0800 (PST)
Date:   Thu, 12 Jan 2023 00:02:32 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 13/17] drm_print: fix stale macro-name in comment
Message-ID: <Y79ACEDu4ePaWMQr@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, jbaron@akamai.com, gregkh@linuxfoundation.org
References: <20221206003424.592078-1-jim.cromie@gmail.com>
 <20221206003424.592078-14-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206003424.592078-14-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:34:20PM -0700, Jim Cromie wrote:
> Cited commit uses stale macro name, fix this, and explain better.
> 
> When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
> onto BITs in drm.debug.  This still uses enum drm_debug_category, but
> it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
> This requires that the macro args: DRM_UT_* list must be kept in sync
> and in order.
> 
> Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Should I land this already?
-Daniel

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
> -	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
> +	/*
> +	 * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
> +	 * the enum-values define BIT()s in drm.debug, so are ABI.
> +	 */
>  	/**
>  	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
>  	 * drm_memory.c, ...
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
