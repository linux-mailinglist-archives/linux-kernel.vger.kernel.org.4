Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29A671FFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjFBKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjFBKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:53:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39DD123;
        Fri,  2 Jun 2023 03:53:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5E7A6E0;
        Fri,  2 Jun 2023 12:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685703209;
        bh=9jlD2s2+YeYZiXb3wAMmYVy0IQj66RhORVNfswvBJYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4I14Myq5dpuM5ld866LX/RiU/3KbhLZVmQ4IGYZklC0V6Lk1wPfbkolTcZk3S+pj
         2y+lptg97WW63b0FYwMPgRP6H0xTRF9jPGlaez0Mg3kQgJIyiClMpUXSIiGuLbrEWg
         989cbTDTeJbRSwFCnDOv1aAjyD5UjSqnbq6fHcLg=
Date:   Fri, 2 Jun 2023 13:53:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/todo: Add atomic modesetting references
Message-ID: <20230602105350.GB26944@pendragon.ideasonboard.com>
References: <cover.1685696114.git.geert+renesas@glider.be>
 <7cea42cd09540657875a210cd16421125497d690.1685696114.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cea42cd09540657875a210cd16421125497d690.1685696114.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Jun 02, 2023 at 11:11:34AM +0200, Geert Uytterhoeven wrote:
> The section about converting existing KMS drivers to atomic modesetting
> mentions the existence of a conversion guide, but does not reference it.
> While the guide is old and rusty, it still contains useful information,
> so add a link to it.  Also link to the LWN.net articles that give an
> overview about the atomic mode setting design.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/gpu/todo.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 68bdafa0284f55f6..51eb67f5268c5ec1 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -49,14 +49,19 @@ converted over. Modern compositors like Wayland or Surfaceflinger on Android
>  really want an atomic modeset interface, so this is all about the bright
>  future.
>  
> -There is a conversion guide for atomic and all you need is a GPU for a
> +There is a conversion guide for atomic[1] and all you need is a GPU for a
>  non-converted driver (again virtual HW drivers for KVM are still all
> -suitable).
> +suitable).  The "Atomic mode setting design overview" series [2][3] at

s/  / /

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +LWN.net can also be helpful.
>  
>  As part of this drivers also need to convert to universal plane (which means
>  exposing primary & cursor as proper plane objects). But that's much easier to
>  do by directly using the new atomic helper driver callbacks.
>  
> +  - [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
> +  - [2] https://lwn.net/Articles/653071/
> +  - [3] https://lwn.net/Articles/653466/
> +
>  Contact: Daniel Vetter, respective driver maintainers
>  
>  Level: Advanced

-- 
Regards,

Laurent Pinchart
