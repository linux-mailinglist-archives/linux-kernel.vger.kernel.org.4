Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3FD720856
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjFBRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjFBRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:24:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87491B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685726657; x=1717262657;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KE+as3H7u1LdHKfriftsu8T7yzvJ4/Tz3dDvVlcxVLI=;
  b=HLf3qIVw7x2OQIQz2t353WheUMQRsI87zn5k2z/jX0XJAvNoZ21x9bGU
   JuI4+dEk471SK9uX1Bz14Suc0a5edZGKjBduq798j1JsdnEvyiHr7GHdQ
   sgMHM8tOefPKMucsCX/13Q6atWIl/wt9ztpZT0NO8Da83plg4EzQ5+gWL
   dDtr7MkmQb4yX5I1Eu5T9B/UOjC992y1AygkCZVA0QJcSMmRbDFNPT45+
   wNxoZWCUQqxum+yZxmZW1yqqcaReJYZm/Oc8IGHuApyurpL7/ohNFPmRp
   gHLLg/pW/KqKHbI2oorfvhDr8AwFZstcuQmSoxke/8At7EweMAqoMIXZc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358352772"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358352772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="740890801"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="740890801"
Received: from jwerner6-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.111])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:24:14 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915_drm.h: fix a typo
In-Reply-To: <20230529112956.2083389-1-suijingfeng@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230529112956.2083389-1-suijingfeng@loongson.cn>
Date:   Fri, 02 Jun 2023 20:24:11 +0300
Message-ID: <87edmtdbgk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>  'rbiter' -> 'arbiter'
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>  include/drm/i915_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
> index 7adce327c1c2..adff68538484 100644
> --- a/include/drm/i915_drm.h
> +++ b/include/drm/i915_drm.h
> @@ -42,7 +42,7 @@ extern struct resource intel_graphics_stolen_res;
>   * The Bridge device's PCI config space has information about the
>   * fb aperture size and the amount of pre-reserved memory.
>   * This is all handled in the intel-gtt.ko module. i915.ko only
> - * cares about the vga bit for the vga rbiter.
> + * cares about the vga bit for the vga arbiter.
>   */
>  #define INTEL_GMCH_CTRL		0x52
>  #define INTEL_GMCH_VGA_DISABLE  (1 << 1)

-- 
Jani Nikula, Intel Open Source Graphics Center
