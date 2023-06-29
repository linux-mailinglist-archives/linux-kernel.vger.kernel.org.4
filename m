Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9674220D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjF2IXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjF2IWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:22:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3C30EF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688026918; x=1719562918;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4orufNJFTU0KKwB1R0g7i45/dV0rMWf0T+wQWzKmwUY=;
  b=YhXTy4UniQHinaaUR3JrQun1+Axk/Za9f30xgGJlkb9AUJbbtZQPui+G
   4nsFDFzuyPky1T0HrxlbaDvDa3rd/e6P4mHIW2w7/cPX8smqSo+yT5/HS
   4mEPrZMLDppiGnP7YgKmFpNsujTyyabOzWcM5MTSkTHidXYU193sxAL6I
   YJ5ZktgNvn3yKdORoBpxY01t0tGi75nNvjodKxpM+QIa8G+HDabriTmzF
   CKXFh8E/havcFvTSXis8R0DA3qcmzVCn3KGbXAdhr258u8MAeaULdZCkH
   WXtoMyXmGiiAdzo+8gl5B4Es+52BfSnL2UcE24trMzFHGxAEGVrrZoNDs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="428070821"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="428070821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="830444298"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830444298"
Received: from gyorgysx-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.63.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:21:18 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v2] drm/edid: Add quirk for OSVR HDK 2.0
In-Reply-To: <20230621061903.3422648-1-rcampbell@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230621061903.3422648-1-rcampbell@nvidia.com>
Date:   Thu, 29 Jun 2023 11:20:59 +0300
Message-ID: <87edlusmqc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Ralph Campbell <rcampbell@nvidia.com> wrote:
> The OSVR virtual reality headset HDK 2.0 uses a different EDID
> vendor and device identifier than the HDK 1.1 - 1.4 headsets.
> Add the HDK 2.0 vendor and device identifier to the quirks table so
> that window managers do not try to display the desktop screen on the
> headset display.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>

Thanks for the patch, pushed to drm-misc-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/drm_edid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> I don't know how many of these VR headsets are still around but I have a
> working one and I saw an entry for HDK 1.x so I thought it would be good
> to add HDK 2.0.
>
> v2: The vendor ID was byte swapped.
> I'm not sure how I missed that in v1.
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 0454da505687..3b8cc1fe05e8 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -230,6 +230,7 @@ static const struct edid_quirk {
>  
>  	/* OSVR HDK and HDK2 VR Headsets */
>  	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
> +	EDID_QUIRK('A', 'U', 'O', 0x1111, EDID_QUIRK_NON_DESKTOP),
>  };
>  
>  /*

-- 
Jani Nikula, Intel Open Source Graphics Center
