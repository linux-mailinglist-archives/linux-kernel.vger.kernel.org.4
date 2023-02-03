Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9CC6897BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjBCL2i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Feb 2023 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjBCL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:28:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69318ABD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:28:05 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pNuEb-00079L-P7; Fri, 03 Feb 2023 12:28:01 +0100
Message-ID: <99c4db33a1966bd1979817277facb4a42ba2333f.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] drm/scheduler: Fix elapsed_ns kernel-doc error
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Intel Graphics Development List 
        <intel-gfx@lists.freedesktop.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>,
        Srinivasan Shanmugam <srinivasan.s@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri, 03 Feb 2023 12:27:55 +0100
In-Reply-To: <20230203100215.31852-3-bagasdotme@gmail.com>
References: <20230203100215.31852-1-bagasdotme@gmail.com>
         <20230203100215.31852-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 03.02.2023 um 17:02 +0700 schrieb Bagas Sanjaya:
> Stephen Rothwell reported htmldocs warnings:
> 
> include/drm/gpu_scheduler.h:232: warning: Incorrect use of kernel-doc format:          * @elapsed_ns
> include/drm/gpu_scheduler.h:238: warning: Function parameter or member 'elapsed_ns' not described in 'drm_sched_entity'
> 
> Fix the error by appending missing colon to @elapsed_ns name in its
> kernel-doc comment.
> 

Thanks, I've added this to the etnaviv tree.

Since the commit is only in -next and not a non-rebase tree yet, I
might be tempted to squash the fix into the offending commit. What
would be the right way to credit you for the fix in that case?

Regards,
Lucas

> Link: https://lore.kernel.org/linux-next/20230203135027.1a4679d3@canb.auug.org.au/
> Fixes: 248cd9b265fca6 ("drm/scheduler: track GPU active time per entity")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  include/drm/gpu_scheduler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 9a50365621ed8d..9db9e5e504eeb3 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -229,7 +229,7 @@ struct drm_sched_entity {
>  	struct rb_node			rb_tree_node;
>  
>  	/**
> -	 * @elapsed_ns
> +	 * @elapsed_ns:
>  	 *
>  	 * Records the amount of time where jobs from this entity were active
>  	 * on the GPU.

