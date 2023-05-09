Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F376FCBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEIQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:51:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47C6019B9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:51:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4BAFEC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:51:53 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C57043F67D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:51:08 -0700 (PDT)
Date:   Tue, 9 May 2023 17:50:47 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Joe Perches <joe@perches.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Vasile <acvasile96@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] MAINTAINERS: Drop realname for L: entries
Message-ID: <ZFp559hKH8snFt46@e110455-lin.cambridge.arm.com>
References: <20230508144135.1450524-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508144135.1450524-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 04:41:35PM +0200, Uwe Kleine-König wrote:
> The format of L: entries in the MAINTAINERS file are expected to just
> contain the list's email address. get_maintainers doesn't cope well, if
> a realname is specified:
> 
> 	$ scripts/get_maintainer.pl -f Documentation/devicetree/bindings/display/arm,komeda.yaml
> 	...
> 	 (open list:ARM KOMEDA DRM-KMS DRIVER)
> 	...
> 
> So drop the realname (and the < >).
> 
> Fixes: ab6911b73493 ("MAINTAINERS: Add maintainer for Arm komeda driver")
> Fixes: 6865788f5ad9 ("MAINTAINERS: Update entries from the Nitro Enclaves section")
> Fixes: 3affaa5a7ca3 ("drm/afbc: Add AFBC modifier usage documentation")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  > ---
> Hello,
> 
> who will apply this patch? Joe?
> 
> Best regards
> Uwe
> 
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..ae1d8e140a67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1669,7 +1669,7 @@ ARM KOMEDA DRM-KMS DRIVER
>  M:	James (Qian) Wang <james.qian.wang@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  M:	Mihail Atanassov <mihail.atanassov@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
> +L:	malidp@foss.arm.com
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
> @@ -1691,7 +1691,7 @@ F:	include/uapi/drm/panfrost_drm.h
>  ARM MALI-DP DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  M:	Brian Starkey <brian.starkey@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
> +L:	malidp@foss.arm.com
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,malidp.yaml

Trying to save some churn, I will NAK this part as I'm planning on sending
an update removing the mailing list completely and trimming down the list
of maintainers, removing the people that have moved on.

If it's too late, the appologies as I have seen this email only today.

Best regards,
Liviu


> @@ -14825,7 +14825,7 @@ F:	arch/nios2/
>  NITRO ENCLAVES (NE)
>  M:	Alexandru Ciobotaru <alcioa@amazon.com>
>  L:	linux-kernel@vger.kernel.org
> -L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
> +L:	aws-nitro-enclaves-devel@amazon.com
>  S:	Supported
>  W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
>  F:	Documentation/virt/ne_overview.rst
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> -- 
> 2.39.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
