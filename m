Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BBB708C88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjERXyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERXyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:54:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B7E6E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454049; x=1715990049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+D5psDNyUmd7dAZ4+pd1QsJ/Pk3EYpwue9iEXA+aI5I=;
  b=eLLQ6ExMuHcIWB9RhkszCO9G8T2fWNTFiFrmKvBQDVgKGPJxm9J333A/
   kV3RPgeJb9Bh7gwai2FIv472bv6W+uVT5IeX3VoRoKj4eEDF0Z+GfJ9Xw
   yFurf/Bl1of9dCDIeKOl4BO/CIi6o2yBR+1v2rQ1C3CH1qoN6VSd2LNDa
   /47bsjr/EUtMTivjPbiizs3UvT2730DutDr998iLN2jfRhWcm7wbdKT8k
   DhvWbVl7Cxl3NPFstkQou4WylohxkWt5xU0BLARzLwoiuDUUsPsa5DBWt
   I1cCUmODn58GI9EQDTL5Ya6J83JHwxnVxVDw/QXI68U5nAXff9jkUBcsN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336813414"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="336813414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846677814"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="846677814"
Received: from refaase-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.221.245])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:54:04 -0700
Date:   Fri, 19 May 2023 01:54:00 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [Intel-gfx] [RESEND PATCH] drm/i915: constify pointers to
 hwmon_channel_info
Message-ID: <ZGa6mAe726ER7N4t@ashyti-mobl2.lan>
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, May 11, 2023 at 07:54:46PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
