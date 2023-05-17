Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2270641F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEQJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEQJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:28:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68385171F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684315713; x=1715851713;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nKgzkfcVAPljUT2zjEKTschQjkA+e905vgG7hjXcyGc=;
  b=Cpd5aTXT9bewqKtkj+4JKPGwJyk9pM0vD5LrE/meobrM+EIjyvN4BOs9
   nqx75NmYehAcHa8x8FX3fmY3xU05Dc5cCDCpPSIReAhWoJNe7sIp/8TWv
   vuSV9RLVL6CcfP+Cuy/1A7h/8KmIyG1wqqJ8qobj9hDMpbDnFzP/5Zyjt
   p1ir2dQ4tU0iPPY6g/RG/GldnY755bWtcLyBCSCzJ0PYBac+7ri9D+xWN
   7x5O0RmyDpIDRvYNoIIGVCDHEYKCvJcyrVQAIs5zb9t7uMRJTm+441YNv
   8jlaYbyNdHWxVxcZBYqgdaML9zKvlQqaJF7mIoOCy6ubpQeZwJU3xaLqU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350546065"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="350546065"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 02:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825894450"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825894450"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.50.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 02:28:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] drm/i915: constify pointers to hwmon_channel_info
In-Reply-To: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
Date:   Wed, 17 May 2023 12:28:14 +0300
Message-ID: <87cz2zgvdd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

FYI we'll merge this once we've done a backmerge to get the hwmon
changes to our tree.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
> index 8e7dccc8d3a0..e99e8c97ef01 100644
> --- a/drivers/gpu/drm/i915/i915_hwmon.c
> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
> @@ -267,7 +267,7 @@ static const struct attribute_group *hwm_groups[] = {
>  	NULL
>  };
>  
> -static const struct hwmon_channel_info *hwm_info[] = {
> +static const struct hwmon_channel_info * const hwm_info[] = {
>  	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
>  	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_CRIT),
>  	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
> @@ -275,7 +275,7 @@ static const struct hwmon_channel_info *hwm_info[] = {
>  	NULL
>  };
>  
> -static const struct hwmon_channel_info *hwm_gt_info[] = {
> +static const struct hwmon_channel_info * const hwm_gt_info[] = {
>  	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
>  	NULL
>  };

-- 
Jani Nikula, Intel Open Source Graphics Center
