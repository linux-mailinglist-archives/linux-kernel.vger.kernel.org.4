Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E704C680DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjA3Mcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjA3Mcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:32:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B5737578
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:32:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F29711758
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:33:09 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B67AF3F71E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:32:27 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:32:22 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] drm/arm/malidp: use sysfs_emit in show function callback
Message-ID: <Y9e41kG1tcQX6L10@e110455-lin.cambridge.arm.com>
References: <Y9Q5Tt8c9WBDxeyV@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Q5Tt8c9WBDxeyV@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 02:21:26AM +0530, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit() instead
> of sprintf() family functions.
> Issue identified using the device_attr_show.cocci Coccinelle script.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will push the change into drm-misc-next by the end of the week.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 589c1c66a6dc..cf040e2e9efe 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -649,7 +649,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct malidp_drm *malidp = drm_to_malidp(drm);
>  
> -	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
> +	return sysfs_emit(buf, "%08x\n", malidp->core_id);
>  }
>  
>  static DEVICE_ATTR_RO(core_id);
> -- 
> 2.34.1
> 
> 
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
