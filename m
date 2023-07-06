Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A0749726
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjGFINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjGFINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:13:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C21726
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688631217; x=1720167217;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9Y4RKqquLT3bLD39/xyJkPPz/58Je7W/hNpP2VEk0Fk=;
  b=Ok0dZh804aO8fLcgoO/xnsyI+4rESA1mGm+fpeHrQftajSdTQ68A/zD+
   gIMs/Hz63flTtCb8tiGMKUdxRyI/76u1rvhzKmYcVvOxdz6HRiQQA2Ktw
   uyuR1wA1BA4/9RVmqZcyQSrgoIgNtpP50QnxSIPuVs4nW6Su3S7eiuQ3/
   Vlvb25ObCltvXGKBDH3I0qEAe2t35Z6GU82o22CAdZ9AVPnvTwZV4G2IG
   rkM92upypM2wVg5qHiuZ9la5MDrAM7WHrpCoATJPP91f2052ugQ85zrV9
   Ip6IWB6seYm+Yrmbz46BBLYbpanHmK5iJsH/NTaPP9+/7+kwJAGnWzctQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="367026118"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367026118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 01:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789461616"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789461616"
Received: from jmvuilla-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.41.105])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 01:13:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Minjie Du <duminjie@vivo.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
Subject: Re: [PATCH v1] gpu: i915: display: Replace define function
In-Reply-To: <20230706072902.4845-1-duminjie@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230706072902.4845-1-duminjie@vivo.com>
Date:   Thu, 06 Jul 2023 11:13:30 +0300
Message-ID: <87fs61zcd1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Minjie Du <duminjie@vivo.com> wrote:
> Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE.

The subject prefix should be "drm/i915/psr: ". Please try git log on the
file to see what is commonly used.

The subject should say what's being done. "Replace define function" is
way too generic to be useful. Even "Prefer DEFINE_DEBUGFS_ATTRIBUTE" is
better.

Finally, the commit message itself should say *why*. Why are we
replacing DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE?

BR,
Jani.

>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 56c17283b..822858f3e 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -2998,7 +2998,7 @@ i915_edp_psr_debug_get(void *data, u64 *val)
>  	return -ENODEV;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(i915_edp_psr_debug_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(i915_edp_psr_debug_fops,
>  			i915_edp_psr_debug_get, i915_edp_psr_debug_set,
>  			"%llu\n");

-- 
Jani Nikula, Intel Open Source Graphics Center
