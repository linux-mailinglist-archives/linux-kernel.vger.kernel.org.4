Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06272468F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbjFFOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbjFFOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:42:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15C2719
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:40:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23665AB;
        Tue,  6 Jun 2023 16:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686062355;
        bh=qyqmnSxwDwLrbxk8+vjpFN2vWJrjzLzmUBFrL48Rkfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4smJqs5dEKcDVHCfkFXhvvZxlZ37wGv8k7loP11UwO+eQEJjJv11rrjS/a9/JlDD
         L+RlpZsRVK8FkPZhlAJ+QiL+70D/6XtzH0RHbEBLfnJtZ8Itfu8ZfPf+Dzo+HFjYwZ
         qJvMdz7dyCVBQtyMGYZRL8EHzvAurt88+U0VvGZw=
Date:   Tue, 6 Jun 2023 17:39:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 4/8] drm: Remove usage of deprecated DRM_NOTE
Message-ID: <20230606143937.GD5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <91d957dd92b41dda42da912397df195e3565866a.1686047727.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91d957dd92b41dda42da912397df195e3565866a.1686047727.git.code@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddh,

Thank you for the patch.

On Tue, Jun 06, 2023 at 04:15:18PM +0530, Siddh Raman Pant wrote:
> drm_print.h says DRM_NOTE is deprecated in favor of drm_notice().
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

With the commit message fixed as mentioned in the review of an earlier
patch in this series,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_displayid.c         | 2 +-
>  drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
> index 9edc111be7ee..27ffeee09e4f 100644
> --- a/drivers/gpu/drm/drm_displayid.c
> +++ b/drivers/gpu/drm/drm_displayid.c
> @@ -42,7 +42,7 @@ validate_displayid(const u8 *displayid, int length, int idx)
>  	for (i = 0; i < dispid_length; i++)
>  		csum += displayid[idx + i];
>  	if (csum) {
> -		DRM_NOTE("DisplayID checksum invalid, remainder is %d\n", csum);
> +		drm_notice(NULL, "DisplayID checksum invalid, remainder is %d\n", csum);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
> index 0bf0fc1abf54..7a41373b67dc 100644
> --- a/drivers/gpu/drm/drm_kms_helper_common.c
> +++ b/drivers/gpu/drm/drm_kms_helper_common.c
> @@ -41,7 +41,7 @@ MODULE_LICENSE("GPL and additional rights");
>  /* Backward compatibility for drm_kms_helper.edid_firmware */
>  static int edid_firmware_set(const char *val, const struct kernel_param *kp)
>  {
> -	DRM_NOTE("drm_kms_helper.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
> +	drm_notice(NULL, "drm_kms_helper.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
>  
>  	return __drm_set_edid_firmware_path(val);
>  }

-- 
Regards,

Laurent Pinchart
