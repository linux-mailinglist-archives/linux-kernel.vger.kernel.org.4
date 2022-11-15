Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A8629D79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKOP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiKOP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:28:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3932D76F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526093; x=1700062093;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QyVi8xwimHr/SBGDnhpw7L6AZK+eBVpkUqCWoyo7LzM=;
  b=HIgs+C4XSkwi98rra4e8L1BKM6necA1FRfZ757Np5NRZk1WeqsM6cUEe
   CrMTogAjx7pFSYM1HIDAhQIOqABlsVnLePSCBSuwTitqC8C7Pr4v4DeZU
   TaExF6gsOIIxFYQv9kCDHdN5Fc81jwYIK09F0zrm8JsNKbMqektTsW18y
   MiWaQ5XtPBJbV6rMzzyG9KXfMAlmnWmlvW3cuRJwJwT7pBcs6ld/fexRq
   7wsIBDl5j/0c3aocugBkaJ5j3Su9P4ndSwEHSG1FLQRSgFpi7c2AzSZzJ
   O7r5hEgUuAez5fF0zK/gkSK0bpTFjEXrE51e/EiP6y28O/IIk1lfcXlIB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313427038"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="313427038"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:28:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763949981"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="763949981"
Received: from golubevv-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:28:10 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/i915: remove circ_buf.h includes
In-Reply-To: <20221115070302.4064-1-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221115070302.4064-1-jirislaby@kernel.org>
Date:   Tue, 15 Nov 2022 17:28:07 +0200
Message-ID: <87o7t82q60.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> The last user of macros from that include was removed in 2018 by the
> commit below.
>
> Fixes: 6cc42152b02b ("drm/i915: Remove support for legacy debugfs crc interface")
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Pushed to drm-intel-next, thanks for the patch!

BR,
Jani.

> ---
>
> Notes:
>     [v2] fixed e-mail setup
>
>  drivers/gpu/drm/i915/display/intel_pipe_crc.c | 1 -
>  drivers/gpu/drm/i915/i915_irq.c               | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> index 673454fbf784..e9774670e3f6 100644
> --- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> +++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> @@ -24,7 +24,6 @@
>   *
>   */
>  
> -#include <linux/circ_buf.h>
>  #include <linux/ctype.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index b0180ea38de0..a815a45a6e6b 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -28,7 +28,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/circ_buf.h>
>  #include <linux/slab.h>
>  #include <linux/sysrq.h>

-- 
Jani Nikula, Intel Open Source Graphics Center
