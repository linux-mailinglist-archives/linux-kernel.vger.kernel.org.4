Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCE5B5274
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiILBZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 21:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiILBZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 21:25:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25FE175AB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662945928; x=1694481928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ecU4kyT9//WudYGodoYB0OtJ/Rmk8S4MnM/86WtnIxo=;
  b=JCyZ8Qd7Td+28qRybz1nX0xiq5DVcWxIhHqEhF6SZD7UpUL7fSmUjEjh
   ysTp+kcFOnzNTOG9kG40Yxc0wqu2rVb5W72SiEVA96dEuM5Q1jpot0LKX
   FW6lCrIVyD+L9nxb+WaU95VM6zD+UWA5ZWJtUTDA78MbgtCMZ07XOLots
   WGKdgeDVuNJjG4cpQDozBmEkkq8srWuqKpVjOETFxRkze9bMmy3AEi+bS
   W5cETje1ZxHBtjLRKktpfIjve1SQVqoqODEYUqaSOcck5hxmvhThFvVF/
   c+VTCmdt6jqDPl5nxV+Qi4jx8+ApGZydZtQ4hDBrPFg/5a07KD4uKz8Oo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278158945"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="278158945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646261125"
Received: from dasegal-mobl.amr.corp.intel.com (HELO intel.com) ([10.249.46.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:25:24 -0700
Date:   Mon, 12 Sep 2022 03:25:21 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 33/37] drm/i915 i915_gem_object_types.h: document
 struct i915_lut_handle
Message-ID: <Yx6KgVcgyB2i2dYG@alfio.lan>
References: <cover.1662708705.git.mchehab@kernel.org>
 <0da7c28a377a1fac9db524dbc8462731d922b39c.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da7c28a377a1fac9db524dbc8462731d922b39c.1662708705.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Sep 09, 2022 at 09:34:40AM +0200, Mauro Carvalho Chehab wrote:
> commit d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
> added a rbtree list to allow searching for obj/ctx.
> 
> Document it.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/
> 
>  drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> index 9f6b14ec189a..35746cf268ea 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> @@ -21,9 +21,15 @@ struct drm_i915_gem_object;
>  struct intel_fronbuffer;
>  struct intel_memory_region;
>  
> -/*
> - * struct i915_lut_handle tracks the fast lookups from handle to vma used
> - * for execbuf. Although we use a radixtree for that mapping, in order to
> +/**
> + * struct i915_lut_handle - tracks the fast lookups from handle to vma used
> + * for execbuf.
> + *

just to be picky: do we or don't we want this extra space here? I
think that besides our personal taste it's important to have a
coherent style.

I would r-b it anyway if I didn't look the next patch.

Andi

> + * @obj_link: link to the object associated with the @handle.
> + * @ctx: context associated with the @handle.
> + * @handle: a rbtree handle to lookup context for specific obj/vma.
> + *
> + * Although we use a radixtree for that mapping, in order to
>   * remove them as the object or context is closed, we need a secondary list
>   * and a translation entry (i915_lut_handle).
>   */
> -- 
> 2.37.3
