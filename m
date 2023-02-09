Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB4690470
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBIKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBIKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:08:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20354548
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675937316; x=1707473316;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3kM3qVc9Ez61uoBGV4OFIyd2qWSgV9wfm15bdDjlPiw=;
  b=AfjR7GHMyXBTo1PQWnBoF+uIKch2QyC8UsYw4Lp6jn//svQnZobL4Y/v
   UbJsO6Fe7EYdBVjhGRs52lpp8FoHbscTQ3uvwPHkaCFya94Srv77BAhZI
   3W1pCxtcgJe1gF6jxM6YbOaB2aytofVOL6oMkHH3NDOCscuabZ6Z8jX9q
   dlJpbR/00aWalPIIXVkdu0vdxJo5TYUP+ruva9iBJTzFRnuTt+aRKFBr8
   Hrvi2TzkIdgaGdd/LBVJYwET7zRuiYjsmZoPGlnODl1uU2SfKQ3X7OoYw
   /2bDc8T5/Dsv/cwZFtOY8CeUJSsCsQ27LkRrSuCUh06a0mwU24IR2Qu/t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331355005"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="331355005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 02:08:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="697970307"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="697970307"
Received: from grizzo-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 02:08:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     ye.xingchen@zte.com.cn, alexander.deucher@amd.com
Cc:     sunpeng.li@amd.com, qingqing.zhuo@amd.com, xinhui.pan@amd.com,
        rodrigo.siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, wenjing.liu@amd.com,
        dri-devel@lists.freedesktop.org, george.shen@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu/display: remove duplicate include header
 =?utf-8?Q?in=C2=A0link=5Fdpms=2Ec?=
In-Reply-To: <202302091511222329971@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202302091511222329971@zte.com.cn>
Date:   Thu, 09 Feb 2023 12:08:28 +0200
Message-ID: <877cwrxiar.fsf@intel.com>
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

On Thu, 09 Feb 2023, <ye.xingchen@zte.com.cn> wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> link_hwss.h is included more than once.

You've got U+00A0 non-breaking space in the subject line.

BR,
Jani.

>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 9cdfa7f7dc77..0c26b3589608 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -51,7 +51,6 @@
>  #include "link_enc_cfg.h"
>  #include "resource.h"
>  #include "dsc.h"
> -#include "link_hwss.h"
>  #include "dccg.h"
>  #include "clk_mgr.h"
>  #include "atomfirmware.h"

-- 
Jani Nikula, Intel Open Source Graphics Center
