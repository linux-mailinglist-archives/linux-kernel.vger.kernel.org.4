Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D236E5C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDRIyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:53:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8C240F5;
        Tue, 18 Apr 2023 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681808022; x=1713344022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XMup0HZRzCdTHOXeUENM9MHnRGKqUmtb7/GwvbX/QgY=;
  b=dw13WquwxDVF4/GeCnVw/CJmvXkqUNSlZGZtMhKBJjf4UC0/C33HiHpx
   SMZk1pEkUKwfDXeyPzilO61LMxSbyg/BpmbZsyADooZs7qOM3ZOI5cFaX
   mw7SISbo7C2AKTIQ/Np9ChYXl3Eht/G8JhSHa9fuMcW2+tda2AvwMV04X
   +1VKqrdCM0I694tlnai+y5oPc01c0GJhwXieu3d0lncSvCEBWBg0s1L0N
   RpyrfQ9/6d6kiBw4jJzNVPxkhUSt7GgVQP9lzwkm4Z0JRntjFLmlHDG0v
   u8Bx4gN5iKb0T9qCSBRyw6qwyvZjwExkyHNgZQW0QJj4kcirK0iEW0mCG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="343868966"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="343868966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834792991"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="834792991"
Received: from dilipban-mobl.ger.corp.intel.com (HELO [10.213.234.43]) ([10.213.234.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:53:37 -0700
Message-ID: <20655be0-65e3-0000-4acd-310ec9cc1d3a@linux.intel.com>
Date:   Tue, 18 Apr 2023 09:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC 3/3] drm/msm: Add comm/cmdline fields
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20230417201215.448099-1-robdclark@gmail.com>
 <20230417201215.448099-4-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230417201215.448099-4-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2023 21:12, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Normally this would be the same information that can be obtained in
> other ways.  But in some cases the process opening the drm fd is merely
> a sort of proxy for the actual process using the GPU.  This is the case
> for guest VM processes using the GPU via virglrenderer, in which case
> the msm native-context renderer in virglrenderer overrides the comm/
> cmdline to be the guest process's values.
> 
> Exposing this via fdinfo allows tools like gputop to show something more
> meaningful than just a bunch of "pcivirtio-gpu" users.

You also later expanded with:

"""
I should have also mentioned, in the VM/proxy scenario we have a
single process with separate drm_file's for each guest VM process.  So
it isn't an option to just change the proxy process's name to match
the client.
"""

So how does that work - this single process temporarily changes it's 
name for each drm fd it opens and creates a context or it is actually in 
the native context protocol?

> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   Documentation/gpu/drm-usage-stats.rst |  8 ++++++++
>   drivers/gpu/drm/msm/msm_gpu.c         | 14 ++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 8e00d53231e0..bc90bed455e3 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -148,6 +148,14 @@ percentage utilization of the engine, whereas drm-engine-<keystr> only reflects
>   time active without considering what frequency the engine is operating as a
>   percentage of it's maximum frequency.
>   
> +- drm-comm: <valstr>
> +
> +Returns the clients executable path.

Full path and not just current->comm? In this case probably give it a 
more descriptive name here.

drm-client-executable
drm-client-command-line

So we stay in the drm-client- namespace?

Or if the former is absolute path could one key be enough for both?

drm-client-command-line: /path/to/executable --arguments

> +
> +- drm-cmdline: <valstr>
> +
> +Returns the clients cmdline.

I think drm-usage-stats.rst text should provide some more text with 
these two. To precisely define their content and outline the use case 
under which driver authors may want to add them, and fdinfo consumer 
therefore expect to see them. Just so everything is completely clear and 
people do not start adding them for drivers which do not support native 
context (or like).

But on the overall it sounds reasonable to me - it would be really cool 
to not just see pcivirtio-gpu as you say. Even if the standard virtiogpu 
use case (not native context) could show real users.

Regards,

Tvrtko

> +
>   Implementation Details
>   ======================
>   
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index f0f4f845c32d..1150dcbf28aa 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -148,12 +148,26 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
>   	return 0;
>   }
>   
> +static void get_comm_cmdline(struct msm_file_private *ctx, char **comm, char **cmd);
> +
>   void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
>   			 struct drm_printer *p)
>   {
> +	char *comm, *cmdline;
> +
> +	get_comm_cmdline(ctx, &comm, &cmdline);
> +
>   	drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
>   	drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
>   	drm_printf(p, "drm-maxfreq-gpu:\t%u Hz\n", gpu->fast_rate);
> +
> +	if (comm)
> +		drm_printf(p, "drm-comm:\t%s\n", comm);
> +	if (cmdline)
> +		drm_printf(p, "drm-cmdline:\t%s\n", cmdline);
> +
> +	kfree(comm);
> +	kfree(cmdline);
>   }
>   
>   int msm_gpu_hw_init(struct msm_gpu *gpu)
