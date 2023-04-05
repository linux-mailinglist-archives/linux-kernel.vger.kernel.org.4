Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E716D72D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjDEECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:02:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5E3C0E;
        Tue,  4 Apr 2023 21:02:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AFD7A905;
        Wed,  5 Apr 2023 06:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680667324;
        bh=7QQDxqe+YDf+wcgyso7uXaGVWNtOHPLCCDx8Kq5oRPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4LaNJo70yb3M8uoeuL+zQ6JGPo7Ch6tGE1Yu2oprxSDCUFd4LLsNZWnMZ5yXytcG
         WYvSQSR1rs3Z6Chl35GTseuLDBQ4nSUQz5sTbMm3FLqRaWzxybj2TV5rWQVaefRmtC
         c4BzssfIhGdaRT+3Xrq/Cza7AZaSerTuLkjhNs+8=
Date:   Wed, 5 Apr 2023 07:02:11 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm: shmobile: Make DRM_SHMOBILE visible on Renesas
 SoC platforms
Message-ID: <20230405040211.GK9915@pendragon.ideasonboard.com>
References: <cover.1680273039.git.geert+renesas@glider.be>
 <972e66cd36e9173ea6817d41565f708cb84bc2f4.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <972e66cd36e9173ea6817d41565f708cb84bc2f4.1680273039.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Mar 31, 2023 at 04:48:11PM +0200, Geert Uytterhoeven wrote:
> The LCD Controller supported by the drm-shmob driver is not only present
> on SuperH SH-Mobile SoCs, but also on Renesas ARM SH/R-Mobile SoCs.
> Make its option visible, so the user can enable support for it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/shmobile/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
> index 4ec5dc74a6b0b880..719d4e7a5cd75aad 100644
> --- a/drivers/gpu/drm/shmobile/Kconfig
> +++ b/drivers/gpu/drm/shmobile/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_SHMOBILE
>  	tristate "DRM Support for SH Mobile"
>  	depends on DRM && ARM

There shouldn't be anything ARM-dependent, could you drop "&& ARM" while
at it ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> -	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST
>  	select BACKLIGHT_CLASS_DEVICE
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER

-- 
Regards,

Laurent Pinchart
