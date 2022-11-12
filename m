Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98F626C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLVs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:48:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E6DB0;
        Sat, 12 Nov 2022 13:48:25 -0800 (PST)
Received: from pendragon.ideasonboard.com (d5152d7bc.static.telenet.be [81.82.215.188])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56D338B;
        Sat, 12 Nov 2022 22:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668289704;
        bh=3RItWUIVfXpjgdNs4eQE5Lf/E9kLBIRkgFe67VhvWMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Szuj8PkXryWVnykDn22sDLfGZm1GKUNiG9mPtgypIvY+6OP3BrUJwawKOHK0QFIc1
         f61lZXkyli+yOk2C+Y7aIsxP7MyrNjOxQILFcu6+J6qZwzi5FmUn2WVQyb88gUR5JR
         gJRHVJw+CXq/tiGWOr2Ba4Xu0eGHkt460c0bGf+Y=
Date:   Sat, 12 Nov 2022 23:48:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: aptina-pll: Remove a useless include
Message-ID: <Y3AUljN3Iz04F/gK@pendragon.ideasonboard.com>
References: <dd90ca1fb95971b63fb6216e10f1b42282455c85.1668286255.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd90ca1fb95971b63fb6216e10f1b42282455c85.1668286255.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Sat, Nov 12, 2022 at 09:51:06PM +0100, Christophe JAILLET wrote:
> <linux/lcm.h> is not needed for this driver. Remove the corresponding
> #include.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/aptina-pll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/aptina-pll.c b/drivers/media/i2c/aptina-pll.c
> index 1423c04a1c90..b1f89bbf9d47 100644
> --- a/drivers/media/i2c/aptina-pll.c
> +++ b/drivers/media/i2c/aptina-pll.c
> @@ -8,7 +8,6 @@
>  #include <linux/device.h>
>  #include <linux/gcd.h>
>  #include <linux/kernel.h>
> -#include <linux/lcm.h>
>  #include <linux/module.h>
>  
>  #include "aptina-pll.h"

-- 
Regards,

Laurent Pinchart
