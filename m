Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8795F6461
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJFKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJFKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:38:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642195E72
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665052728; x=1696588728;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=B3augJp3fk1qe+mBthnq0pxJCB8QBCksPWpBNe9BcX8=;
  b=A+OcyPannz48RAE3rVXlz+W+MBs0r/1n+4LHNI9AxwQ3XatptWAClkPZ
   5tiQAQ1GEd+DpbggDxfBuz7ZVYrx1jbPUpJBXioD3idEe6H737avXkGpn
   wcgh9jtfe3m86YIjDdddCO2K2/2QuU9Ceua7oSvb0iJLWYdibu+r0tjbo
   RUSzeZoph9djitimVx+gLmzsGDEU2M2JpYNm34oGuJORcBWe94eDDvbsl
   EbCcxoHnLuF/ss6AF9J46rmbEn3sSnykj5aD7cB7oBUIS4C8CxXWXnxDf
   Ta5yb9iXpRauEltRG2DDEqGj2CaFuRr1feLMuWMgQUEfulJlUdWfrIWFf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301009819"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="301009819"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 03:38:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="624674737"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="624674737"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.153])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 03:38:45 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: fix repeated words in comments
In-Reply-To: <20220907113644.32831-1-yuanjilin@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220907113644.32831-1-yuanjilin@cdjrlc.com>
Date:   Thu, 06 Oct 2022 13:38:42 +0300
Message-ID: <87zge9p77x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022, Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
> Delete the redundant word 'on'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks for the patch, pushed to drm-misc-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/drm_edid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 4005dab6147d..25866b568d6b 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6837,7 +6837,7 @@ drm_hdmi_avi_infoframe_quant_range(struct hdmi_avi_infoframe *frame,
>  	 * by non-zero YQ when receiving RGB. There doesn't seem to be any
>  	 * good way to tell which version of CEA-861 the sink supports, so
>  	 * we limit non-zero YQ to HDMI 2.0 sinks only as HDMI 2.0 is based
> -	 * on on CEA-861-F.
> +	 * on CEA-861-F.
>  	 */
>  	if (!is_hdmi2_sink(connector) ||
>  	    rgb_quant_range == HDMI_QUANTIZATION_RANGE_LIMITED)

-- 
Jani Nikula, Intel Open Source Graphics Center
