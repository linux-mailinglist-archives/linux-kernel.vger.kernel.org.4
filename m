Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69977145FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjE2IGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjE2IGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:06:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E2A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685347587; x=1716883587;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MFgq1cmYBpxJ6c4Q4/KeMmfcD10/N5tccL1870amklU=;
  b=C0xFyYN03KPtbIKlp6Txf5MIGkIqKRtA4jzzCRHBJRo0MMgWpbHhcUoh
   LTrswGRHreL1cYkET0eoJmgMoeewrl/qVneCgyUdkdmk62hEbZHNnAw9h
   QlAd7LyKwsDOx3ReovBwFfyurDwsy9e7b95X7zunQoOytnFY/E5Tab1p7
   FK0Z84OEZFcgrSDBZjAjHMKOmCe7ELnJ1sv/IWwF+GNYpQ0mfHGm6mEdC
   ZBXxyrcVKShgIDrIGDoWdyEoNoV8zf7jp0I3rxuqYObK+NGYSneBF0IAL
   4YjPmOUqRZREDTaxvvPnl8G4zHdDYxWNxhhyIlUliUFBJQGM7sPtf1XIP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="418131656"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="418131656"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 01:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="775848200"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="775848200"
Received: from iswiersz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.191])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 01:06:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915_drm.h: fix a typo
In-Reply-To: <20230529074912.2070902-1-suijingfeng@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230529074912.2070902-1-suijingfeng@loongson.cn>
Date:   Mon, 29 May 2023 11:06:20 +0300
Message-ID: <874jnvimtf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>  'rbiter' -> 'arbite'

Should be arbiter.

>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  include/drm/i915_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
> index 7adce327c1c2..3dcb1db519ae 100644
> --- a/include/drm/i915_drm.h
> +++ b/include/drm/i915_drm.h
> @@ -42,7 +42,7 @@ extern struct resource intel_graphics_stolen_res;
>   * The Bridge device's PCI config space has information about the
>   * fb aperture size and the amount of pre-reserved memory.
>   * This is all handled in the intel-gtt.ko module. i915.ko only
> - * cares about the vga bit for the vga rbiter.
> + * cares about the vga bit for the vga arbite.
>   */
>  #define INTEL_GMCH_CTRL		0x52
>  #define INTEL_GMCH_VGA_DISABLE  (1 << 1)

-- 
Jani Nikula, Intel Open Source Graphics Center
