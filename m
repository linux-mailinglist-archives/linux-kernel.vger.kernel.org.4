Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A06D4C06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjDCPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjDCPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:35:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BB270A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680536136; x=1712072136;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y8RNv3n49PxFwMFIgJOIlbEfTmTQ8dwtbs5llVu/kPU=;
  b=UerFzgGMjXQU8efa0qp5NeBB243XekKBcv692xx9y/BDz9BsWkFBjbcL
   siNEu80RCj6BEmaL5hTK9zkNop9R52GWW8tjs8asH5qx9EvCnWDf+1NwS
   QKHJx4tMR34EM+fmR74pZTn5M5MZ2I2ZtLJ4kgw5teMpsB2btZ+FwCc4J
   1PHFNH6pGgEsYvJ+VHPcXr0hvP5lfGuuufs7PiDIona3TATmJIV3jQjoV
   bWKww0fkT1fDYvn7Kdm5PiZqn9qPGEHr4xgvP/7+B2IxjKgr+zxgoTWYO
   FLey17p1kqXrTonDnpIynnECpfDeehhbK/hUZBCOcT1y7ELO4xgdoHV9u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="341957097"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="341957097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="829611071"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="829611071"
Received: from pstratma-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.30])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:35:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee@kernel.org>, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/19] drm/i915/i915_scatterlist: Fix kerneldoc
 formatting issue - missing '@'
In-Reply-To: <20230331092607.700644-2-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230331092607.700644-1-lee@kernel.org>
 <20230331092607.700644-2-lee@kernel.org>
Date:   Mon, 03 Apr 2023 18:35:30 +0300
Message-ID: <87jzyt0yil.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023, Lee Jones <lee@kernel.org> wrote:
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'
>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Thanks for the patches!

Applied all but one of the drm/i915 patches to drm-intel-next or
drm-intel-gt-next depending on the area. There were a couple of issues
that I fixed while applying. There was a conflict with patch 5/19
against drm-intel-gt-next so I left that one out.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_scatterlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.c b/drivers/gpu/drm/i915/i915_scatterlist.c
> index 7c7a86921b1c7..e93d2538f2988 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.c
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.c
> @@ -56,7 +56,7 @@ static const struct i915_refct_sgt_ops rsgt_ops = {
>  /**
>   * i915_refct_sgt_init - Initialize a struct i915_refct_sgt with default ops
>   * @rsgt: The struct i915_refct_sgt to initialize.
> - * size: The size of the underlying memory buffer.
> + * @size: The size of the underlying memory buffer.
>   */
>  void i915_refct_sgt_init(struct i915_refct_sgt *rsgt, size_t size)
>  {

-- 
Jani Nikula, Intel Open Source Graphics Center
