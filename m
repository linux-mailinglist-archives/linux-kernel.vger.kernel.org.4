Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08239633CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiKVMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiKVMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:49:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDC606A5;
        Tue, 22 Nov 2022 04:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669121347; x=1700657347;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wIJg1xGX4Yte1WCZtUnuC+TmFlgnxwSAMKL4iqSLhss=;
  b=Wc0hsLn9T4hVB6m6uSdBaGIwN2Q7//vpCWX9/KOQFG0KAOnsRHnMQMEE
   X2gyIbJ84k1lEzWnQocPOFI6FSAHOgeZjadVDrX4X+vw5Cslyrmb2FfvW
   WJuCB+dLjx8ifbwVZ1n1HVNZ+Iazk3dJnmhcpJnsm3yUkrkIS43q/YSg1
   ggw308G9/Q25IgNuuBFSOIxwSOKt2xO9Tcx2mKi3CCODKJc1DBZM0SVcp
   6a6aHNY52dY0gmHiKuGIMLQg5K+wGGijAmbQFQXEVgSwyw2QeGA6hlvnF
   D/8SZgYcNszR92D2sYekHgoj2JgU7U4x4f8pHqr5QBEwVXzJkrUXuLVw/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="375948696"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="375948696"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:49:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="766327818"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="766327818"
Received: from sfflynn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.18.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:49:01 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     coverity-bot <keescook@chromium.org>
Cc:     David Airlie <airlied@gmail.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: intel_hti_uses_phy(): Integer handling issues
In-Reply-To: <202211180848.D39006C@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202211180848.D39006C@keescook>
Date:   Tue, 22 Nov 2022 14:48:58 +0200
Message-ID: <875yf7xih1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221118 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Thu Nov 17 16:12:56 2022 +0200
>     62749912540b ("drm/i915/display: move hti under display sub-struct")
>
> Coverity reported the following:
>
> *** CID 1527374:  Integer handling issues  (BAD_SHIFT)
> drivers/gpu/drm/i915/display/intel_hti.c:24 in intel_hti_uses_phy()
> 18     	if (INTEL_INFO(i915)->display.has_hti)
> 19     		i915->display.hti.state = intel_de_read(i915, HDPORT_STATE);
> 20     }
> 21
> 22     bool intel_hti_uses_phy(struct drm_i915_private *i915, enum phy phy)
> 23     {
> vvv     CID 1527374:  Integer handling issues  (BAD_SHIFT)
> vvv     In expression "1UL << 2 * phy + 1", shifting by a negative amount has undefined behavior.  The shift amount, "2 * phy + 1", is as little as -1.
> 24     	return i915->display.hti.state & HDPORT_ENABLED &&
> 25     		i915->display.hti.state & HDPORT_DDI_USED(phy);
> 26     }
> 27
> 28     u32 intel_hti_dpll_mask(struct drm_i915_private *i915)
> 29     {
>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527374 ("Integer handling issues")
> Fixes: 62749912540b ("drm/i915/display: move hti under display sub-struct")

Thanks for the report, fix at [1].

I realize I didn't use the suggested tags above. For one thing, we've
never really logged any proprietary tools used. Looks like
"Addresses-Coverity-ID:" is growing in popularity though.

The Fixes: tag points at code refactoring, it was a pre-existing
condition.

BR,
Jani.


[1] https://patchwork.freedesktop.org/patch/msgid/20221122120948.3436180-1-jani.nikula@intel.com


>
> This code appears to be safe currently (intel_hti_uses_phy() is never
> called with PHY_NONE), but perhaps add an explicit check?
>
> 	if (WARN_ON(phy == PHY_NONE))
> 		return false;
>
> Thanks for your attention!

-- 
Jani Nikula, Intel Open Source Graphics Center
