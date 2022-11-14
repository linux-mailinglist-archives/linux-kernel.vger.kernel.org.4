Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3316284F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiKNQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiKNQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:20:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA32F6;
        Mon, 14 Nov 2022 08:20:30 -0800 (PST)
Received: from pendragon.ideasonboard.com (unknown [46.183.103.8])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F1FE891;
        Mon, 14 Nov 2022 17:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668442828;
        bh=bsJLde+lEx0AtdQ4007vP+gZJnhejTWkkwvxQxA7Wwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T891eZdwVB2V/LLdjtMfPFDIMKRWUeSP/FnU+0PlDbRhdt7ctE+2RIaCIjyYmdwBJ
         jpkDCgZemKpcx6bZkFhyxUEN1iADQoeukpPWnFmU1EMsAvyPD4O7ySiws4hmR+L9qZ
         YRhc8Mc8VsakTyW7qHBUUhC7UDZ63mvHncN4RNDU=
Date:   Mon, 14 Nov 2022 18:20:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: omap4iss: remove cacheflush import
Message-ID: <Y3Jqt2NX4j9LdCni@pendragon.ideasonboard.com>
References: <20221114161700.14378-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114161700.14378-1-ian@linux.cowan.aero>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

Thank you for the patch.

On Mon, Nov 14, 2022 at 11:17:00AM -0500, Ian Cowan wrote:
> The cacheflush import is never used, so it is safe to remove it as an
> import.
> 
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/staging/media/omap4iss/iss_video.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
> index 842509dcfedf..e732f08fad26 100644
> --- a/drivers/staging/media/omap4iss/iss_video.c
> +++ b/drivers/staging/media/omap4iss/iss_video.c
> @@ -19,8 +19,6 @@
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
