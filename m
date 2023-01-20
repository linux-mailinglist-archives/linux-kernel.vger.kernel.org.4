Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472426751C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjATJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjATJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:55:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BFAA733D;
        Fri, 20 Jan 2023 01:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674208498; x=1705744498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+nvvEu/BOUFSCsUyjF17UjmDZnCUyvy9snQzL3mM8lQ=;
  b=WzFqsynfQ/gwu1dYtEwTJXhFbY4ERg4lW9EhACGSrcTPaSzHli5v02tn
   cPl7XRg4oIqvuqTizr/nF9a+ACzm4mq/EHRw1Wv5zc7U+lgapGaL9cIHB
   Mwn59zElV0NBADZi+ZEogfA46kl4J7D8RK7NuNwTMZFE43iIsH+wQ/sJ2
   Op37oXx2JcjoPBFWT9uUhoO0v9RGpAZUALrA7jKVNiu0eGatdixP/AOHk
   PiiZeOHYaTiMv9ALs2qRHnTYybbulIvQQYms65mAoJgYiT7E9GEY/cFR2
   zhHmUpqt0VAbChftHfi0jhSnoLLZnKwG9hokBnPNA6AhobvaYPw1FDkqE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305912520"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="305912520"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:54:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="834364601"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="834364601"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:54:56 -0800
Date:   Fri, 20 Jan 2023 10:54:54 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] accel/ivpu: Fix spelling mistake "tansition" ->
 "transition"
Message-ID: <20230120095454.GA56856@linux.intel.com>
References: <20230120092842.79238-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120092842.79238-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:28:42AM +0000, Colin Ian King wrote:
> There are spelling mistakes in two ivpu_err error messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>


> ---
>  drivers/accel/ivpu/ivpu_hw_mtl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_hw_mtl.c b/drivers/accel/ivpu/ivpu_hw_mtl.c
> index b59b1f472b40..62bfaa9081c4 100644
> --- a/drivers/accel/ivpu/ivpu_hw_mtl.c
> +++ b/drivers/accel/ivpu/ivpu_hw_mtl.c
> @@ -608,7 +608,7 @@ static int ivpu_boot_d0i3_drive(struct ivpu_device *vdev, bool enable)
>  
>  	ret = REGB_POLL_FLD(MTL_BUTTRESS_VPU_D0I3_CONTROL, INPROGRESS, 0, TIMEOUT_US);
>  	if (ret) {
> -		ivpu_err(vdev, "Failed to sync before D0i3 tansition: %d\n", ret);
> +		ivpu_err(vdev, "Failed to sync before D0i3 transition: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -621,7 +621,7 @@ static int ivpu_boot_d0i3_drive(struct ivpu_device *vdev, bool enable)
>  
>  	ret = REGB_POLL_FLD(MTL_BUTTRESS_VPU_D0I3_CONTROL, INPROGRESS, 0, TIMEOUT_US);
>  	if (ret)
> -		ivpu_err(vdev, "Failed to sync after D0i3 tansition: %d\n", ret);
> +		ivpu_err(vdev, "Failed to sync after D0i3 transition: %d\n", ret);
>  
>  	return ret;
>  }
> -- 
> 2.30.2
> 
