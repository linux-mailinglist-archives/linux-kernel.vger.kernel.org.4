Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C645E5B5276
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 03:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILB1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiILB1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 21:27:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A571BEBE;
        Sun, 11 Sep 2022 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662946070; x=1694482070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xmotxmw3nocnvBW51ZNXHo6s0m1J8j499zaBKXWXBX0=;
  b=ZqBH5gCrCU39yhoFYjaMRoc5MUx8ylTw8xReA4foLJB/0EiSl1+AhhQ2
   f6cj0lcQWPV592FLFB9srgplP7lHB3SMfFFNICzLyj7nQM5NEfY0FVWMB
   +tKQHNMCENQulmQk/ufrxsqOtNYUYn9AEtCt2JCYQlVQn5BMgEC/QSOTH
   VnPRpPpPzVkC7D/vxZvAhPqFMF6NmBpAWPSiJDffF31hpfMckV1wuemZo
   rwAHsgf+2jSWj7ycFPAvZt5cm8QnAuRUBbIKXLDGBnGCeokXiCEr/2imC
   rwPKRp1BU3iFMGtgggI1i1HU6xXb3pM1qjbRrispCriuG85Hd1J+iUys8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="277501456"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="277501456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:27:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="677897204"
Received: from dasegal-mobl.amr.corp.intel.com (HELO intel.com) ([10.249.46.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:27:45 -0700
Date:   Mon, 12 Sep 2022 03:27:42 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/37] drm/i915: add descriptions for some RPM macros
 at intel_gt_pm.h
Message-ID: <Yx6LDoMBkL6IO0Gu@alfio.lan>
References: <cover.1662708705.git.mchehab@kernel.org>
 <997567dcc2b5942afde093d92d0666948e66d83a.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997567dcc2b5942afde093d92d0666948e66d83a.1662708705.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

[...]

> +/**
> + * intel_gt_pm_is_awake: Query whether the runtime PM is awake held
> + *
> + * @gt: pointer to the graphics engine

...

> +/**
> + * intel_gt_pm_get: grab a runtime PM reference ensuring that GT is powered up
> + * @gt: pointer to the graphics engine

...

> +/**
> + * __intel_gt_pm_get: Acquire the runtime PM reference again
> + * @gt: pointer to the graphics engine which contains the wakeref

...

> +/**
> + * intel_gt_pm_get_if_awake: Acquire the runtime PM reference if active
> + * @gt: pointer to the graphics engine which contains the PM reference

...

> +/**
> + * intel_gt_pm_put: Release the runtime PM reference
> + * @gt: pointer to the graphics engine which contains the PM reference

...

> +/**
> + * with_intel_gt_pm - get a GT reference ensuring that GT is powered up,
> + *	run some code and then put the reference away.
> + *
> + * @gt: pointer to the gt

as you can see sometimes you put that extra blank line and
sometimes not... can we please stick to one style?

Thanks,
Andi
