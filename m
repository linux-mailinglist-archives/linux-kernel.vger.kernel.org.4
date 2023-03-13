Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002BF6B822B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCMUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCMUEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:04:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBA6C8A8;
        Mon, 13 Mar 2023 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678737846; x=1710273846;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y5ECLy3twENnI8OadRYmVgVwWANZtmeHdLoi5ULIRXk=;
  b=nqpcEXMusIBW2Wu5dI0hvTnRy7eqbXejlfQ1baAQX+dKFBi4uZcB/rTP
   a4S7gABo9pD0RDf3iADE0/FZs2E2ymonRudgqCg+WrgLpQYinEE8jiVBF
   tMsIGuRaNRlFc69c3cbA62WDfKMBDwILAf6N89+Q7INYxzFzNhjlxQ0q0
   uRYId03am/icEciJNssswp2IEm5VIRn62rG/QwG0ayhogvgvdNnKpP1Eo
   mRtOhrxByCCWUiQkT0KXR/Uc5jZK/kH5yMhRLgnh6FiMUp5fSY24pgQBG
   rFwXfhlH1EPaZxYBG6t5UrVJBbX+zUNfLbSlxVA3rjBfSWxhU1dVilo42
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334725077"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334725077"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656082539"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="656082539"
Received: from jjohanss-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 13:04:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the 01.org website entries
In-Reply-To: <20230308141322.25201-1-lukas.bulwahn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230308141322.25201-1-lukas.bulwahn@gmail.com>
Date:   Mon, 13 Mar 2023 22:03:55 +0200
Message-ID: <87sfe87710.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> The 01.org links in MAINTAINERS now forward to different other pages or do
> not resolve.
>
> The link https://01.org/linuxgraphics/ resolves to the Intel Graphics for
> Linux - Programmer's Reference Manuals. Update this webpage entry.
>
> The link
> https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
> does not resolve. Remove this webpage entry.
>
> The link https://01.org/igvt-g resolves to
> https://github.com/intel/gvt-linux. Remove the webpage entry, as the
> github repository is already referred to by the T: entry in that section.
>
> The link resolves the pm-graph project page in Intel's Open Ecosystem area
> at intel.com. Update this webpage entry.
>
> M:      "Todd E Brandt" <todd.e.brandt@linux.intel.com>
> L:      linux-pm@vger.kernel.org
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1333928a7be4..99adcd74b06a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6747,7 +6747,6 @@ M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>  M:	Maxime Ripard <mripard@kernel.org>
>  M:	Thomas Zimmermann <tzimmermann@suse.de>
>  S:	Maintained
> -W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html

This was likely the same as:

https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html

>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/gpu/
>  F:	drivers/gpu/drm/*
> @@ -10250,7 +10249,7 @@ M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
>  M:	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>  L:	intel-gfx@lists.freedesktop.org
>  S:	Supported
> -W:	https://01.org/linuxgraphics/
> +W:	https://www.intel.com/content/www/us/en/develop/documentation/intel-graphics-for-linux-programmers-reference-guide/top.html

I don't think this is what we want, but we'll need to sort out what the
right thing is first.

BR,
Jani.

>  Q:	http://patchwork.freedesktop.org/project/intel-gfx/
>  B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
>  C:	irc://irc.oftc.net/intel-gfx
> @@ -10312,7 +10311,6 @@ M:	Zhi Wang <zhi.a.wang@intel.com>
>  L:	intel-gvt-dev@lists.freedesktop.org
>  L:	intel-gfx@lists.freedesktop.org
>  S:	Supported
> -W:	https://01.org/igvt-g
>  T:	git https://github.com/intel/gvt-linux.git
>  F:	drivers/gpu/drm/i915/gvt/
>  
> @@ -16668,7 +16666,7 @@ PM-GRAPH UTILITY
>  M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
> -W:	https://01.org/pm-graph
> +W:	https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
>  B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
>  T:	git git://github.com/intel/pm-graph
>  F:	tools/power/pm-graph

-- 
Jani Nikula, Intel Open Source Graphics Center
