Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC56281F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiKNOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiKNOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4312CC8B;
        Mon, 14 Nov 2022 06:07:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (85-76-14-120-nat.elisa-mobile.fi [85.76.14.120])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E850891;
        Mon, 14 Nov 2022 15:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668434846;
        bh=/o81K5ZaEIsKIK1E5LeS0R4ufj8imWkNuqxcjDuntt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDBOYzpBZbutDsK3ZdTxIsdQBHQxoQErEEU0x1FeVq8F5uGHiMaQElRqJEsuMEOm7
         d5ZzzAUoS6QOjt6CdAgH+RHPZGrZ2Y6V6k7dQrZ5nF2oZEq/zu5GMJIpNDVdg6euFZ
         DMmZwTNgE2rtQg4vwoCIOKKEK1HrDzQ9dSWZ/R24=
Date:   Mon, 14 Nov 2022 16:06:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: omap4iss: correct cacheflush import
Message-ID: <Y3JLenvvuRhb0xfZ@pendragon.ideasonboard.com>
References: <20221113003347.93483-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221113003347.93483-1-ian@linux.cowan.aero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

Thank you for the patch.

On Sat, Nov 12, 2022 at 07:33:47PM -0500, Ian Cowan wrote:
> Correct the import for cacheflush from the asm directory to the linux
> directory.

Unless I'm mistaken, it looks like the header is actually not needed at
all.

> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/staging/media/omap4iss/iss_video.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
> index 842509dcfedf..9f08dd976a24 100644
> --- a/drivers/staging/media/omap4iss/iss_video.c
> +++ b/drivers/staging/media/omap4iss/iss_video.c
> @@ -7,6 +7,7 @@
>   * Author: Sergio Aguirre <sergio.a.aguirre@gmail.com>
>   */
>  
> +#include <linux/cacheflush.h>
>  #include <linux/clk.h>
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
> @@ -19,8 +20,6 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-mc.h>
>  
> -#include <asm/cacheflush.h>
> -
>  #include "iss_video.h"
>  #include "iss.h"
>  

-- 
Regards,

Laurent Pinchart
