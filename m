Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E11362E303
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiKQR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiKQR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:29:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3374CC7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:29:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t17so1566938pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bm7d0wA3PKw5o/R8yEgxkQkgqbavxCURCDthVZnwpGY=;
        b=PibsK1VOlK4fTo5ahOxV+p9puHHY3ZW35l84zzWsnv6i7MGNW0zqvYb3uSlk0x1M9X
         cVg0sS5uCXc5sak61YfVdGaNW/3RQOWeJdDjkRULb+ZdODZLI9tvuB/ahgG6SWGzjilg
         Zp7XZLUrYaaqgv+DjkED+xrFZC/joxXh4O0T2fshc7SJibB8ENREVY20njtaVp3CVAAb
         cT3o8VPbECbli/GBVZMFHbRQR7Dc+yfJEmSB6oK6EgmM2GTECHEbkXGnqKnzR3QQY+o7
         mFKgZKNX58kdEEkYVNXPk0Z0JRnj/xHvSDqt/59Z9dEuKFyT/d+TTlMTjjyTg6QwZ8xG
         uTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm7d0wA3PKw5o/R8yEgxkQkgqbavxCURCDthVZnwpGY=;
        b=qOSuE6Yn5KzOP6u8pd1RVeiA4gYvtfP4Au27kUcoxTbC2w8iTNUs8jf7ZElZmGHncC
         ilt04Yzy0LVDzo1ISs0kgLQz3P07KY2umHC7j13fNUuSzm+55iOffpqTtt9KJ49LYS4P
         8oPKUDd0UmHWyEd/AwbwfVTVbiXbHe9eivA8jX9heQcUTPLrka3OwmVAWnEIA7+rD5rn
         JBGOX2uicbHt129UE3JuZo2EOx41k5BVoILbacC2lzmoHoXny5l7lLYY9w/vAAhsaQbR
         6hzlNBQXWsJ0xqD0I+g3QXMc9GQU90XN9Crc/qnDZJfY4H9wKBaTlIe1U9lSRs4D9mLA
         Xw/w==
X-Gm-Message-State: ANoB5plHYAOZEkRcsLIHQ4qrRu+H9fko+eEwO/dpBQYzQmiIUHDGHR50
        Yl1Xnh6/eSUX93ZFmWRfPs3q3w==
X-Google-Smtp-Source: AA0mqf4NNH913OVAb0kIWfodXGDglX1hqlY7MuJyPzQmgZ/pm3XpzJlSCHmS+D1JUqRA8usrgi9yoQ==
X-Received: by 2002:a17:903:2584:b0:185:3d0b:ac93 with SMTP id jb4-20020a170903258400b001853d0bac93mr3807384plb.5.1668706139508;
        Thu, 17 Nov 2022 09:28:59 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:39c9:4fa5:1594:6af9])
        by smtp.gmail.com with ESMTPSA id q20-20020a631f54000000b00464858cf6b0sm1245753pgm.54.2022.11.17.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:28:59 -0800 (PST)
Date:   Thu, 17 Nov 2022 09:28:49 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     mripard@kernel.org, emma@anholt.net, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] drm/vc4: hdmi: Fix pointer dereference before
 check
Message-ID: <20221117172849.hk7bgahjbvycml5v@google.com>
References: <20221110134752.238820-1-jose.exposito89@gmail.com>
 <20221110134752.238820-3-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110134752.238820-3-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:47:52PM +0100, José Expósito wrote:
> Commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug") introduced
> the vc4_hdmi_reset_link() function. This function dereferences the
> "connector" pointer before checking whether it is NULL or not.
> 
> Rework variable assignment to avoid this issue.
> 
> Fixes: 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a49f88e5d2b9..6b223a5fcf6f 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -318,8 +318,8 @@ static int reset_pipe(struct drm_crtc *crtc,
>  static int vc4_hdmi_reset_link(struct drm_connector *connector,
>  			       struct drm_modeset_acquire_ctx *ctx)
>  {
> -	struct drm_device *drm = connector->dev;
> -	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> +	struct drm_device *drm;
> +	struct vc4_hdmi *vc4_hdmi;

Hi, I think this change, or another in this area recently, is causing
the following warning. PTAL

drivers/gpu/drm/vc4/vc4_hdmi.c:351:14: warning: variable 'vc4_hdmi' is uninitialized when used here [-Wuninitialized]
        mutex_lock(&vc4_hdmi->mutex);
                    ^~~~~~~~
drivers/gpu/drm/vc4/vc4_hdmi.c:322:27: note: initialize the variable 'vc4_hdmi' to silence this warning
        struct vc4_hdmi *vc4_hdmi;
                                 ^
                                  = NULL

>  	struct drm_connector_state *conn_state;
>  	struct drm_crtc_state *crtc_state;
>  	struct drm_crtc *crtc;
> @@ -330,6 +330,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
>  	if (!connector)
>  		return 0;
>  
> +	drm = connector->dev;
>  	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
>  	if (ret)
>  		return ret;
> @@ -347,6 +348,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
>  	if (!crtc_state->active)
>  		return 0;
>  
> +	vc4_hdmi = connector_to_vc4_hdmi(connector);
>  	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
>  		return 0;
>  
> -- 
> 2.25.1
> 
> 
