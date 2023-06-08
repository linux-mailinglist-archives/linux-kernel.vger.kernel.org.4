Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D4727CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjFHKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:24:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560D173B;
        Thu,  8 Jun 2023 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686219869; x=1717755869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0kSBNlHK2bsytGA9aO1JMLSbfCDZkZdpa9AQY9EE1gA=;
  b=M7sDMU6J3fEgy7VZ4MhM0XGP4/M/304qMDuz3Qf3vzMcN+ZZxopZ4lPr
   sK8Qyj6AJ/QHNgCFUiXODGlKPuIpB7pGtuoI1G3yQ6g/V/hGugxb32LTT
   zGwTIZ60u7II/rKausTGJkzmCtriAYvydaN+bYgDKGPrh4BrfHtu4H5Gj
   RLJaOuGI1ztKEEv0BBmfAJirmDiO40oTL+Vyq32adZJwuoCWUjIODitfT
   Hlcmqy6frODBPTwB/3GYUZ7O+QUiOwhP5mJxsMR1aPjQ85kiQivmZbCW0
   xTnpBWPMr0CTGNU2Yn6lxhZFxhzh7gzR2KgH6E+Zr8XtB5Qy7aBPD0ITj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443637477"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="443637477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="713068553"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="713068553"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:24:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/mtl: Fix spelling mistake "initate" ->
 "initiate"
In-Reply-To: <20230608100722.1148771-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230608100722.1148771-1-colin.i.king@gmail.com>
Date:   Thu, 08 Jun 2023 13:24:23 +0300
Message-ID: <87h6ris148.fsf@intel.com>
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

On Thu, 08 Jun 2023, Colin Ian King <colin.i.king@gmail.com> wrote:
> There is a spelling mistake in a drm_dbg_kms message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_pmdemand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_pmdemand.c b/drivers/gpu/drm/i915/display/intel_pmdemand.c
> index f7608d363634..f59e1e962e3d 100644
> --- a/drivers/gpu/drm/i915/display/intel_pmdemand.c
> +++ b/drivers/gpu/drm/i915/display/intel_pmdemand.c
> @@ -555,7 +555,7 @@ intel_pmdemand_program_params(struct drm_i915_private *i915,
>  		goto unlock;
>  
>  	drm_dbg_kms(&i915->drm,
> -		    "initate pmdemand request values: (0x%x 0x%x)\n",
> +		    "initiate pmdemand request values: (0x%x 0x%x)\n",
>  		    mod_reg1, mod_reg2);
>  
>  	intel_de_rmw(i915, XELPDP_INITIATE_PMDEMAND_REQUEST(1), 0,

-- 
Jani Nikula, Intel Open Source Graphics Center
