Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CAC62DC67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiKQNOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiKQNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:14:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB8CE0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC95761E0A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314FC433C1;
        Thu, 17 Nov 2022 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668690832;
        bh=8/wv6QDY2hSZTUr8xypWmCWEqdTGGHFAJ/VXIdpEZSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1VKBD4uF4pb0NzSYTn7Q16gq7Hm7S+f5YcWkipELr0PetzS/U0eGOntQ1FX9fnC2
         b4mHTcqdMlHLPiDMaauEYQ5EnBlORdt4R4QHnJ7JiReoYqJrutOWKktUKZo7UVmS6g
         lxSbuiWx0L8/4uPZ7h1JBfMDGfgxQEuFXV+Hh1ns=
Date:   Thu, 17 Nov 2022 14:13:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 1/2] staging: vc04_services: mmal-vchiq: Do not assign
 bool to u32
Message-ID: <Y3Yziqaj9majJlNl@kroah.com>
References: <20221117125953.88441-1-umang.jain@ideasonboard.com>
 <20221117125953.88441-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117125953.88441-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:29:52PM +0530, Umang Jain wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> struct vchiq_mmal_component.enabled is a u32 type. Do not assign
> it a bool.
> 
> Fixes: 640e77466e69 ("staging: mmal-vchiq: Avoid use of bool in structures")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index cb921c94996a..17f8ceda87ca 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -1773,7 +1773,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
>  
>  	ret = enable_component(instance, component);
>  	if (ret == 0)
> -		component->enabled = true;
> +		component->enabled = 1;

Why not make enabled a bool instead?

thanks,

greg k-h
