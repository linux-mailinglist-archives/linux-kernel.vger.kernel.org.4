Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E46E7B00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjDSNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjDSNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:36:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA115A2A;
        Wed, 19 Apr 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681911343; x=1713447343;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JTI6bmzuEQ/Nj1Rb7tcpT49wOi4YnttQtFOpUCB/+LA=;
  b=Qu0JKMh2omqsP1ggO9TT103d+KMbc473hOaMxQuJ3rkPfmkuSPXTMShg
   cWDmEP/Tc5BVygFHIzfPtUgPfFr+n7P7Th486mInVkANk6WgGSITR6sTE
   jY9DrwPzKICZ+X8UGAvoEUfd9DtYfSxhpc7/UY+fJpyMldOWXV4VN0Evl
   eYQoJY2jc4gxPmU3D+KZjWTAmobJMiGrgavMKE5PsW1YZfnwYc58SL++w
   XBSdbAJMbpHS+w0yTiV5/kyR/SMFMCGWyC7zM9ZhN+XjcQdIUQCAAN9eZ
   EVY3VHR6kkW/BG4TO9sMRI5Rrr2gWXfIyi5FDPkDR/BIImT0NHOurFEyW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345449326"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345449326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="721932512"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721932512"
Received: from hbourgeo-mobl2.ger.corp.intel.com ([10.249.34.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:35:13 -0700
Date:   Wed, 19 Apr 2023 16:35:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Return error on write
 frequency
In-Reply-To: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <64e98df-1663-1630-e2bf-5472aced5cac@linux.intel.com>
References: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-986072932-1681911315=:1986"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-986072932-1681911315=:1986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 18 Apr 2023, Srinivas Pandruvada wrote:

> Currently when the uncore_write() returns error, it is silently
> ignored. Return error to user space when uncore_write() fails.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>
> ---
> This patch has no dependency on TPMI patches for uncore support.
> 
>  .../x86/intel/uncore-frequency/uncore-frequency-common.c    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index cb24de9e97dc..fa8f14c925ec 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
>  				      int min_max)
>  {
>  	unsigned int input;
> +	int ret;
>  
>  	if (kstrtouint(buf, 10, &input))
>  		return -EINVAL;
>  
>  	mutex_lock(&uncore_lock);
> -	uncore_write(data, input, min_max);
> +	ret = uncore_write(data, input, min_max);
>  	mutex_unlock(&uncore_lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	return count;
>  }

Shouldn't this have Fixes tag?

Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-986072932-1681911315=:1986--
