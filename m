Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328E15B526A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILBW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 21:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILBWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 21:22:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E822512
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662945743; x=1694481743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d23CLNofMYNRbKJhNQOOuRrVPflbS1+3REmtjGgHoKs=;
  b=W3X5WV+0C6O2cbc9wm3UBmLwLcBJOldjU94/7/mimBHda26XtqycrScz
   xIsmx3+1ECGBOWc9AeFAi1D+URQUKlLVVMGk9TqcPLN4Tc6cRJ7apBH8m
   FUQxGlbmkXbCSJWpSs5uHR5OIGJ/JQRzebdKTqs1DlTx4u6KxENBpBDa4
   ZlPEijfh6eMa4L4QhYAYeqBqvRwz6UqsccxNYTZlcrExQC0xUrEdZnDp8
   Dd7/qwUo1/LxpoW2WyGUUxa4Ts3QX0hH1VU+O+vj7Bdpl6hjW4nQ7lJP4
   gKiARCIrPhiEPWznKH6LJklndZ2cAzbw04n5PI2OH1+Qkce4MNdJJV3ou
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="284786729"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="284786729"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:22:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="677895905"
Received: from dasegal-mobl.amr.corp.intel.com (HELO intel.com) ([10.249.46.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:22:18 -0700
Date:   Mon, 12 Sep 2022 03:22:16 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/37] drm/i915: i915_gem_wait.c: fix a kernel-doc
 markup
Message-ID: <Yx6JyMdEsfUTNEPS@alfio.lan>
References: <cover.1662708705.git.mchehab@kernel.org>
 <a43bcb92337531714f9b7cf6d158d599d5b630ad.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43bcb92337531714f9b7cf6d158d599d5b630ad.1662708705.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Sep 09, 2022 at 09:34:24AM +0200, Mauro Carvalho Chehab wrote:
> The return codes for i915_gem_wait_ioctl() have identation issues,
> and will be displayed on a very confusing way. Use lists to improve
> its output.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/
> 
>  drivers/gpu/drm/i915/gem/i915_gem_wait.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> index 4a33ad2d122b..1fd5cff552ed 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -210,23 +210,25 @@ static unsigned long to_wait_timeout(s64 timeout_ns)
>   * @data: ioctl data blob
>   * @file: drm file pointer
>   *
> - * Returns 0 if successful, else an error is returned with the remaining time in
> - * the timeout parameter.
> - *  -ETIME: object is still busy after timeout
> - *  -ERESTARTSYS: signal interrupted the wait
> - *  -ENONENT: object doesn't exist
> - * Also possible, but rare:
> - *  -EAGAIN: incomplete, restart syscall
> - *  -ENOMEM: damn
> - *  -ENODEV: Internal IRQ fail
> - *  -E?: The add request failed
> - *
>   * The wait ioctl with a timeout of 0 reimplements the busy ioctl. With any
>   * non-zero timeout parameter the wait ioctl will wait for the given number of
>   * nanoseconds on an object becoming unbusy. Since the wait itself does so
>   * without holding struct_mutex the object may become re-busied before this
>   * function completes. A similar but shorter * race condition exists in the busy
>   * ioctl
> + *
> + * Returns:
> + * 0 if successful, else an error is returned with the remaining time in
> + * the timeout parameter.
> + * * -ETIME: object is still busy after timeout
> + * * -ERESTARTSYS: signal interrupted the wait
> + * * -ENONENT: object doesn't exist
> + *
> + * Also possible, but rare:
> + * * -EAGAIN: incomplete, restart syscall
> + * * -ENOMEM: damn
> + * * -ENODEV: Internal IRQ fail
> + * * -E?: The add request failed
>   */
>  int
>  i915_gem_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
> -- 
> 2.37.3
