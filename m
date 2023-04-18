Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7136E5BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjDRIUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDRIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:20:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EA420F;
        Tue, 18 Apr 2023 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681805995; x=1713341995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BUDt7Leg5YNsBfAufyHE9J891sNBSaCcNnWZI81W9tU=;
  b=WkLhIT85YvgBF50wY9kqg5NxFibXE6b84JSq2/dM0HYORnLx/YPEYLJK
   xzRKiSOEh1dNQY0uFc4Cp4e8VMJ+2CN1lkshpVC6inFbaZp63ToVRR/f9
   dWYvn4ooUKAO3Y2z6x9ZMgBcSp1ClNdbhfhYa3s/y54AtkwEUdcwbcDQ6
   vWn3yRs01mrD3JfEbDajxYT9dyUw+YJVivga4BsHw/wyLM4vAkBams79A
   SIfpQUDN7y138rLCbEVk5Nylbwpz7/xtVKedJ/I4c+KmsdpaS0o/aRi1L
   zF+OOopLMlKF654vhabM0A7ZSOaQD3kMRRHQf3x8bC58XQz5G52D1zYOD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347858338"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="347858338"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="641288458"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="641288458"
Received: from dilipban-mobl.ger.corp.intel.com (HELO [10.213.234.43]) ([10.213.234.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:19:51 -0700
Message-ID: <a3edcd53-bcbe-7408-100c-3db52c897a18@linux.intel.com>
Date:   Tue, 18 Apr 2023 09:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC 1/3] drm/doc: Relax fdinfo string constraints
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230417201215.448099-1-robdclark@gmail.com>
 <20230417201215.448099-2-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230417201215.448099-2-robdclark@gmail.com>
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
> The restriction about no whitespace, etc, really only applies to the
> usage of strings in keys.  Values can contain anything (other than
> newline).
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   Documentation/gpu/drm-usage-stats.rst | 29 ++++++++++++++-------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 258bdcc8fb86..8e00d53231e0 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -24,7 +24,7 @@ File format specification
>   - All keys shall be prefixed with `drm-`.
>   - Whitespace between the delimiter and first non-whitespace character shall be
>     ignored when parsing.
> -- Neither keys or values are allowed to contain whitespace characters.
> +- Keys are not allowed to contain whitespace characters.
>   - Numerical key value pairs can end with optional unit string.
>   - Data type of the value is fixed as defined in the specification.
>   
> @@ -39,12 +39,13 @@ Data types
>   ----------
>   
>   - <uint> - Unsigned integer without defining the maximum value.
> -- <str> - String excluding any above defined reserved characters or whitespace.
> +- <keystr> - String excluding any above defined reserved characters or whitespace.
> +- <valstr> - String.

Makes sense I think. At least I can't remember that I had special reason 
to word it as strict as it was. Lets give it some time to marinade so 
for later:

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko

>   
>   Mandatory fully standardised keys
>   ---------------------------------
>   
> -- drm-driver: <str>
> +- drm-driver: <valstr>
>   
>   String shall contain the name this driver registered as via the respective
>   `struct drm_driver` data structure.
> @@ -69,10 +70,10 @@ scope of each device, in which case `drm-pdev` shall be present as well.
>   Userspace should make sure to not double account any usage statistics by using
>   the above described criteria in order to associate data to individual clients.
>   
> -- drm-engine-<str>: <uint> ns
> +- drm-engine-<keystr>: <uint> ns
>   
>   GPUs usually contain multiple execution engines. Each shall be given a stable
> -and unique name (str), with possible values documented in the driver specific
> +and unique name (keystr), with possible values documented in the driver specific
>   documentation.
>   
>   Value shall be in specified time units which the respective GPU engine spent
> @@ -84,16 +85,16 @@ larger value within a reasonable period. Upon observing a value lower than what
>   was previously read, userspace is expected to stay with that larger previous
>   value until a monotonic update is seen.
>   
> -- drm-engine-capacity-<str>: <uint>
> +- drm-engine-capacity-<keystr>: <uint>
>   
>   Engine identifier string must be the same as the one specified in the
> -drm-engine-<str> tag and shall contain a greater than zero number in case the
> +drm-engine-<keystr> tag and shall contain a greater than zero number in case the
>   exported engine corresponds to a group of identical hardware engines.
>   
>   In the absence of this tag parser shall assume capacity of one. Zero capacity
>   is not allowed.
>   
> -- drm-memory-<str>: <uint> [KiB|MiB]
> +- drm-memory-<keystr>: <uint> [KiB|MiB]
>   
>   Each possible memory type which can be used to store buffer objects by the
>   GPU in question shall be given a stable and unique name to be returned as the
> @@ -126,10 +127,10 @@ The total size of buffers that are purgeable.
>   
>   The total size of buffers that are active on one or more rings.
>   
> -- drm-cycles-<str>: <uint>
> +- drm-cycles-<keystr>: <uint>
>   
>   Engine identifier string must be the same as the one specified in the
> -drm-engine-<str> tag and shall contain the number of busy cycles for the given
> +drm-engine-<keystr> tag and shall contain the number of busy cycles for the given
>   engine.
>   
>   Values are not required to be constantly monotonic if it makes the driver
> @@ -138,12 +139,12 @@ larger value within a reasonable period. Upon observing a value lower than what
>   was previously read, userspace is expected to stay with that larger previous
>   value until a monotonic update is seen.
>   
> -- drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
> +- drm-maxfreq-<keystr>: <uint> [Hz|MHz|KHz]
>   
>   Engine identifier string must be the same as the one specified in the
> -drm-engine-<str> tag and shall contain the maximum frequency for the given
> -engine.  Taken together with drm-cycles-<str>, this can be used to calculate
> -percentage utilization of the engine, whereas drm-engine-<str> only reflects
> +drm-engine-<keystr> tag and shall contain the maximum frequency for the given
> +engine.  Taken together with drm-cycles-<keystr>, this can be used to calculate
> +percentage utilization of the engine, whereas drm-engine-<keystr> only reflects
>   time active without considering what frequency the engine is operating as a
>   percentage of it's maximum frequency.
>   
